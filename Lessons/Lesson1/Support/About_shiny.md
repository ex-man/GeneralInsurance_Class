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

### How shiny works
Shiny apps are basically web applications that run on some server. There are different kinds of servers on which the apps can be run. There can be a web server that contains the app, or a local computer.

In this course we will run all apps from a local machine.

### Basic app script description
Every shiny app consists of two parts: `ui` and `server`, where `ui` stands for "user interface". User interface part basically takes care of everything that will be displayed in the browser. Server part manages everything that is going on it the background. That is mainly calculation of R scripts, processing of the inputs that user provides in the interaction with the user interface, and also preparation of outputs that are produced based on the R code and the user interaction.

There are two ways of creating shiny apps. First is to have a single R script called "app.R" that contains both `ui` and `server` part. In this case, the R script must contain also command for launching the app. The command looks like this: `shinyApp(ui = ui, server = server)`

The second way to write apps is to have two separate scripts - the first script called "ui.R" and the second one called "server.R". These two must be placed in a single folder.

In both of the cases shiny looks for the `ui` and `server` part. Throughout this course we will use the second approach. We prefer this way because as codes of an app grow, the split into two separate files makes it easier to navigate in the files.

The minimum code for a working shiny app are the following lines saved in a script called "server.R"
```
library(shiny)
server <- function(input, output){}
```
and this line of code saved in "ui.R" in the same folder as the previous script.
```
ui <- fluidPage()
```

To see this app, we have to save these two scripts, then highlight code in "server.R" and run it. A browser tab will be opened and we should see empty web page.

At the start of every shiny app we will have to load shiny library to be able to run any app. Afterwards, the server part is defined. It must be a function with input and output parameters. The body of the function can contain R codes and scripts that do all the heavy work that will be displayed in form of outputs on the web page.

Then comes the definition of the `ui` part. It must return a `fluidPage()` object. This object basically rewrites everything within to HTML, CSS and JavaScript codes and hence does all the web developement work for us.

And since this is not a single R script shiny app, we don't have to call the `shinyApp()` function.

This piece of code is a template that can be used at the start of development of any shiny app.

### Inputs and outputs
Basically every shiny app will contain two sets of elements - inputs and outputs. We will use these to interact with a user and with our server R scripts. Since we want to show both inputs and outputs to the shiny app user, we will add this kind of elements as arguments to `fluidPage()`.

<pre><code>
ui <- fluidPage(
  <i># Input() elements, </i>
  <i># Output() elements </i>
)
</code></pre>

Everything we put in the `fluidPage` object will be what will appear on the web page of our shiny app.

#### Let's have a look at inputs

Since we want to have an interactive interface to make a user able to interact with the R script running in the server part of our app, we will need some elements where the user will be able to pass some input to our script.

In shiny there are many input elements that are ready for use, for example dropdown menus, buttons, sliders etc. These elements are called widgets. Widgets have simple syntax with their own sets of required parameters to run correctly. However, all widgets have in common first two arguments:
+a name - This is  avery important parameter. It is the code name of the widget that is invisible for a shiny app user but we will need it in our R codes to reference the values provided from the widget. The name must be unique for every widget of the shiny app.
+a label - The label appears on the web page created by the shiny app. It should be a string (can be also an empty string).

To see available widgets with explanation of values that they return and their respective R codes visit [this link](https://shiny.rstudio.com/gallery/widget-gallery.html).

With that said, let's try it out in a shiny app. We will take the basic app that was introduced in the previous section and add an input component into it. In this case, we will use a slider. The code of our new app will have the following `ui` part

```
ui <- fluidPage(
	sliderInput(
		inputId = "chosen_number",
		label = "Choose a number",
		value = 7,
		min = 1,
		max = 10
	)
)
```

Now we can run this new app. It will now contain also the new input element that we added. Since we didn't connect the input widget to any particular working part of code, it will not affect the run of the application. We can still change the value on the slider, though.

#### Outputs

Outputs are web page elements that are used to display some content to a user. The outputs are elements that can be changed as the user interacts with the input elements of the app, or as the R script is executed. For example we can output data in form of plots, tables or text.

Just like in case of inputs for every type of output there is a separate function. Every output has to have one parameter and that is `outputId`. This is again the code name that should be unique and will be used in our R script to interact with the output in our shiny app.

Further resources
-----------------
There are many interesting resources and more extensive tutorials on Internet for further learning. We recommend a couple of them on the links below.

### Widgets and Inputs vs. Outputs
[Widgets Gallery](https://shiny.rstudio.com/gallery/widget-gallery.html)

### Cheatsheet and other supporting materials
[Shiny cheatsheet](https://github.com/rstudio/cheatsheets/raw/master/shiny.pdf)

#### Sources
[Rstudio - Shiny](http://shiny.rstudio.com/)
[Shiny - Articles](https://shiny.rstudio.com/articles/)
[Shiny App formats](https://shiny.rstudio.com/articles/app-formats.html)
[Shiny - Tutorial](https://shiny.rstudio.com/tutorial/)
