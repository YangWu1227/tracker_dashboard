#' Header
#'
#' @importFrom bs4Dash dashboardHeader dashboardBrand
#' @export
#'
header <- function() {
  dashboardHeader(
    title = dashboardBrand(
      title = "Yang Wu",
      color = "primary",
      href = "https://www.kenwuyang.com/",
      image = "www/profile.jpg",
      opacity = 0.8
    ),
    titleWidth = NULL,
    disable = FALSE,
    .list = NULL,
    skin = "light",
    status = "white",
    border = TRUE,
    compact = FALSE,
    sidebarIcon = icon("bars"),
    controlbarIcon = icon("th"),
    fixed = TRUE,
    leftUi = NULL,
    rightUi = NULL
  )
}
