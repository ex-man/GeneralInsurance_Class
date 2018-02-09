Shiny
================
> ***Interact. Analyse. Communicate.***  
> In data science or actuary world you are always trying to view on the data based on different angle to find the most significant insight. During your data analysis you might come to the point there is so many options to view on the data your code might become too messy or even it is not possible to hard code all options. For such a case `shiny` might come quite handy as it provides very interactive way to serve all options you desire in real time as well as presentation tool for your data story.  
> Perfect thing is you need only R for building this interactive framework.

> `Shiny` is an R package for users who want to create web based applications in R but don't have the necessary skills. Using `shiny`, users can create the aplication engine in R and `shiny` takes care of web page functionality.

### Motivation Example
This is an example of interactive page based on data created in `shiny`.  
[LEGO Set Visualizer](https://gallery.shinyapps.io/lego-viz)  

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
To get started with `shiny` we will need RStudio, or R GUI and a web browser. Before we start to do anything with `shiny`, we will have to install the package. To do so, we need to run the following code on our machine `install.packages("shiny")`.

### How shiny works
`Shiny` apps are basically web applications that run on some server. There are different kinds of servers on which the apps can be run. There can be a web server that contains the app, or a local computer.

In this course we will run all apps from a local machine.

### Basic app script description
Every `shiny` app consists of two parts: `ui` and `server`, where `ui` stands for "user interface". User interface part basically takes care of everything that will be displayed in the browser. Server part manages everything that is going on it the background. That is mainly calculation of R scripts, processing of the inputs that user provides in the interaction with the user interface, and also preparation of outputs that are produced based on the R code and the user interaction.

There are two ways of creating `shiny` apps. First is to have a single R script called "app.R" that contains both `ui` and `server` part. In this case, the R script must contain also command for launching the app. The command looks like this: `shinyApp(ui = ui, server = server)`

The second way to write apps is to have two separate scripts - the first script called "ui.R" and the second one called "server.R". These two must be placed in a single folder.

In both of the cases `shiny` looks for the `ui` and `server` part. Throughout this course we will use the second approach. We prefer this way because as codes of an app grow, the split into two separate files makes it easier to navigate in the files.

The minimum code for a working `shiny` app are the following lines saved in a script called "server.R"
```
library(shiny)
server <- function(input, output){}
```
and this line of code saved in "ui.R" in the same folder as the previous script.
```
ui <- fluidPage()
```

To see this app, we have to save these two scripts, then highlight code in "server.R" and run it. A browser tab will be opened and we should see empty web page.

At the start of every `shiny` app we will have to load `shiny` library to be able to run any app. Afterwards, the server part is defined. It must be a function with input and output parameters. The body of the function can contain R codes and scripts that do all the heavy work that will be displayed in form of outputs on the web page.

Then comes the definition of the `ui` part. It must return a `fluidPage()` object. This object basically rewrites everything within to HTML, CSS and JavaScript codes and hence does all the web developement work for us.

And since this is not a single R script `shiny` app, we don't have to call the `shinyApp()` function.

This piece of code is a template that can be used at the start of development of any `shiny` app.

### Inputs and outputs
Basically every `shiny` app will contain two sets of elements - inputs and outputs. We will use these to interact with a user and with our server R scripts. Since we want to show both inputs and outputs to the `shiny` app user, we will add this kind of elements as arguments to `fluidPage()`.

<pre><code>
ui <- fluidPage(
  <i># Input() elements, </i>
  <i># Output() elements </i>
)
</code></pre>

Everything we put in the `fluidPage` object will be what will appear on the web page of our `shiny` app.

#### Let's have a look at inputs

Since we want to have an interactive interface to make a user able to interact with the R script running in the server part of our app, we will need some elements where the user will be able to pass some input to our script.

In `shiny` there are many input elements that are ready for use, for example dropdown menus, buttons, sliders etc. These elements are called widgets. Widgets have simple syntax with their own sets of required parameters to run correctly. However, all widgets have in common first two arguments:

- a name - This is a very important parameter. It is the code name of the widget that is invisible for a `shiny` app user but we will need it in our R codes to reference the values provided from the widget. The name must be unique for every widget of the `shiny` app.

- a label - The label appears on the web page created by the `shiny` app. It should be a string (can be also an empty string).

To see available widgets with explanation of values that they return and their respective R codes visit [this link](https://shiny.rstudio.com/gallery/widget-gallery.html).

With that said, let's try it out in a `shiny` app. We will take the basic app that was introduced in the previous section and add an input component into it. In this case, we will use a slider. The code of our new app will have the following `ui` part

```
ui <- fluidPage(
	sliderInput(
		inputId = "chosen_number",
		label = "Choose a number",
		value = 7,
		min = 1,
		max = 100
	)
)
```

Now we can run this new app. It will now contain also the new input element that we added. Since we didn't connect the input widget to any particular working part of code, it will not affect the run of the application. We can still change the value on the slider, though.

#### Outputs

Outputs are web page elements that are used to display some content to a user. The outputs are elements that can be changed as the user interacts with the input elements of the app, or as the R script is executed. For example we can output data in form of plots, tables or text.

Just like in case of inputs for every type of output there is a separate function. Every output has to have one parameter and that is `outputId`. This is again the code name that should be unique and will be used in our R script to interact with the output in our `shiny` app.

To see all types of output functions, visit [this page](https://shiny.rstudio.com/reference/shiny/1.0.5/), section "UI Outputs".

Let's try to use it in the `shiny` app as well. Firstly, we will update the `ui` code. Since we want to display some output, we will have to put some output function to the `fluidPage` element. In this example we will add to our `shiny` app `plotOutput` function. Our new `ui` code will now look like this

```
ui <- fluidPage(
    sliderInput(
        inputId = "chosen_number",
        label = "Choose a number",
        value = 7,
        min = 1,
        max = 100
    ),
    plotOutput(outputId = "chart")
)
```

We can run the `shiny` app now. There are a couple of things to notice here. First is that elements contained in the `fluidPage` are separated by commas.
The second thing is a bit hidden in the web page source code. Since we didn't tell our app what we want to see on the plot that is output, there is nothing much to see in the app. But when we have a look at the source code of the app, we can notice that there are some HTML tags added that allocate room for the `plotOutput`.

So now we know how to add input and output elements to the `fluidPage`. But we also want to see some output from the app. To achieve this, we will have to make some changes in our `server` code.

### Putting inputs and outputs together

Until now we have looked at separate elements of shiny apps. Now it is time to make use of them in one app that makes these elements work together. This part takes place in the `server` function of a shiny app.

The concept of working with inputs and outputs in our shiny app is fairly simple. The key elements here are the parameters of the server function and IDs of the input and output elements.

The server function in our case occupies a single code called `server.R`. The function has two parameters - input and output. We use these parameters when we want to work with inputs and outputs, respectively.

#### Inputs

When we want to use a value that is passed from a user to the app by an input widget, we reference this value using the input parameter of the server function and the name of the widget. For example if we want to use the value from the slider in our app, we would reference the value from the slider as `input$chosen_number`. This is because we set the `inputId` parameter of the slider to be `chosen_number`.

#### Outputs and render functions

To create a visible output in a shiny app we have to use the output parameter of the server function. Just like we did it with the inputs, we use the parameter and the output ID of the output element.

Compared to the inputs, there is one more step we have to do to really display something in an app. We will need a render function.

Render function is a function that takes R code as an argument and uses this code to render an output object to display a visible output in an app. We can put there a single command but if we use curly brackets inside a render function, we can put there unlimited number of lines of R code or run an entire R script from there.

Similarly to the inputs and output, there are several types of render functions. We use different render functions based on the type of the output we want to display. These functions in some cases create analogous pairs with the output functions, for example `plotOutput` and `renderPlot` or `textOutput` and `renderText`.

To see all types of the rendering functions please visit "Renderig functions" section on [this page](https://shiny.rstudio.com/reference/shiny/1.0.5/).

Now let's try it out in our app from the previous example. We will do it in two steps. The first step will be that we will render a plot in our app. For example we can display a histogram of 100 random numbers generated from normal distribution. We will use the same `ui` as before but we will make a couple of changes in `server`. It will look like this

```
library(shiny)

server <- function(input, output){
    output$chart <- renderPlot(
        hist(rnorm(100))
    )
}
```

When we run this app, we should see our slider, and a chart that is completely unrelated to the value that is provided by the slider. We haven't connected them yet but we will do it in the second step.

What we want to do now is to take the value that a user chooses using the slider and use it to generate the selected number of random numbers. Using the instructions from this section we will further modify the server function to look like this

```
library(shiny)

server <- function(input, output){
    output$chart <- renderPlot(
        hist(rnorm(input$chosen_number))
    )
}
```

This time the slider is connected to what we see on the plot. When the slider moves, it returns a new value which is then used to generate a different number of random values which are then displayed on the chart.

A thing to note here is that we don't have to write any line of code to tell our app to watch out for the changes of the slider. This is carried out automatically by shiny and it is called reactivity. Now we have basically built a simple shiny app with a reactive input slider and a reactive output histogram.

Other Material, Literature and Credits
--------------------------------------
### Widgets and Inputs vs. Outputs
[Widgets Gallery](https://shiny.rstudio.com/gallery/widget-gallery.html)

### Cheatsheet and other supporting materials
[Shiny cheatsheet](https://github.com/rstudio/cheatsheets/raw/master/shiny.pdf)

#### Sources
[Rstudio - Shiny](http://shiny.rstudio.com/)
[Shiny - Articles](https://shiny.rstudio.com/articles/)
[Shiny App formats](https://shiny.rstudio.com/articles/app-formats.html)
[Shiny - Tutorial](https://shiny.rstudio.com/tutorial/)
