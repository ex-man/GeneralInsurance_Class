#Author: Peter Cvacho
#Date: 20/11/2015
#Desctription:
# This is simple application written with 'shiny' package to explore the relationship between target and predicted values
# after modeling was made. The application offers you different options how to show target and predicted values
# based on binning especially for continuous variables.
#This is UI part

#Enjoy!

shinyUI(fluidPage(
  
  titlePanel("Explore Data"),
  
  textOutput('binning_test'),
  
          plotOutput("EmblemPlot",height=500),
          #plotlyOutput("pltly",height=500),
          
          hr(),
          
          fluidRow(
                column(4,
                  selectInput("var_input",label=h4("Choose variable"),
                              choices=as.list(predictors)
                    )),
                
                column(4,
                conditionalPanel(
                  condition= "output.binning_test",
                        radioButtons("binning_choose","Choose the binning methodology:",
                                     c('Distribution Equal'='dist_equal',
                                       #'Weight Equal'='weight_equal',
                                       'Own Binning'= 'own_bin',
                                       'No Binning'='no_bin'),
                                     selected = 'dist_equal'
                        )
                )),
                column(4,
                       conditionalPanel(
                         condition= "output.binning_test && (input.binning_choose!='no_bin' && input.binning_choose!='own_bin')",
                         sliderInput("no_bins","Number of Bins",2,20,5,1)
                         ),
                       conditionalPanel(
                         condition="output.binning_test && (input.binning_choose=='no_bin')",
                          selectInput("category_noBin",label="Choose variable to color by",
                                     choices=as.list(c(predictors,'No Category')),
                                     selected = 'No Category'),
                           sliderInput("zoom_x", "X Axis Zoom",
                                       min = 0, max = 2, value = c(0.25, 1.5),step=0.01),
                           sliderInput("zoom_y", "Y Axis Zoom",
                                     min = 0, max = 300, value = c(0.25, 1.5),step=0.01)
                           
                         ),
                       conditionalPanel(
                         condition="output.binning_test && (input.binning_choose=='own_bin')",
                         textInput("own_breaks", label = h3("Define your own breaks"), value = "0,50,100,1000")
                        )
                       )
        
            )

))