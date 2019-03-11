library(shiny)
library(dplyr)
library(ggplot2)
dt_KPI_raw <-
  read.csv("C:/GeneralInsurance_Class/Data/lesson2_KPI.csv")
dt_KPI_raw <- dt_KPI_raw %>% filter_all(all_vars(!is.na(.)))

server <- function(input, output)
  
{
  output$graph <- renderPlot({
    ggplot(dt_KPI_raw, aes_string(x = "Premium", y = "Expenses")) +
      geom_point(aes_string(
        x = dt_KPI_raw$Premium,
        y = dt_KPI_raw$Expenses,
        colour = input$select
      )) +
      geom_smooth(
        aes_string(
          x = dt_KPI_raw$Premium,
          y = dt_KPI_raw$Expenses,
          colour = input$select
        ),
        method = loess,
        se = FALSE
      )
  })
}

shinyServer(server)
