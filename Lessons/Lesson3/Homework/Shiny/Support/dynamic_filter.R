### dynamically generate filter widgets if columns are categorical (character or factor)
columns_for_choice <- reactive({
  # find all columns they are category (character or factor)
  dt <- data_lesson3_KPI_prep_react()
  
  sapply(dt, function(x) {
    is.character(x) || is.factor(x)
  }) %>%
    names(dt)[.]
  
  # c("dimension1", "dimension2", "dimension3")
})

observe({
  lapply(columns_for_choice(), FUN = function(x){
    insertUI(
      selector = "#lesson3_KPI_multidim_table",
      where = "beforeBegin",
      ui = selectizeInput(inputId = paste0("lesson3_KPI_multidim_selectize_filter_", x),
                          label = paste0("Filter by ", x),
                          multiple = TRUE, 
                          choices = unique(data_lesson3_KPI_prep_react()[ , x])
      )
      
    )
  })
})

# data prep based on filtering
data_lesson3_KPI_multidim_prep_filter_react <- reactive({
  dt <- data_lesson3_KPI_prep_react() 
  
  # setup filter
  one_up_env <- environment()
  lapply(columns_for_choice(), FUN = function(x){
    col_val <- input[[paste0("lesson3_KPI_multidim_selectize_filter_", x)]]
    
    if(!is.null(col_val)) {
      assign("dt", 
             dt %>% 
               filter_at(vars(x), all_vars(. %in% col_val)),
             envir = one_up_env
      )
    }
  })
  
  # update selections based on selected filtering
  sapply(columns_for_choice(), function(y){
    col_val <- input[[paste0("lesson3_KPI_multidim_selectize_filter_", y)]]
    if(is.null(col_val)) {
      updateSelectizeInput(session = session,
                           inputId = paste0("lesson3_KPI_multidim_selectize_filter_", y),
                           choices = unique(dt[ , y])
      )
    }
  })
  
  dt
  
})

output$lesson3_KPI_multidim_select_axis_render <- renderUI({
  selectInput(inputId = "lesson3_kpi_multidim_select_axis",
              label = "Select Dimension:",
              choices = columns_for_choice()
  )
})