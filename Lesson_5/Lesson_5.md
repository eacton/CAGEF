---
title: "Lesson 5 - Linear and Non-Linear Regression: Choosing the Best Model for the Job"
output: 
  html_document:
          keep_md: yes
          toc: TRUE
          toc_depth: 3
  html_notebook:
          toc: TRUE
          toc_depth: 3
---
***

Approximate time: 2 hours per lesson

 _Each lesson will have:_
 
 - Comprehension questions as we go along on Socrative.
 - How to read help pages online.
 - Give the class a function not previously used during the lesson and have them figure out what it does and how to use it.
 - Each lesson will start from an excel spreadsheet with imperfect data.


***
__Objective:__ At the end of this session you will be able to perform simple and multiple linear or non-linear regression on your dataset. You will be able to interpret the statistics that come out of this model, and use these statistics to select the best model for the job. 



```r
library(tidyverse)
library(knitr)
library(kableExtra)
```


_Discussion: Lesson 4 Challenge question_




The dataset we will use for this lesson is from the Summer Institute in Statistical Genetics course in Regression from 2016. I like this dataset because it has a number of categorical and continuous variables, which allows us to use the same dataset for all kinds of models. Also, everyone will be familiar with the variables, which makes data interpretation easier while we are in the learning stage. 


```r
cholesterol <- read.delim("data/SISG-Data-cholesterol.txt", sep = " ", header = TRUE)
```




How do we describe our data? How do we test our assumptions about the data? How do we test our hypotheses? How do we make a prediction with new values?


Our hypotheses are that there are associations between our variables.

_Commonly used statistics_

- quick review: mean, median, mode, quantiles, sd, variance   

- t-tests     
-comparing the means between groups
ie. is serum cholesterol associated with age?
-you could split age into 2 groups and compare the mean cholestorol b/w the groups


We can plot this association and it looks like the mean increases with age, how do we test this?

```r
cholesterol <- cholesterol %>% mutate(age_group = ifelse(cholesterol$age >55, 1, 0))


ggplot(cholesterol, aes(factor(age_group),chol)) + geom_boxplot() +
  scale_x_discrete(labels = c("30-55", "56-80")) +
  xlab("age") +
  ylab("cholestorol (mg/dl)")
```

