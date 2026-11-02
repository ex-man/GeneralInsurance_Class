# Weighted Tweedie deviance (variance power p, default 1.5 as in our GLMs).
# Lower is better. Unlike the grouped RMSE it uses every row, so it is much more stable
# when we compare models on a small number of claims.
tweedie_deviance <- function(actual, prediction, weight = NULL, power = 1.5) {
  if (is.null(weight)) {
    weight <- rep(1, length(actual))
  }

  y <- actual
  mu <- prediction
  term_y <- ifelse(y > 0, y^(2 - power) / ((1 - power) * (2 - power)), 0)

  sum(weight * 2 * (term_y - y * mu^(1 - power) / (1 - power) + mu^(2 - power) / (2 - power)))
}
