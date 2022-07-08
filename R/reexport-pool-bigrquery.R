# Reexports from the pool package -----------------------------------------

#' @importFrom pool dbPool poolClose
#' @export
pool::dbPool
#' @export
pool::poolClose

# Rexports from bigrquery -------------------------------------------------

#' @importFrom bigrquery bigquery bq_auth bq_test_project
#' @export
bigrquery::bq_auth
#' @export
bigrquery::bigquery
#' @export
bigrquery::bq_test_project

# Reexports from cranlogs -------------------------------------------------

#' @importFrom cranlogs cran_top_downloads cran_downloads
#' @export
cranlogs::cran_top_downloads
#' @export
cranlogs::cran_downloads
