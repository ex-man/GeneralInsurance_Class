
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

