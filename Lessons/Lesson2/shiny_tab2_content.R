tagList(
  fluidRow(
    div(style = "text-align:center", h3("This is second class about KPIs"))
  ),
  navlistPanel(
    tabPanel("Overall"),
    tabPanel("Dimensions",
             selectInput(inputId = "lesson2_kpi_dimension_select",
                         label = "Select Dimension:",
                         choices = c("dimension1", "dimension2", "dimension3")
                         ),
             tableOutput("lesson2_KPI_dimension_table")
             ),
    h3("Its nothing here right now")
  )
)