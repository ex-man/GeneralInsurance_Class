
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

#### Sub-Tab Overall
output$lesson2_KPI_total_table <- renderTable({
  data_lesson2_KPI_prep_react() %>% 
    #group_by_(as.name(input$lesson2_kpi_dimension_select)) %>% 
    summarize(LR = mean(LR, na.rm =TRUE),
              ER = mean(ER, na.rm = TRUE),
              CoR = mean(CoR, na.rm = TRUE),
              UWR = sum(UWR, na.rm = TRUE)) %>% 
    mutate(Dimension = "Total") %>% 
    select(Dimension, everything())
})

output$lesson2_KPI_total_graph <- renderPlot({
  data_lesson2_KPI_prep_react() %>% 
    #group_by_(as.name(input$lesson2_kpi_dimension_select)) %>% 
    summarize(LR = mean(LR, na.rm =TRUE),
              ER = mean(ER, na.rm = TRUE),
              CoR = mean(CoR, na.rm = TRUE),
              UWR = sum(UWR, na.rm = TRUE)) %>% 
    mutate(Dimension = "Total") %>% 
    select(Dimension, everything()) %>%
    reshape2::melt(measure.vars = c("LR", "ER"), variable.name = "Ratio") %>% 
    ggplot() +
    geom_col(aes(x = Dimension, y = value, group = Ratio, fill = Ratio),
             position = "stack") +
    ylab("Ratios") +
    theme_bw()
})

#### Sub-Tab Dimension
output$lesson2_KPI_dimension_table <- renderTable({
  data_lesson2_KPI_prep_react() %>% 
    group_by_(as.name(input$lesson2_kpi_dimension_select)) %>% 
    summarize(LR = mean(LR, na.rm =TRUE),
              ER = mean(ER, na.rm = TRUE),
              CoR = mean(CoR, na.rm = TRUE),
              UWR = sum(UWR, na.rm = TRUE))
})

output$lesson2_KPI_dimension_graph <- renderPlot({
  data_lesson2_KPI_prep_react() %>% 
    group_by_(as.name(input$lesson2_kpi_dimension_select)) %>% 
    summarize(LR = mean(LR, na.rm =TRUE),
              ER = mean(ER, na.rm = TRUE),
              CoR = mean(CoR, na.rm = TRUE),
              UWR = sum(UWR, na.rm = TRUE)) %>% 
    reshape2::melt(measure.vars = c("LR", "ER"), 
                   variable.name = "Ratio") %>% 
    ggplot() +
    geom_col(aes_string(x = as.character(input$lesson2_kpi_dimension_select), 
                        y = "value", 
                        group = "Ratio", 
                        fill = "Ratio"),
             position = "stack") +
    ylab("Ratios") +
    theme_bw() +
    coord_flip()
})

