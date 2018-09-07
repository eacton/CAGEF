![](CAGEF_new.png)

CAGEF Training & Outreach Material by Erica Acton (erica.acton@utoronto.ca)

***

- [Bioinformatics Training & Outreach Material](#heading)
  * [The Intro to R Lesson Series](#sub-heading)
    + [Lesson 1 - Intro to R and R-Studio: Becoming Friends with the R Environment and Getting your Data In and Out of R](#sub-sub-heading)
    + [Lesson 2 - Intro to Tidy Data: How to Transform and Manipulate your Data Efficiently](#sub-sub-heading-1)
    + [Lesson 3 - Plot all the things! From Data Exploration to Publication-Quality Figures](#sub-sub-heading-2)
    + [Lesson 4 - Of Data Cleaning and Documentation - Conquer Regular Expressions, Use R markdown and knitr to make PDFs, and Challenge yourself with a 'Real' Dataset](#sub-sub-heading-3)
    + [Lesson 5 - Linear Regression, Multiple Linear Regression, ANOVA, ANCOVA: Choosing the Best Model for the Job](#sub-sub-heading-4)
    + [Lesson 6 - Scaling up your Analyses: Writing Functions in R](#sub-sub-heading-5)

    
#Contents

<!-- toc -->





##Bioinformatics Training & Outreach Material

This repository is part of the Centre for the Analysis of Genome Evolution & Function's (CAGEF) bioinformatics training initiative. These courses and workshops were developed based on feedback of the needs and interests of the Department of Cell & Systems Biology and the Department of Ecology and Evolutionary Biology at the University of Toronto.    



###The Intro to R Lesson Series

***

This lesson series is intended as a beginner's introduction to R, with no previous experience required. It was created keeping in mind the scientist without a computer science background who wants the skills to analyze his or her own data. At the end of the 6-lesson series you will be able to import data from a .txt, .csv, .tsv, .xlsx or googlesheet worksheet, order, filter and reshape data, make exploratory plots, perform some basic statistical tests, run a regression model, and make reproducible documents (such as pdfs, word documents, or html) to share your results. 


The structure of the class is a code-along style. It is hands on, and you are expected to bring a laptop with R and R-Studio installed. The lesson material and code are available for download at this repository (<https://github.com/eacton/CAGEF>), so you can spend the time coding and not taking notes. As we go along, there will be some challenge questions as well as multiple choice questions on Socrative; a class key will be provided in class. 


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
- a primer on missing data

_Installing and importing libraries_

- from CRAN, Bioconductor, GitHub
    
_Reading in data & writing data_

- read.delim(), read.csv(), read_csv(), readxl(), gs_read() 
- look at help files for the differences in function defaults
- corresponding write fxns

***
####Lesson 2 - Intro to Tidy Data: How to Transform and Manipulate your Data Efficiently


__Objective:__ At the end of this session you will know the principles of tidy data, and be able to subset and transform your data, merge data frames, and perform simple calculations.


_Data Manipulation_     

- base R data manipulation
- the dplyr package: 
      + how to subset data with filter(), select()
      + how to order data with arrange()
      + using mutate(), transmute() for new data columns 
      + using summarize() to get mean, median, modes, quantiles and standard deviations, variance, skew
      + using group_by() to perform calculations on factored data 
      
_Intro to tidy data_

- Know the principles of tidy data and why it is useful to have your data in this format
- Intro to the tidyverse
- the tidyr package:
      + transforming data from wide to long and back again 
      + spread(), gather(), unite(), separate()
      
_Merging data tables_ 

- join functions!
- binding functions with caveats
      
        

***
####Lesson 3 - Plot all the things! From Data Exploration to Publication-Quality Figures

__Objective:__ At the end of this session you will be able to use ggplot2 to make a ton of different types of plots with your data for both for data exploration and for publication-quality figures.    

_Intro to the Grammar of Graphics_

- general structure of ggplot syntax:
      + aesthetics, geoms, scaling, statistical transformations, facetting
- how ggplot makes use of the tidy data format

_Data Exploration - plot all the things!_

- dot plots, line graphs, scatter plots, bar graphs, violin plots, histograms, density plots, bubble plots
- emphasis on boxplots + explanation, beeswarm plots
- heatmaps and correlation plots
- regression lines and error bars
  
_Customization of Figures_

- attributes related to your data
      + shapes, fill, color, opacity, size
      + adding text to data points, labels
      + controlling categorical variable order in your legend (forcats package)
- color palettes (sequential, diverging, qualitative)
- themes (attributes unrelated to your data)
      + ie. axis, legend, panels, gridlines, backgrounds
      + element_text, _line, _rect, _blank, _grob
      + designer themes
- saving plots
  
  
_Taking it up a notch_ 

- Interactive graphics (d3heatmap, ggvis, plotly)
- Multiple plots on one page (ie. publication images) (ggpubr)
- Upset plots (UpSetR) as alternative to venn diagrams
- Preview:
      + Network diagrams (visNetwork, DiagrammR, igraph)
      + Time series data (dygraphs)
      + Circos plots (migest)
      + Geospatial data (geodataviz)
      + Phylogenetics data (ggtree, treeman, phyloseq, metacoder)
      + Genomics data (ggbio, GenVisR, GenomeGraphs)
   
***   
####Lesson 4 - Lesson 4 - Of Data Cleaning and Documentation - Conquer Regular Expressions, Use R markdown and knitr to make PDFs, and Challenge yourself with a 'Real' Dataset

__Objective:__ At the end of this session you will be able to use regular expressions to 'clean' your data. You will also learn R markdown and be able to render your R code into slides, a pdf, html, a word document, or a notebook.

_Intro to regular expressions_

- regex language
      + matching by position
      + quantifiers
      + classes
      + operators
      + escape characters
      
_Data Cleaning_

- data cleaning with base R & with stringr/i packages
      + searching and replace patterns
      + subset using character strings
      + collapse and expand character vectors
      + splitting/combining at a delimiter
      + trimming whitespace


_R markdown and knitr_

- r markdown syntax
- working in Projects, .Rmd files, notebooks
- adding hyperlinks, images, table of contents
- knitr chunk options
      + caching 
      + kable tables
- rendering to pdf, html, word documents
- slides


***    
####Lesson 5 - Linear Regression, Multiple Linear Regression, ANOVA, ANCOVA: Choosing the Best Model for the Job

__Objective:__ At the end of this session you will be able to perform simple and multiple linear regression, one- and multiway analysis of variance (ANOVA) and analysis of covariance (ANCOVA). You will be able to interpret the statistics that come out of this model, be cognizant of the assumptions the model makes, and use an F-test to select the best model for the job. 


_How we Evaluate which Model to Use_

- How do we describe our data?
- What hypotheses are we testing?
- What assumptions does our model have?
- How do we test these assumptions?
- How do we compare models?
- How do we interpret the output of our model?
- How do we make a prediction for new values?
 

_Models we will Consider_

- T-tests
- Simple linear regression
- Multiple linear regression
- One- and Multi-way Analysis of Variance (ANOVA)
- Analysis of Covariance (ANCOVA)

_Important considerations_

- Dummy variables: encoding categorical variables
- Interaction terms
- Multiple test correction

_Prediction_

- confidence vs prediction (narrow vs wide) intervals

_Assessing the performance of the model (feedback)_

- Checking residuals
- Q-Q plots
- Next steps (when assumptions fail)


******    
####Lesson 6 - Scaling up your Analyses: Writing Functions in R

__Objective:__ At the end of this session you will be able to write functions, making your coding more efficient, understandable, reproducible, and hopefully less frustrating.


_Basic Syntax of Functions in R_

- the structure of a function
- understanding lexical scoping
- generalizing a function
- setting default values
- the '...' argument
- sourcing functions
  
_Control Structures_

- if else
- for
- while
- repeat
- break
- next
  
_Scaling Up_

- using loops vs apply in functions
- multiple inputs
- running iterations in parallel

_Defensive Programming_

- handling errors & writing useful error messages
- unit tests
- assertions
- NAs in functions



***

