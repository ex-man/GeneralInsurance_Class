# Objective
To learn what is a Loss Ratio and what are different forms of projections of losses (average, chain ladder/bf, loss ratio walk)

# Content
1) start from absolute number => losses and expense (10min)
2) introduce loss ratio (losses / nep) and expense ratio (expenses / nep) - start by writing business and handling claims (20min)
3) look for underperformers in in terms of loss ratio => visulize data using shiny dashboard (20min) => look for more at home (history, ...)
4) look for underperformers in in terms of underwriting result => visulize data using shiny dashboard (20min) => look for more at 
home (history, ...) 

### Lesson Flow:
1) Data Exploration and simple Visualization: `data_prep_exercise_KPI.R`
2) Integration to Class Shiny: ui=`shiny_tab2_content.r`, server=`shiny_tab2_server.R`
3) Repository update

### Homework
1) Find out, which __year__ was the __most terrific__ for portfolio you have identified as __most profitable__ during the lesson and show it on the chart using `ggplot2` package. Write an explanation about your findings into the code as comment. __Commit__ it to your repository into `Lessons/Lesson2/Homework`.

2) Implement UWR chart into Class Shiny app. 
Edit file shiny_tab2_server.R (as server.R for lesson2) at `output$lesson2_KPI_multidim_table` with predefined input data and implement UWR chart we learned during lesson2 as dynamic view not only for `Unit`. Do not forget to commit your changes.

# NOT DOING	
	3) how to calculate ultimate losses? Come up with something based on history of quarterly development data for one of the portfolios from part 2) (20 min)
	4) introduce chain ladder, bf and loss ratio walk (optional) (30min) => practice using https://github.com/mages/ChainLadder
	
