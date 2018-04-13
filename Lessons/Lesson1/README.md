# Objective
#### To learn how to use Git, Tidyverse and Shiny ####
In this class we will use [**Git**](Support/About_GIT.md) to colaborate and share contents. And we will use some very usefull **R** packages. [**Tidyverse**](Support/About_tidyverse.md) is used for working with data applying database principles and [**Shiny**](Support/About_shiny.md) will help us to visualise results of analysis in graphical way. 

## Content
1) [Git](Support/About_GIT.md) - what is Git and why we use it (15 min)
2) [GitHub](Exercises/Ex01_Fork.md) - set account, fork directory (15 min)
3) [My first commit/push](Exercises/Ex02_MyFirst.md) - create notes for the class to *Lesson 1* folder (5 min)
4) [Compare different forks](Exercises/Ex03_CompareForks.md) - understand how forks work and how to review them (10 min)
5) [Tidyverse](Support/About_tidyverse.md) - collection of useful tools in R for data scientist (actuary as well) (20 min)
6) [Shiny](Support/About_shiny.md) intro - what is it and why is it + hello world shiny app (25 min)

----------------------------------------------
#### Feedback (3 min)

Go to `https://www.surveymonkey.co.uk/r/635ZB8J`, and please answer the questions as they really help us to improve the course.

#### Homework (~20 min) [6b]
##### Implement tidyverse example into shiny and commit into your forked repository

* Prepare interactive scatterplot (Premium vs. Expenses) we have seen in [`ggplot2` example](Support/About_tidyverse_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-13-1.png) and make __colouring__ of the scatter points dynamic based on not only `Region`, but for all categorical variable available in data set `dt_KPI`. Use `shiny` framework
* Save your application into `Lessons/Lesson1/Homework` and `commit` it to your forked repository

> Hint: instead of `aes` you might need `aes_string` 

It might look something like this:  

![](Support/About_shiny_files/Lesson1_Homework.png)`
