
#### MAIN ####
server <- function(input, output, session){
  
  
  # Data for lesson 2 load
  data_lesson3_react <- reactive({
    read.csv("data/lesson3_KPI.csv")
  })
  
  # Definition of basic KPIs
  data_lesson3_KPI_prep_react <- reactive({
    dt <- data_lesson3_react()
    # 
    # prepared <- 
    #   dt %>% # copy all data manipulation we have done in data preparation for KPIs definition
    #   #
    #   #
    #   #
    #   #
    #   
    #   prepared
  })
  
  #### Sub-Tab Multi Dim (Focus Group) ####
  # dynamically generate filter widgets if columns are categorical (character or factor)
  source(file.path("Support", "dynamic_filter.R"),
         local = TRUE)$value
  
  ######################################
  output$lesson3_KPI_multidim_table <- renderDataTable({
    
    # dt_prep <- data_lesson3_KPI_multidim_prep_filter_react()
    # 
    # dt_prep <- 
    #   dt_prep %>%
    #   group_by_at(vars(input$lesson3_kpi_multidim_select_axis)) %>% 
    #   # summarize(LR = , 
    #   #           ER = ,
    #   #           CoR = ,
    #   #           Premium = ,
    #   #           UWR = 
    #   # )
    #   
    #   
    #   DT::datatable(dt_prep,
    #                 rownames = FALSE,
    #                 class = "hover") %>% 
    #   DT::formatPercentage(c("LR", "ER", "CoR")) %>% 
    #   DT::formatCurrency(c("UWR", "Premium"), digits = 0) 
  })
  
  output$lesson3_KPI_multidim_ratio_graph <- renderPlot({
    
    # data_lesson3_KPI_multidim_prep_filter_react() %>% 
    #   group_by_at(vars(input$lesson3_kpi_multidim_select_axis)) %>% 
    #   # summarize(LR = , 
    #   #           ER = ,
    #   #           CoR = ,
    #   #           Premium = ,
    #   #           UWR = 
    #   # ) %>% 
    #   ggplot() +
    #   geom_col(
    #     #
    #     #
    #     #
    #     #
    #     #
    #   ) +
    #   geom_hline(yintercept = 1) +
    #   ylab("Ratios") +
    #   scale_y_continuous(labels = scales::percent) +
    #   theme_bw() +
    #   coord_flip()
    
  })
  
  output$lesson3_KPI_multidim_UWR_graph <- renderPlot({
    # # Homework
    # data_lesson3_KPI_multidim_prep_filter_react() %>%
      
      
  })
  
  
  
  
}