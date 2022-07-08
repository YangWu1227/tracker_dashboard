# Reexports from the pool package -----------------------------------------

#' @importFrom pool dbPool poolClose
#' @export
dbPool
#' @export
poolClose

# Rexports from bigrquery -------------------------------------------------

#' @importFrom bigrquery bigquery bq_auth bq_test_project
#' @export
bq_auth
#' @export
bigquery
#' @export
bq_test_project

# Reexports from cranlogs -------------------------------------------------

#' @importFrom cranlogs cran_top_downloads cran_downloads
#' @export
cran_top_downloads
#' @export
cran_downloads
