emb_chart_plotly <- function(
    model,
    x_var, 
    target = "Burning_Cost",
    weight = "Time_Exposure",
    prediction = "pred",
    dt.frm = NULL, 
    print_data = FALSE) {
  
  # load all necessary packages
  libs <- c("ggplot2", "dplyr", "reshape2", "lazyeval", "patchwork")
  lapply(libs, require, character.only = TRUE)
  
  # if there is no dataset and model, print warning message
  if(is.null(dt.frm) && is.null(model)) {
    stop("Please provide one of the arguments `dt.frm` or `model`")
  }
  
  # if there is no dataset, extract it from the model 
  if(is.null(dt.frm)) {
    dt.frm <- cbind(
      model$data,
      data.frame(pred = predict(model, model$data, type = "response"))
    )
  }
  
  # if any weights are assigned, create it (equal to 1)
  if(is.null(weight)) {
    dt.frm <- dt.frm %>% 
      mutate(weight_col=1)
    weight <- "weight_col"
  }
  
  #data preparation for graph
  prepared <- dt.frm %>%
    group_by(get(x_var)) %>% 
    summarize(
      actual_mean = weighted.mean(.data[[target]], .data[[weight]], na.rm = TRUE),
      fitted_mean = weighted.mean(.data[[prediction]], .data[[weight]], na.rm = TRUE),
      weight_sum = sum(.data[[weight]])
    ) %>% 
    mutate(weight_sum_pct = weight_sum/sum(weight_sum)*100) %>%
    rename("group_var" = "get(x_var)" ) 
  
  # print data if selected 
  if(print_data) {
    print(prepared)  
  }
  
  # check unique categories of explored variable
  x_unique <- unique(prepared$group_var)
  
  # if there is more than 20 factors 
  if((is.character(x_unique) || is.factor(x_unique)) && length(x_unique) > 20) {
    
    # group factors together
    prepared <- prepared %>% 
      mutate(
        group_var_label = ifelse(
          weight_sum_pct > 100/length(x_unique), 
          group_var,
          ""
        )
      ) %>% 
      filter(group_var_label != "")
    
  } else {
    # else do nothing
    prepared <- prepared %>% 
      mutate(group_var_label = group_var)
    scale_x_fun <- NULL
  }
  
  #graph
  prepared %>%
    plot_ly(x = ~group_var_label) %>%
    # bins - exposure
    add_trace(
      y = ~weight_sum_pct,
      type = "bar",
      marker = list(color = "orange"),
      alpha = 0.5,
      name = "Exposure"
    ) %>%
    # line - observed values
    add_trace(
      y = ~actual_mean,
      type = "scatter",
      mode = "lines+markers",
      yaxis = "y2",
      name = "Actual",
      marker = list(color = "#F8766D"),
      line = list(color = "#F8766D")
    ) %>%
    # line - predicted values
    add_trace(
      y = ~fitted_mean,
      type = "scatter",
      mode = "lines+markers",
      yaxis = "y2",
      name = "Fitted",
      marker = list(color = "#619CFF"),
      line = list(color = "#619CFF")
    ) %>%
    # specify layout
    layout(
      title = list(
        text = x_var,
        y = 0.95
      ),
      yaxis = list(
        title = "Exposure - %",
        side = "right",
        range = c(0, 3 * max(prepared$weight_sum_pct))
      ),
      yaxis2 = list(
        title = "Prediction vs. Actual",
        overlaying = "y",
        range = c(0, 1.25 * max(c(prepared$fitted_mean, prepared$actual_mean)))
      ),
      xaxis = list(title = "")
    )
  
}
