#Author: Peter Cvacho
#Date: 20/11/2015
#Desctription:
# This is simple application written with 'shiny' package to explore the relationship between target and predicted values
# after modeling was made. The application offers you different options how to show target and predicted values
# based on binning especially for continuous variables.
#This is Server part

#Enjoy!


shinyServer(function(input, output,session) {
      
  output$binning_test<-reactive({
    as.logical(input$var_input %in% contivars)
    #as.logical(getElement(caf_analyse,input$var_input) %>% class =='numeric')
    })
  observe({
    if(input$var_input %in% contivars) {
    val <- c(caf_analyse[,input$var_input] %>% min(na.rm=TRUE),caf_analyse[,input$var_input] %>% max(na.rm=TRUE))
    updateSliderInput(session, "zoom_x", value = mean(caf_analyse[,input$var_input],na.rm=TRUE),
                      min = val[1], max = val[2], step = (val[2]-val[1])/200)
    }
  })
    output$EmblemPlot <- renderPlot({
                
              if (input$var_input %in% classvars) {
                  emblem_graph(caf_analyse,input$var_input,target,modelweight)
              } else {
                      if(input$binning_choose!='no_bin') {
                          caf_analyse<-mutate(caf_analyse,
                                                 binned=switch(input$binning_choose,
                                                               "weight_equal"=
                                                                 bin_weight_equal(
                                                                 caf_analyse[,input$var_input] %>% unlist %>% as.numeric,
                                                                 caf_analyse[,modelweight] %>% unlist %>% as.numeric,
                                                                 input$no_bins)$i_inter,
                                                               "dist_equal"=
                                                                 bin_dist_equal(
                                                                 caf_analyse[,input$var_input] %>% unlist %>% as.numeric,
                                                                 input$no_bins)$i_inter,
                                                               'own_bin' = bin_inter_equal(
                                                                 caf_analyse[,input$var_input] %>% unlist %>% as.numeric,
                                                                 input$own_breaks %>% paste0("c(",.,")") %>% lazy_eval)$i_inter
                                                               )) %>%
                                        rename_(.dots=setNames('binned',as.character(paste(input$var_input,'_binned',sep=''))))
                                             
                          emblem_graph(caf_analyse,
                                       as.character(paste(input$var_input,'_binned',sep='')),
                                       target,
                                       modelweight)
                      } else {
                              if (input$category_noBin=='No Category') {
                                    ggplot(caf_analyse,aes_string(x=input$var_input,y=target),size=3) + 
                                      geom_point(alpha=I(1/10)) + 
                                      theme_classic() +
                                      theme(legend.position=c(0.3,0.8)) +
                                      xlim(input$zoom_x[1],input$zoom_x[2]) +
                                      ylim(input$zoom_y[1],input$zoom_y[2]) +
                                      geom_smooth() 
                              } else {
                                ggplot(caf_analyse,aes_string(x=input$var_input,y=target)) + 
                                  geom_point(aes_string(color=input$category_noBin),alpha=I(1/2)) + 
                                  theme_classic() +
                                  theme(legend.position=c(0.8,0.3)) +
                                  xlim(input$zoom_x[1],input$zoom_x[2]) +
                                  ylim(input$zoom_y[1],input$zoom_y[2]) +
                                  geom_smooth() 
                              }
                      }
              }
  })
#     output$pltly<-renderPlotly({
#       if (!(input$var_input %in% classvars) && input$binning_choose=='no_bin') {
#         
#           if (input$category_noBin=='No Category') {
#             ggplot(caf_analyse,aes_string(x=input$var_input,y='LR')) + 
#               geom_point(alpha=I(1/10)) + 
#               theme_classic() +
#               theme(legend.position=c(0.3,0.8)) +
#               #xlim(input$zoom_x[1],input$zoom_x[2]) +
#               #ylim(input$zoom_y[1],input$zoom_y[2]) +
#               geom_smooth() %>% plotly
#           } else {
#             ggplot(caf_analyse,aes_string(x=input$var_input,y='LR')) + 
#               geom_point(aes_string(color=input$category_noBin),alpha=I(1/2)) + 
#               theme_classic() +
#               theme(legend.position=c(0.8,0.3)) +
#               #xlim(input$zoom_x[1],input$zoom_x[2]) +
#               #ylim(input$zoom_y[1],input$zoom_y[2]) +
#               geom_smooth() %>% plotly
#           }
#         }
#     })
    
})