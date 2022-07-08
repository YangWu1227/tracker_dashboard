#' Server for R tab
#'
#' @param data A data frame.
#' @param x The x variable.
#' @param y The y variable.
#' @param group Grouping variable
#'
#' @importFrom ggplot2 ggplot aes geom_line xlab ylab theme element_blank element_text
#' @importFrom plotly ggplotly config layout
#' @importFrom rlang ensym
#'
#' @export
r_plot <- function(data, x, y, group) {
  x <- ensym(x)
  y <- ensym(y)
  group <- ensym(group)

  p <- ggplot(data, mapping = aes(!!x, !!y, colour = !!group)) +
    geom_line() +
    xlab(NULL) +
    ylab("<span style='color:#777'><b>Daily Downloads</b></span>") +
    theme(
      panel.grid = element_blank(),
      axis.text.x = element_text(colour = "#777777", face = "bold"),
      axis.text.y = element_text(colour = "#777777", face = "bold"),
      legend.text = element_text(colour = "#777777", face = "bold"),
      legend.title = element_text(colour = "#777777", face = "bold")
    )

  ggplotly(p) |>
    config(modeBarButtonsToRemove = list(
      "select", "lasso", "zoomIn", "zoomOut", "resetScale"
    )) |>
    layout(
      paper_bgcolor = "transparent",
      plot_bgcolor = "transparent",
      legend = list(bgcolor = "transparent"),
      modebar = list(bgcolor = "transparent")
    )
}
