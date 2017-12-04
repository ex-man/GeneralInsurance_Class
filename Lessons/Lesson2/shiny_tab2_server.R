
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
    mutate(LR = Loss / NEP / 100,
           ER = Expenses / NEP / 100,
           CoR = (Loss + Expenses) / NEP / 100,
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
              UWR = sum(UWR, na.rm = TRUE), 
              Premium = sum(NEP, na.rm = TRUE)
    ) %>% 
    mutate(Dimension = "Total") %>% 
    select(Dimension, everything()) %>% 
    mutate_at(vars(UWR, Premium), funs(scales::dollar)) %>% 
    mutate_at(vars(LR, ER, CoR), funs(scales::percent))
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
    scale_y_continuous(labels = scales::percent) +
    theme_bw()
})

output$lesson2_KPI_total_UWR_graph <- renderPlot({
  data_lesson2_KPI_prep_react() %>% 
    summarize(UWR = sum(UWR, na.rm = TRUE)) %>% 
    mutate(Dimension = "Total") %>% 
    ggplot() +
    geom_col(
      aes(x = Dimension,
          y = UWR
      ),
      fill = "dodgerblue2"
    ) +
    ylab("UWR") +
    scale_y_continuous(labels = scales::dollar) +
    theme_bw()
})

#### Sub-Tab Dimension
output$lesson2_KPI_dimension_table <- renderTable({
  data_lesson2_KPI_prep_react() %>% 
    group_by_(as.name(input$lesson2_kpi_dimension_select)) %>% 
    summarize(LR = mean(LR, na.rm =TRUE),
              ER = mean(ER, na.rm = TRUE),
              CoR = mean(CoR, na.rm = TRUE),
              UWR = sum(UWR, na.rm = TRUE),
              Premium = sum(NEP, na.rm = TRUE)
    ) %>% 
    mutate_at(vars(UWR, Premium), funs(scales::dollar)) %>% 
    mutate_at(vars(LR, ER, CoR), funs(scales::percent))
})

output$lesson2_KPI_dimension_ratio_graph <- renderPlot({
  data_lesson2_KPI_prep_react() %>% 
    group_by_(as.name(input$lesson2_kpi_dimension_select)) %>% 
    summarize(LR = mean(LR, na.rm =TRUE),
              ER = mean(ER, na.rm = TRUE),
              CoR = mean(CoR, na.rm = TRUE),
              UWR = sum(UWR, na.rm = TRUE)) %>% 
    reshape2::melt(measure.vars = c("LR", "ER"), 
                   variable.name = "Ratio") %>% 
    ggplot() +
    geom_col(
      aes_string(
        x = as.character(input$lesson2_kpi_dimension_select), 
        y = "value", 
        group = "Ratio", 
        fill = "Ratio"
      ),
      position = "stack"
    ) +
    ylab("Ratios") +
    scale_y_continuous(labels = scales::percent) +
    theme_bw() +
    coord_flip()
})

output$lesson2_KPI_dimension_UWR_graph <- renderPlot({
  data_lesson2_KPI_prep_react() %>% 
    group_by_(as.name(input$lesson2_kpi_dimension_select)) %>% 
    summarize(UWR = sum(UWR, na.rm = TRUE)) %>% 
    ggplot() +
    geom_col(
      aes_string( x = as.character(input$lesson2_kpi_dimension_select), 
                  y = "UWR"
                ),
      fill = "dodgerblue2"
    ) +
    ylab("UWR") +
    scale_y_continuous(labels = scales::dollar) +
    theme_bw() +
    coord_flip()
})

