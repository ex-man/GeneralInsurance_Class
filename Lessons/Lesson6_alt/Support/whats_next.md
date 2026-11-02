# What next?

The course ends here, but the topics do not. If you want to continue, these are the directions that connect
most directly to what we did.

## Learn R properly

-   **R for Data Science (R4DS)** by Hadley Wickham - the standard introduction to data work in R: importing,
    tidying, transforming, visualising and communicating. Everything we did with `dplyr` and `ggplot2` is
    explained there in a systematic way. Free online: <https://r4ds.hadley.nz>
-   **Advanced R** by Hadley Wickham - how R really works: functions, environments, functional programming.
    Read it when you start writing your own helpers (like `forward_select()` or `mismatch_rank()` in this
    lesson) and want them to be robust. Free online: <https://adv-r.hadley.nz>

## Other modelling methods

A GLM is the standard tool for pricing because it is transparent: every variable has a multiplier. Other
methods can find patterns that a GLM only finds if we prepare them by hand (interactions, non-linear shapes).

-   **A single decision tree** - the simplest of them. It splits the data into groups by a sequence of
    questions ("is the bonus-malus level above 9?"). Easy to draw and explain, but not very accurate.
-   **Random forest and gradient boosting (GBM, XGBoost, LightGBM)** - many trees combined. This is what
    usually wins on predictive accuracy for tabular data. In an insurance project they are often used next to
    the GLM: as a benchmark ("how much accuracy does our GLM leave on the table?") and as a source of ideas for
    new variables, bands and interactions.
-   **Neural networks for tabular data** (for example TabNet) - promising, but on most tabular problems
    boosted trees are still hard to beat, and they are harder to set up.

Whichever you pick, the habits from this course carry over: a clean split between training and validation
data, a metric that is stable enough to compare models (not one noisy number), and a check of the result
against the business reality, as in the price check.

## Understanding models that are not transparent

With trees and boosting there is no table of multipliers. To explain what such a model does, you need
interpretation tools:

-   **Variable importance** - which variables matter most.
-   **Partial dependence plots** - what the model predicts on average as one variable changes.
-   **SHAP values** - how much each variable contributes to a *single* prediction. The `shapviz` and `fastshap`
    packages work with R models.
-   Free book: *Interpretable Machine Learning* by Christoph Molnar, <https://christophm.github.io/interpretable-ml-book/>

## Variable selection beyond this course

We used three simple methods. In practice you will also meet cross-validation (to choose the penalty of the
lasso properly), the elastic net (a mix of the L1 and L2 penalty) and group penalties that keep or remove all
levels of a categorical variable together. The `glmnet` documentation is a good start.
