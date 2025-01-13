#' Cuts a vector into equal weight bins
#'
#' This function cuts a numeric vector into n equal weight bins.
#'
#' @param x A numeric vector
#' @param n An integer specifying the number of bins to create (default is 10)
#' @return A factor vector with labels indicating the bin number
#' @examples
#' # Create equal weight bins
#' x <- rnorm(100)
#' cut_weight(x, n = 5)
#'
#' @export

cut_weight <- function(x, n = 10) {
  
  # Calculate cumulative sum of x
  x <- cumsum(x)
  # Calculate breaks for equal weight bins
  breaks <- 1:n * tail(x, 1) / n
  breaks[length(breaks)] <- breaks[length(breaks)] + 1
  # Cut x into equal weight bins
  cut(x, breaks = c(-Inf, breaks), labels = 1:n)
}