![](Lesson_5_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

A simple Welch Two Sample t-test tells us that our alternative hypothesis, that the true difference in means is not equal to 0 is true. It tells us the mean for those aged 30-55 is 180 mg/dl and the mean for those aged 56-80 is 188 mg/dl and that this significant at a p-value of 0.0003125. Remember that the null hypothesis is that there is no difference between the means. 

```r
t.test(cholesterol$chol ~ cholesterol$age_group)
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  cholesterol$chol by cholesterol$age_group
## t = -3.637, df = 393.48, p-value = 0.0003125
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -12.200209  -3.638487
## sample estimates:
## mean in group 0 mean in group 1 
##        179.9751        187.8945
```

So we now know there is a positive relationship between cholesterol and age. However the t-test has limitations. What is the magnitude of this relationship during aging? Can we see how much cholesterol might change by in a continuous manner (ie. how much does cholesterol change per year?)? What if we don't want to break our data into groups? 

What I am looking for then, is the slope of the line relating cholesterol to age, which will tell me the magnitude and direction of the relationship between these variables.


```r
ggplot(cholesterol, aes(age, chol)) + geom_point() + stat_smooth(method = "lm")
```

![](Lesson_5_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

Just to make sure everyone is comfortable, we will briefly review the equation for a straight line. y is our dependent variable that we are attempting to model and x is our independent variable. Here a is the intercept, which is the value of x where y = 0 (where x crosses the y-axis), and b is the slope of the line, which is the change in y corresponding to a unit increase in x. In this equation we also have some normally distributed variance. A flat line would mean that there is no association between x and y. The above example has a positive association with a positive slope, meaning that y increases as values of x increase. With a negative association and negative slope, y decreases as values of x decrease. With a straight line we are not, of course, plotting through all of our points, but rather the mean of an outcome in y as a function of x. For example, there are values of cholestorol for about six 50 year-olds, and our line will fall somewhere close to the mean of these values.

_Expression:_ 

\begin{equation*}
Y \verb|~| Normal(a + bx, {\sigma^2})
\end{equation*}


\begin{equation*}
y = a + bx + \epsilon, \epsilon \verb|~| N\{0, \sigma^2\}
\end{equation*}


When we use code for this in R, the intercept and slope terms are implicit.

_R code:_ 
\begin{equation*}
lm(y \verb|~| x)
\end{equation*}



- correlations     
- explain parametric vs non-parametric data     

_Models we will Consider_

https://ms.mcmaster.ca/~bolker/emdbook/book.pdf

Before we get too scared about anything, I have put together a table of data types and assumptions and what model should be used for each permutation. I hope to show that this means model selection is basically going through a mental checklist for your data, and that all of these models are related. 




<table class="table table-striped table-hover" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> model </th>
   <th style="text-align:left;"> categorical </th>
   <th style="text-align:left;"> continuous </th>
   <th style="text-align:left;"> linear </th>
   <th style="text-align:left;"> normal_errors </th>
   <th style="text-align:left;"> independent </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> simple linear regression </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> $\checkmark$ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> multiple linear regression </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:left;"> $\checkmark$ $\checkmark$ </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> $\checkmark$ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> one-way analysis of variance (ANOVA) </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> $\checkmark$ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> multi-way analysis of variance (ANOVA) </td>
   <td style="text-align:left;"> $\checkmark$ $\checkmark$ </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> $\checkmark$ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> analysis of covariance (ANCOVA) </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> $\checkmark$ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> nonlinear least squares </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> $\checkmark$ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> nonlinear analysis of covariance (ANCOVA) </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> $\checkmark$ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> generalized linear models </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:left;"> $\checkmark$ </td>
  </tr>
</tbody>
</table>

_Models we will Consider Today_

We are going to go through the code for this example dataset and then generalize to mathematical notation. We are going to start with models assuming normally distributed errors and come back to models with non-normal errors in the next lesson. For all of these models we are trying to determine the effect of different variables on cholesterol. 

For _simple linear regression_ we are modelling cholesterol by a single continuous variable, BMI.

For _multiple linear regression_ we are modelling cholesterol by more than one continuous variable, BMI AND age. This equation does not take into account any __interaction__ BMI might have with age on cholesterol levels. To denote the interaction term we use `*`. For example, lm(chol~ BMI + age + BMI\*age) or for the term alone lm(chol~BMI*age).

For _one-way ANOVA_ we are modelling cholesterol by a single categorical variable, sex. Since we have encoded sex as 0 and 1 (instead of 'M' and 'F', for example), we need to specify that sex is to be treated as a categorical variable and not a number. Therefore we turn sex into a factor of 2 levels, 0 and 1.

For _multi-way ANOVA_ we are modelling cholesterol by more than one categorical variable, sex and APOE variant. Again, we need to specify that our numeric values are encoded and to be treated as a categorical variable and not a number. APOE will be a factor of 6 levels, one for each genetic variant.

Lastly, for _ANCOVA_ we are modelling cholesterol by a combination of categorical AND continuous variables, the genetic variants of APOE and BMI. 


<table class="table table-striped table-hover" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> model </th>
   <th style="text-align:left;"> categorical </th>
   <th style="text-align:left;"> continuous </th>
   <th style="text-align:left;"> R_code </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> simple linear regression </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> lm(chol ~ BMI) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> multiple linear regression </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:left;"> $\checkmark$ $\checkmark$ </td>
   <td style="text-align:left;"> lm(chol ~ BMI + age) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> one-way analysis of variance (ANOVA) </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:left;"> lm(chol ~ factor(sex)) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> multi-way analysis of variance (ANOVA) </td>
   <td style="text-align:left;"> $\checkmark$ $\checkmark$ </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:left;"> lm(chol ~ factor(sex)*factor(APOE)) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> analysis of covariance (ANCOVA) </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> $\checkmark$ </td>
   <td style="text-align:left;"> lm(chol~factor(APOE)*BMI) </td>
  </tr>
</tbody>
</table>

In the table below, our R code for each of the models has been generalized. y is our predictor variable, x is a continuous variable, and f is a categorical variable (aka factor). a and b are coefficients which are implicit in the lm formulas but specified in the nls formulas.


<table class="table table-striped table-hover" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> model </th>
   <th style="text-align:left;"> R_code </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> simple linear regression </td>
   <td style="text-align:left;"> lm(y ~ x) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> multiple linear regression </td>
   <td style="text-align:left;"> lm(y ~ x + I(x^2)) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> one-way analysis of variance (ANOVA) </td>
   <td style="text-align:left;"> lm(y ~ f) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> multi-way analysis of variance (ANOVA) </td>
   <td style="text-align:left;"> lm(y ~ f~1~*f~2~) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> analysis of covariance (ANCOVA) </td>
   <td style="text-align:left;"> lm(y~f*x) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> nonlinear least squares </td>
   <td style="text-align:left;"> nls(y~a*x^b, start = list(a=1, b=1)) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> nonlinear analysis of covariance (ANCOVA) </td>
   <td style="text-align:left;"> nlsList(y ~ a*x^b|x~2~, data, start = list(a=1, b=1)) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> generalized linear models </td>
   <td style="text-align:left;"> glm(cbind(y, N-y)~x, family = 'binomial') </td>
  </tr>
</tbody>
</table>




General linear models:     

- linear regression     
-association of a continuous outcome with one or more predictors (categorical or continuouss)
- analysis of variance (ANOVA)     
-comparison of a continuous outcome over a fixed number of groups
- analysis of covariance (ANCOVA)     

-linear functions of the parameters (a, b, c), not necessarily of the independent variables (x, x^2)
ie. 
\begin{equation*}
Y \verb|~|  Normal(a + bx + cx^2, {\sigma^2}) 
\end{equation*}

is linear (ie. could call x^2 w and looks like multivariate ilnear regression), 
\begin{equation*}
Y \verb|~|  Normal(ax^b, {\sigma^2}) 
\end{equation*}

is non-linear wrt b

- Simple linear regression
- predicts y as a function of a single continuous covariate x

_Expression:_ 

\begin{equation*}
Y \verb|~| Normal(a + bx, {\sigma^2})
\end{equation*}

_R code:_ 
\begin{equation*}
lm(y \verb|~| x)
\end{equation*}

- Y rather than y since it's a random variable
#R code: lm(y~x), intercept a is implicit in the model
To force the intercept to zero: Y~ Normal(bx, sigma^2)

_R code:_ 
\begin{equation*}
lm(y \verb|~| x-1)
\end{equation*}


- Multiple linear regression
- adding more covariates (continuous predictor variables)
a) extra covariates that are powers of the original variable ie. polynomial regression, quadratic regression

_Expression:_ 

\begin{equation*}
Y \verb|~| Normal(a + b_1x + b_2x^2, {\sigma^2})
\end{equation*}

_R code:_ 
\begin{equation*}
lm(y \verb|~| x + I(x^2))
\end{equation*}

- I = "asis"
b) extra variables

