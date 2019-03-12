# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).
library(shiny)
library(dplyr)
library(ggplot2)
setwd("D:/aktuarstvo/GeneralInsurance_Class/Data")
dt_KPI <- read.csv("lesson2_KPI.csv")
dt_KPI <- dt_KPI %>% filter_all(all_vars(!is.na(.)))

# Define a server for the Shiny app
server <- function(input, output) {
  
  # Fill in the spot we created for a plot
  output$Plot <- renderPlot({
    ggplot(data = dt_KPI, mapping = aes_string(x = "Premium", y = "Expenses", colour = input$select)) +
    geom_point() +
    geom_smooth()
  })
}