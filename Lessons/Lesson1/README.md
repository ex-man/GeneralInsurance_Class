# Objective
To learn how to use GIT, tidyverse and shiny

## Content

1) [git](Support/About_GIT.md) - what is git and why we use it (15 min)
2) GitHub - set account, fork directory (15 min)
3) my first commit/push - create notes for the class to lesson 1 folder (5 min)
4) compare different forks + other exercises (10 min)
5) [Tidyverse](Support/About_tidyverse.md) - collection of useful tools in R for data scientist (actuary as well) (20 min)
6) [Shiny](Support/About_shiny.md) intro - what is it and why is it + hello world shiny app (25 min)

----------------------------------------------

#### Homework (20 min)
##### Implement tidyverse example into shiny and commit into your forked repository

* Prepare interactive scatterplot (Premium vs. Expenses) we have seen in [`ggplot2` example](Support/About_tidyverse_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-13-1.png) and make __colouring__ of the scatter points dynamic based on not only `Region`, but for all categorical variable available in data set `dt_KPI`. Use `shiny` framework
* Save your application into `Lessons/Lesson1/Homework` and `commit` it to your forked repository

> Hint: instead of `aes` you might need `aes_string` 

It might look something like this:

![](Support/About_shiny_files/Lesson1_Homework.png)`
