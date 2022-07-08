#' Add directory of static resources to Shiny's web server
#'
# The function `addResourcePath()` makes static files in 'www' available to app components.
#'
#' @param libname A character vector giving the library directory where the package defining the namespace was found.
#' @param pkgname A character vector giving the name of the package.
#'
#' @importFrom shiny addResourcePath
.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Welcome to my dashboard!")
  addResourcePath("www", system.file("www", package = "TrackerDashboard"))
}
