Shiny
================
> ***Interact. Analyse. Communicate.***  
> In data science or actuary world you are always trying to view on the data based on different angle to find the most significant insight. During your data analysis you might come to the point there is so many options to view on the data your code might become too messy or even it is not possible to hard code all options. For such a case `shiny` might come quite handy as it provides very interactive way to serve all options you desire in real time as well as presentation tool for your data story. Perfect thing is you need only R for building this interactive framework.

> `Shiny` is an R package for users who want to create web based applications in R but don't have the necessary skills. Using `shiny`, users can create the aplication engine in R and `shiny` takes care of web page functionality.

### Motivation Example
> This is an example of interactive page created in `shiny`.  
[LEGO Set Visualizer](https://gallery.shinyapps.io/lego-viz)  

-----------------
### HELLO WORLD example
> In following paragrphs we will look at much simpler `shiny` app in more detail. We will use [Telephone By Region app](https://shiny.rstudio.com/gallery/telephones-by-region.html).

Shiny Intro
-----------------
> `Shiny` apps are basically web applications that run on some server. There are different kinds of servers web server that contains the app, or even a local computer. In this course we will run all apps from a local machine.

### Basic app script description
> Every `shiny` app consists of two parts: `ui` and `server`.  
> `ui` (stands for "user interface") basically takes care of everything that will be displayed in the browser.  
> `server` part manages everything that is going on it the background like calculation of R scripts, processing of the inputs that user provides and also preparation of outputs based on the R code.  
> There are two ways of creating `shiny` app.

> 1. **`app.R`** - single R script that contains both `ui` and `server` part. In this case, the R script must contain also command for launching the app.
``` r
shinyApp(ui = ui, server = server)
```
> 2. **`ui.R`** and **`server.R`** - two separate scripts that must be placed in a single folder.
> Throughout this course we will use the second approach. We prefer this way because as codes of an app grow, the split into two separate files makes it easier to navigate in the files.

Other Material, Literature and Credits
--------------------------------------
### Widgets and Inputs vs. Outputs
[Widgets Gallery](https://shiny.rstudio.com/gallery/widget-gallery.html)

### Cheatsheet and other supporting materials
[Shiny cheatsheet](https://github.com/rstudio/cheatsheets/raw/master/shiny.pdf)
[Little explanation](About_shiny_files/shiny_prezi.pdf)

#### Sources
[Rstudio - Shiny](http://shiny.rstudio.com/)
[Shiny - Articles](https://shiny.rstudio.com/articles/)
[Shiny App formats](https://shiny.rstudio.com/articles/app-formats.html)
[Shiny - Tutorial](https://shiny.rstudio.com/tutorial/)
