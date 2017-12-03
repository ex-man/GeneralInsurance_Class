tagList(
  fluidRow(
    div(style = "text-align:center", h3("This is second class about KPIs"))
  ),
  navlistPanel(
    widths = c(2, 6),
    tabPanel("Overall",
             fluidRow(
               column(width = 8,
                      tableOutput("lesson2_KPI_total_table")
                      ),
               column(width = 4,
                      plotOutput("lesson2_KPI_total_graph", width = 400)
                      )
              )
    ),
    tabPanel("Dimensions",
             selectInput(inputId = "lesson2_kpi_dimension_select",
                         label = "Select Dimension:",
                         choices = c("dimension1", "dimension2", "dimension3")
              ),
             fluidRow(
               column(width = 8,
                      tableOutput("lesson2_KPI_dimension_table")
               ),
               column(width = 4,
                      plotOutput("lesson2_KPI_dimension_graph", width = 400)
               )
             )
    )
  )
)