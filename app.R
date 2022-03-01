pkgload::load_all(".")
library(bigrquery)
library(shiny)
library(pool)
library(DBI)

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

runApp(top5, today, last_month, pool)

