library(ggplot2)  #grammar of graphics package
library(gridExtra)#extra package for combining the graph
library(grid)     #extra package for combining the graph
library(dplyr)    #data manipulation
library(reshape2) #melting the data frame to long format
library(lazyeval) #for non-standard evaluation to create general purpose code

emblem_graph<-function(dt.frm,x_var,target,prediction) {
  
  #data preparation for graph
  prepared<-dt.frm %>%
    group_by_(x_var) %>% 
    summarise_( actual_mean = interp(~ mean(x,na.rm=TRUE), x=as.name(target)), #using the non-standard evaluation
                fitted_mean = interp(~ weighted.mean(x,na.rm=TRUE), x=as.name(prediction)),
                weight_sum = quote(n())
    )  %>%
    mutate(weight_sum_pct = weight_sum/sum(weight_sum)*100) %>%
    ungroup %>%
    melt(id=c(x_var,"weight_sum","weight_sum_pct"),
         variable.name = "line",value.name="mean") %>%
    rename_( "group_var"= x_var )
  
  print(prepared)
  
  #graph
  gg.top<-ggplot2::ggplot(data=prepared,aes(x=group_var,y=mean,group=line,colour=line)) + 
    geom_line() + geom_point(size=3,shape=21,fill="white")+ 
    theme_classic() +
    scale_x_discrete(breaks=NULL,name="") +
    ylab("Prediction vs. Actual") +
    scale_y_continuous(expand=c(0,1/5)) +
    theme(legend.position=c(0.8,0.8)) +
    theme(plot.margin = unit(c(0,0,0,0),units="points"))
  
  gg.bottom<- prepared %>%
    dplyr::filter(line == "actual_mean") %>%
    ggplot2::ggplot(data=.,aes(x=group_var,y=weight_sum_pct)) + 
    geom_bar(stat="identity",width=0.5,fill="orange") +
    theme_classic() +
    xlab(as.name(x_var)) +
    ylab("Exposure - %") +
    theme(plot.margin = unit(c(0,5,1,1),units="points"))
  
  gridExtra::grid.arrange(gg.top,gg.bottom,heights=c(3/5,2/5))
  
}

bin_dist_equal<-function(var,n){
  
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
