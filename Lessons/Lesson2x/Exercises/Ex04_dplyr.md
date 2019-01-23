## Exercise - dplyr
> We will work with the local repository you have cloned in the first (Git) exercise.  
> Open R project for this class in R Studio  
> Run following command in R console to link to `dplyr` library:
``` r
library(dplyr)
```

### Piping
> Now let's try to calculate simple thing using multiple encapsulated functions.
``` r
abs(min(c(1, 4, 2, 8, -5)))
```
> Can you understand what this command does?  
> Is following result what you've expected?  
``` r
  ## [1] 5
```    
> with `dplyr` we can code the same thing using **piping**
``` r
c(1, 4, 2, 8, -5) %>% min %>% abs
```
> result is the same
``` r
  ## [1] 5
```    

### 6 basic `dplyr` verbs
> In this exercise let's practice `dplyr` and **piping** on simple dataset.  
>  
> Firstly let's `read` some data in:  
``` r
dt_KPI <- read.csv("data/lesson2_KPI.csv")
```
> We can select top 6 rows using `head` function. 
``` r
dt_KPI %>% head
```
> is giving us  
``` r
    ##    Region  Unit Segment  Business Year    Losses  Expenses Premium
    ## 1 Alandia Unit1     Big   Doctors 2012 2520045.7 1158681.0 4739761
    ## 2 Alandia Unit1     Big   Doctors 2013 4272333.6 2051002.6 6086992
    ## 3 Alandia Unit1     Big   Doctors 2014 2212548.6 1613848.3 2668969
    ## 4 Alandia Unit1     Big   Doctors 2015 2408595.1 1719529.1 3741451
    ## 5 Alandia Unit1     Big   Doctors 2016 6189395.3 3831292.8 8451344
    ## 6 Alandia Unit1     Big Criminals 2012  406094.8  309548.2 2755107
```

> OK, now let's create additonal column (*Combined*) by `mutate` and showing first 6 rows right away.  
``` r
dt_KPI %>% 
  mutate(Combined = Losses + Expenses) %>% head
```
> gives us  
``` r
    ##    Region  Unit Segment  Business Year    Losses  Expenses Premium
    ## 1 Alandia Unit1     Big   Doctors 2012 2520045.7 1158681.0 4739761
    ## 2 Alandia Unit1     Big   Doctors 2013 4272333.6 2051002.6 6086992
    ## 3 Alandia Unit1     Big   Doctors 2014 2212548.6 1613848.3 2668969
    ## 4 Alandia Unit1     Big   Doctors 2015 2408595.1 1719529.1 3741451
    ## 5 Alandia Unit1     Big   Doctors 2016 6189395.3 3831292.8 8451344
    ## 6 Alandia Unit1     Big Criminals 2012  406094.8  309548.2 2755107
    ##   Combined
    ## 1  3678727
    ## 2  6323336
    ## 3  3826397
    ## 4  4128124
    ## 5 10020688
    ## 6   715643
```
> What if we want to see only *Region* and *Losses*? Let's `select` it to output:  
``` r
dt_KPI %>% 
  select(Region, Losses) %>% head
```
> This is giving us  
``` r
    ##    Region    Losses
    ## 1 Alandia 2520045.7
    ## 2 Alandia 4272333.6
    ## 3 Alandia 2212548.6
    ## 4 Alandia 2408595.1
    ## 5 Alandia 6189395.3
    ## 6 Alandia  406094.8
```
> We can also `filter` data using condition on one (or more) columns  
``` r
dt_KPI %>% 
  filter(Business == "Criminals") %>% head
```
> returning *Criminals* data only  
``` r
    ##    Region  Unit Segment  Business Year    Losses  Expenses Premium
    ## 1 Alandia Unit1     Big Criminals 2012  406094.8  309548.2 2755107
    ## 2 Alandia Unit1     Big Criminals 2013  553705.5 1159439.1 3853190
    ## 3 Alandia Unit1     Big Criminals 2014 1169258.6 1164472.9 4247686
    ## 4 Alandia Unit1     Big Criminals 2015 1870166.5 1035699.5 4980802
    ## 5 Alandia Unit1     Big Criminals 2016 1552076.1 1498643.6 7437430
    ## 6 Alandia Unit1     Big Criminals 2012  141731.1  961888.1 2281195
```
> In some cases it is good to `arange` the data to have a better picture about it  
``` r
dt_KPI %>% 
  arrange(Losses, desc(Premium)) %>% head
```
> is ordering data by *Premium*
``` r
    ##     Region   Unit Segment Business Year   Losses    Expenses     Premium
    ## 1 Belandia Unit11     Big     <NA> 2016 -9204887   -736449.0   1282337.3
    ## 2    Cegro Unit13     Big     <NA> 2016 -4769805  -1169280.1  89715605.9
    ## 3    Cegro Unit13     Big     <NA> 2014 -2552363   -727952.9         0.0
    ## 4    Cegro Unit14     Big     <NA> 2016 -1930677 -12353445.2 -23717167.9
    ## 5    Cegro Unit14   Small     <NA> 2015 -1862066   1601650.9   -380880.4
    ## 6    Cegro Unit12   Small     <NA> 2016 -1397744   -264918.0 -12588349.4
```
> Or we may want to `summarise` data to see some basic statistic about it. 
``` r
dt_KPI %>% 
  summarise(Loss_avg = mean(Losses))
```
> gives us average loss  
``` r
    ##   Loss_avg
    ## 1 29227137
```
> We may also want to see the summary split by one (or more) of columns.  
``` r
dt_KPI %>% 
  group_by(Region) %>% 
  summarise(Loss_avg = mean(Losses)) %>% head
```
> gives us average loss by *Region*  
``` r
    ## # A tibble: 3 x 2
    ##     Region Loss_avg
    ##     <fctr>    <dbl>
    ## 1  Alandia 24001038
    ## 2 Belandia 41959316
    ## 3    Cegro  8317821
```

[Return to previous section](../Support/About_tidyverse.md)
[Proceed to ggplot2 exercise](Ex05_ggplot2.md)