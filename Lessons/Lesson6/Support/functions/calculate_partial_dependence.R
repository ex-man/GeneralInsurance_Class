#' Partial Dependence Calculation
#'
#' This function computes the partial dependence of a specified variable
#' in a given model. It varies the feature values across a grid and
#' averages the predictions while keeping other features constant.
#' This function is used to calculate partial dependence
#' in plot_partial_dependence function to show the marginal effect one feature
#' have on the predicted outcome of a gbm model. A partial dependence plot
#' can show whether the relationship between the target and a feature is linear,
#' monotonic or more complex.
#'
#' @param model A trained model object.
#' @param data A data frame containing the dataset.
#' @param var A string representing the name of the variable for which partial
#'   dependence is to be calculated.
#' @param weights A vector of weights for the instances in the dataset.
#' @param sample An integer specifying the number of samples to be used.
#' @param pred_fun A function that takes a model and data as input and returns
#'   predictions.
#' @param ... Additional arguments to be passed to the `pred_fun`.
#'
#' @return A tibble containing the grid of feature values and the corresponding
#'   partial dependence predictions.
#' 
#' @export

calculate_partial_dependence <- function(
    model,
    data,
    var,
    weights = NULL,
    sample = 10000,
    pred_fun,
    ...
) {
  
  # Determine the sample size to be used based on the data size.
  # If the dataset has fewer rows than the specified sample size, use the entire
  #  dataset. Otherwise, randomly sample the specified number of rows.
  #  Handle large datasets efficiently by reducing computation time.
  if (nrow(data) < sample) {
    set.seed(1234)
    pdindex <- as.vector(sample(1:nrow(data), size = nrow(data)))
  } else {
    set.seed(1234)
    pdindex <- as.vector(sample(1:nrow(data), size = sample))
  }
  
  # Extract the data corresponding to the sampled indices
  data_subs <- data[pdindex, ]
  
  # If no weights are provided, assigning equal weights to each sample (1)
  # Partial dependence calculation involves averaging using weights
  if (is.null(weights)) {
    weights <- replicate(sample, 1)
  } else {
    weights <- as.numeric(weights[pdindex])
  }
  
  # Extract levels from variables
  variable_levels <- data %>%
    select(all_of(var)) %>%
    distinct()
  
  # Check if variable is numeric
  is_numeric <- variable_levels %>%
    pull() %>% 
    is.numeric()
  
  # Check the granularity of the variable
  is_granular <- variable_levels %>% 
    pull() %>% 
    length()
  
  # If levels are numeric and too granular, create a subsample of the values
  # Round numeric levels, otherwise there could be a problem with join
  if (all(is_numeric, is_granular > 1000)) {
    
    levels <- round(
      quantile(
        variable_levels %>% 
          arrange(get(var)),
        probs = seq(0, 1, 1 / 1000), 
        names = FALSE, 
        na.rm = T
      ),
      0
    )
    
    variable_levels <- tibble(
      !!var := levels
    )
    
  }
  
  # Create column to store calculated partial dependences
  variable_levels <- variable_levels %>%
    mutate(pd = 0)
  
  # Compute partial dependeces for each combination of feature values
  for (i in 1:nrow(variable_levels)) {
    # Modify the data to have the current combination of feature values
    data_modif <- data_subs %>%
      mutate(!!var := variable_levels[[i, 1]])
    
    # calculate partial dependeces
    variable_levels[i, 2] <- (
      sum(pred_fun(object = model, X = data_modif, ...) * weights) / 
        sum(weights)
    )
  }
  
  variable_levels
}
