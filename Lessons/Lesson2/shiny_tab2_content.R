tagList(
  fluidRow(
    div(style = "text-align:center", h3("This is second class about KPIs"))
  ),
  navlistPanel(
    widths = c(2, 6),
    tabPanel("Overall",
             fluidRow(
               column(width = 12,
                      h4("Overall KPI's results"),
                      DT::dataTableOutput("lesson2_KPI_total_table")
                      )
              )
    ),
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
    #,
    # tabPanel("Time Dimension",
    #          fluidRow(
    #            column(width = 4, #offset = 1,
    #                   uiOutput("lesson2_KPI_time_filter_daterange_render")
    #            )
    #          ),
    #          fluidRow(
    #            column(width = 9,
    #                   DT::dataTableOutput("lesson2_KPI_time_table")
    #            ),
    #            column(width = 3,
    #                   plotOutput("lesson2_KPI_time_ratio_graph",
    #                              width = 400),
    #                   plotOutput("lesson2_KPI_time_UWR_graph",
    #                              width = 400)
    #            )
    #          )
    # )
  )
)