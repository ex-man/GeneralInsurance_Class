library(Hmisc) #library needed for weighted quantiles 
library(plyr) #library needed for recoding values

#define the binning function
# weight equal
bin_weight_equal<-function(var,weight,n){
  
  #identifing the single values which have the bigger sum of weight 
  #as planned bin which is sum(weight)/n
  #browser()
  
  # dt.frm<-data.frame(var,weight)
  sum_weight_all<-sum(weight)
  #calculate the quantiles by weight
  q_points<-wtd.quantile(var,weight,probs=1:(n-1)/n, na.rm=TRUE) 
  q_points<-c(min(var, na.rm=TRUE), q_points, max(var, na.rm=TRUE))
  
  #identifying the bins bigger that sum(weight)/n
  big_weight_bins<-unique(q_points[duplicated(round(q_points,7))])
  
  if ( identical(big_weight_bins,numeric(0)) ) {
    
    #rounding min and max for 2 decimal places, where for min using floor and for max ceiling rounding
    q_points[1]<-(q_points[1] *10000000) %>% floor(.)/10000000
    q_points[q_points %>% length()]<-(q_points[q_points %>% length()] * 10000000) %>% ceiling(.)/10000000
    
    #calculating the break points, 
    #we need the new recalculated quantiles, but also the big single bins
    breaks<-c(q_points) %>% sort %>% unique 

    #breaking down the variable into intervals
    points<-cut2(var , breaks, digits=2, minmax = FALSE)  
    lvls<-points %>% unique %>% sort
    
    #some adjustment to see intervals in appropriate form
    lvls<-as.character(lvls)
    lvls<-gsub('\\)','',lvls) #removing the 'bracket'
    lvls<-gsub('\\(','',lvls) #removing the 'bracket'
    lvls<-gsub('\\]','',lvls) #removing the 'bracket'
    lvls<-gsub('\\[','',lvls) #removing the 'bracket'
    #lvls<-gsub(',',',\n',lvls) #',' become new line
    
    if (var %>% is.na %>% any) lvls<-c(lvls,"NA")
    return(list(i_inter=factor(points,labels=lvls,exclude=NULL)))
    
  } else {
    #excluding those single values from big bins
    whr_big<- (var %in% big_weight_bins) 
    
    #recalculating the quantiles after exclusions
    d<-length(big_weight_bins)
    q_points<-wtd.quantile(var[!whr_big],weight[!whr_big],probs=1:(n-d-1)/(n-d), na.rm=TRUE)
    q_points<-c(min(var, na.rm=TRUE),q_points,max(var, na.rm=TRUE))
    
    #rounding min and max for 2 decimal places, where for min using floor and for max ceiling rounding
    q_points[1]<-(q_points[1] *10000000) %>% floor(.)/10000000
    q_points[q_points %>% length()]<-(q_points[q_points %>% length()] * 10000000) %>% ceiling(.)/10000000
    
    #calculating the break points, 
    #we need the new recalculated quantiles, but also the big single bins
    breaks<-c(big_weight_bins,q_points) %>% sort %>% unique
    
    #breaking down the variable into intervals
    points<-cut2(var[!whr_big] %>% round(10), breaks, oneval=TRUE,digits=2) 
    points_mean<-cut2(var[!whr_big],breaks,levels.mean=TRUE,oneval=TRUE,digits=2)
    lvls<-points %>% unique %>% sort
    
    #creating big buckets
    temp<-data.frame(var,whr_big,bin=rep(NA,length(var)),bin_mean=rep(NA,length(var)))
    temp[temp$whr_big==FALSE,"bin_mean"]<-points_mean %>% as.character() %>% as.numeric
    temp[temp$whr_big==FALSE,"bin"]<-points %>% as.character
    
    temp<-temp %>%
      mutate(bin_mean=ifelse(is.na(bin_mean),var,bin_mean),
             bin=ifelse(is.na(bin),var,bin) %>% as.factor
             )
      #to have levels sorted in proper way inside factor
      lvls<-temp$bin[temp$bin_mean %>% sort %>% match(.,temp$bin_mean )] %>% unique %>% as.character
      
      #some adjustment to see intervals in appropriate form
      lvls_adj<-as.character(lvls) 
      
      lvls_adj<-gsub('\\)','',lvls_adj) #removing the 'bracket'
      lvls_adj<-gsub('\\(','',lvls_adj) #removing the 'bracket'
      lvls_adj<-gsub('\\]','',lvls_adj) #removing the 'bracket'
      lvls_adj<-gsub('\\[','',lvls_adj) #removing the 'bracket'
      
      #lvls_adj<-gsub(',',',\n',lvls_adj) # ',' become new line 
      
      if (var %>% is.na %>% any) lvls_adj<-c(lvls_adj,'NA')
      temp<-dplyr::mutate(temp,bin_fctr_ordered=factor(bin,levels=lvls,labels=lvls_adj,exclude=NULL))
      
      return(list(i_inter=temp$bin_fctr_ordered))
    
  }
  
}
# count equal
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
  # points<-as.character(points)
  # points[whr_big]<-as.character(var[whr_big]) #splitting the interval if contain also big single value bin
  # 
  # points[!whr_big]<-gsub('\\)','',points[!whr_big]) #removing the 'bracket'
  # points[!whr_big]<-gsub('\\(','',points[!whr_big]) #removing the 'bracket'
  # points[!whr_big]<-gsub('\\]','',points[!whr_big]) #removing the 'bracket'
  # points[!whr_big]<-gsub('\\[','',points[!whr_big]) #removing the 'bracket'
  
  return(list(i_inter=points))
}

#interval equal or specify, default is 0.5-2 by 0.1
bin_inter_equal<-function(var, breaks=seq(0.5,2,0.1)){
  #breaking down the variable into intervals
  points<-cut2(var, breaks, oneval=TRUE, digits = 2)  
  
  #some adjustment to see intervals in appropriate form
  # points<-as.character(points)
  # points<-gsub('\\)','',points) #removing the 'bracket'
  # points<-gsub('\\(','',points) #removing the 'bracket'
  # points<-gsub('\\]','',points) #removing the 'bracket'
  # points<-gsub('\\[','',points) #removing the 'bracket'
  # points<-gsub(',',',\n',points) # ',' become new line 
  
  return(list(i_inter=factor(points,exclude=NULL)))
}