## Exercise - ggplot2
> We will work with the local repository you have cloned in the first (Git) exercise.  
> Open R project for this class in R Studio  
> Run following command in R console to link to `ggplot2` library:
``` r
library(ggplot2)
```
> Load data if you have not done so yet:
``` r
dt_KPI <- read.csv("Data/lesson2_KPI.csv")
```
> every plot created with ggplot2 has 3 base layers:
**data** or source to visualize,
**aesthetics** - graphical representation of data (axes specification, colors / filling, ...),
**geoms**  — visual layers that represent specific aspects of data (points, lines, ...).

### First Plot - Scatter
> Now let's try to show our data on simple scatter plot  
``` r
ggplot(data = dt_KPI,aes(x = Premium, y = Expenses)) + geom_point()
```
> We used `ggplot` function specifying **data** set to use, `aes` function to specify aestetics (visualisation) and ***geoms*** function `geom_point` to specify how data should be represemeted.  
> Note that we used `+` sign to add geom layer to chart. We will use this technique in future steps as well.  

![](../Support/About_tidyverse_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-11-1.png)

### Aesthetics and layers
> In previous example we set **data** and **aesthetics** on global level, setting axes in **geoms** to ***Premium*** and ***Expenses***. We will do the same now but specifying it for geom `geom_points` only. This is usefull when you want to show multiple measures on same chart having their own axes.  
> In addition we will also specify colour of dots varying colour by ***Region***.  
``` r
ggplot(data = dt_KPI) +
geom_point(mapping = aes(x = Premium, y = Expenses, colour = Region))
```

![](../Support/About_tidyverse_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-12-1.png)

### Geometric Objects and iheritance of aesthetics
> Now let's add new **geom** for smoothed regresion line. We will do so by adding new **geom** using `+` sign and function `geom_smooth`.  
> 
``` r
ggplot(data = dt_KPI)
+ geom_point(mapping = aes(x = Premium, y = Expenses, colour = Region))
+ geom_smooth(mapping = aes(x = Premium, y = Expenses))
````
> Note that there is one regresion line for whole dataset.  
> Also note that we can specify `x` and `y` for each **geom** separatelly.  
![](../Support/About_tidyverse_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-14-1.png)

> What if we specify `aes` on global (`ggplot`) level.
``` r
ggplot(data = dt_KPI,
       mapping = aes(x = Premium, y = Expenses, colour = Region)
) +
geom_point() +
geom_smooth()
```
> This will produce chart with dots and smoothed line where regresion is done on data by ***Region***.  
> This feature of `ggplot` is called **inheritance**. You can do lot's using it.  
![](../Support/About_tidyverse_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-13-1.png)

> You can find out more about `ggplot` features on [ggplot2 cheatsheet](https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf).

[Return to previous section](../Support/About_tidyverse.md)

[Proceed to 'Losses and Expenses' section](../Support/L2_losses_and_expenses.md)