_Expression:_ 

\begin{equation*}
Y \verb|~| Normal(a + b_1x + b_2x_2 + b_3x_3, {\sigma^2})
\end{equation*}

_R code:_ 
\begin{equation*}
lm(y \verb|~| x_1 +x_2 + x_3)
\end{equation*}

Again intercept and coefficients are implicit in the code.

Interaction terms. What is meant by an interaction? The slope wrt one covariate changes linearly as a function of another covariate.

_Expression:_ 

\begin{equation*}
Y  \verb|~|  Normal(a + b_1x + b_2x_2 + b_{12}x_{12}, {\sigma^2})   
\end{equation*}

_R code:_ 

\begin{equation*}
lm(y \verb|~| x_1*x^2)
\end{equation*}



-can text between models with a certain anova parameter test = "Chisq" https://ms.mcmaster.ca/~bolker/emdbook/book.pdf

##One-way anaysis of variance (ANOVA)

- predictor variables are discrete (factors) rather than continuous (covariates)

_Expression:_ 

\begin{equation*}
Y \verb|~| Normal({\alpha_i}, {\sigma^2}) 
\end{equation*}


_R code:_ 


$\begin{aligned}
\text{lm(y }\verb|~| \text{f)}
\end{aligned}$

f is the factor - as long as your data is character, R will automatically make factors, but if it is numeric, R will interpret it as continuous - therefore need to make it a factor first ie. variable = factor(variable)
-the summary() of anova tests the significance of each parameter agains the null hypothesis that it equals 0
-interpretation: R parameterizes the model in terms of the differences between the first group and subsequent groups (treatment contrasts) rather than in terms of the mean of each group
-you can tell it to fit the means of each group by: lm(y~f-1)

##Multi-way analysis of variance (ANOVA)

- two or more discrete/categorical variables (factors)

_Expression:_ 

\begin{equation*}
Y \verb|~| Normal({\alpha_i} + {\beta_j} + {\gamma_{ij}}, {\sigma^2}) 
\end{equation*}

_R code:_ 

\begin{equation*}
lm(y \verb|~| f_1*f_2)
\end{equation*}

(i is the level of the first treatment/group, and j is the level of the second)

R code: lm(y~ f~1~*f~2~), or the main effects without the interaction as lm(y~ f~1~ + f~2~)

- Analysis of covariance (ANCOVA)
-allows for different intercepts and slopes with repect to covariate x in different groups

_Expression:_ 

\begin{equation*}
Y \verb|~| Normal({\alpha_i} + {\beta_{ix}}, {\sigma^2}) 
\end{equation*}


