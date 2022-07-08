# Server function  --------------------------------------------------------

server <- function(input, output, session) {
  auth <- secure_server(
    check_credentials = check_credentials(
      db = app_sys("extdata", "credentials_database.sqlite"),
      passphrase = "credentials_db_password"
    )
  )

  R_downloads <- reactive({
    R_packages <- strsplit(x = input$R_packages, split = ", ?")[[1]]

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

# Expected reactive expression output -------------------------------------

df <- cran_downloads(
  packages = c("data.table", "dplyr"),
  from = "2021-12-01",
  to = "2022-01-01"
)

# Tests -------------------------------------------------------------------

test_that("server function returns correct reactive value", {
  testServer(server, {
    # Simulate user input
    session$setInputs(
      R_packages = "data.table, dplyr",
      R_date_range_input = c("2021-12-01", "2022-01-01")
    )
    # Reactive expression should be a data.frame
    expect_s3_class(object = R_downloads(), class = "data.frame", exact = T)
    expect_equal(object = R_downloads(), expected = df)
  })
})
