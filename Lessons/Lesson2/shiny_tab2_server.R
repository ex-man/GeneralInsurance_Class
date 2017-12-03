
# Data for lesson 2 load
data_lesson2_react <- reactive({
  readRDS("data/data_lesson2.rds")
})

# Definition of basic KPIs
data_lesson2_KPI_prep_react <- reactive({
  dt <- data_lesson2_react()
  
  prepared <- 
    dt %>% 
    rename(NEP = premium,
           Loss = loss,
           Expenses = expenses,
           Time = date) %>% 
    mutate(LR = Loss / NEP,
           ER = Expenses / NEP,
           CoR = (Loss + Expenses) / NEP,
           UWR = NEP - Loss - Expenses) 
  
  prepared
})

output$lesson2_KPI_dimension_table <- renderTable({
  data_lesson2_KPI_prep_react() %>% 
    group_by_(as.name(input$lesson2_kpi_dimension_select)) %>% 
    summarize(LR = mean(LR, na.rm =TRUE),
              ER = mean(ER, na.rm = TRUE),
              CoR = mean(CoR, na.rm = TRUE),
              UWR = sum(UWR, na.rm = TRUE))
})
