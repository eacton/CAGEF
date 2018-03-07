Centre for the Analysis of Genome Evolution & Function (CAGEF)
_______________________________________________________________________________________


- [Bioinformatics Training & Outreach Material](#heading)
  * [The Intro to R Lesson Series](#sub-heading)
    + [Lesson 1 - Intro to R and R-Studio: Becoming Friends with the R Environment and Getting your Data In and Out of R](#sub-sub-heading)
    + [Lesson 2 - Intro to Tidy Data: How to Filter, Subset, Transform and Merge your Data](#sub-sub-heading-1)
    + [Lesson 3 - Plot all the things! From Data Exploration to Publication-Quality Figures](#sub-sub-heading-2)
    + [Lesson 4 - Data Cleaning/Stop Wrestling with Regular Expressions](#sub-sub-heading-3)
    + [Lesson 5 - Linear and Non-Linear Regression: Choosing the Best Model for the Job](#sub-sub-heading-4)
    + [Lesson 6 - Scaling up your Analyses: Writing Functions in R](#sub-sub-heading-5)
  * [Resources](#sub-heading-1)
    
#Contents

<!-- toc -->



<!-- tocstop -->

##Bioinformatics Training & Outreach Material

This repository is part of the Centre for the Analysis of Genome Evolution & Function's (CAGEF) bioinformatics training initiative. These courses and workshops were developed based on feedback of the needs and interests of the Department of Cell & Systems Biology and the Department of Ecology and Evolutionary Biology at the University of Toronto.    



###The Intro to R Lesson Series

***

####Lesson 1 - Intro to R and R-Studio: Becoming Friends with the R Environment and Getting your Data In and Out of R
__Objective:__ At the end of this session you will be familiar with the R environment, setting your working directory, know about basic data structures in R and how to create them. You will be able to import data into R (tsv, csv, xls(x), googlesheets) and export your data again.


_Quick Intro to the R Environment_

- setting working directory (also, absolute and relative paths)
- check out variables in the global environment and viewer
- changing global options
- how to get help

_Making Life Easier_

- trouble-shooting basics
- annotating your code
- finding answers online

_Quick Intro to R Data Structures_ - ie. vectors, matrices, data frames, lists
  
- numerical, integer, character, factor, logical types of data
- controlling/setting factor levels
- how to create each of these data classes
- str(), dim(), nrow(), ncol(), class(), length()
- transpose a matrix, t()
- how to do simple mathematical calculations (+, - , ^, *, /)
- simple calculation using apply()

_Installing and importing libraries_

- from CRAN, Bioconductor, GitHub
    
_Reading in data & writing data_

- read.delim(), read.csv(), read_csv(), readxl(), gs_read() 
- look at help files for the differences in function defaults
- corresponding write fxns

***
####Lesson 2 - Intro to Tidy Data: How to Filter, Subset, Transform and Merge your Data 


__Objective:__ At the end of this session you will know the principles of tidy data, and be able to subset and transform your data, merge data frames, and perform simple calculations.

_Why tidy data?_

- Know the principles of tidy data and why it is useful to have your data in this format
- Intro to the tidyverse

_Data Manipulation_     

- dplyr() 
      + how to subset data
      + how to order data
      + filter(), select(), arrange(), glance()
- tidyr() 
      + transforming data from wide to long and back again (or reshape2())
      + spread(), gather(), unite(), separate()
- merging/adding data 
      + join/merge functions
      + binding functions with caveats
      
_Simple Statistics_
  
- how to perform simple calculations and store the results in new columns
    + using summarize() to get mean, median, modes, quantiles and standard deviations, variance, skew
    + using mutate() to add columns 
    + using group_by() to perform calculations on factored data 
    
- revisitng the apply() function

- performing t-tests in R
        

***
####Lesson 3 - Plot all the things! From Data Exploration to Publication-Quality Figures

__Objective:__ At the end of this session you will be able to use ggplot2() to make a ton of different types of plots with your data for both for data exploration and for publication-quality figures.   

_Intro to the Grammar of Graphics_

- general structure of ggplot2 syntax()
- dependence of ggplot2 on the tidy data format

_Data Exploration - plot all the things!_

- dot plots, line graphs, scatter plots, bar graphs, violin plots, histograms, facetting
- emphasis on boxplots + explanation, beeswarm plots
- heatmaps and correlation plots
  
_Making Figures_

- labels, scaling, ggsave(), regression lines, error bars, changing axis limits, rotating labels, adding text to data points, changing the legend, alpha, colors, shapes
- forcats pkg: controlling categorical variable order in your legend
- alternatives to pie charts
- customize with ggthemes
  
_Taking it up a notch_ - Maybe preview these, and if time vote on one to look at in more detail

- Interactive graphics (d3heatmap, ggvis, plotly)
- Network diagrams (DiagrammR, igraph)
- dygraphs() - time series data, migest - circos plots
- upset plots
- geospatial data? interest?
- phylogenetics data - ggtree, treeman, metacoder
- genomics data - ggbio
   
***   
####Lesson 4 - Data Cleaning/Stop Wrestling with Regular Expressions

__Objective:__ At the end of this session you will be able to use regular expressions to 'clean' your data. You will also learn R markdown and be able to render your R code into slides, a pdf, html, a word document, or a notebook.

_Intro to regular expressions_

- escape characters, character classes, quantifiers and all that jazz

_Text manipulation with stringr/i_

- searching for a word/patterns, subset using character strings, collapse and expand character vectors, replacement, replacing NAs, splitting/combining at a delimiter

_R markdown and knitr_

- r markdown syntax
    +  making things pretty: adding table of contents, images, hyperlinks, urls
- knitr code chunk options
    + suppressing pkg load warnings, eval = T/F, re-running some chunks while keeping others in memory
    + tables in knitr
- rendering to pdf, html, word documents (any interest in slides?)
- sharing on Rpubs

***    
####Lesson 5 - Linear and Non-Linear Regression: Choosing the Best Model for the Job

__Objective:__ At the end of this session you will be able to perform simple and multiple linear or non-linear regression on your dataset. You will be able to interpret the statistics that come out of this model, and use these statistics to select the best model for the job. 

_Commonly used statistics_

- quick review: mean, median, mode, quantiles, sd, variance     
- t-tests     
- correlations     
- explain parametric vs non-parametric data     

_Models we will Consider_

- Simple linear regression
- Non-linear regression
- Multiple linear regression
- ANOVA

_How we Evaluate which Model to Use_

- Taking a moment to think about the question we are asking...
- Assumptions of the model
- Interpreting the output of our model
- Assessing the performance of the model (feedback)
    + Diagnostic plots (ie. residuals, Q-Q plots)


_Running the Model_

- Dealing with dummy variables/encoding categorical variables
- Is it necessary to scale our data?
- Using broom() to get a data frame of our result statistics
- Predictors 

******    
####Lesson 6 - Scaling up your Analyses: Writing Functions in R

__Objective:__ At the end of this session you will be able to write functions, making your coding more efficient, understandable, reproducible, and hopefully less frustrating.


_Basic Syntax of Functions in R_

- the structure of a function
- understanding scoping
- naming conventions
- adding '...'
- the output of your function
- sourcing functions
  
_Handling Errors_

- stopifnot(), warning(), suppressWarnings(), tryCatch()

_Testing Arguments and Validity of your Function_

- testthat() for formal unit testing

***
###Resources

https://github.com/patrickwalls/R-examples/blob/master/LinearAlgebraInR.Rmd     
http://stat545.com/block002_hello-r-workspace-wd-project.html  
http://stat545.com/block026_file-out-in.html     
http://sisbid.github.io/Module1/
http://seananderson.ca/2013/10/19/reshape.html     
https://github.com/wmhall/tidyr_lesson/blob/master/tidyr_lesson.md     
http://stat545.com/block009_dplyr-intro.html     
http://stat545.com/block010_dplyr-end-single-table.html
http://mazamascience.com/WorkingWithData/?p=912
https://github.com/ttimbers/lm_and_glm/blob/master/lm_and_glm.Rmd     
https://github.com/seananderson/glmm-course     
http://michael.hahsler.net/SMU/EMIS7331/R/regression.html
http://stat545.com/block028_character-data.html     
http://r4ds.had.co.nz/strings.html
https://github.com/jennybc/ggplot2-tutorial
http://stat545.com/block011_write-your-own-function-01.html     
http://stat545.com/block011_write-your-own-function-02.html     
http://stat545.com/block011_write-your-own-function-03.html
