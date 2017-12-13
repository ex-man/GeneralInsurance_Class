
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

#### Sub-Tab Multi Dim (Focus Group) ####
# dynamically generate filter widgets if columns are categorical (character or factor)
columns_for_choice <- reactive({
  ## find all columns they are category (character or factor)
  # dt <- data_lesson2_KPI_prep_react()
  # 
  # sapply(dt, function(x) {
  #   is.character(x) || is.factor(x)
  # }) %>% 
  # names(dt)[.] 
  
  c("dimension1", "dimension2", "dimension3")
})

observe({
  lapply(columns_for_choice(), FUN = function(x){
    insertUI(
      selector = "#lesson2_KPI_multidim_table",
      where = "beforeBegin",
      ui = selectizeInput(inputId = paste0("lesson2_KPI_multidim_selectize_filter_", x),
                          label = paste0("Filter by ", x),
                          multiple = TRUE, 
                          choices = unique(data_lesson2_KPI_prep_react()[ , x])
          )
      
    )
  })
})

# data prep based on filtering
data_lesson2_KPI_prep_filter_react <- reactive({
  dt <- data_lesson2_KPI_prep_react() 

  one_up_env <- environment()
  lapply(columns_for_choice(), FUN = function(x){
    col_val <- input[[paste0("lesson2_KPI_multidim_selectize_filter_", x)]]

    if(!is.null(col_val)) {
      assign("dt", 
             dt %>% 
               filter_at(vars(x), all_vars(. %in% col_val)),
             envir = one_up_env
             )
      # lapply(columns_for_choice(), function(y){
      #   updateSelectizeInput(session = session,
      #                        inputId = paste0("lesson2_KPI_multidim_selectize_filter_", y),
      #                        choices = unique(dt[ , y])
      #                      )
      # })
    }
  })
  
  dt
  
})

output$lesson2_KPI_multidim_select_axis_render <- renderUI({
  selectInput(inputId = "lesson2_kpi_multidim_select_axis",
              label = "Select Dimension:",
              choices = columns_for_choice()
  )
})

output$lesson2_KPI_multidim_table <- renderDataTable({

  dimensions <- names(input)[grep("lesson2_KPI_multidim_selectize_filter_", names(input))]
  grp_by <- sapply(dimensions, function(x){
    !is.null(input[[x]])
  })

  dt_prep <- data_lesson2_KPI_multidim_prep_filter_react() %>% 
    group_by_at(vars(input$lesson2_kpi_multidim_select_axis)) %>% 
    summarize(LR = mean(LR, na.rm =TRUE),
              ER = mean(ER, na.rm = TRUE),
              CoR = mean(CoR, na.rm = TRUE),
              UWR = sum(UWR, na.rm = TRUE),
              Premium = sum(NEP, na.rm = TRUE)
    ) #%>% 
    # mutate_at(vars(UWR, Premium), funs(scales::dollar)) %>% 
    # mutate_at(vars(LR, ER, CoR), funs(scales::percent)) 
  
    DT::datatable(dt_prep,
                  rownames = FALSE,
                  class = "hover") %>% 
    DT::formatPercentage(c("LR", "ER", "CoR")) %>% 
    DT::formatCurrency(c("UWR", "Premium"), digits = 0) %>%   
    DT::formatStyle(
      'LR',
      background = styleColorBar(dt_prep$LR, 'orange'),
      backgroundSize = '100% 90%',
      backgroundRepeat = 'no-repeat',
      backgroundPosition = 'center'
    ) %>% 
    DT::formatStyle(
        'ER',
        background = styleColorBar(dt_prep$ER, 'green'),
        backgroundSize = '100% 90%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center'
    ) %>% 
    DT::formatStyle(
        'CoR',
        background = styleColorBar(dt_prep$CoR, 'red'),
        backgroundSize = '100% 90%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center'
    ) %>% 
    DT::formatStyle(
        'UWR',
        background = styleColorBar(dt_prep$UWR, 'yellow'),
        backgroundSize = '100% 90%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center'
    ) %>% 
    DT::formatStyle(
        'Premium',
        background = styleColorBar(dt_prep$Premium, 'pink'),
        backgroundSize = '100% 90%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center'
    )
})

