#' Function that accesses files in the current package
#'
#' @param ... Character vectors, specifying subdirectory and file(s) within the package.
#'
#' @export
app_sys <- function(...){
  system.file(..., package = "TrackerDashboard")
}
