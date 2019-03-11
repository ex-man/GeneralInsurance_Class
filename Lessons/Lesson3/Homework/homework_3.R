library(shiny)
library(dplyr)
library(ggplot2)
dt_KPI_raw <- read.csv("./Data/lesson2_KPI.csv")
#dt_KPI_raw <- read.csv("C:/Users/Lucia_Sebestova/Documents/Matfyz(4)/VTvAktuarstve/GeneralInsurance_Class/Data/lesson2_KPI.csv") # v mojom prípade cesta k lesson2_KPI.csv
dt_KPI_raw <- dt_KPI_raw %>% filter_all(all_vars(!is.na(.)))
ui <- fluidPage(
  titlePanel("Scatter Plot with colour"),
  selectInput("colouring_var", "Colouring Var:", 
              choices = list( "Region", "Unit", "Segment","Business", "Year")),
  plotOutput(outputId = "scatterPlot"))
server <- function(input, output) 
{
  output$scatterPlot <- renderPlot({
    ggplot(dt_KPI_raw, aes_string(x = "Premium", y = "Expenses")) +
      geom_point(aes_string(x = dt_KPI_raw$Premium, y = dt_KPI_raw$Expenses, colour = input$colouring_var)) +
      geom_smooth(aes_string(x = dt_KPI_raw$Premium, y = dt_KPI_raw$Expenses, colour = input$colouring_var), method = loess, se = FALSE)})
}

shinyApp(ui, server)

# why categories behave differently?
# 1.Vzťah medzi Premium a Expenses je najstrmší v regióne Belandia, pretože v ňom sú podniky vyžadujúce vyššie náklady na menší zisk.
# 2.Keďže portfólio Unit7 obsahuje najrizikovejšie podniky, tak Premium aj Expenses majú preň najvyššie hodnoty.
# 3.Small Segment sú rizikovejšie ako Big Segment, preto pre Premium a Expenses majú vyššie hodnoty.
# 4.Vzťah medzi Premium a Expenses je najstrmší v Business Housing v porovnaní s ostatnými odvetviami.Business Housing ovplyvňuje množstvo faktorov, preto sú nákladnejšie v pomere k zisku ako iné odvetvia.

