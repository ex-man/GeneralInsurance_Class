tagList(
  fluidRow(
    div(style = "text-align:center", h3("This is second class about KPIs"))
  ),
  navlistPanel(
    widths = c(2, 6),
    tabPanel("Focus Group",
             fluidRow(
               column(width = 3, offset = 9,
                      uiOutput("lesson2_KPI_multidim_select_axis_render")
                )
             ),
             fluidRow(
               column(width = 9,
                      DT::dataTableOutput("lesson2_KPI_multidim_table")
               ),
               column(width = 3,
                      plotOutput("lesson2_KPI_multidim_ratio_graph", 
                                 width = 400),
                      plotOutput("lesson2_KPI_multidim_UWR_graph", 
                                 width = 400)
               )
             )
    )
  )
)