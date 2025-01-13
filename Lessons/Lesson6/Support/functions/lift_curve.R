#' Lift Chart
#' 
#' Calculate lift chart metrics and create lift chart
#'
#' @param data A data.frame object with columns observed, fitted and weights
#' @param target_variable A string indicated the target variables
#' @param bins The number of bins to use when creating the lift chart
#' @param critical_value The confidence level for the confidence interval
#'   of the observed values
#'
#' @return Plotly graph of the lift chart 

lift_curve <- function(
    data, 
    target_variable, 
    weights_input = NULL,
    bins = 10, 
    pred_fun = NULL,
    is_fitted = FALSE,
    ...
) {
  
  
  if(is_fitted == FALSE) {
    
    X <- data %>%
      select(-all_of(c(target_variable, weights_input)))
    
    # calculate fitted values
    data$fitted <- pred_fun(
      X = X,
      ...
    )
  }
  
  # Prepare data used for metrics and graph
  testing_plot <- data %>%
    arrange(fitted) %>%
    mutate(
      observed = get(target_variable),
      weights = if (is.null(weights_input)) 1 else get(weights_input),
      bin = cut_weight(weights, bins)
    ) %>%
    select(fitted, weights, observed, bin) %>%
    mutate(across(everything(), as.numeric)) %>%
    group_by(bin) %>%
    dplyr::summarise(
      fit = (sum(fitted * weights)) / sum(weights),
      obs = (sum(observed * weights)) / sum(weights),
      wth = sum(weights)
    )
  
  # Create graph
  testing_plot %>%
    plotly::plot_ly(x = ~bin) %>%
    # Bins - exposure
    plotly::add_trace(
      y = ~wth,
      type = "bar",
      marker = list(color = "orange"),
      alpha = 0.5,
      name = "Exposure"
    ) %>%
    # Line - observed values
    plotly::add_trace(
      y = ~obs,
      type = "scatter",
      mode = "lines+markers",
      yaxis = "y2",
      name = "Observed",
      marker = list(color = "#F8766D"),
      line = list(color = "#F8766D")
    ) %>%
    # Line - predicted values
    plotly::add_trace(
      y = ~fit,
      type = "scatter",
      mode = "lines+markers",
      yaxis = "y2",
      name = "Predicted",
      marker = list(color = "#619CFF"),
      line = list(color = "#619CFF")
    ) %>%
    # Specify layout
    plotly::layout(
      yaxis = list(
        title = "Exposure",
        side = "right",
        range = c(0, 3 * max(testing_plot$wth))
      ),
      yaxis2 = list(
        title = "observed / predicted average",
        overlaying = "y",
        range = c(0, 1.25 * max(c(testing_plot$fit, testing_plot$obs)))
      ),
      xaxis = list(title = "Exposure Bins")
    )
}
