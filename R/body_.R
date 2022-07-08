#' Body
#'
#' @param top_packages A character vector of packages names.
#' @param today Today's date.
#' @param last_month Last month's date.
#'
#' @importFrom bs4Dash dashboardBody tabItems tabItem box boxLabel boxSidebar
#' @importFrom plotly plotlyOutput
#' @importFrom cranlogs cran_top_downloads
#'
#' @export
body_ <- function(top_packages, today, last_month) {
  dashboardBody(

    ################
    # Resize plots #
    ################

    tags$head(
      tags$script(
        "$(function() {
            function resizeBoxContent(trigger, target) {
              $(trigger).on('click', function() {
                setTimeout(function() {
                  var isMaximized = $('html').hasClass('maximized-card');
                    if (isMaximized) {
                      $(target).css('height', '100%');
                    } else {
                      $(target).css('height', '400px');
                    }
                }, 300);
                $(target).trigger('resize');
              });
            }
            setTimeout(function() {
              resizeBoxContent('#R_box [data-card-widget=\"maximize\"]', '#R_plot');
              resizeBoxContent('#python_box [data-card-widget=\"maximize\"]', '#python_plot');
            }, 500);
          });
          "
      )
    ),
    tabItems(

      #########
      # R tab #
      #########

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
            elevation = 4,
            headerBorder = TRUE,
            # Box label
            label = boxLabel("Credit", "primary", tooltip = "The inspiration of this visualization comes from Hadley Wickham."),
            dropdownMenu = NULL,
            id = "R_box",
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
            plotlyOutput(outputId = "R_plot")
          )
        )
      ),

      ##############
      # Python tab #
      ##############

      tabItem(
        tabName = "python-downloads",
        fluidRow(
          box(
            title = "Visualize Python Package Download History",
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
            elevation = 4,
            headerBorder = TRUE,
            dropdownMenu = NULL,
            id = "python_box",
            textInput(
              "python_package",
              HTML("<span style='font-size:12.0pt'><b>Enter a single Python package to visualize its daily downloads for the past six months: <br><span style='font-size:9.0pt'>It may take a few seconds to retrieve the data.</span></b></span>"),
              "datatable"
            ),
            actionButton("run_query", "Run Query"),
            plotlyOutput(outputId = "python_plot")
          )
        )
      )
    )
  )
}
