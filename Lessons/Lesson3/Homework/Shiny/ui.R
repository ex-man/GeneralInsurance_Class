library(shiny)
library(ggplot2)
library(dplyr)
setwd("D:/aktuarstvo/GeneralInsurance_Class/Data")
dt_KPI <- read.csv("lesson2_KPI.csv")
dt_KPI <- dt_KPI %>% filter_all(all_vars(!is.na(.)))

ui <- fluidPage(
  titlePanel("Premium vs. Expenses"),
  sidebarLayout(      
   sidebarPanel(
      selectInput("select", "Colouring Var: ", 
                  choices=list("Region", "Unit", "Segment", "Business", "Year")),
      hr(),
      helpText("KPI data")
    ),
  
    mainPanel(
      plotOutput("Plot")  
    )
    
  )
  
)


#slovny popis:
#pri pohlade na Region z grafu vidime, ze zo zaciatku su vsetky regiony indiferentne, co sa nakladovosti/ziskov tyka, ale potom region Alandia bude pravdepodobne najvacsim, co sa poctu poistenych tyka, lebo hoci dosahuje najvacsie zisky, ale aj najvacsie naklady kvoli rychlemu rastu smernice
#z grafu Unit sa da vidiet, ze hlavnou skupinou poistenych bude Unit2 podla podobnej uvahy
#zo Segmentoveho grafu sa dozvedame, ze poistovna sa zameriava skor na maly segment, alebo mozno budu naklady aj zisky preto take vysoke oproti velkemu segmentu, lebo sa v tomto segmente stavaju poistne udalosti castejsie a aj preto je poistne vyssie(predp. z vyssich ziskov), nakladovy graf velkeho segmentu je prevazne pod grafom maleho segmentu, a teda je menej nakladny  
#z grafu pre Business mozeme usudit, ze najziskovejsou bude oblast travel a potom housing, avsak pri domacnostiach naklady rastu rychlejsie kvoli strmsiemu sklonu