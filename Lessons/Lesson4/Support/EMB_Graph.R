# Author: Peter Cvacho
# Date: 20/11/2015
# Description: 
#   this function creates standart emblem graph of 
#   categorical variable with 
#   actual values vs. predicted values (e.g. observed loss vs. predicted loss)
#   the values were calculated by weighted mean by modelweight
#   bottom graph is showing the weight (e.g. exposure or expected loss)

#libraries needed to run this function
library(ggplot2)  #grammar of graphics package
library(gridExtra)#extra package for combining the graph
library(grid)     #extra package for combining the graph
library(dplyr)    #data manipulation
library(reshape2) #melting the data frame to long format
library(lazyeval) #for non-standard evaluation to create general purpose code

emblem_graph<-function(dt.frm,x_var,target,modelweight,x_var_name=' ') {

#data preparation for graph
  prepared<-dt.frm %>%
      group_by_(x_var) %>% 
      summarise_( actual_mean = interp(~ mean(x,na.rm=TRUE), x=as.name(target)#,y=as.name(modelweight)
                                       ), #using the non-standard evaluation
                  fitted_mean = interp(~ mean(x,na.rm=TRUE), x=as.name(pred_value)#,y=as.name(modelweight)
                                       ),
                  weight_sum = interp(~ sum(x), x=as.name(modelweight))
                 )  %>%
      mutate(weight_sum_pct = weight_sum/sum(weight_sum)*100) %>%
      ungroup %>%
        melt(id=c(x_var,"weight_sum","weight_sum_pct"),
             variable.name = "line",value.name="mean") %>%
      rename_( "group_var"= x_var )

  #print(prepared)
#graph
  gg.top<-ggplot2::ggplot(data=prepared,aes(x=group_var,y=mean,group=line,colour=line)) + 
    geom_line() + geom_point(size=3,shape=21,fill="white")+ 
    theme_classic() +
    scale_x_discrete(breaks=NULL,name="", limits = levels(dt.frm[, x_var])) +
    ylab("Predicted values for Loss Ratio") +
    scale_y_continuous(expand=c(0,1/5)) +
    theme(legend.position=c(0.8,0.8)) +
    theme(plot.margin = unit(c(10,10,-5,3),units="points"))
  
  gg.bottom<- prepared %>%
             dplyr::filter(line == "actual_mean") %>%
     ggplot2::ggplot(data=.,aes(x=group_var %>% addNA(ifany=TRUE),y=weight_sum_pct)) + 
       geom_bar(stat="identity",width=0.5,fill="orange") +
       scale_x_discrete(limits = levels(dt.frm[, x_var])) +
       theme_classic() +
       xlab(as.name(x_var)) +
      ylab("Weight - %") +
       theme(plot.margin = unit(c(0,5,1,5),units="points"))
  
  gridExtra::grid.arrange(gg.top,gg.bottom,heights=c(3/5,2/5))
  
}


# loading example data
# load("G:/Actuary/BA_04_OT/02_TEAMS/Peter_C/R/EMB/Emblem_Graph_Example.RData")
# head(caf_analyse)
# 
# # defining variable names
# target<-'loss_ratio'
# modelweight<-'Offset_Prem_Cap'
# analyzed_var<-'var311_protyp_cnt'
# 
# #example
# emblem_graph(caf_analyse,analyzed_var,target,modelweight)

