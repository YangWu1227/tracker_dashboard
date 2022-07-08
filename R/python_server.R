#' Server for Python tab
#'
#' @param data A data frame.
#' @param x The x variable.
#' @param y The y variable.
#'
#' @export
python_plot <- function(data, x, y) {
  x <- ensym(x)
  y <- ensym(y)

  p <- ggplot(data, mapping = aes(!!x, !!y)) +
    geom_line(color = "#CC5500") +
    xlab(NULL) +
    ylab("<span style='color:#777'><b>Daily Downloads</b></span>") +
    theme(
      panel.grid = element_blank(),
      axis.text.x = element_text(colour = "#777777", face = "bold"),
      axis.text.y = element_text(colour = "#777777", face = "bold"),
      legend.position = "none"
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
