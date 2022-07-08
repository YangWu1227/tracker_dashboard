#' Sidebar
#'
#' @importFrom bs4Dash bs4DashSidebar sidebarUserPanel sidebarHeader menuItem sidebarMenu
#'
#' @export
sidebar <- function() {
  bs4DashSidebar(

    ############################
    # Customization parameters #
    ############################
    disable = FALSE,
    width = 250,
    skin = "light",
    status = "primary",
    elevation = 4,
    collapsed = FALSE,
    minified = FALSE,
    expandOnHover = TRUE,
    fixed = TRUE,
    id = "sidebar",
    customArea = NULL,

    ##############
    # User panel #
    ##############

    sidebarUserPanel(
      name = "Powered By R Shiny!"
    ),
    # Sidebar
    sidebarMenu(
      id = "sidebar_menu",
      flat = FALSE,
      compact = FALSE,
      # Indent child menuItem() after each sidebarHeader()
      childIndent = TRUE,
      sidebarHeader("Select one below:"),
      menuItem(
        "R",
        tabName = "R-downloads",
        icon = icon("chart-line")
      ),
      menuItem(
        "Python",
        tabName = "python-downloads",
        icon = icon("stats", lib = "glyphicon")
      )
    )
  )
}
