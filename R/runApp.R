#' Run application
#'
#' @param top_packages A character vector of packages names.
#' @param today Today's date.
#' @param last_month Last month's date.
#' @param pool_obj A pool object with a reference to BigQuery.
#'
#' @import htmltools
#' @importFrom shinymanager secure_app secure_server check_credentials
#' @importFrom cranlogs cran_top_downloads cran_downloads
#' @importFrom shiny reactive shinyApp bindCache bindEvent onStop
#' @importFrom highcharter renderHighchart
#' @importFrom plotly renderPlotly
#' @importFrom bs4Dash dashboardPage
#' @importFrom DBI dbGetQuery
#' @importFrom glue glue
#'
#' @export
runApp <- function(top_packages, today, last_month, pool_obj) {

  # UI ----------------------------------------------------------------------

  ui <- dashboardPage(
    dark = TRUE,
    header = header(),
    sidebar = sidebar(),
    body = body_(top_packages, today, last_month)
  )

  # Secure app --------------------------------------------------------------

  ui <- secure_app(
    ui,
    enable_admin = TRUE,
    # Top
    tags_top =
      tags$div(
        # The <h4> tag defines the fourth level heading
        tags$h3("Welcome to", style = "align:center"),
        tags$img(
          src = "www/sticker.png", width = 100
        )
      ),
    # Bottom
    tags_bottom = tags$div(
      tags$p(
        "For any question, please contact the",
        tags$a(
          href = "mailto:yangwu2020@gmail.com?subject=Shiny%20aManager",
          target = "_top", "administrator"
        )
      )
    ),
    # Background
    background = "linear-gradient(315deg, #ffffff 0%, #d7e1ec 74%);"
  )

  # Server ------------------------------------------------------------------

  server <- function(input, output, session) {

    # Check_credentials directly on sqlite database
    auth <- secure_server(
      check_credentials = check_credentials(
        db = app_sys("extdata", "credentials_database.sqlite"),
        passphrase = "credentials_db_password"
      )
    )

    #########
    # R tab #
    #########

    R_downloads <- reactive({
      # Use [[ since strsplit() returns a list, returning a character vector of package names
      # The ", ?" regex matches a comma and a space character
      R_packages <- strsplit(x = input$R_packages, split = ", ?")[[1]]
      # Daily package downloads data
      # Returns as data frame with columns: package, date, count
      dt <- cran_downloads(
        packages = R_packages,
        from = input$R_date_range_input[[1]],
        to = input$R_date_range_input[[2]]
      )
    }) |> bindCache(input$R_packages, input$R_date_range_input, cache = "app")


    output$R_plot <- renderPlotly({
      r_plot(R_downloads(), x = "date", y = "count", group = "package")
    })

    ##############
    # Python tab #
    ##############

    python_downloads <- reactive({
      dt <- dbGetQuery(
        pool_obj,
        statement = glue(
          "SELECT COUNT(*) AS num_downloads, DATE_TRUNC(DATE(timestamp), DAY) AS `day`
         FROM `bigquery-public-data.pypi.file_downloads`
         WHERE
              file.project = '{input$python_package}'
              AND DATE(timestamp)
         BETWEEN DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 183 DAY), DAY) AND CURRENT_DATE()
         GROUP BY `day`;"
        )
      )
    }) |>
      bindCache(input$python_package, cache = "app") |>
      bindEvent(input$run_query)

    output$python_plot <- renderPlotly({
      python_plot(python_downloads(), x = "day", y = "num_downloads")
    })
  }

  shinyApp(ui = ui, server = server)
}
