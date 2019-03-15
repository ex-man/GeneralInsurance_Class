# Objective
	To understand what is behind the losses. How do they get calculated and even more impotantly - projected.
	
# Content
	1) How to project losses using "triangles"
	2) understanding development over time
	3) Using development pattern in discounting future flows of money
	4) going one step further towards capital

### Lesson Flow:
1) [Discounting](discounting.rmd): `discounting.exercise.R`
2) Repository update ([using pull request](https://www.sitepoint.com/quick-tip-sync-your-fork-with-the-original-without-the-cli/))

#### Feedback (3 min)  
Please fill in [survey](https://forms.office.com/Pages/ResponsePage.aspx?id=unI2RwfNcUOirniLTGGEDmMCeqOOjBtIuObM18vXqrtUQlFNREZXWTIxMEdNMDhQMDFaWkI3SkNLSC4u) about this lesson to help us to improve the course.

#### Homework (~30 min) [4b / 2b]
Finish exercises 2 and 3 in [Discounting](discounting.rmd). 
1) It means you need to find Age-to-age factors for all combinations in the data and comment on what differences you are finding (unusual data points in triangles, differences in Age-to-age factors, volatility, ...)
2) Once done, comment also on the "length of tail" (how long it usually takes for losses in triangle to not change any massively any further). Why do you think there are differences between Household (building) and 3rd party (cars)? What is the difference between small and large claims?

Hint:
For those that have the chainladder package installed with an error and the development periods 1 and 2 are at the end of the triangle, please reorder them using the following R code template:

\# create a triangle as you would in the first place

dTest <- as.triangle(paid_hh_sml, origin = "ay", dev = "dy", "SumOfamount")

\# force the correct order of columns and store the matrix as a triangle

dTriang <- triangle(
    dTest[,10],
    dTest[,9],
    dTest[,1],
    dTest[,2],
    dTest[,3],
    dTest[,4],
    dTest[,5],
    dTest[,6],
    dTest[,7],
    dTest[,8]
)
