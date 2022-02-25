#' Body
#'
#' @param top_packages A character vector of packages names.
#' @param today Today's date.
#' @param last_month Last month's date.
#'
#' @importFrom bs4Dash dashboardBody tabItems tabItem box boxLabel boxSidebar
#' @importFrom shiny fluidRow dateRangeInput textInput actionButton
#' @importFrom highcharter highchartOutput
#' @importFrom plotly plotlyOutput
#' @importFrom cranlogs cran_top_downloads
#'
#' @export
body_ <- function(top_packages, today, last_month) {
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "R-downloads",
        fluidRow(
          box(
            title = "Visualize R Package Download History",
            # Border color
            status = "primary",
            # Solod box header
            solidHeader = FALSE,
            # Background color of box
            background = NULL,
            # Overall width of a region is 12
            width = 12,
            # Scales automatically with the content
            height = NULL,
            # Collapse aka minimize box
            collapsible = TRUE,
            # Do not start as collapsed box
            collapsed = FALSE,
            closable = FALSE,
            # Allow user to maximize box as one single view
            maximizable = TRUE,
            icon = NULL,
            gradient = FALSE,
            boxToolSize = "sm",
            elevation = NULL,
            headerBorder = TRUE,
            # Box label
            label = boxLabel("Credit", "primary", tooltip = "The inspiration of this visualization comes from Hadley Wickham."),
            dropdownMenu = NULL,
            id = NULL,
            textInput(
              "R_packages",
              "Packages",
              paste(top_packages, collapse = ", ")
            ),
            dateRangeInput(
              "R_date_range_input",
              "Select a data range:",
              start = last_month,
              end = today
            ),
            highchartOutput(outputId = "R_plot")
          )
        )
      )
    )
  )
}
