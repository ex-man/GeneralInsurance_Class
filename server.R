### Other R sources ###
# Tab Content

# tab_lesson1_server<-
#   source(file.path("Lessons", "Lesson1", "shiny_tab1_server.R"),
#          local = TRUE)$value

tab_lesson2_server <-
  source(file.path("Lessons", "Lesson2", "shiny_tab2_server.R"),
         local = TRUE)$value

#### MAIN ####
server <- function(input, output, session){
  
  #### Lesson 1 ####
  #tab_lesson1_server
  
  #### Lesson 2 ####
  tab_lesson2_server
  
}