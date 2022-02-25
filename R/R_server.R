#' Server for R tab
#'
#' @param data A data frame.
#' @param x The x variable.
#' @param y The y variable.
#' @param group Grouping variable
#'
#' @importFrom ggplot2 ggplot aes geom_line xlab ylab theme element_blank element_blank
#' @importFrom plotly ggplotly config
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
    ylab("Daily downloads") +
    theme(
      panel.background = element_blank(),
      panel.grid = element_blank()
    )

  ggplotly(p) |>
    config(modeBarButtonsToRemove = list(
      "zoom", "select", "lasso", "zoomIn", "zoomOut", "resetScale"
    ))
}



#' Server for R tab (Highcharter)
#'
#' @param data A data frame.
#' @param x The x variable.
#' @param y The y variable.
#' @param group Grouping variable
#'
#' @importFrom highcharter hchart hcaes hc_yAxis hc_legend
#'
#' @export
r_plot_hc <- function(data, x, y, group) {
  x <- ensym(x)
  y <- ensym(y)
  group <- ensym(group)

  hchart(data, "line", hcaes(x = !!x, y = !!y, group = !!group)) |>
    hc_yAxis(title = list(text = "Daily Downloads")) |>
    hc_legend(itemStyle = list(color = "#777"))
}
