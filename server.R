### Libraries ###
library(dplyr)
library(magrittr)
library(ggplot2)
library(DT)

#### MAIN ####
server <- function(input, output, session){
  
  #### Lesson 1 ####
  #   source(file.path("Lessons", "Lesson1", "shiny_tab1_server.R"),
  #          local = TRUE)$value
  
  #### Lesson 2 ####
  source(file.path("Lessons", "Lesson2", "shiny_tab2_server.R"),
         local = TRUE)$value
  
}