R code: lm(y~f*x) for non-parallel slopes, lm(y~f + x) for parallel slopes, lm(y~f) for zero slopes but different intercepts, lm(y~x) a single slope
-paramters are the intercept of the first factor level, the slpe wrt x for the first factor level, the differences in the intercepts for each factor level other than the first, and the differences in slopes for each factor level other than the first.

output: summary - range and quartile of the residuals, standard errors, p-values for coefficients, R^2 and F stats for the full model, 
coef - coefficients alson, coef(summary()) table of estimates, standard errors, t-statistics and pvalues, confint confidencce intervals, plot - diagnostics on assumptions of  model fit, anova anova table 

Take home - R will interpret what your are doing based on whether your variables are factors or numeric.

What happens if we don't have linearity?
nonlinear least squares

1. nonlinear
2. independece
3. normal errors

Examples: power law \begin{equation*} 
Y \verb|~| Normal(ax^b, {\sigma^2}) \end{equation*} is non-linear wrt b,

Ricker model \begin{equation*}  
Y \verb|~| Normal(axe^{-rx}, {\sigma^2}) \end{equation*} 

-minimize the sum of least squares (equivalent to minimizing the negative log likehoold)

nls(y~a*x^b, start = list(a=1, b=1))

-nonlinear analogue  of ANCOVA - nonlinear covariates and categorical variables
#not sure if I have interpreted this rights
nlsList(y ~ a*x^b|x~2~, data, start = list(a=1, b=1))
-fits separate a and b paramters for the two different groups


Generalized linear models:
- allows any nonlinear relationship that has a linearizing transformation ie. a link function

1. nonlinearity
1. non-normal errors
1. still independent     



    A link function transforms a nonlinear relationship to a linear one.

    Examples of linker functions:
    log: x = log(y) linearizes y=e^x 
    squareroot: x=squareroot(y) linearizes y = x^2 
    inverse:x = 1/y linearizes y = 1/x 
    

-still have to calculate the variance on the untransformed scale b/c linearizations will distort this

What type of non-normal erros does glm handle?
exponenetial family - Poisson (link fxn log), binomial (logit), gamma and normal distributions
NOT negative binomial or beta-binomial
-fit by iteratively reweighted least squares, the description of which is somewhat confusing <https://ms.mcmaster.ca/~bolker/emdbook/book.pdf>
-they estimate log-liklihoods and test the differences between models using the likelihood ratio test

2 most common glms: poisson regression for count data, logistic regresssion for survival/failure data

Poisson regression: log link, Poisson error \begin{equation*} 
Y \verb|~| Poisson(ae^{bx}))
\end{equation*}

R code: glm(y~x, family = "poisson")
Logistic regression: logit link, binomial error \begin{equation*} 
Y \verb|~| Binom(p=\frac{exp(a+bx)}{1+exp(a+bx)}, N) 
\end{equation*}

R code: glm(cbind, y, N-y)~x, family = "binomial")

Note that while the output is interpreted the same as lm, the parameters are on the scale of the link function and have to be transformed back by an inverse link function for interpretation (exponential for Poisson, logistic(=plogis) for binomial)

Dealing with overdispersion ie. quasilikelihood inflates the expected variance to account for overdispersion (include?) 

Negative binomial models - not explained

time series and spatial data? mixed (effect) models, mcmc





_How we Evaluate which Model to Use_

- Taking a moment to think about the question we are asking...
- Assumptions of the model
    General linear models:
    1. observed values are independent
    1. normally distributed 
    1. constant variance (homoscedastic)
    1. any covariates (continuous predictor variables) are measured without error 
- Interpreting the output of our model
- Assessing the performance of the model (feedback)
    + Diagnostic plots (ie. residuals, Q-Q plots)


_Running the Model_

- Dealing with dummy variables/encoding categorical variables
- Is it necessary to scale our data?
- Using broom() to get a data frame of our result statistics
- Predictors 

__Challenge:__      

Given this dataset, answer this question. Is this the best model for the job? What else could you apply? Can you prove this is any better?

__Resources:__      
https://github.com/ttimbers/lm_and_glm/blob/master/lm_and_glm.Rmd     
https://github.com/seananderson/glmm-course     
http://michael.hahsler.net/SMU/EMIS7331/R/regression.html
    


##Post-Lesson Assessment
***
_Questions_

- Speed: Too slow, too fast, just right
- Content: Too easy, too hard, just right
- From the description of the lesson, the content was what I expected to learn. T/F
- What was the most useful thing you learned?
- What was the least useful thing?
- Comments/suggestions for improvement.


##Notes
***
- Possibly split lesson 5 - definately - does that put lesson 6 as glms + functions or do we need another lesson?
- Do we want to include nonlinear models, parametric vs nonparametric in this lesson? It might be better to go slow with this so people don't get confused. 
