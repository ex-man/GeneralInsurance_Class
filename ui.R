### Libraries ###
library(shiny)
library(shinythemes)

### Other R sources ###
# Tab Content
tab_lesson1_content <-
  source(file.path("Lessons", "Lesson1", "shiny_tab1_content.R"),
         local = TRUE)$value

tab_lesson2_content <-
  source(file.path("Lessons", "Lesson2", "shiny_tab2_content.R"),
         local = TRUE)$value

#### MAIN PAGE ####
ui <- fluidPage(
  theme = shinytheme("paper"),
  title = "General Insurance Class",
  navbarPage(title = span(img(src = "logo_zurich.png", height = 30), "General Insurance Class"),
             tabPanel("Lesson1",
                      tab_lesson1_content),
             tabPanel("Lesson2",
                      tab_lesson2_content),
             tabPanel("Lesson3"),
             tabPanel("Lesson4"),
             tabPanel("Lesson5"),
             tabPanel("Lesson6")
             )
)