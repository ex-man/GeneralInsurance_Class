# Rank the variables NOT yet in the model by how much the model misses on them.
#
# For every candidate variable we do what the "actual vs fitted" chart does: group the rows by the
# variable, compute the exposure weighted actual and fitted mean per level and compare them.
# The mismatch of a variable is the exposure weighted average gap between the two lines,
# relative to the overall mean:
#
#   mismatch = sum(exposure_level * |actual_level - fitted_level|) / sum(exposure) / overall mean
#
# Levels with a lot of exposure count more (they are credible), levels with almost no exposure
# hardly count. A large mismatch means "the model is missing information that this variable has".
#
# `chart_vars` is a named character vector: name = variable we add to the model,
# value = the column used for the grouping/plot (for numbers with many values this is a banded copy).
mismatch_rank <- function(data, prediction = "pred", chart_vars,
                          target = "Burning_Cost", weight = "Time_Exposure") {
  overall_mean <- weighted.mean(data[[target]], data[[weight]])

  result <- lapply(seq_along(chart_vars), function(i) {
    by_level <- data |>
      dplyr::group_by(level = .data[[chart_vars[[i]]]]) |>
      dplyr::summarise(
        actual = weighted.mean(.data[[target]], .data[[weight]]),
        fitted = weighted.mean(.data[[prediction]], .data[[weight]]),
        expo = sum(.data[[weight]]),
        .groups = "drop"
      )

    data.frame(
      variable = names(chart_vars)[[i]],
      chart_column = chart_vars[[i]],
      levels = nrow(by_level),
      mismatch = round(sum(by_level$expo * abs(by_level$actual - by_level$fitted)) /
        sum(by_level$expo) / overall_mean, 3)
    )
  })

  dplyr::bind_rows(result) |>
    dplyr::arrange(dplyr::desc(mismatch))
}
