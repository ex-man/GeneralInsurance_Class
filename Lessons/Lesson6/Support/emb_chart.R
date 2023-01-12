# library(ggplot2)  #grammar of graphics package
# library(gridExtra)#extra package for combining the graph
# library(grid)     #extra package for combining the graph
# library(dplyr)    #data manipulation
# library(reshape2) #melting the data frame to long format

emblem_graph<-function(model, x_var, target="Burning_Cost", weight="Time_Exposure", prediction="pred",  dt.frm = NULL, print_data = FALSE) {
  
  if(is.null(dt.frm) && is.null(model)) stop("Please provide one of the arguments `dt.frm` or `model`")
  if(is.null(dt.frm)) {
    dt.frm <- cbind(
      model$data,
      data.frame(pred = predict(model, model$data, type = "response"))
    )
  }
  if(is.null(weight)) {
    dt.frm <- dt.frm %>% 
      mutate(weight_col=1)
    weight <- "weight_col"
  }
  
  libs <- c("ggplot2", "dplyr", "reshape2", "lazyeval", "patchwork")
  lapply(libs, require, character.only = TRUE)
  
  #data preparation for graph
  prepared<-dt.frm %>%
    group_by_(x_var) %>% 
    summarize(
      actual_mean = weighted.mean(.data[[target]], .data[[weight]], na.rm = TRUE),
      fitted_mean = weighted.mean(.data[[prediction]], .data[[weight]], na.rm = TRUE),
      weight_sum = sum(.data[[weight]])
    ) %>% 
    mutate(weight_sum_pct = weight_sum/sum(weight_sum)*100) %>%
    ungroup %>%
    melt(id=c(x_var,"weight_sum","weight_sum_pct"),
         variable.name = "line",value.name="mean") %>%
    rename_( "group_var"= x_var )
  
  if(print_data) {
    print(prepared)  
  }
  
  x_unique <- unique(prepared$group_var)
  
  if((is.character(x_unique) || is.factor(x_unique)) && length(x_unique) > 20) {
    prepared <- prepared %>% 
      mutate(group_var_label = ifelse(weight_sum_pct > 100/length(x_unique), group_var, ""))
    
    scale_x_fun <- scale_x_discrete(labels = prepared$group_var_label)
  } else {
    prepared <- prepared %>% 
      mutate(group_var_label = group_var)
    
    scale_x_fun <- NULL
  }
  
  #graph
  gg.top<-ggplot2::ggplot(data=prepared,aes(x=group_var,y=mean,group=line,colour=line)) + 
    geom_line() + geom_point(size=3,shape=21,fill="white")+ 
    theme_classic() +
    scale_x_discrete(breaks=NULL,name="") +
    ylab("Prediction vs. Actual") +
    labs(color="Type") + 
    scale_y_continuous(expand=c(0,1/5)) 
  # +
  # theme(legend.position=c(0.8,0.8)) +
  # theme(plot.margin = unit(c(0,0,0,0),units="points"))
  
  gg.bottom<- prepared %>%
    dplyr::filter(line == "actual_mean") %>%
    ggplot2::ggplot(data=.,aes(x=group_var,y=weight_sum_pct)) + 
    geom_bar(stat="identity",width=0.5,fill="orange") +
    theme_classic() +
    scale_x_fun + 
    # xlab(as.name(x_var)) +
    xlab(NULL) +
    ylab("Exposure - %") +
    theme(axis.text.x = element_text(angle = 20, vjust = 0.5))
  # theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1))
  # +
  # theme(plot.margin = unit(c(0,5,1,1),units="points"))
  
  patchwork::wrap_plots(list(gg.top, gg.bottom), heights = c(3/5, 2/5)) + 
    patchwork::plot_annotation(title = x_var, theme=ggplot2::theme(plot.title=element_text(hjust=0.4)))
  # gridExtra::grid.arrange(gg.top,gg.bottom,heights=c(3/5,2/5))
  
}

bin_dist_equal<-function(var,n){
  
  libs <- c("Hmisc", "dplyr")
  lapply(libs, function(lib) {
    if(!require(lib)) install.packages(lib)
    require(lib)
  })
  
  #calculate quantiles
  q_points<-quantile(var,probs=(0:n)/n, na.rm=TRUE)             
  
  #
  big_count_bins<-unique(q_points[duplicated(q_points)])
  
  #excluding those single values from big bins
  whr_big<- (var %in% big_count_bins) 
  #recalculating the quantiles after exclusions
  d<-length(big_count_bins)
  q_points<-quantile(var[!whr_big],probs=1:(n-d-1)/(n-d), na.rm=TRUE)
  
  #calculating the break points, 
  #we need the new recalculated quantiles, but also the big single bins
  breaks<-c(min(var),max(var),big_count_bins,q_points) %>% sort %>% unique
  
  #breaking down the variable into intervals
  points<-cut2(var,breaks,oneval=TRUE)  
  
  #some adjustment to see intervals in appropriate form
  points<-as.character(points)
  points[whr_big]<-as.character(var[whr_big]) #splitting the interval if contain also big single value bin
  
  points[!whr_big]<-gsub('\\)','',points[!whr_big]) #removing the 'bracket'
  points[!whr_big]<-gsub('\\(','',points[!whr_big]) #removing the 'bracket'
  points[!whr_big]<-gsub('\\]','',points[!whr_big]) #removing the 'bracket'
  points[!whr_big]<-gsub('\\[','',points[!whr_big]) #removing the 'bracket'
  
  return(list(i_inter=factor(points,exclude=NULL)))
}
