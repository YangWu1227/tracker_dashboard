pkgload::load_all(".")
library(bigrquery)

# Variables for default inputs --------------------------------------------

top5 <- cranlogs::cran_top_downloads(count = 5)$package
today <- Sys.Date() - 1
last_month <- today - 60

# UI ----------------------------------------------------------------------

ui <- dashboardPage(
  dark = TRUE,
  header = header(),
  sidebar = sidebar(),
  body = body_(top_packages = cranlogs::cran_top_downloads(count = 5)$package, today = Sys.Date() - 1, last_month = Sys.Date() - 1 - 60)
)

# Server ------------------------------------------------------------------

server <- function(input, output, session) {

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
}

shinyApp(ui, server)

