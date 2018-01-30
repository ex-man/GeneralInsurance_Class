Tidyverse
================

> **Tidyverse** is collection of very usefull R packages for data wrangling, visualization etc. You don't need to manually install it as it is already part of R project for this class.
> We will use mainly two, `dplyr` for data preparation and `ggplot2` for visualizations.  
> You can find here links to package cheatsheets and simple example. We will not go through details buth rather learn by doing.  
> In the end of section there is link to literature, vignettes and nice examples.  

------------------------------------------------------------------------

dplyr - data transformation package
-----------------------------------

> `dplyr` is well known package for data tranformation especially in recent R community.  
> It's using concept [grammar of data transformation](https://rstudio-pubs-static.s3.amazonaws.com/153547_3a8e24d4ceeb4868a5f22e70641e8165.html#/) providing consistent set of verbs that help you solve the most common data manipulation challenges.  
> You can solve ~85% of data manipulation issues using 6 verbs:
-   `mutate()` adds new variables that are functions of existing variables
-   `select()` picks variables based on their names.
-   `filter()` picks cases based on their values.
-   `summarise()` reduces multiple values down to a single summary.
-   `arrange()` changes the ordering of the rows.

> These all combine naturally with `group_by()` which allows you to perform any operation "by group". You can learn more about them in `vignette("dplyr")`. As well as these single-table verbs, dplyr also provides a variety of two-table verbs, which you can learn about in `vignette("two-table")`.

> Let's try it now in R

ggplot2 - data visualization package
------------------------------------

> “The simple graph has brought more information to the data analyst’s mind than any other device.” — John Tukey

Althoug R has a lot of systems of providing graphics, `ggplot2` is one of the most elegant and most versatile system for visualiaztion in R. ggplot2 implements the [grammar of graphics](http://vita.had.co.nz/papers/layered-grammar.html), a coherent system for describing and building graphs.

### First Plot - Scatter

``` r
library(ggplot2)

ggplot(data = dt_KPI) +
  geom_point(mapping = aes(x = Premium, y = Expenses))
```

![](About_tidyverse_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-11-1.png)

### Aesthetics and layers

``` r
ggplot(data = dt_KPI) +
  geom_point(mapping = aes(x = Premium, y = Expenses, colour = Region))
```

![](About_tidyverse_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-12-1.png)

### Geometric Objects and iheritance of aesthetics

``` r
ggplot(data = dt_KPI,
       mapping = aes(x = Premium, y = Expenses, colour = Region)
) +
geom_point() +
geom_smooth()
```

![](About_tidyverse_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-13-1.png)

Other Material, Literature and Credits
--------------------------------------

[R for Data Science - Data Transformation](http://r4ds.had.co.nz/transform.html#introduction-2)

[R for Data Science - Data Visualization](http://r4ds.had.co.nz/data-visualisation.html)

[dplyr cheatsheet](https://github.com/rstudio/cheatsheets/raw/master/data-transformation.pdf)

[ggplot2 cheatsheet](https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf)
