Shiny
================
* What `shiny` is and why it can by usefull for actuary
* Motivation Example
* How to install and HELLO WORLD example

  0) folder structure is standard and good practise
  1) ui vs. server
  2) widgets and inputs vs. outputs
  3) HELLO WORLD app, reactivity
* Cheatsheet and other supporting materials


What `shiny` is and why it can by usefull for actuary
----------------
> Interact. Analyse. Communicate.

In data science or actuary world you are always trying to view on the data based on different angle to find the most significant insight.

During your data analysis you might come to the point there is so many options to view on the data your code might become too messy or even it is not possible to __hard__ code all options.

For such a case `shiny` might come quite handy as it provides very interactive way to serve all options you desire __in real time__ as well as presentation tool for your data story.

Perfect thing is you need only R for building this interactive framework.

Shiny is an R package. This package was created for users who want to create web based applications in R but don't have the necessary skills in creation of interactive websites. Using shiny, users can create the aplication engine in R and shiny takes care of web page functionality, such as interactive input and output elements, javascript codes etc.

-----------------
### Motivation Example
[SuperZip Example](https://shiny.rstudio.com/gallery/superzip-example.html)

![](About_shiny_files/superzip.PNG)

-----------------
### How to install and HELLO WORLD example
Install by executing :
```
install.packages("shiny")
library(shiny)
```
#### HELLO WORLD app
[Telephone By Region app](https://shiny.rstudio.com/gallery/telephones-by-region.html)

[Little explanation](About_shiny_files/shiny_prezi.pdf)


Shiny Intro
-----------------
To get started with Shiny we will need RStudio, or R GUI and a web browser. Before we start to do anything with shiny, we will have to install the package. To do so, we need to run the following code on our machine `install.packages("shiny")`.

### Basic app script description 
Every shiny app consists of two parts: `ui` and `server`, where `ui` stands for "user interface". User interface part basically takes care of everything that will be displayed in the browser. Server part manages everything that is going on it the background. That is mainly calculation of R scripts, processing of the inputs that user provides in the interaction with the user interface, and also preparation of outputs that are produced based on the R code and the user interaction.

There are two ways of creating shiny apps. First is to have a single R script called "app.R" that contains both `ui` and `server` part. In this case, the R script must contain also command for launching the app. The command looks like this: `shinyApp(ui = ui, server = server)`

The second way to write apps is to have two separate scripts - the first script called "ui.R" and the second one called "server.R". These two must be placed in a single folder.

In both of the cases shiny looks for the `ui` and `server` part. Throughout this course we will use the second approach. We prefer this way because as codes of an app grow, the split into two separate files makes it easier to navigate in the files.

The minimum code for a working shiny app are the following lines
```
library(shiny)

ui <- fluidPage()
server <- function(input, output){}

shinyApp(ui = ui, server = server)
```
At the start of every shiny app we will have to load shiny library to be able to run any app. Then comes the definition of the `ui` part. It must return a `fluidPage()` object. This object basically rewrites everything within to HTML, CSS and JavaScript codes and hence does all the web developement work for us.

Afterwards, the server part is defined. It must be a function with input and output parameters. The body of the function can contain R codes and scripts that do all the heavy work that will be displayed in form of outputs on the web page.

And since this is a single R script shiny app, we have to call the `shinyApp()` function where we define what are the `ui` and `server` parts of the R script.

This piece of code is a template that can be used at the start of development of any shiny app.

Further resources
-----------------

### Widgets and Inputs vs. Outputs
[Widgets Gallery](https://shiny.rstudio.com/gallery/widget-gallery.html)

### Cheatsheet and other supporting materials
[Shiny cheatsheet](https://github.com/rstudio/cheatsheets/raw/master/shiny.pdf)

#### Sources
[Rstudio - Shiny](http://shiny.rstudio.com/)
[Shiny - Articles](https://shiny.rstudio.com/articles/)
