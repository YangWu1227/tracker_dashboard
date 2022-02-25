#' Run application
#'
#' @param top_packages A character vector of packages names.
#' @param today Today's date.
#' @param last_month Last month's date.
#'
#' @import htmltools
#' @importFrom shinymanager secure_app secure_server check_credentials
#' @importFrom cranlogs cran_top_downloads cran_downloads
#' @importFrom shiny reactive shinyApp bindCache
#' @importFrom highcharter renderHighchart
#' @importFrom plotly renderPlotly
#' @importFrom bs4Dash dashboardPage
#'
#' @export
runApp <- function(top_packages, today, last_month) {

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


    # Reactive expression for packages
    # Use [[ since strsplit() returns a list, returning a character vector of package names
    # The ", ?" regex matches a comma and a space character
    R_packages <- reactive(strsplit(x = input$R_packages, split = ", ?")[[1]]) |>
      bindCache(input$R_packages, cache = "app")

    R_downloads <- reactive({
      # Daily package downloads data
      # Returns as data frame with columns: package, date, count
      dt <- cran_downloads(
        packages = R_packages(),
        from = input$R_date_range_input[[1]],
        to = input$R_date_range_input[[2]]
      )
    }) |> bindCache(input$R_date_range_input, cache = "app")


    output$R_plot <- renderPlotly({
      r_plot(R_downloads(), x = "date", y = "count", group = "package")
    })
  }

  shinyApp(ui = ui, server = server)
}
