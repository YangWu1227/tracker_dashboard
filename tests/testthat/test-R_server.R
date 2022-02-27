# Test data ---------------------------------------------------------------

df <- cran_downloads(
  packages = c("data.table", "dplyr"),
  from = "2021-12-01",
  to = "2022-01-01"
)

plot_R <- r_plot(df, "date", "count", "package")
plot_R_hc <- r_plot_hc(df, "date", "count", "package")

# Tests for ggplotly ------------------------------------------------------

test_that("plot_R() returns correct ggplotly output", {
  # S3 class
  expect_s3_class(object = plot_R, class = c("plotly", "htmlwidget"), exact = T)
  # Base type
  expect_type(object = plot_R, type = "list")
})

test_that("snapshot for ggplotly output", {
  vdiffr::expect_doppelganger(title = "Output for ggplotly line plot", fig = plot_R)
})

# Tests for highcharter ---------------------------------------------------

test_that("plot_R_hc() returns correct highcharts output", {
  # S3 class
  expect_s3_class(object = plot_R_hc, class = c("highchart", "htmlwidget"), exact = T)
  # Base type
  expect_type(object = plot_R_hc, type = "list")
})

test_that("snapshot for highcharts output", {
  vdiffr::expect_doppelganger(title = "Output for highcharts line plot", fig = plot_R_hc)
})
