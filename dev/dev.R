pkgload::load_all(".")
library(bigrquery)
library(pool)
library(DBI)
library(glue)

# Service account token ---------------------------------------------------

bq_auth(path = Sys.getenv("path_to_bq_token"))

# Pool object -------------------------------------------------------------

pool <- dbPool(
  drv = bigquery(),
  project = "bigquery-public-data",
  dataset = "pypi",
  billing = bq_test_project()
)
onStop(function() {
  poolClose(pool)
})

# Variables for default R text inputs -------------------------------------

top5 <- cranlogs::cran_top_downloads(count = 5)$package
today <- Sys.Date() - 1
last_month <- today - 60

# UI ----------------------------------------------------------------------

ui <- dashboardPage(
  dark = TRUE,
  header = header(),
  sidebar = sidebar(),
  body = body_(top_packages = top5, today = today, last_month = last_month)
)

# Server ------------------------------------------------------------------

server <- function(input, output, session) {

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
      pool,
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

shinyApp(ui, server)
