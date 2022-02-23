#' @importFrom shiny addResourcePath
# The function addResourcePath() makes static files in 'www' available to app components (secure ui)
.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Welcome to my dashboard!")
  addResourcePath('www', system.file("www", package = "TrackerDashboard"))
}
