.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Welcome to my dashboard!")
  addResourcePath('www', system.file("www", package = "TrackerDashboard"))
}