---
title: "Lesson 2 - Intro to Tidy Data: How to Transform and Manipulate your Data Efficiently"
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

![](img/Data-Wrangling-Is-The.jpg){width=400px} 

</br>

##A quick intro to the intro to R Lesson Series

</br>

This 'Intro to R Lesson Series' is brought to you by the Centre for the Analysis of Genome Evolution & Function's (CAGEF) bioinformatics training initiative. This course was developed based on feedback on the needs and interests of the Department of Cell & Systems Biology and the Department of Ecology and Evolutionary Biology. 



This lesson is the second in a 6-part series. The idea is that at the end of the series, you will be able to import and manipulate your data, make exploratory plots, perform some basic statistical tests, test a regression model, and make some even prettier plots and documents to share your results. 


![](img/data-science-explore.png)

</br>

How do we get there? Today we are going to be learning about how to subset and filter our data and perform all of the manipulations one has to do in daily coding life. We will learn about tidy data and how it makes data analysis less of a pain. We will perform some basic statistics on our newly transformed dataset. Next week we will learn how to tidy our data, subset and merge data and generate descriptive statistics. The next lesson will be data cleaning and string manipulation; this is really the battleground of coding - getting your data into the format where you can analyse it. After that, we will make all sorts of plots - from simple data exploration to interactive plots - this is always a fun lesson. And then lastly, we will learn to write some functions, which really can save you time and help scale up your analyses.


![](img/spotify-howtobuildmvp.gif)

</br>

The structure of the class is a code-along style. It is hands on. The lecture AND code we are going through are available on GitHub for download at https://github.com/eacton/CAGEF __(Note: repo is private until approved)__, so you can spend the time coding and not taking notes. As we go along, there will be some challenge questions and multiple choice questions on Socrative. At the end of the class if you could please fill out a post-lesson survey (https://www.surveymonkey.com/r/SMGKMCS), it will help me further develop this course and would be greatly appreciated. 

</br>

***
__Objective:__ At the end of this session you will know the principles of tidy data, and be able to subset and transform your data, merge data frames, and perform simple calculations.

###Our Dataset

Metagenomic 16SrRNA sequencing of latrines from Tanzania and Vietnam at different depths (multiples of 20cm). 

We have 2 csv files (change one to tsv or xlsx - maybe both and make an additional files and get a google spreadsheet): 
1. A metadata file (Naming conventions: [Country_LatrineNo_Depth]) with sample names and environmental variables.
2. A table of species abundance.

B Torondel, JHJ Ensink, O Gunvirusdu, UZ Ijaz, J Parkhill, F Abdelahi, V-A Nguyen, S Sudgen, W Gibson, AW Walker, and C Quince.
Assessment of the influence of intrinsic environmental and geographical factors on the bacterial ecology of pit latrines
Microbial Biotechnology, 9(2):209-223, 2016. DOI:10.1111/1751-7915.12334

***

Let's read in our dataset, store it in a variable, and remind ourselves about the structure.


```r
dat <- read.csv("data/SPE_pitlatrine.csv", stringsAsFactors = FALSE)
str(dat)
```

```
## 'data.frame':	52 obs. of  82 variables:
##  $ Taxa  : chr  "Acidobacteria_Gp1" "Acidobacteria_Gp10" "Acidobacteria_Gp14" "Acidobacteria_Gp16" ...
##  $ T_2_1 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ T_2_10: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ T_2_12: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ T_2_2 : int  0 0 0 0 0 2 0 0 0 0 ...
##  $ T_2_3 : int  0 0 0 0 0 2 0 0 0 0 ...
##  $ T_2_6 : int  0 0 0 0 0 5 0 0 0 1 ...
##  $ T_2_7 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ T_2_9 : int  0 0 0 0 0 15 0 0 0 0 ...
##  $ T_3_2 : int  0 0 0 0 0 2 0 0 0 0 ...
##  $ T_3_3 : int  0 0 0 0 0 1 0 0 0 0 ...
##  $ T_3_5 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ T_4_3 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ T_4_4 : int  0 0 0 0 0 1 0 0 0 0 ...
##  $ T_4_5 : int  1 0 1 0 0 0 0 0 32 0 ...
##  $ T_4_6 : int  0 0 0 0 0 0 0 0 2 1 ...
##  $ T_4_7 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ T_5_2 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ T_5_3 : int  0 0 0 0 0 1 0 0 0 0 ...
##  $ T_5_4 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ T_5_5 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ T_6_2 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ T_6_5 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ T_6_7 : int  0 0 0 0 0 1 0 0 1 1 ...
##  $ T_6_8 : int  0 0 0 0 0 0 0 0 0 1 ...
##  $ T_9_1 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ T_9_2 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ T_9_3 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ T_9_4 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ T_9_5 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_1_2 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_10_1: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_11_1: int  0 0 0 1 1 0 0 0 1 7 ...
##  $ V_11_2: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_11_3: int  0 0 0 0 0 0 0 0 1 3 ...
##  $ V_12_1: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_12_2: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_13_1: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_13_2: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_14_1: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_14_2: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_14_3: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_15_1: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_15_2: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_15_3: int  0 0 0 0 0 0 0 0 2 0 ...
##  $ V_16_1: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_16_2: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_17_1: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_17_2: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_18_1: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_18_2: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_18_3: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_18_4: int  0 0 0 0 0 0 0 0 10 0 ...
##  $ V_19_1: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_19_2: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_19_3: int  0 0 0 0 0 0 0 0 9 0 ...
##  $ V_2_1 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_2_2 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_2_3 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_20_1: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_21_1: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_21_4: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_22_1: int  1 3 0 0 0 0 0 1 2 7 ...
##  $ V_22_3: int  0 0 0 0 0 0 0 0 0 1 ...
##  $ V_22_4: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_3_1 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_3_2 : int  0 0 0 0 0 0 3 0 0 0 ...
##  $ V_4_1 : int  0 0 0 0 0 0 0 0 0 1 ...
##  $ V_4_2 : int  0 2 0 1 0 0 2 0 3 2 ...
##  $ V_5_1 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_5_3 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_6_1 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_6_2 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_6_3 : int  0 0 0 0 0 0 0 0 11 1 ...
##  $ V_7_1 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_7_2 : int  1 1 0 0 0 0 1 0 1 0 ...
##  $ V_7_3 : int  7 9 1 0 0 1 3 4 68 8 ...
##  $ V_8_2 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_9_1 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_9_2 : int  18 0 0 0 0 0 0 0 0 0 ...
##  $ V_9_3 : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ V_9_4 : int  38 0 17 0 0 0 0 0 19 0 ...
```


    In this lesson we want to answer 3 simple questions: 
    - Which latrine depth has the greatest mean number of OTUs?
    - Is there more Clostridia in Tanzania or Vietnam?
    - Which site had the greatest number of bacteria?


To help us be able to answer these questions, we are going to learn how to manipulate our data.

![](img/making_progress.png){width=200px} 

First, I am going to show you how to subset the data and answers these questions in __base R__. Then I will show you how do the same thing with the popular packages `dplyr` and `tidyr`. These packages are great for data wrangling __with data frames__. While a lot of new packages play nicely with the functions we are going to use today, but not all packages or data structures will work with `dplyr` functions. You will see `dplyr` and `tidyr` used for data cleaning and the manipulation of data frames.


##A quick intro to base R subsetting

It is often extremely useful to subset your data by some logical condition (`==` (equal to), `!=` (not equal to), `>` (greater than), `>=` (greater than or equal to), `<` (less than), `<=` (less than or equal to), `&` (and), `|` (or)). For example, we may want to keep all rows that have either Fusobacteria or Methanobacteria.


```r
dat[dat$Taxa == "Fusobacteria" | dat$Taxa == "Methanobacteria", ]
```

```
##               Taxa T_2_1 T_2_10 T_2_12 T_2_2 T_2_3 T_2_6 T_2_7 T_2_9 T_3_2
## 34    Fusobacteria     0      0      0     0     0     1     0     2     0
## 39 Methanobacteria     0      0      0     1     0     0     0     0     0
##    T_3_3 T_3_5 T_4_3 T_4_4 T_4_5 T_4_6 T_4_7 T_5_2 T_5_3 T_5_4 T_5_5 T_6_2
## 34     0     0     0     0     0     0     0     1     2     0     0     0
## 39     0     0     0     0     0     0     0     0     0     0     0     0
##    T_6_5 T_6_7 T_6_8 T_9_1 T_9_2 T_9_3 T_9_4 T_9_5 V_1_2 V_10_1 V_11_1
## 34     0     0     0     0     0     0     2     0    19     92      1
## 39     0     0     0     0     0     0     0     0     0      0      0
##    V_11_2 V_11_3 V_12_1 V_12_2 V_13_1 V_13_2 V_14_1 V_14_2 V_14_3 V_15_1
## 34      0      0      0      0      0      3      6      1     55      1
## 39      0      0      0      0      0      0      0      0      0      0
##    V_15_2 V_15_3 V_16_1 V_16_2 V_17_1 V_17_2 V_18_1 V_18_2 V_18_3 V_18_4
## 34      0      0    115     32    152    207     10      3      0      2
## 39      0      0      0      0      0      0      0      0      0      0
##    V_19_1 V_19_2 V_19_3 V_2_1 V_2_2 V_2_3 V_20_1 V_21_1 V_21_4 V_22_1
## 34     27      5      0     0     0     0      1      0      0      0
## 39      0      0      0     0     0     0      0      0      0      0
##    V_22_3 V_22_4 V_3_1 V_3_2 V_4_1 V_4_2 V_5_1 V_5_3 V_6_1 V_6_2 V_6_3
## 34      0      0     0     0     0     0    10     2     6     1     0
## 39      0      0     0     0     0     0     0     0     0     0     0
##    V_7_1 V_7_2 V_7_3 V_8_2 V_9_1 V_9_2 V_9_3 V_9_4
## 34    92     1    16     0     3     0     0     0
## 39     0     0     0     0     0     0     0     0
```
Will this work?


```r
dat[dat$Taxa == "Fusobacteria" | "Methanobacteria", ]
```

```
## Error in dat$Taxa == "Fusobacteria" | "Methanobacteria": operations are possible only for numeric, logical or complex types
```

What about this? 


```r
dat[dat$Taxa == c("Fusobacteria", "Methanobacteria"), ]
```

```
##  [1] Taxa   T_2_1  T_2_10 T_2_12 T_2_2  T_2_3  T_2_6  T_2_7  T_2_9  T_3_2 
## [11] T_3_3  T_3_5  T_4_3  T_4_4  T_4_5  T_4_6  T_4_7  T_5_2  T_5_3  T_5_4 
## [21] T_5_5  T_6_2  T_6_5  T_6_7  T_6_8  T_9_1  T_9_2  T_9_3  T_9_4  T_9_5 
## [31] V_1_2  V_10_1 V_11_1 V_11_2 V_11_3 V_12_1 V_12_2 V_13_1 V_13_2 V_14_1
## [41] V_14_2 V_14_3 V_15_1 V_15_2 V_15_3 V_16_1 V_16_2 V_17_1 V_17_2 V_18_1
## [51] V_18_2 V_18_3 V_18_4 V_19_1 V_19_2 V_19_3 V_2_1  V_2_2  V_2_3  V_20_1
## [61] V_21_1 V_21_4 V_22_1 V_22_3 V_22_4 V_3_1  V_3_2  V_4_1  V_4_2  V_5_1 
## [71] V_5_3  V_6_1  V_6_2  V_6_3  V_7_1  V_7_2  V_7_3  V_8_2  V_9_1  V_9_2 
## [81] V_9_3  V_9_4 
## <0 rows> (or 0-length row.names)
```

Wait a second - why is this answer different?

***

<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/pause.jpg){width=100px}

</div>


##A quick reminder/warning about vectors. 


```r
c(1,2,3) + c(10,11)
```

```
## Warning in c(1, 2, 3) + c(10, 11): longer object length is not a multiple
## of shorter object length
```

```
## [1] 11 13 13
```

```r
c(1,2,3,4) + c(10,11)
```

```
## [1] 11 13 13 15
```
Vectors recycle. In this case, R gave us a warning that our vectors don't match. However, R will assume that you know what you are doing as long as your one of your vector lengths is a multiple of your other vector length.


```r
c(1,2,3,4) + c(10,11)
```

```
## [1] 11 13 13 15
```

Let's go back to our example.


```r
dat[dat$Taxa == "Fusobacteria" | dat$Taxa == "Methanobacteria", ]
```
In this code, I am looking through the Taxa column for when Taxa is equal to Fusobacteria OR Taxa is equal to Methanobacteria.



```r
dat[dat$Taxa == c("Fusobacteria", "Methanobacteria"), ]
```

However, with a vector, I am alternately going through all values of Taxa and asking: does the first value match Fusobacteria? does the second value match Methanobacteria? Then the vector recycles and asks: does the third value match Fusobacteria? does the 4th value match Methanobacteria? We end up with a data frame of zero observations when we are expecting a data frame of 2 observations. 


Be careful when filtering. You have been warned.

</br>

***
You can also filter to obtain more specific subsets using more than one column. To see if there were any Bacteroidia at site T_2_1, you can use the following filter:


```r
dat[dat$Taxa == "Bacteroidia" & dat$T_2_1 != 0, ]
```

```
##           Taxa T_2_1 T_2_10 T_2_12 T_2_2 T_2_3 T_2_6 T_2_7 T_2_9 T_3_2
## 19 Bacteroidia  1547      8      0   718   679   143     1   924   314
##    T_3_3 T_3_5 T_4_3 T_4_4 T_4_5 T_4_6 T_4_7 T_5_2 T_5_3 T_5_4 T_5_5 T_6_2
## 19   138    22     1   116   156    49    13   964  1377    70    41     1
##    T_6_5 T_6_7 T_6_8 T_9_1 T_9_2 T_9_3 T_9_4 T_9_5 V_1_2 V_10_1 V_11_1
## 19     3   274    81     0   317    26   830   504   347   4221     45
##    V_11_2 V_11_3 V_12_1 V_12_2 V_13_1 V_13_2 V_14_1 V_14_2 V_14_3 V_15_1
## 19    112    366    126     21     49    542    722      4    399   1003
##    V_15_2 V_15_3 V_16_1 V_16_2 V_17_1 V_17_2 V_18_1 V_18_2 V_18_3 V_18_4
## 19    541    540   4267   2556  11392   2140    389    368    176    976
##    V_19_1 V_19_2 V_19_3 V_2_1 V_2_2 V_2_3 V_20_1 V_21_1 V_21_4 V_22_1
## 19   2560    800    262    48    37   100   1652    200     84     31
##    V_22_3 V_22_4 V_3_1 V_3_2 V_4_1 V_4_2 V_5_1 V_5_3 V_6_1 V_6_2 V_6_3
## 19    311     53     4    11     3     3   274   217    48   468   134
##    V_7_1 V_7_2 V_7_3 V_8_2 V_9_1 V_9_2 V_9_3 V_9_4
## 19  2231   141   166  1346  3582    56     2     7
```

You can select columns by name or position, and reorder them as well (you can also do this for rows). I want to to compare the depth of latrine 2 at 9cm compared to 10cm, but I want Taxa in the last column. To inspect the first 10 rows of an output, you can use the `head()` function. Likewise, to inspect the last 10 rows, you can use the `tail()` function. Try changing the output to show only the first 5 rows of your data frame.


```r
head(dat[ , c("T_2_9", "T_2_10", "Taxa")])
```

```
##   T_2_9 T_2_10               Taxa
## 1     0      0  Acidobacteria_Gp1
## 2     0      0 Acidobacteria_Gp10
## 3     0      0 Acidobacteria_Gp14
## 4     0      0 Acidobacteria_Gp16
## 5     0      0 Acidobacteria_Gp17
## 6    15      0 Acidobacteria_Gp18
```

```r
#equivalent to
head(dat[ , c(9:10,1)])
```

```
##   T_2_9 T_3_2               Taxa
## 1     0     0  Acidobacteria_Gp1
## 2     0     0 Acidobacteria_Gp10
## 3     0     0 Acidobacteria_Gp14
## 4     0     0 Acidobacteria_Gp16
## 5     0     0 Acidobacteria_Gp17
## 6    15     2 Acidobacteria_Gp18
```

```r
tail(dat[ , "Taxa"])
```

```
## [1] "Subdivision3"   "Synergistia"    "Thermomicrobia" "Thermoplasmata"
## [5] "Thermotogae"    "Unknown"
```

```r
#equivalent to
tail(dat[ , 1])
```

```
## [1] "Subdivision3"   "Synergistia"    "Thermomicrobia" "Thermoplasmata"
## [5] "Thermotogae"    "Unknown"
```
You can arrange your data frame alphabetically or by value using `order()`.


```r
head(dat[order(dat$Taxa, decreasing = TRUE), ]) 
```

```
##              Taxa T_2_1 T_2_10 T_2_12 T_2_2 T_2_3 T_2_6 T_2_7 T_2_9 T_3_2
## 52        Unknown   759     24      6  1342  1555  1832     7  3240   676
## 51    Thermotogae     0      0      0     0     0     1     0     1     0
## 50 Thermoplasmata     0      0      0     0     0     0     0     0     0
## 49 Thermomicrobia     0      0      0     3     3     3     0     2     1
## 48    Synergistia    21      4      0    84   110   333     0   658   125
## 47   Subdivision3     0      0      0     0     0     0     0     0     0
##    T_3_3 T_3_5 T_4_3 T_4_4 T_4_5 T_4_6 T_4_7 T_5_2 T_5_3 T_5_4 T_5_5 T_6_2
## 52   306    69     3   826   676   200    44  1871  3214   131    94    13
## 51     0     0     0     0     0     0     0     0     0     0     0     0
## 50     0     0     0     0     0     0     0     1     0     0     0     0
## 49     0     0     0    16    42    13     1     1     1     1     0     0
## 48    70    13     0   404   297    95    22   218   324    20     8     1
## 47     0     0     0     0     0     1     0     0     0     0     0     0
##    T_6_5 T_6_7 T_6_8 T_9_1 T_9_2 T_9_3 T_9_4 T_9_5 V_1_2 V_10_1 V_11_1
## 52   128   602   560     0 10624    75  2808  2817    89    132    425
## 51     0     0     0     0     0     0     0     0     0      0      0
## 50     0     0     0     0     0     0     0     0     0      0      0
## 49     0     0     6     0     0     0     0     0     0      1    130
## 48    47    80    37     0     7     3    16    32     0      0      0
## 47     0     0     0     0     0     0     0     0     0      0      0
##    V_11_2 V_11_3 V_12_1 V_12_2 V_13_1 V_13_2 V_14_1 V_14_2 V_14_3 V_15_1
## 52    141   1304    482    196    123    914    416      0     81    837
## 51      0      0      0      0      0      0      0      0      0      0
## 50      0      0      0      0      0      0      0      0      0      0
## 49     20    209      1      7      2      3      0      0      2      5
## 48      0      2      0      0      2      5      1      0      5     50
## 47      0      0      0      0      0      0      0      0      0      0
##    V_15_2 V_15_3 V_16_1 V_16_2 V_17_1 V_17_2 V_18_1 V_18_2 V_18_3 V_18_4
## 52    504    429    345   1365     87    285     55     54    404   1483
## 51      0      0      0      0      0      0      0      0      0      0
## 50      0      0      0      0      0      0      0      0      0      0
## 49     35     23      1      0      1      1      1      1     32     84
## 48      5      3      0      9      0      5      0      0      0      0
## 47      0      0      0      0      0      0      0      0      0      0
##    V_19_1 V_19_2 V_19_3 V_2_1 V_2_2 V_2_3 V_20_1 V_21_1 V_21_4 V_22_1
## 52    484    176    371    16   167   150    725     58     72   1013
## 51      0      0      0     0     0     0      0      0      0      0
## 50      0      0      0     0     0     0      0      0      0      0
## 49      0     15     29     0     9     1      1      5      8    190
## 48      3      0      0     0     0     0      0      0      0      0
## 47      0      0      0     0     0     0      0      0      0      0
##    V_22_3 V_22_4 V_3_1 V_3_2 V_4_1 V_4_2 V_5_1 V_5_3 V_6_1 V_6_2 V_6_3
## 52    670    784   814   645    79   242    30  1139   227   187   527
## 51      0      0     0     0     0     0     0     0     0     0     0
## 50      0      0     0     0     0     0     0     0     0     0     0
## 49      9      9   309   196     6    29     0   212   325    12    78
## 48      0      0     0     2     0     0     0     0     3    22     2
## 47      0      0     0     0     0     0     0     0     0     0     0
##    V_7_1 V_7_2 V_7_3 V_8_2 V_9_1 V_9_2 V_9_3 V_9_4
## 52    50   696  1170   792    41   954     2   303
## 51     0     0     0     0     0     0     0     0
## 50     0     0     0     0     0     0     0     0
## 49    25    64    54    71     1     2     0    35
## 48     0     0     2     0     0     0     0     0
## 47     0     0     0     0     0     0     0     0
```
You can order your data frame by multiple variables.


```r
head(dat[order(dat$T_2_1, decreasing = TRUE), ])
```

```
##               Taxa T_2_1 T_2_10 T_2_12 T_2_2 T_2_3 T_2_6 T_2_7 T_2_9 T_3_2
## 25      Clostridia  6213     71      0  8999 10944 12169    28 17471  3431
## 19     Bacteroidia  1547      8      0   718   679   143     1   924   314
## 52         Unknown   759     24      6  1342  1555  1832     7  3240   676
## 31 Erysipelotrichi   433      0      0   495   643   629     0   933   193
## 15  Actinobacteria   110      3      5   240   414   227     1   811    89
## 46    Spirochaetes    62      0      0    72   266    43     1   175    19
##    T_3_3 T_3_5 T_4_3 T_4_4 T_4_5 T_4_6 T_4_7 T_5_2 T_5_3 T_5_4 T_5_5 T_6_2
## 25  1277   277     7 10545  3612  1306   198  5985  8981   763   311   106
## 19   138    22     1   116   156    49    13   964  1377    70    41     1
## 52   306    69     3   826   676   200    44  1871  3214   131    94    13
## 31    66    20     0   127    65    25     3   285   432    14     5     0
## 15    36     7   498   573  1345   444    57   120   139    20     6     2
## 46     7     0     0     8     7     2     0   114   137    11     4     1
##    T_6_5 T_6_7 T_6_8 T_9_1 T_9_2 T_9_3 T_9_4 T_9_5 V_1_2 V_10_1 V_11_1
## 25   496  3841  1264     0   740    33  1085  1064  3947  11180    790
## 19     3   274    81     0   317    26   830   504   347   4221     45
## 52   128   602   560     0 10624    75  2808  2817    89    132    425
## 31     7    97    92     0    19     0    23    28   242    205     39
## 15     3   160   193     0     2     2     6     4   182     94   5182
## 46     2    32    13     0    21     2    44    26     0      0      0
##    V_11_2 V_11_3 V_12_1 V_12_2 V_13_1 V_13_2 V_14_1 V_14_2 V_14_3 V_15_1
## 25    278   1608   2165    622   1008   4648   3449     33   1712   8244
## 19    112    366    126     21     49    542    722      4    399   1003
## 52    141   1304    482    196    123    914    416      0     81    837
## 31     34    106    153     21      9     94    169      1     64    592
## 15    452   2364   1572    492     25    214     77      2     87    237
## 46      0     26      0      0      0      0      6      0      3      0
##    V_15_2 V_15_3 V_16_1 V_16_2 V_17_1 V_17_2 V_18_1 V_18_2 V_18_3 V_18_4
## 25   4761   3910  10043  17572   7722  13875   7481   6071   1044   6246
## 19    541    540   4267   2556  11392   2140    389    368    176    976
## 52    504    429    345   1365     87    285     55     54    404   1483
## 31    226    184    253    496    292    328    219     66      4    112
## 15    379    273    138    391    112    248    116     77    288    683
## 46     25     88     20      3      1      3      0      0      0     19
##    V_19_1 V_19_2 V_19_3 V_2_1 V_2_2 V_2_3 V_20_1 V_21_1 V_21_4 V_22_1
## 25   1720    493   5970   174    93   716   5878   4052   3797   1093
## 19   2560    800    262    48    37   100   1652    200     84     31
## 52    484    176    371    16   167   150    725     58     72   1013
## 31    234     52     35     6    13    14    306     66     96     96
## 15    313    221    352    15  1717   260    425    608    160   1771
## 46    557    176      6     0     0     0      0      0      0      3
##    V_22_3 V_22_4 V_3_1 V_3_2 V_4_1 V_4_2 V_5_1 V_5_3 V_6_1 V_6_2 V_6_3
## 25   1046    324   237   688   233   571   794  4461  1134  6048  1432
## 19    311     53     4    11     3     3   274   217    48   468   134
## 52    670    784   814   645    79   242    30  1139   227   187   527
## 31     33     15     5    16     7    49    12   114    38   217    76
## 15    751    387  2312  2649    30    70    12  1671  1367   779  2280
## 46     11      3     2     0     1     1     0     3     0     1    11
##    V_7_1 V_7_2 V_7_3 V_8_2 V_9_1 V_9_2 V_9_3 V_9_4
## 25  4213   717  3134  3084  2356   143    18  3051
## 19  2231   141   166  1346  3582    56     2     7
## 52    50   696  1170   792    41   954     2   303
## 31    20    18    81   172    23    40     1    43
## 15   376  1005   337   675    84   870     6   273
## 46     0     4     4     2     3     0     0    18
```

```r
head(dat[order(dat$T_2_1, dat$T_2_12, decreasing = TRUE), ]) 
```

```
##               Taxa T_2_1 T_2_10 T_2_12 T_2_2 T_2_3 T_2_6 T_2_7 T_2_9 T_3_2
## 25      Clostridia  6213     71      0  8999 10944 12169    28 17471  3431
## 19     Bacteroidia  1547      8      0   718   679   143     1   924   314
## 52         Unknown   759     24      6  1342  1555  1832     7  3240   676
## 31 Erysipelotrichi   433      0      0   495   643   629     0   933   193
## 15  Actinobacteria   110      3      5   240   414   227     1   811    89
## 46    Spirochaetes    62      0      0    72   266    43     1   175    19
##    T_3_3 T_3_5 T_4_3 T_4_4 T_4_5 T_4_6 T_4_7 T_5_2 T_5_3 T_5_4 T_5_5 T_6_2
## 25  1277   277     7 10545  3612  1306   198  5985  8981   763   311   106
## 19   138    22     1   116   156    49    13   964  1377    70    41     1
## 52   306    69     3   826   676   200    44  1871  3214   131    94    13
## 31    66    20     0   127    65    25     3   285   432    14     5     0
## 15    36     7   498   573  1345   444    57   120   139    20     6     2
## 46     7     0     0     8     7     2     0   114   137    11     4     1
##    T_6_5 T_6_7 T_6_8 T_9_1 T_9_2 T_9_3 T_9_4 T_9_5 V_1_2 V_10_1 V_11_1
## 25   496  3841  1264     0   740    33  1085  1064  3947  11180    790
## 19     3   274    81     0   317    26   830   504   347   4221     45
## 52   128   602   560     0 10624    75  2808  2817    89    132    425
## 31     7    97    92     0    19     0    23    28   242    205     39
## 15     3   160   193     0     2     2     6     4   182     94   5182
## 46     2    32    13     0    21     2    44    26     0      0      0
##    V_11_2 V_11_3 V_12_1 V_12_2 V_13_1 V_13_2 V_14_1 V_14_2 V_14_3 V_15_1
## 25    278   1608   2165    622   1008   4648   3449     33   1712   8244
## 19    112    366    126     21     49    542    722      4    399   1003
## 52    141   1304    482    196    123    914    416      0     81    837
## 31     34    106    153     21      9     94    169      1     64    592
## 15    452   2364   1572    492     25    214     77      2     87    237
## 46      0     26      0      0      0      0      6      0      3      0
##    V_15_2 V_15_3 V_16_1 V_16_2 V_17_1 V_17_2 V_18_1 V_18_2 V_18_3 V_18_4
## 25   4761   3910  10043  17572   7722  13875   7481   6071   1044   6246
## 19    541    540   4267   2556  11392   2140    389    368    176    976
## 52    504    429    345   1365     87    285     55     54    404   1483
## 31    226    184    253    496    292    328    219     66      4    112
## 15    379    273    138    391    112    248    116     77    288    683
## 46     25     88     20      3      1      3      0      0      0     19
##    V_19_1 V_19_2 V_19_3 V_2_1 V_2_2 V_2_3 V_20_1 V_21_1 V_21_4 V_22_1
## 25   1720    493   5970   174    93   716   5878   4052   3797   1093
## 19   2560    800    262    48    37   100   1652    200     84     31
## 52    484    176    371    16   167   150    725     58     72   1013
## 31    234     52     35     6    13    14    306     66     96     96
## 15    313    221    352    15  1717   260    425    608    160   1771
## 46    557    176      6     0     0     0      0      0      0      3
##    V_22_3 V_22_4 V_3_1 V_3_2 V_4_1 V_4_2 V_5_1 V_5_3 V_6_1 V_6_2 V_6_3
## 25   1046    324   237   688   233   571   794  4461  1134  6048  1432
## 19    311     53     4    11     3     3   274   217    48   468   134
## 52    670    784   814   645    79   242    30  1139   227   187   527
## 31     33     15     5    16     7    49    12   114    38   217    76
## 15    751    387  2312  2649    30    70    12  1671  1367   779  2280
## 46     11      3     2     0     1     1     0     3     0     1    11
##    V_7_1 V_7_2 V_7_3 V_8_2 V_9_1 V_9_2 V_9_3 V_9_4
## 25  4213   717  3134  3084  2356   143    18  3051
## 19  2231   141   166  1346  3582    56     2     7
## 52    50   696  1170   792    41   954     2   303
## 31    20    18    81   172    23    40     1    43
## 15   376  1005   337   675    84   870     6   273
## 46     0     4     4     2     3     0     0    18
```

```r
head(dat[order(dat$T_2_1, dat$T_2_12, dat$T_2_9, decreasing = TRUE), ])
```

```
##               Taxa T_2_1 T_2_10 T_2_12 T_2_2 T_2_3 T_2_6 T_2_7 T_2_9 T_3_2
## 25      Clostridia  6213     71      0  8999 10944 12169    28 17471  3431
## 19     Bacteroidia  1547      8      0   718   679   143     1   924   314
## 52         Unknown   759     24      6  1342  1555  1832     7  3240   676
## 31 Erysipelotrichi   433      0      0   495   643   629     0   933   193
## 15  Actinobacteria   110      3      5   240   414   227     1   811    89
## 46    Spirochaetes    62      0      0    72   266    43     1   175    19
##    T_3_3 T_3_5 T_4_3 T_4_4 T_4_5 T_4_6 T_4_7 T_5_2 T_5_3 T_5_4 T_5_5 T_6_2
## 25  1277   277     7 10545  3612  1306   198  5985  8981   763   311   106
## 19   138    22     1   116   156    49    13   964  1377    70    41     1
## 52   306    69     3   826   676   200    44  1871  3214   131    94    13
## 31    66    20     0   127    65    25     3   285   432    14     5     0
## 15    36     7   498   573  1345   444    57   120   139    20     6     2
## 46     7     0     0     8     7     2     0   114   137    11     4     1
##    T_6_5 T_6_7 T_6_8 T_9_1 T_9_2 T_9_3 T_9_4 T_9_5 V_1_2 V_10_1 V_11_1
## 25   496  3841  1264     0   740    33  1085  1064  3947  11180    790
## 19     3   274    81     0   317    26   830   504   347   4221     45
## 52   128   602   560     0 10624    75  2808  2817    89    132    425
## 31     7    97    92     0    19     0    23    28   242    205     39
## 15     3   160   193     0     2     2     6     4   182     94   5182
## 46     2    32    13     0    21     2    44    26     0      0      0
##    V_11_2 V_11_3 V_12_1 V_12_2 V_13_1 V_13_2 V_14_1 V_14_2 V_14_3 V_15_1
## 25    278   1608   2165    622   1008   4648   3449     33   1712   8244
## 19    112    366    126     21     49    542    722      4    399   1003
## 52    141   1304    482    196    123    914    416      0     81    837
## 31     34    106    153     21      9     94    169      1     64    592
## 15    452   2364   1572    492     25    214     77      2     87    237
## 46      0     26      0      0      0      0      6      0      3      0
##    V_15_2 V_15_3 V_16_1 V_16_2 V_17_1 V_17_2 V_18_1 V_18_2 V_18_3 V_18_4
## 25   4761   3910  10043  17572   7722  13875   7481   6071   1044   6246
## 19    541    540   4267   2556  11392   2140    389    368    176    976
## 52    504    429    345   1365     87    285     55     54    404   1483
## 31    226    184    253    496    292    328    219     66      4    112
## 15    379    273    138    391    112    248    116     77    288    683
## 46     25     88     20      3      1      3      0      0      0     19
##    V_19_1 V_19_2 V_19_3 V_2_1 V_2_2 V_2_3 V_20_1 V_21_1 V_21_4 V_22_1
## 25   1720    493   5970   174    93   716   5878   4052   3797   1093
## 19   2560    800    262    48    37   100   1652    200     84     31
## 52    484    176    371    16   167   150    725     58     72   1013
## 31    234     52     35     6    13    14    306     66     96     96
## 15    313    221    352    15  1717   260    425    608    160   1771
## 46    557    176      6     0     0     0      0      0      0      3
##    V_22_3 V_22_4 V_3_1 V_3_2 V_4_1 V_4_2 V_5_1 V_5_3 V_6_1 V_6_2 V_6_3
## 25   1046    324   237   688   233   571   794  4461  1134  6048  1432
## 19    311     53     4    11     3     3   274   217    48   468   134
## 52    670    784   814   645    79   242    30  1139   227   187   527
## 31     33     15     5    16     7    49    12   114    38   217    76
## 15    751    387  2312  2649    30    70    12  1671  1367   779  2280
## 46     11      3     2     0     1     1     0     3     0     1    11
##    V_7_1 V_7_2 V_7_3 V_8_2 V_9_1 V_9_2 V_9_3 V_9_4
## 25  4213   717  3134  3084  2356   143    18  3051
## 19  2231   141   166  1346  3582    56     2     7
## 52    50   696  1170   792    41   954     2   303
## 31    20    18    81   172    23    40     1    43
## 15   376  1005   337   675    84   870     6   273
## 46     0     4     4     2     3     0     0    18
```
Now that we have some basic data-wrangling skills:

    - Which latrine depth has the greatest mean number of OTUs?
    - Is there more Clostridia in Tanzania or Vietnam?
    - Which site had the greatest number of bacteria?


How easy is it to answer these questions with the data in this 'messy' format?

***
__Challenge__ 


<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/pug_challenge1.jpeg){width=200px}

</div>

Answer our 3 questions using the base R.

</br>
</br>

***

##A quick intro to the dplyr package

The `dplyr` package was made by Hadley Wickham to help make data manipulation with data frames easier. It has 5 major functions:
  1. `filter()` - subsets your data frame by row
  2. `select()` - subsets your data frame by columns
  3. `arrange()` - orders your data frame alphabetically or numerically by ascending or descending variables
  4. `mutate(), transmute()` - create a new column of data
  5. `summarize()` - reduces data to summary values (for example using `mean()`, `sd()`, `min()`, `quantile()`, etc)
  
  
The `dplyr` package, and some other common packages for data frame manipulation allow the use of the pipe function, `%>%`. This is equivalent to `|` for any unix peeps. 'Piping' allows the output of a function to be passed to the next function without making intermediate variables. Piping can save typing, make your code more readable, and reduce clutter in your global environment from variables you don't need.

Let's load the library.


```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

We are going to see how pipes work in conjunction with our first function, `filter()`. We are going to use the same subsetting examples so you can see how the syntax differs from base R. In this case, we want to keep all rows that have either Fusobacteria or Methanobacteria. 


```r
filter(dat, Taxa == "Fusobacteria" | Taxa == "Methanobacteria")
```

```
##              Taxa T_2_1 T_2_10 T_2_12 T_2_2 T_2_3 T_2_6 T_2_7 T_2_9 T_3_2
## 1    Fusobacteria     0      0      0     0     0     1     0     2     0
## 2 Methanobacteria     0      0      0     1     0     0     0     0     0
##   T_3_3 T_3_5 T_4_3 T_4_4 T_4_5 T_4_6 T_4_7 T_5_2 T_5_3 T_5_4 T_5_5 T_6_2
## 1     0     0     0     0     0     0     0     1     2     0     0     0
## 2     0     0     0     0     0     0     0     0     0     0     0     0
##   T_6_5 T_6_7 T_6_8 T_9_1 T_9_2 T_9_3 T_9_4 T_9_5 V_1_2 V_10_1 V_11_1
## 1     0     0     0     0     0     0     2     0    19     92      1
## 2     0     0     0     0     0     0     0     0     0      0      0
##   V_11_2 V_11_3 V_12_1 V_12_2 V_13_1 V_13_2 V_14_1 V_14_2 V_14_3 V_15_1
## 1      0      0      0      0      0      3      6      1     55      1
## 2      0      0      0      0      0      0      0      0      0      0
##   V_15_2 V_15_3 V_16_1 V_16_2 V_17_1 V_17_2 V_18_1 V_18_2 V_18_3 V_18_4
## 1      0      0    115     32    152    207     10      3      0      2
## 2      0      0      0      0      0      0      0      0      0      0
##   V_19_1 V_19_2 V_19_3 V_2_1 V_2_2 V_2_3 V_20_1 V_21_1 V_21_4 V_22_1
## 1     27      5      0     0     0     0      1      0      0      0
## 2      0      0      0     0     0     0      0      0      0      0
##   V_22_3 V_22_4 V_3_1 V_3_2 V_4_1 V_4_2 V_5_1 V_5_3 V_6_1 V_6_2 V_6_3
## 1      0      0     0     0     0     0    10     2     6     1     0
## 2      0      0     0     0     0     0     0     0     0     0     0
##   V_7_1 V_7_2 V_7_3 V_8_2 V_9_1 V_9_2 V_9_3 V_9_4
## 1    92     1    16     0     3     0     0     0
## 2     0     0     0     0     0     0     0     0
```

```r
#equivalent to
dat %>% filter(Taxa == "Fusobacteria" | Taxa == "Methanobacteria")
```

```
##              Taxa T_2_1 T_2_10 T_2_12 T_2_2 T_2_3 T_2_6 T_2_7 T_2_9 T_3_2
## 1    Fusobacteria     0      0      0     0     0     1     0     2     0
## 2 Methanobacteria     0      0      0     1     0     0     0     0     0
##   T_3_3 T_3_5 T_4_3 T_4_4 T_4_5 T_4_6 T_4_7 T_5_2 T_5_3 T_5_4 T_5_5 T_6_2
## 1     0     0     0     0     0     0     0     1     2     0     0     0
## 2     0     0     0     0     0     0     0     0     0     0     0     0
##   T_6_5 T_6_7 T_6_8 T_9_1 T_9_2 T_9_3 T_9_4 T_9_5 V_1_2 V_10_1 V_11_1
## 1     0     0     0     0     0     0     2     0    19     92      1
## 2     0     0     0     0     0     0     0     0     0      0      0
##   V_11_2 V_11_3 V_12_1 V_12_2 V_13_1 V_13_2 V_14_1 V_14_2 V_14_3 V_15_1
## 1      0      0      0      0      0      3      6      1     55      1
## 2      0      0      0      0      0      0      0      0      0      0
##   V_15_2 V_15_3 V_16_1 V_16_2 V_17_1 V_17_2 V_18_1 V_18_2 V_18_3 V_18_4
## 1      0      0    115     32    152    207     10      3      0      2
## 2      0      0      0      0      0      0      0      0      0      0
##   V_19_1 V_19_2 V_19_3 V_2_1 V_2_2 V_2_3 V_20_1 V_21_1 V_21_4 V_22_1
## 1     27      5      0     0     0     0      1      0      0      0
## 2      0      0      0     0     0     0      0      0      0      0
##   V_22_3 V_22_4 V_3_1 V_3_2 V_4_1 V_4_2 V_5_1 V_5_3 V_6_1 V_6_2 V_6_3
## 1      0      0     0     0     0     0    10     2     6     1     0
## 2      0      0     0     0     0     0     0     0     0     0     0
##   V_7_1 V_7_2 V_7_3 V_8_2 V_9_1 V_9_2 V_9_3 V_9_4
## 1    92     1    16     0     3     0     0     0
## 2     0     0     0     0     0     0     0     0
```

```r
#equivalent to
dat %>% filter(., Taxa == "Fusobacteria" | Taxa == "Methanobacteria")
```

```
##              Taxa T_2_1 T_2_10 T_2_12 T_2_2 T_2_3 T_2_6 T_2_7 T_2_9 T_3_2
## 1    Fusobacteria     0      0      0     0     0     1     0     2     0
## 2 Methanobacteria     0      0      0     1     0     0     0     0     0
##   T_3_3 T_3_5 T_4_3 T_4_4 T_4_5 T_4_6 T_4_7 T_5_2 T_5_3 T_5_4 T_5_5 T_6_2
## 1     0     0     0     0     0     0     0     1     2     0     0     0
## 2     0     0     0     0     0     0     0     0     0     0     0     0
##   T_6_5 T_6_7 T_6_8 T_9_1 T_9_2 T_9_3 T_9_4 T_9_5 V_1_2 V_10_1 V_11_1
## 1     0     0     0     0     0     0     2     0    19     92      1
## 2     0     0     0     0     0     0     0     0     0      0      0
##   V_11_2 V_11_3 V_12_1 V_12_2 V_13_1 V_13_2 V_14_1 V_14_2 V_14_3 V_15_1
## 1      0      0      0      0      0      3      6      1     55      1
## 2      0      0      0      0      0      0      0      0      0      0
##   V_15_2 V_15_3 V_16_1 V_16_2 V_17_1 V_17_2 V_18_1 V_18_2 V_18_3 V_18_4
## 1      0      0    115     32    152    207     10      3      0      2
## 2      0      0      0      0      0      0      0      0      0      0
##   V_19_1 V_19_2 V_19_3 V_2_1 V_2_2 V_2_3 V_20_1 V_21_1 V_21_4 V_22_1
## 1     27      5      0     0     0     0      1      0      0      0
## 2      0      0      0     0     0     0      0      0      0      0
##   V_22_3 V_22_4 V_3_1 V_3_2 V_4_1 V_4_2 V_5_1 V_5_3 V_6_1 V_6_2 V_6_3
## 1      0      0     0     0     0     0    10     2     6     1     0
## 2      0      0     0     0     0     0     0     0     0     0     0
##   V_7_1 V_7_2 V_7_3 V_8_2 V_9_1 V_9_2 V_9_3 V_9_4
## 1    92     1    16     0     3     0     0     0
## 2     0     0     0     0     0     0     0     0
```



To see if there were any Bacteroidia at site T_2_1, you can use the following filter:


```r
dat %>% filter(., Taxa == "Bacteroidia" & T_2_1 != 0)
```

```
##          Taxa T_2_1 T_2_10 T_2_12 T_2_2 T_2_3 T_2_6 T_2_7 T_2_9 T_3_2
## 1 Bacteroidia  1547      8      0   718   679   143     1   924   314
##   T_3_3 T_3_5 T_4_3 T_4_4 T_4_5 T_4_6 T_4_7 T_5_2 T_5_3 T_5_4 T_5_5 T_6_2
## 1   138    22     1   116   156    49    13   964  1377    70    41     1
##   T_6_5 T_6_7 T_6_8 T_9_1 T_9_2 T_9_3 T_9_4 T_9_5 V_1_2 V_10_1 V_11_1
## 1     3   274    81     0   317    26   830   504   347   4221     45
##   V_11_2 V_11_3 V_12_1 V_12_2 V_13_1 V_13_2 V_14_1 V_14_2 V_14_3 V_15_1
## 1    112    366    126     21     49    542    722      4    399   1003
##   V_15_2 V_15_3 V_16_1 V_16_2 V_17_1 V_17_2 V_18_1 V_18_2 V_18_3 V_18_4
## 1    541    540   4267   2556  11392   2140    389    368    176    976
##   V_19_1 V_19_2 V_19_3 V_2_1 V_2_2 V_2_3 V_20_1 V_21_1 V_21_4 V_22_1
## 1   2560    800    262    48    37   100   1652    200     84     31
##   V_22_3 V_22_4 V_3_1 V_3_2 V_4_1 V_4_2 V_5_1 V_5_3 V_6_1 V_6_2 V_6_3
## 1    311     53     4    11     3     3   274   217    48   468   134
##   V_7_1 V_7_2 V_7_3 V_8_2 V_9_1 V_9_2 V_9_3 V_9_4
## 1  2231   141   166  1346  3582    56     2     7
```

You can subset columns by using the `select()` function. You can also reorder columns while using this function. I want to to compare the depth of latrine 2 at 9cm compared to 10cm, but I want Taxa in the last column. `head()` and `tail()` can also be used with pipes to look at your output.


```r
dat %>% select(T_2_9, T_2_10, Taxa) %>% head()
```

```
##   T_2_9 T_2_10               Taxa
## 1     0      0  Acidobacteria_Gp1
## 2     0      0 Acidobacteria_Gp10
## 3     0      0 Acidobacteria_Gp14
## 4     0      0 Acidobacteria_Gp16
## 5     0      0 Acidobacteria_Gp17
## 6    15      0 Acidobacteria_Gp18
```
If I wanted to perform a calculation, I would want to exclude Taxa since it is of character type and not used in the calculation. If your data is unique you may want to retain your character data as rownames.


```r
rownames(dat) <- dat$Taxa
dat %>% select(-Taxa) %>% head()
```

```
##                    T_2_1 T_2_10 T_2_12 T_2_2 T_2_3 T_2_6 T_2_7 T_2_9 T_3_2
## Acidobacteria_Gp1      0      0      0     0     0     0     0     0     0
## Acidobacteria_Gp10     0      0      0     0     0     0     0     0     0
## Acidobacteria_Gp14     0      0      0     0     0     0     0     0     0
## Acidobacteria_Gp16     0      0      0     0     0     0     0     0     0
## Acidobacteria_Gp17     0      0      0     0     0     0     0     0     0
## Acidobacteria_Gp18     0      0      0     2     2     5     0    15     2
##                    T_3_3 T_3_5 T_4_3 T_4_4 T_4_5 T_4_6 T_4_7 T_5_2 T_5_3
## Acidobacteria_Gp1      0     0     0     0     1     0     0     0     0
## Acidobacteria_Gp10     0     0     0     0     0     0     0     0     0
## Acidobacteria_Gp14     0     0     0     0     1     0     0     0     0
## Acidobacteria_Gp16     0     0     0     0     0     0     0     0     0
## Acidobacteria_Gp17     0     0     0     0     0     0     0     0     0
## Acidobacteria_Gp18     1     0     0     1     0     0     0     0     1
##                    T_5_4 T_5_5 T_6_2 T_6_5 T_6_7 T_6_8 T_9_1 T_9_2 T_9_3
## Acidobacteria_Gp1      0     0     0     0     0     0     0     0     0
## Acidobacteria_Gp10     0     0     0     0     0     0     0     0     0
## Acidobacteria_Gp14     0     0     0     0     0     0     0     0     0
## Acidobacteria_Gp16     0     0     0     0     0     0     0     0     0
## Acidobacteria_Gp17     0     0     0     0     0     0     0     0     0
## Acidobacteria_Gp18     0     0     0     0     1     0     0     0     0
##                    T_9_4 T_9_5 V_1_2 V_10_1 V_11_1 V_11_2 V_11_3 V_12_1
## Acidobacteria_Gp1      0     0     0      0      0      0      0      0
## Acidobacteria_Gp10     0     0     0      0      0      0      0      0
## Acidobacteria_Gp14     0     0     0      0      0      0      0      0
## Acidobacteria_Gp16     0     0     0      0      1      0      0      0
## Acidobacteria_Gp17     0     0     0      0      1      0      0      0
## Acidobacteria_Gp18     0     0     0      0      0      0      0      0
##                    V_12_2 V_13_1 V_13_2 V_14_1 V_14_2 V_14_3 V_15_1 V_15_2
## Acidobacteria_Gp1       0      0      0      0      0      0      0      0
## Acidobacteria_Gp10      0      0      0      0      0      0      0      0
## Acidobacteria_Gp14      0      0      0      0      0      0      0      0
## Acidobacteria_Gp16      0      0      0      0      0      0      0      0
## Acidobacteria_Gp17      0      0      0      0      0      0      0      0
## Acidobacteria_Gp18      0      0      0      0      0      0      0      0
##                    V_15_3 V_16_1 V_16_2 V_17_1 V_17_2 V_18_1 V_18_2 V_18_3
## Acidobacteria_Gp1       0      0      0      0      0      0      0      0
## Acidobacteria_Gp10      0      0      0      0      0      0      0      0
## Acidobacteria_Gp14      0      0      0      0      0      0      0      0
## Acidobacteria_Gp16      0      0      0      0      0      0      0      0
## Acidobacteria_Gp17      0      0      0      0      0      0      0      0
## Acidobacteria_Gp18      0      0      0      0      0      0      0      0
##                    V_18_4 V_19_1 V_19_2 V_19_3 V_2_1 V_2_2 V_2_3 V_20_1
## Acidobacteria_Gp1       0      0      0      0     0     0     0      0
## Acidobacteria_Gp10      0      0      0      0     0     0     0      0
## Acidobacteria_Gp14      0      0      0      0     0     0     0      0
## Acidobacteria_Gp16      0      0      0      0     0     0     0      0
## Acidobacteria_Gp17      0      0      0      0     0     0     0      0
## Acidobacteria_Gp18      0      0      0      0     0     0     0      0
##                    V_21_1 V_21_4 V_22_1 V_22_3 V_22_4 V_3_1 V_3_2 V_4_1
## Acidobacteria_Gp1       0      0      1      0      0     0     0     0
## Acidobacteria_Gp10      0      0      3      0      0     0     0     0
## Acidobacteria_Gp14      0      0      0      0      0     0     0     0
## Acidobacteria_Gp16      0      0      0      0      0     0     0     0
## Acidobacteria_Gp17      0      0      0      0      0     0     0     0
## Acidobacteria_Gp18      0      0      0      0      0     0     0     0
##                    V_4_2 V_5_1 V_5_3 V_6_1 V_6_2 V_6_3 V_7_1 V_7_2 V_7_3
## Acidobacteria_Gp1      0     0     0     0     0     0     0     1     7
## Acidobacteria_Gp10     2     0     0     0     0     0     0     1     9
## Acidobacteria_Gp14     0     0     0     0     0     0     0     0     1
## Acidobacteria_Gp16     1     0     0     0     0     0     0     0     0
## Acidobacteria_Gp17     0     0     0     0     0     0     0     0     0
## Acidobacteria_Gp18     0     0     0     0     0     0     0     0     1
##                    V_8_2 V_9_1 V_9_2 V_9_3 V_9_4
## Acidobacteria_Gp1      0     0    18     0    38
## Acidobacteria_Gp10     0     0     0     0     0
## Acidobacteria_Gp14     0     0     0     0    17
## Acidobacteria_Gp16     0     0     0     0     0
## Acidobacteria_Gp17     0     0     0     0     0
## Acidobacteria_Gp18     0     0     0     0     0
```
`dplyr` also includes some helper functions that allow you to select variables based on their names. For example, if we only wanted the samples from Vietnam, we could use "starts_with".


```r
dat %>% select(starts_with("V")) %>% head()
```

```
##                    V_1_2 V_10_1 V_11_1 V_11_2 V_11_3 V_12_1 V_12_2 V_13_1
## Acidobacteria_Gp1      0      0      0      0      0      0      0      0
## Acidobacteria_Gp10     0      0      0      0      0      0      0      0
## Acidobacteria_Gp14     0      0      0      0      0      0      0      0
## Acidobacteria_Gp16     0      0      1      0      0      0      0      0
## Acidobacteria_Gp17     0      0      1      0      0      0      0      0
## Acidobacteria_Gp18     0      0      0      0      0      0      0      0
##                    V_13_2 V_14_1 V_14_2 V_14_3 V_15_1 V_15_2 V_15_3 V_16_1
## Acidobacteria_Gp1       0      0      0      0      0      0      0      0
## Acidobacteria_Gp10      0      0      0      0      0      0      0      0
## Acidobacteria_Gp14      0      0      0      0      0      0      0      0
## Acidobacteria_Gp16      0      0      0      0      0      0      0      0
## Acidobacteria_Gp17      0      0      0      0      0      0      0      0
## Acidobacteria_Gp18      0      0      0      0      0      0      0      0
##                    V_16_2 V_17_1 V_17_2 V_18_1 V_18_2 V_18_3 V_18_4 V_19_1
## Acidobacteria_Gp1       0      0      0      0      0      0      0      0
## Acidobacteria_Gp10      0      0      0      0      0      0      0      0
## Acidobacteria_Gp14      0      0      0      0      0      0      0      0
## Acidobacteria_Gp16      0      0      0      0      0      0      0      0
## Acidobacteria_Gp17      0      0      0      0      0      0      0      0
## Acidobacteria_Gp18      0      0      0      0      0      0      0      0
##                    V_19_2 V_19_3 V_2_1 V_2_2 V_2_3 V_20_1 V_21_1 V_21_4
## Acidobacteria_Gp1       0      0     0     0     0      0      0      0
## Acidobacteria_Gp10      0      0     0     0     0      0      0      0
## Acidobacteria_Gp14      0      0     0     0     0      0      0      0
## Acidobacteria_Gp16      0      0     0     0     0      0      0      0
## Acidobacteria_Gp17      0      0     0     0     0      0      0      0
## Acidobacteria_Gp18      0      0     0     0     0      0      0      0
##                    V_22_1 V_22_3 V_22_4 V_3_1 V_3_2 V_4_1 V_4_2 V_5_1
## Acidobacteria_Gp1       1      0      0     0     0     0     0     0
## Acidobacteria_Gp10      3      0      0     0     0     0     2     0
## Acidobacteria_Gp14      0      0      0     0     0     0     0     0
## Acidobacteria_Gp16      0      0      0     0     0     0     1     0
## Acidobacteria_Gp17      0      0      0     0     0     0     0     0
## Acidobacteria_Gp18      0      0      0     0     0     0     0     0
##                    V_5_3 V_6_1 V_6_2 V_6_3 V_7_1 V_7_2 V_7_3 V_8_2 V_9_1
## Acidobacteria_Gp1      0     0     0     0     0     1     7     0     0
## Acidobacteria_Gp10     0     0     0     0     0     1     9     0     0
## Acidobacteria_Gp14     0     0     0     0     0     0     1     0     0
## Acidobacteria_Gp16     0     0     0     0     0     0     0     0     0
## Acidobacteria_Gp17     0     0     0     0     0     0     0     0     0
## Acidobacteria_Gp18     0     0     0     0     0     0     1     0     0
##                    V_9_2 V_9_3 V_9_4
## Acidobacteria_Gp1     18     0    38
## Acidobacteria_Gp10     0     0     0
## Acidobacteria_Gp14     0     0    17
## Acidobacteria_Gp16     0     0     0
## Acidobacteria_Gp17     0     0     0
## Acidobacteria_Gp18     0     0     0
```

Or all latrines with depths of 4 cm.


```r
dat %>% select(ends_with("4")) %>% head()
```

```
##                    T_4_4 T_5_4 T_9_4 V_18_4 V_21_4 V_22_4 V_9_4
## Acidobacteria_Gp1      0     0     0      0      0      0    38
## Acidobacteria_Gp10     0     0     0      0      0      0     0
## Acidobacteria_Gp14     0     0     0      0      0      0    17
## Acidobacteria_Gp16     0     0     0      0      0      0     0
## Acidobacteria_Gp17     0     0     0      0      0      0     0
## Acidobacteria_Gp18     1     0     0      0      0      0     0
```

You can look up other `dplyr` 'select_helpers' in the help menu.

***
__Challenge__ 


<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/pug_challenge1.jpeg){width=200px}

</div>

Check out 'select_helpers' in the help menu. Grab all of the columns that contain depths for Well 2, whether it is from Vietnam or Tanzania.

</br>

</br>
***

The `arrange()` function helps you to sort your data. The default is ordered from smallest to largest (or a-z for character data). You can switch the order as shown below. 

I have added a few extra lines of code to show you how we can start building code that passes a result to the next function instead of creating a bunch of new variables to store data in between functions being exectuted. However, if you get more than 2 pipes `%>%` it gets hard to follow for a reader (or yourself after 5 minutes). Starting a new line after each pipe, allows a reader to easily see which function is operating and makes it easier to follow your logic.


```r
## dat %>% select(Taxa, T_2_1) %>% arrange(desc(T_2_1)) %>% filter(T_2_1 !=0) %>% filter(Taxa != "Unknown") %>% unique()
## #equivalent to
dat %>% 
  select(Taxa, T_2_1) %>% 
  arrange(desc(T_2_1)) %>% 
  filter(T_2_1 !=0) %>%
  filter(Taxa != "Unknown") %>%
  unique()
```

```
##                   Taxa T_2_1
## 1           Clostridia  6213
## 2          Bacteroidia  1547
## 3      Erysipelotrichi   433
## 4       Actinobacteria   110
## 5         Spirochaetes    62
## 6  Gammaproteobacteria    23
## 7          Synergistia    21
## 8              Bacilli    19
## 9  Alphaproteobacteria    11
## 10          Mollicutes     3
## 11        Anaerolineae     2
## 12  Betaproteobacteria     2
## 13     Sphingobacteria     2
## 14       Flavobacteria     1
```
`
`unique()` is a function that removes duplicate rows. How many rows did it remove in this case?


`mutate()` is a function to create new column, most often the product of a calculation. For example, let's calculate the total number of OTUs for each bacteria. You must specify a column name for the column you are creating. `transmute()` will also create a new variable, but it will drop the existing variables (it will give you a single column of your new variable).


```r
dat %>% select(-Taxa) %>% mutate(total_OTUs = rowSums(.)) %>% head()
```

```
##   T_2_1 T_2_10 T_2_12 T_2_2 T_2_3 T_2_6 T_2_7 T_2_9 T_3_2 T_3_3 T_3_5
## 1     0      0      0     0     0     0     0     0     0     0     0
## 2     0      0      0     0     0     0     0     0     0     0     0
## 3     0      0      0     0     0     0     0     0     0     0     0
## 4     0      0      0     0     0     0     0     0     0     0     0
## 5     0      0      0     0     0     0     0     0     0     0     0
## 6     0      0      0     2     2     5     0    15     2     1     0
##   T_4_3 T_4_4 T_4_5 T_4_6 T_4_7 T_5_2 T_5_3 T_5_4 T_5_5 T_6_2 T_6_5 T_6_7
## 1     0     0     1     0     0     0     0     0     0     0     0     0
## 2     0     0     0     0     0     0     0     0     0     0     0     0
## 3     0     0     1     0     0     0     0     0     0     0     0     0
## 4     0     0     0     0     0     0     0     0     0     0     0     0
## 5     0     0     0     0     0     0     0     0     0     0     0     0
## 6     0     1     0     0     0     0     1     0     0     0     0     1
##   T_6_8 T_9_1 T_9_2 T_9_3 T_9_4 T_9_5 V_1_2 V_10_1 V_11_1 V_11_2 V_11_3
## 1     0     0     0     0     0     0     0      0      0      0      0
## 2     0     0     0     0     0     0     0      0      0      0      0
## 3     0     0     0     0     0     0     0      0      0      0      0
## 4     0     0     0     0     0     0     0      0      1      0      0
## 5     0     0     0     0     0     0     0      0      1      0      0
## 6     0     0     0     0     0     0     0      0      0      0      0
##   V_12_1 V_12_2 V_13_1 V_13_2 V_14_1 V_14_2 V_14_3 V_15_1 V_15_2 V_15_3
## 1      0      0      0      0      0      0      0      0      0      0
## 2      0      0      0      0      0      0      0      0      0      0
## 3      0      0      0      0      0      0      0      0      0      0
## 4      0      0      0      0      0      0      0      0      0      0
## 5      0      0      0      0      0      0      0      0      0      0
## 6      0      0      0      0      0      0      0      0      0      0
##   V_16_1 V_16_2 V_17_1 V_17_2 V_18_1 V_18_2 V_18_3 V_18_4 V_19_1 V_19_2
## 1      0      0      0      0      0      0      0      0      0      0
## 2      0      0      0      0      0      0      0      0      0      0
## 3      0      0      0      0      0      0      0      0      0      0
## 4      0      0      0      0      0      0      0      0      0      0
## 5      0      0      0      0      0      0      0      0      0      0
## 6      0      0      0      0      0      0      0      0      0      0
##   V_19_3 V_2_1 V_2_2 V_2_3 V_20_1 V_21_1 V_21_4 V_22_1 V_22_3 V_22_4 V_3_1
## 1      0     0     0     0      0      0      0      1      0      0     0
## 2      0     0     0     0      0      0      0      3      0      0     0
## 3      0     0     0     0      0      0      0      0      0      0     0
## 4      0     0     0     0      0      0      0      0      0      0     0
## 5      0     0     0     0      0      0      0      0      0      0     0
## 6      0     0     0     0      0      0      0      0      0      0     0
##   V_3_2 V_4_1 V_4_2 V_5_1 V_5_3 V_6_1 V_6_2 V_6_3 V_7_1 V_7_2 V_7_3 V_8_2
## 1     0     0     0     0     0     0     0     0     0     1     7     0
## 2     0     0     2     0     0     0     0     0     0     1     9     0
## 3     0     0     0     0     0     0     0     0     0     0     1     0
## 4     0     0     1     0     0     0     0     0     0     0     0     0
## 5     0     0     0     0     0     0     0     0     0     0     0     0
## 6     0     0     0     0     0     0     0     0     0     0     1     0
##   V_9_1 V_9_2 V_9_3 V_9_4 total_OTUs
## 1     0    18     0    38         66
## 2     0     0     0     0         15
## 3     0     0     0    17         19
## 4     0     0     0     0          2
## 5     0     0     0     0          1
## 6     0     0     0     0         31
```
Versus:


```r
#maintains answer in data frame
dat %>% select(-Taxa) %>% transmute(total_OTUs = rowSums(.))
```

```
##    total_OTUs
## 1          66
## 2          15
## 3          19
## 4           2
## 5           1
## 6          31
## 7           9
## 8           5
## 9         162
## 10         34
## 11         11
## 12        163
## 13          1
## 14          1
## 15      40978
## 16      33238
## 17       1013
## 18      26799
## 19      55450
## 20      27171
## 21        600
## 22          3
## 23          1
## 24         41
## 25     277296
## 26         60
## 27          7
## 28      12970
## 29       2442
## 30          5
## 31      10441
## 32         74
## 33      40319
## 34        871
## 35      63588
## 36         89
## 37          3
## 38         77
## 39          1
## 40          2
## 41       5242
## 42         46
## 43        764
## 44        533
## 45      22049
## 46       2069
## 47          1
## 48       3150
## 49       2347
## 50          1
## 51          2
## 52      57237
```

```r
#answer is now a vector
dat %>% select(-Taxa) %>% rowSums()
```

```
##     Acidobacteria_Gp1    Acidobacteria_Gp10    Acidobacteria_Gp14 
##                    66                    15                    19 
##    Acidobacteria_Gp16    Acidobacteria_Gp17    Acidobacteria_Gp18 
##                     2                     1                    31 
##    Acidobacteria_Gp21    Acidobacteria_Gp22     Acidobacteria_Gp3 
##                     9                     5                   162 
##     Acidobacteria_Gp4     Acidobacteria_Gp5     Acidobacteria_Gp6 
##                    34                    11                   163 
##     Acidobacteria_Gp7     Acidobacteria_Gp9        Actinobacteria 
##                     1                     1                 40978 
##   Alphaproteobacteria          Anaerolineae               Bacilli 
##                 33238                  1013                 26799 
##           Bacteroidia    Betaproteobacteria           Caldilineae 
##                 55450                 27171                   600 
##            Chlamydiae           Chloroflexi        Chrysiogenetes 
##                     3                     1                    41 
##            Clostridia         Cyanobacteria     Dehalococcoidetes 
##                277296                    60                     7 
##            Deinococci   Deltaproteobacteria Epsilonproteobacteria 
##                 12970                  2442                     5 
##       Erysipelotrichi         Fibrobacteria         Flavobacteria 
##                 10441                    74                 40319 
##          Fusobacteria   Gammaproteobacteria      Gemmatimonadetes 
##                   871                 63588                    89 
##            Holophagae         Lentisphaeria       Methanobacteria 
##                     3                    77                     1 
##       Methanomicrobia            Mollicutes            Nitrospira 
##                     2                  5242                    46 
##              Opitutae      Planctomycetacia       Sphingobacteria 
##                   764                   533                 22049 
##          Spirochaetes          Subdivision3           Synergistia 
##                  2069                     1                  3150 
##        Thermomicrobia        Thermoplasmata           Thermotogae 
##                  2347                     1                     2 
##               Unknown 
##                 57237
```

You may have noticed that I included `.` in the bracket for rowSums. In this case, an error would be generated with empty brackets that argument 'x' is missing with no default. You need to specify your input if you are inside a nested function. Note that if I use `rowSums` outside of another function, I do not need to specify the data frame.

Note: it is up to you whether you want to keep your data in a data frame or switch to a vector if you are dealing with a single variable. Using a `dplyr` function will maintain your data in a data frame. Using non-dplyr functions will switch your data to a vector if you have a single variable.


`dplyr` has one more super-useful function, `summarize()` which allows us to get summary statistics on data. I'll give one example and then we'll come back to this function once our data is in 'tidy' format. with `n()` we are simply going to count the instances of a Taxa. We can arrange the results in descending order to see if there is more than one row per Taxa. Can anyone think of another way to see if there is more than one row per Taxa? 


```r
dat %>% group_by(Taxa) %>% summarize(n = n()) %>% arrange(desc(.))
```

```
## # A tibble: 2 x 2
##   Taxa                   n
##   <chr>              <int>
## 1 Acidobacteria_Gp10     1
## 2 Acidobacteria_Gp1      1
```



##Intro to tidy data

_Why tidy data?_

Data cleaning (or dealing with 'messy' data) accounts for a huge chunk of data scientist's time. Ultimately, we want to get our data into a 'tidy' format where it is easy to manipulate, model and visualize. Having a consistent data structure and tools that work with that data structure can help this process along.

Tidy data has:

1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.

This seems pretty straight forward, and it is. It is the datasets you get that will not be straight forward. Having a map of where to take your data is helpful to unraveling its structure and getting it into a usable format.

The 5 most common problems with messy datasets are:
- common headers are values, not variable names
- multiple variables in one column
- variables stored in both rows and columns
- a single variable stored in multiple tables 
- multiple types of observational units stored in the same table

Fortunately, Hadley has also given us the tools to solve these problems.

###Intro to the tidyverse

The tidyverse is the universe of packages created by Hadley Wickham for data analysis. There are packages to help import, tidy, transform, model and visualize data. His packages are pretty popular, so he made a package to load all of his packages at once. This wrapper package is `tidyverse`. In this lesson series we have used `readr` and `readxl`, and we will be using `dplyr` and `tidyr` today, and `stringr` and `ggplot2` in future lessons. Install the package now.


```r
install.packages("tidyverse")
```


![](img/tidyverse1.png)

Hadley has a large fan-base. Someone even made a plot of Hadley using his own package, `ggplot2`.


![](img/HadleyObama2.png)


Back to the normalverse...

    - Which latrine depth has the greatest mean number of OTUs?
    - Is there more Clostridia in Tanzania or Vietnam?
    - Which site had the greatest number of bacteria?


How easy is it to answer these questions with the data in its 'messy' format?

***
__Challenge__ 


<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/pug_challenge1.jpeg){width=200px}

</div>

Answer our 3 questions using the `dplyr`.

</br>
</br>

***

###Assessing our data frame

Which tidy data rules might our data frame break?

At first glance we can see that the column names are actually 3 different variables: 'Country', 'LatrineNumber', and 'Depth'. This information will likely be useful in our study, as we expect different bacteria at different depths, sites, and geographical locations. Each of these is a variable and should have its own separate column.

We could keep the column names as the sample names (as they are meaningful to the researcher) and add the extra variable columns, or we could make up sample names (ie. Sample_1) knowing that the information is not being lost, but rather stored in a more useful format.

Some of the Taxa also appear to have an additional variable of information (ie. _Gp1), but not all taxa have this information. We can also make a separate column for this information.

Each result is the same observational unit (ie. relative abundances of bacteria), so having one table is fine.

##Intro to tidyr

`tidyr` is a package with functions that help us turn our 'messy' data into 'tidy' data. It has 2 major workhorse functions and 2 other tidying functions:

1. `gather()` - convert a data frame from wide to long format
2. `spread()` - convert a data frame from long to wide format
3. `separate()` - split a column into 2 or more columns based on a string separator
4. `unite()` - merge 2 or more columns into 1 column using a string separator

`gather()` and `spread()` rely on key-value pairs to collapse or expand columns.

First let's load our library. Loading `tidyverse` will include the `tidyr` package that the `gather()` function is from.


```r
library(tidyverse)
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.2.1 ──
```

```
## ✔ ggplot2 2.2.1     ✔ readr   1.1.1
## ✔ tibble  1.4.2     ✔ purrr   0.2.4
## ✔ tidyr   0.8.0     ✔ stringr 1.3.0
## ✔ ggplot2 2.2.1     ✔ forcats 0.2.0
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
```
Note that 8 different packages are loaded, and that 2 functions from the `stats` package have been replaced by functions of the same name by `dplyr`. Note that you can still access the `stats` version of the function by calling it directly as `stats::filter()`. 

We can use the `gather()` function to collect our non-variable columns. This will make our dataset 'long' instead of 'wide'. 
We need to provide `gather()` with our new columns. The first argument is our data frame, the second argument is the 'key'. In this case we want the column names that represent our Sites. The next argument is the 'value', which are our relative abundance values or OTUs. The third argument is all of the columns that we need to gather. You can specify the columns by listing their names or positions. In this example `-` means every column except Taxa.


```r
spread_dat <- gather(dat, Site, OTUs, T_2_1:V_9_4)

dat %>% gather(Site, OTUs, T_2_1:V_9_4) %>% head()
```

```
##                 Taxa  Site OTUs
## 1  Acidobacteria_Gp1 T_2_1    0
## 2 Acidobacteria_Gp10 T_2_1    0
## 3 Acidobacteria_Gp14 T_2_1    0
## 4 Acidobacteria_Gp16 T_2_1    0
## 5 Acidobacteria_Gp17 T_2_1    0
## 6 Acidobacteria_Gp18 T_2_1    0
```

```r
#equivalent to
dat %>% gather(Site, OTUs, 2:82) %>% head()
```

```
##                 Taxa  Site OTUs
## 1  Acidobacteria_Gp1 T_2_1    0
## 2 Acidobacteria_Gp10 T_2_1    0
## 3 Acidobacteria_Gp14 T_2_1    0
## 4 Acidobacteria_Gp16 T_2_1    0
## 5 Acidobacteria_Gp17 T_2_1    0
## 6 Acidobacteria_Gp18 T_2_1    0
```

```r
#equivalent to
dat %>% gather(Site, OTUs, -Taxa) %>% head()
```

```
##                 Taxa  Site OTUs
## 1  Acidobacteria_Gp1 T_2_1    0
## 2 Acidobacteria_Gp10 T_2_1    0
## 3 Acidobacteria_Gp14 T_2_1    0
## 4 Acidobacteria_Gp16 T_2_1    0
## 5 Acidobacteria_Gp17 T_2_1    0
## 6 Acidobacteria_Gp18 T_2_1    0
```

```r
#equivalent to
dat %>% gather(Site, OTUs, -1) %>% head()
```

```
##                 Taxa  Site OTUs
## 1  Acidobacteria_Gp1 T_2_1    0
## 2 Acidobacteria_Gp10 T_2_1    0
## 3 Acidobacteria_Gp14 T_2_1    0
## 4 Acidobacteria_Gp16 T_2_1    0
## 5 Acidobacteria_Gp17 T_2_1    0
## 6 Acidobacteria_Gp18 T_2_1    0
```

Note how the dimensions of your dataframe have changed. spread_dat is now in a long format instead of wide.

Next, we can use the `separate()` function to get the Country, Latrine_Number, and Depth information from our Site column. `separate()` takes in your dataframe, the name of the column to be split, the name of your new columns, and the character that you want to split the columns by (in this case an underscore). Note that the default is to remove your original column - if you want to keep it, you can add the additional argument `remove = FALSE`, keeping in mind that you now have redundant data. We may also want to do this for the 'Group' of Acidobacteria. Try the code, but do not save the answer in a variable.


```r
split_dat <- spread_dat %>% separate(Site, c("Country", "Latrine_Number", "Depth"), sep = "_")
#equivalent to
split_dat <- spread_dat %>% separate(Site, c("Country", "Latrine_Number", "Depth"), sep = "_", remove = TRUE)

split_dat %>% separate(Taxa, c("Taxa", "Group"), sep = "_Gp")
```

```
## Warning: Expected 2 pieces. Missing pieces filled with `NA` in 3078 rows
## [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
## 33, 34, ...].
```

```
##                       Taxa Group Country Latrine_Number Depth  OTUs
## 1            Acidobacteria     1       T              2     1     0
## 2            Acidobacteria    10       T              2     1     0
## 3            Acidobacteria    14       T              2     1     0
## 4            Acidobacteria    16       T              2     1     0
## 5            Acidobacteria    17       T              2     1     0
## 6            Acidobacteria    18       T              2     1     0
## 7            Acidobacteria    21       T              2     1     0
## 8            Acidobacteria    22       T              2     1     0
## 9            Acidobacteria     3       T              2     1     0
## 10           Acidobacteria     4       T              2     1     0
## 11           Acidobacteria     5       T              2     1     0
## 12           Acidobacteria     6       T              2     1     0
## 13           Acidobacteria     7       T              2     1     0
## 14           Acidobacteria     9       T              2     1     0
## 15          Actinobacteria  <NA>       T              2     1   110
## 16     Alphaproteobacteria  <NA>       T              2     1    11
## 17            Anaerolineae  <NA>       T              2     1     2
## 18                 Bacilli  <NA>       T              2     1    19
## 19             Bacteroidia  <NA>       T              2     1  1547
## 20      Betaproteobacteria  <NA>       T              2     1     2
## 21             Caldilineae  <NA>       T              2     1     0
## 22              Chlamydiae  <NA>       T              2     1     0
## 23             Chloroflexi  <NA>       T              2     1     0
## 24          Chrysiogenetes  <NA>       T              2     1     0
## 25              Clostridia  <NA>       T              2     1  6213
## 26           Cyanobacteria  <NA>       T              2     1     0
## 27       Dehalococcoidetes  <NA>       T              2     1     0
## 28              Deinococci  <NA>       T              2     1     0
## 29     Deltaproteobacteria  <NA>       T              2     1     0
## 30   Epsilonproteobacteria  <NA>       T              2     1     0
## 31         Erysipelotrichi  <NA>       T              2     1   433
## 32           Fibrobacteria  <NA>       T              2     1     0
## 33           Flavobacteria  <NA>       T              2     1     1
## 34            Fusobacteria  <NA>       T              2     1     0
## 35     Gammaproteobacteria  <NA>       T              2     1    23
## 36        Gemmatimonadetes  <NA>       T              2     1     0
## 37              Holophagae  <NA>       T              2     1     0
## 38           Lentisphaeria  <NA>       T              2     1     0
## 39         Methanobacteria  <NA>       T              2     1     0
## 40         Methanomicrobia  <NA>       T              2     1     0
## 41              Mollicutes  <NA>       T              2     1     3
## 42              Nitrospira  <NA>       T              2     1     0
## 43                Opitutae  <NA>       T              2     1     0
## 44        Planctomycetacia  <NA>       T              2     1     0
## 45         Sphingobacteria  <NA>       T              2     1     2
## 46            Spirochaetes  <NA>       T              2     1    62
## 47            Subdivision3  <NA>       T              2     1     0
## 48             Synergistia  <NA>       T              2     1    21
## 49          Thermomicrobia  <NA>       T              2     1     0
## 50          Thermoplasmata  <NA>       T              2     1     0
## 51             Thermotogae  <NA>       T              2     1     0
## 52                 Unknown  <NA>       T              2     1   759
## 53           Acidobacteria     1       T              2    10     0
## 54           Acidobacteria    10       T              2    10     0
## 55           Acidobacteria    14       T              2    10     0
## 56           Acidobacteria    16       T              2    10     0
## 57           Acidobacteria    17       T              2    10     0
## 58           Acidobacteria    18       T              2    10     0
## 59           Acidobacteria    21       T              2    10     0
## 60           Acidobacteria    22       T              2    10     0
## 61           Acidobacteria     3       T              2    10     0
## 62           Acidobacteria     4       T              2    10     0
## 63           Acidobacteria     5       T              2    10     0
## 64           Acidobacteria     6       T              2    10     0
## 65           Acidobacteria     7       T              2    10     0
## 66           Acidobacteria     9       T              2    10     0
## 67          Actinobacteria  <NA>       T              2    10     3
## 68     Alphaproteobacteria  <NA>       T              2    10     0
## 69            Anaerolineae  <NA>       T              2    10     0
## 70                 Bacilli  <NA>       T              2    10    60
## 71             Bacteroidia  <NA>       T              2    10     8
## 72      Betaproteobacteria  <NA>       T              2    10     0
## 73             Caldilineae  <NA>       T              2    10     0
## 74              Chlamydiae  <NA>       T              2    10     0
## 75             Chloroflexi  <NA>       T              2    10     0
## 76          Chrysiogenetes  <NA>       T              2    10     0
## 77              Clostridia  <NA>       T              2    10    71
## 78           Cyanobacteria  <NA>       T              2    10     0
## 79       Dehalococcoidetes  <NA>       T              2    10     0
## 80              Deinococci  <NA>       T              2    10     0
## 81     Deltaproteobacteria  <NA>       T              2    10     0
## 82   Epsilonproteobacteria  <NA>       T              2    10     0
## 83         Erysipelotrichi  <NA>       T              2    10     0
## 84           Fibrobacteria  <NA>       T              2    10     0
## 85           Flavobacteria  <NA>       T              2    10     0
## 86            Fusobacteria  <NA>       T              2    10     0
## 87     Gammaproteobacteria  <NA>       T              2    10    30
## 88        Gemmatimonadetes  <NA>       T              2    10     0
## 89              Holophagae  <NA>       T              2    10     0
## 90           Lentisphaeria  <NA>       T              2    10     0
## 91         Methanobacteria  <NA>       T              2    10     0
## 92         Methanomicrobia  <NA>       T              2    10     0
## 93              Mollicutes  <NA>       T              2    10     0
## 94              Nitrospira  <NA>       T              2    10     0
## 95                Opitutae  <NA>       T              2    10     0
## 96        Planctomycetacia  <NA>       T              2    10     0
## 97         Sphingobacteria  <NA>       T              2    10     0
## 98            Spirochaetes  <NA>       T              2    10     0
## 99            Subdivision3  <NA>       T              2    10     0
## 100            Synergistia  <NA>       T              2    10     4
## 101         Thermomicrobia  <NA>       T              2    10     0
## 102         Thermoplasmata  <NA>       T              2    10     0
## 103            Thermotogae  <NA>       T              2    10     0
## 104                Unknown  <NA>       T              2    10    24
## 105          Acidobacteria     1       T              2    12     0
## 106          Acidobacteria    10       T              2    12     0
## 107          Acidobacteria    14       T              2    12     0
## 108          Acidobacteria    16       T              2    12     0
## 109          Acidobacteria    17       T              2    12     0
## 110          Acidobacteria    18       T              2    12     0
## 111          Acidobacteria    21       T              2    12     0
## 112          Acidobacteria    22       T              2    12     0
## 113          Acidobacteria     3       T              2    12     0
## 114          Acidobacteria     4       T              2    12     0
## 115          Acidobacteria     5       T              2    12     0
## 116          Acidobacteria     6       T              2    12     0
## 117          Acidobacteria     7       T              2    12     0
## 118          Acidobacteria     9       T              2    12     0
## 119         Actinobacteria  <NA>       T              2    12     5
## 120    Alphaproteobacteria  <NA>       T              2    12     2
## 121           Anaerolineae  <NA>       T              2    12     0
## 122                Bacilli  <NA>       T              2    12    36
## 123            Bacteroidia  <NA>       T              2    12     0
## 124     Betaproteobacteria  <NA>       T              2    12  2545
## 125            Caldilineae  <NA>       T              2    12     0
## 126             Chlamydiae  <NA>       T              2    12     0
## 127            Chloroflexi  <NA>       T              2    12     0
## 128         Chrysiogenetes  <NA>       T              2    12     0
## 129             Clostridia  <NA>       T              2    12     0
## 130          Cyanobacteria  <NA>       T              2    12     0
## 131      Dehalococcoidetes  <NA>       T              2    12     0
## 132             Deinococci  <NA>       T              2    12     0
## 133    Deltaproteobacteria  <NA>       T              2    12     0
## 134  Epsilonproteobacteria  <NA>       T              2    12     0
## 135        Erysipelotrichi  <NA>       T              2    12     0
## 136          Fibrobacteria  <NA>       T              2    12     0
## 137          Flavobacteria  <NA>       T              2    12     0
## 138           Fusobacteria  <NA>       T              2    12     0
## 139    Gammaproteobacteria  <NA>       T              2    12    27
## 140       Gemmatimonadetes  <NA>       T              2    12     0
## 141             Holophagae  <NA>       T              2    12     0
## 142          Lentisphaeria  <NA>       T              2    12     0
## 143        Methanobacteria  <NA>       T              2    12     0
## 144        Methanomicrobia  <NA>       T              2    12     0
## 145             Mollicutes  <NA>       T              2    12     0
## 146             Nitrospira  <NA>       T              2    12     0
## 147               Opitutae  <NA>       T              2    12     0
## 148       Planctomycetacia  <NA>       T              2    12     0
## 149        Sphingobacteria  <NA>       T              2    12     0
## 150           Spirochaetes  <NA>       T              2    12     0
## 151           Subdivision3  <NA>       T              2    12     0
## 152            Synergistia  <NA>       T              2    12     0
## 153         Thermomicrobia  <NA>       T              2    12     0
## 154         Thermoplasmata  <NA>       T              2    12     0
## 155            Thermotogae  <NA>       T              2    12     0
## 156                Unknown  <NA>       T              2    12     6
## 157          Acidobacteria     1       T              2     2     0
## 158          Acidobacteria    10       T              2     2     0
## 159          Acidobacteria    14       T              2     2     0
## 160          Acidobacteria    16       T              2     2     0
## 161          Acidobacteria    17       T              2     2     0
## 162          Acidobacteria    18       T              2     2     2
## 163          Acidobacteria    21       T              2     2     0
## 164          Acidobacteria    22       T              2     2     0
## 165          Acidobacteria     3       T              2     2     0
## 166          Acidobacteria     4       T              2     2     0
## 167          Acidobacteria     5       T              2     2     0
## 168          Acidobacteria     6       T              2     2     0
## 169          Acidobacteria     7       T              2     2     0
## 170          Acidobacteria     9       T              2     2     0
## 171         Actinobacteria  <NA>       T              2     2   240
## 172    Alphaproteobacteria  <NA>       T              2     2    21
## 173           Anaerolineae  <NA>       T              2     2    15
## 174                Bacilli  <NA>       T              2     2    32
## 175            Bacteroidia  <NA>       T              2     2   718
## 176     Betaproteobacteria  <NA>       T              2     2     7
## 177            Caldilineae  <NA>       T              2     2     0
## 178             Chlamydiae  <NA>       T              2     2     0
## 179            Chloroflexi  <NA>       T              2     2     0
## 180         Chrysiogenetes  <NA>       T              2     2     0
## 181             Clostridia  <NA>       T              2     2  8999
## 182          Cyanobacteria  <NA>       T              2     2     0
## 183      Dehalococcoidetes  <NA>       T              2     2     0
## 184             Deinococci  <NA>       T              2     2     0
## 185    Deltaproteobacteria  <NA>       T              2     2     6
## 186  Epsilonproteobacteria  <NA>       T              2     2     0
## 187        Erysipelotrichi  <NA>       T              2     2   495
## 188          Fibrobacteria  <NA>       T              2     2     2
## 189          Flavobacteria  <NA>       T              2     2    15
## 190           Fusobacteria  <NA>       T              2     2     0
## 191    Gammaproteobacteria  <NA>       T              2     2    17
## 192       Gemmatimonadetes  <NA>       T              2     2     0
## 193             Holophagae  <NA>       T              2     2     0
## 194          Lentisphaeria  <NA>       T              2     2     0
## 195        Methanobacteria  <NA>       T              2     2     1
## 196        Methanomicrobia  <NA>       T              2     2     0
## 197             Mollicutes  <NA>       T              2     2    11
## 198             Nitrospira  <NA>       T              2     2     0
## 199               Opitutae  <NA>       T              2     2     0
## 200       Planctomycetacia  <NA>       T              2     2     0
## 201        Sphingobacteria  <NA>       T              2     2     4
## 202           Spirochaetes  <NA>       T              2     2    72
## 203           Subdivision3  <NA>       T              2     2     0
## 204            Synergistia  <NA>       T              2     2    84
## 205         Thermomicrobia  <NA>       T              2     2     3
## 206         Thermoplasmata  <NA>       T              2     2     0
## 207            Thermotogae  <NA>       T              2     2     0
## 208                Unknown  <NA>       T              2     2  1342
## 209          Acidobacteria     1       T              2     3     0
## 210          Acidobacteria    10       T              2     3     0
## 211          Acidobacteria    14       T              2     3     0
## 212          Acidobacteria    16       T              2     3     0
## 213          Acidobacteria    17       T              2     3     0
## 214          Acidobacteria    18       T              2     3     2
## 215          Acidobacteria    21       T              2     3     0
## 216          Acidobacteria    22       T              2     3     0
## 217          Acidobacteria     3       T              2     3     0
## 218          Acidobacteria     4       T              2     3     0
## 219          Acidobacteria     5       T              2     3     0
## 220          Acidobacteria     6       T              2     3     0
## 221          Acidobacteria     7       T              2     3     0
## 222          Acidobacteria     9       T              2     3     0
## 223         Actinobacteria  <NA>       T              2     3   414
## 224    Alphaproteobacteria  <NA>       T              2     3    11
## 225           Anaerolineae  <NA>       T              2     3    31
## 226                Bacilli  <NA>       T              2     3    33
## 227            Bacteroidia  <NA>       T              2     3   679
## 228     Betaproteobacteria  <NA>       T              2     3    61
## 229            Caldilineae  <NA>       T              2     3     0
## 230             Chlamydiae  <NA>       T              2     3     0
## 231            Chloroflexi  <NA>       T              2     3     0
## 232         Chrysiogenetes  <NA>       T              2     3     0
## 233             Clostridia  <NA>       T              2     3 10944
## 234          Cyanobacteria  <NA>       T              2     3     0
## 235      Dehalococcoidetes  <NA>       T              2     3     0
## 236             Deinococci  <NA>       T              2     3     0
## 237    Deltaproteobacteria  <NA>       T              2     3     3
## 238  Epsilonproteobacteria  <NA>       T              2     3     0
## 239        Erysipelotrichi  <NA>       T              2     3   643
## 240          Fibrobacteria  <NA>       T              2     3     4
## 241          Flavobacteria  <NA>       T              2     3     7
## 242           Fusobacteria  <NA>       T              2     3     0
## 243    Gammaproteobacteria  <NA>       T              2     3    25
## 244       Gemmatimonadetes  <NA>       T              2     3     0
## 245             Holophagae  <NA>       T              2     3     0
## 246          Lentisphaeria  <NA>       T              2     3     0
## 247        Methanobacteria  <NA>       T              2     3     0
## 248        Methanomicrobia  <NA>       T              2     3     0
## 249             Mollicutes  <NA>       T              2     3     1
## 250             Nitrospira  <NA>       T              2     3     0
## 251               Opitutae  <NA>       T              2     3     0
## 252       Planctomycetacia  <NA>       T              2     3     0
## 253        Sphingobacteria  <NA>       T              2     3     4
## 254           Spirochaetes  <NA>       T              2     3   266
## 255           Subdivision3  <NA>       T              2     3     0
## 256            Synergistia  <NA>       T              2     3   110
## 257         Thermomicrobia  <NA>       T              2     3     3
## 258         Thermoplasmata  <NA>       T              2     3     0
## 259            Thermotogae  <NA>       T              2     3     0
## 260                Unknown  <NA>       T              2     3  1555
## 261          Acidobacteria     1       T              2     6     0
## 262          Acidobacteria    10       T              2     6     0
## 263          Acidobacteria    14       T              2     6     0
## 264          Acidobacteria    16       T              2     6     0
## 265          Acidobacteria    17       T              2     6     0
## 266          Acidobacteria    18       T              2     6     5
## 267          Acidobacteria    21       T              2     6     0
## 268          Acidobacteria    22       T              2     6     0
## 269          Acidobacteria     3       T              2     6     0
## 270          Acidobacteria     4       T              2     6     1
## 271          Acidobacteria     5       T              2     6     0
## 272          Acidobacteria     6       T              2     6     1
## 273          Acidobacteria     7       T              2     6     0
## 274          Acidobacteria     9       T              2     6     0
## 275         Actinobacteria  <NA>       T              2     6   227
## 276    Alphaproteobacteria  <NA>       T              2     6    49
## 277           Anaerolineae  <NA>       T              2     6   159
## 278                Bacilli  <NA>       T              2     6    11
## 279            Bacteroidia  <NA>       T              2     6   143
## 280     Betaproteobacteria  <NA>       T              2     6     4
## 281            Caldilineae  <NA>       T              2     6     1
## 282             Chlamydiae  <NA>       T              2     6     0
## 283            Chloroflexi  <NA>       T              2     6     0
## 284         Chrysiogenetes  <NA>       T              2     6     0
## 285             Clostridia  <NA>       T              2     6 12169
## 286          Cyanobacteria  <NA>       T              2     6     0
## 287      Dehalococcoidetes  <NA>       T              2     6     2
## 288             Deinococci  <NA>       T              2     6     3
## 289    Deltaproteobacteria  <NA>       T              2     6    59
## 290  Epsilonproteobacteria  <NA>       T              2     6     0
## 291        Erysipelotrichi  <NA>       T              2     6   629
## 292          Fibrobacteria  <NA>       T              2     6     0
## 293          Flavobacteria  <NA>       T              2     6     3
## 294           Fusobacteria  <NA>       T              2     6     1
## 295    Gammaproteobacteria  <NA>       T              2     6     4
## 296       Gemmatimonadetes  <NA>       T              2     6     0
## 297             Holophagae  <NA>       T              2     6     0
## 298          Lentisphaeria  <NA>       T              2     6     1
## 299        Methanobacteria  <NA>       T              2     6     0
## 300        Methanomicrobia  <NA>       T              2     6     0
## 301             Mollicutes  <NA>       T              2     6     3
## 302             Nitrospira  <NA>       T              2     6     0
## 303               Opitutae  <NA>       T              2     6     0
## 304       Planctomycetacia  <NA>       T              2     6     2
## 305        Sphingobacteria  <NA>       T              2     6     1
## 306           Spirochaetes  <NA>       T              2     6    43
## 307           Subdivision3  <NA>       T              2     6     0
## 308            Synergistia  <NA>       T              2     6   333
## 309         Thermomicrobia  <NA>       T              2     6     3
## 310         Thermoplasmata  <NA>       T              2     6     0
## 311            Thermotogae  <NA>       T              2     6     1
## 312                Unknown  <NA>       T              2     6  1832
## 313          Acidobacteria     1       T              2     7     0
## 314          Acidobacteria    10       T              2     7     0
## 315          Acidobacteria    14       T              2     7     0
## 316          Acidobacteria    16       T              2     7     0
## 317          Acidobacteria    17       T              2     7     0
## 318          Acidobacteria    18       T              2     7     0
## 319          Acidobacteria    21       T              2     7     0
## 320          Acidobacteria    22       T              2     7     0
## 321          Acidobacteria     3       T              2     7     0
## 322          Acidobacteria     4       T              2     7     0
## 323          Acidobacteria     5       T              2     7     0
## 324          Acidobacteria     6       T              2     7     0
## 325          Acidobacteria     7       T              2     7     0
## 326          Acidobacteria     9       T              2     7     0
## 327         Actinobacteria  <NA>       T              2     7     1
## 328    Alphaproteobacteria  <NA>       T              2     7     0
## 329           Anaerolineae  <NA>       T              2     7     0
## 330                Bacilli  <NA>       T              2     7    17
## 331            Bacteroidia  <NA>       T              2     7     1
## 332     Betaproteobacteria  <NA>       T              2     7     1
## 333            Caldilineae  <NA>       T              2     7     0
## 334             Chlamydiae  <NA>       T              2     7     0
## 335            Chloroflexi  <NA>       T              2     7     0
## 336         Chrysiogenetes  <NA>       T              2     7     0
## 337             Clostridia  <NA>       T              2     7    28
## 338          Cyanobacteria  <NA>       T              2     7     0
## 339      Dehalococcoidetes  <NA>       T              2     7     0
## 340             Deinococci  <NA>       T              2     7     0
## 341    Deltaproteobacteria  <NA>       T              2     7     0
## 342  Epsilonproteobacteria  <NA>       T              2     7     0
## 343        Erysipelotrichi  <NA>       T              2     7     0
## 344          Fibrobacteria  <NA>       T              2     7     0
## 345          Flavobacteria  <NA>       T              2     7     0
## 346           Fusobacteria  <NA>       T              2     7     0
## 347    Gammaproteobacteria  <NA>       T              2     7     0
## 348       Gemmatimonadetes  <NA>       T              2     7     0
## 349             Holophagae  <NA>       T              2     7     0
## 350          Lentisphaeria  <NA>       T              2     7     0
## 351        Methanobacteria  <NA>       T              2     7     0
## 352        Methanomicrobia  <NA>       T              2     7     0
## 353             Mollicutes  <NA>       T              2     7     0
## 354             Nitrospira  <NA>       T              2     7     0
## 355               Opitutae  <NA>       T              2     7     0
## 356       Planctomycetacia  <NA>       T              2     7     0
## 357        Sphingobacteria  <NA>       T              2     7     0
## 358           Spirochaetes  <NA>       T              2     7     1
## 359           Subdivision3  <NA>       T              2     7     0
## 360            Synergistia  <NA>       T              2     7     0
## 361         Thermomicrobia  <NA>       T              2     7     0
## 362         Thermoplasmata  <NA>       T              2     7     0
## 363            Thermotogae  <NA>       T              2     7     0
## 364                Unknown  <NA>       T              2     7     7
## 365          Acidobacteria     1       T              2     9     0
## 366          Acidobacteria    10       T              2     9     0
## 367          Acidobacteria    14       T              2     9     0
## 368          Acidobacteria    16       T              2     9     0
## 369          Acidobacteria    17       T              2     9     0
## 370          Acidobacteria    18       T              2     9    15
## 371          Acidobacteria    21       T              2     9     0
## 372          Acidobacteria    22       T              2     9     0
## 373          Acidobacteria     3       T              2     9     0
## 374          Acidobacteria     4       T              2     9     0
## 375          Acidobacteria     5       T              2     9     0
## 376          Acidobacteria     6       T              2     9     0
## 377          Acidobacteria     7       T              2     9     0
## 378          Acidobacteria     9       T              2     9     0
## 379         Actinobacteria  <NA>       T              2     9   811
## 380    Alphaproteobacteria  <NA>       T              2     9    71
## 381           Anaerolineae  <NA>       T              2     9   376
## 382                Bacilli  <NA>       T              2     9    41
## 383            Bacteroidia  <NA>       T              2     9   924
## 384     Betaproteobacteria  <NA>       T              2     9     5
## 385            Caldilineae  <NA>       T              2     9     7
## 386             Chlamydiae  <NA>       T              2     9     0
## 387            Chloroflexi  <NA>       T              2     9     0
## 388         Chrysiogenetes  <NA>       T              2     9     0
## 389             Clostridia  <NA>       T              2     9 17471
## 390          Cyanobacteria  <NA>       T              2     9     0
## 391      Dehalococcoidetes  <NA>       T              2     9     0
## 392             Deinococci  <NA>       T              2     9     2
## 393    Deltaproteobacteria  <NA>       T              2     9   158
## 394  Epsilonproteobacteria  <NA>       T              2     9     0
## 395        Erysipelotrichi  <NA>       T              2     9   933
## 396          Fibrobacteria  <NA>       T              2     9     3
## 397          Flavobacteria  <NA>       T              2     9     6
## 398           Fusobacteria  <NA>       T              2     9     2
## 399    Gammaproteobacteria  <NA>       T              2     9    37
## 400       Gemmatimonadetes  <NA>       T              2     9     1
## 401             Holophagae  <NA>       T              2     9     0
## 402          Lentisphaeria  <NA>       T              2     9     1
## 403        Methanobacteria  <NA>       T              2     9     0
## 404        Methanomicrobia  <NA>       T              2     9     0
## 405             Mollicutes  <NA>       T              2     9     4
## 406             Nitrospira  <NA>       T              2     9     0
## 407               Opitutae  <NA>       T              2     9     0
## 408       Planctomycetacia  <NA>       T              2     9     8
## 409        Sphingobacteria  <NA>       T              2     9     1
## 410           Spirochaetes  <NA>       T              2     9   175
## 411           Subdivision3  <NA>       T              2     9     0
## 412            Synergistia  <NA>       T              2     9   658
## 413         Thermomicrobia  <NA>       T              2     9     2
## 414         Thermoplasmata  <NA>       T              2     9     0
## 415            Thermotogae  <NA>       T              2     9     1
## 416                Unknown  <NA>       T              2     9  3240
## 417          Acidobacteria     1       T              3     2     0
## 418          Acidobacteria    10       T              3     2     0
## 419          Acidobacteria    14       T              3     2     0
## 420          Acidobacteria    16       T              3     2     0
## 421          Acidobacteria    17       T              3     2     0
## 422          Acidobacteria    18       T              3     2     2
## 423          Acidobacteria    21       T              3     2     0
## 424          Acidobacteria    22       T              3     2     0
## 425          Acidobacteria     3       T              3     2     0
## 426          Acidobacteria     4       T              3     2     0
## 427          Acidobacteria     5       T              3     2     0
## 428          Acidobacteria     6       T              3     2     0
## 429          Acidobacteria     7       T              3     2     0
## 430          Acidobacteria     9       T              3     2     0
## 431         Actinobacteria  <NA>       T              3     2    89
## 432    Alphaproteobacteria  <NA>       T              3     2    13
## 433           Anaerolineae  <NA>       T              3     2     8
## 434                Bacilli  <NA>       T              3     2    23
## 435            Bacteroidia  <NA>       T              3     2   314
## 436     Betaproteobacteria  <NA>       T              3     2     4
## 437            Caldilineae  <NA>       T              3     2     0
## 438             Chlamydiae  <NA>       T              3     2     0
## 439            Chloroflexi  <NA>       T              3     2     0
## 440         Chrysiogenetes  <NA>       T              3     2     0
## 441             Clostridia  <NA>       T              3     2  3431
## 442          Cyanobacteria  <NA>       T              3     2     0
## 443      Dehalococcoidetes  <NA>       T              3     2     1
## 444             Deinococci  <NA>       T              3     2     1
## 445    Deltaproteobacteria  <NA>       T              3     2    17
## 446  Epsilonproteobacteria  <NA>       T              3     2     0
## 447        Erysipelotrichi  <NA>       T              3     2   193
## 448          Fibrobacteria  <NA>       T              3     2     1
## 449          Flavobacteria  <NA>       T              3     2     1
## 450           Fusobacteria  <NA>       T              3     2     0
## 451    Gammaproteobacteria  <NA>       T              3     2    20
## 452       Gemmatimonadetes  <NA>       T              3     2     0
## 453             Holophagae  <NA>       T              3     2     0
## 454          Lentisphaeria  <NA>       T              3     2     0
## 455        Methanobacteria  <NA>       T              3     2     0
## 456        Methanomicrobia  <NA>       T              3     2     0
## 457             Mollicutes  <NA>       T              3     2     1
## 458             Nitrospira  <NA>       T              3     2     0
## 459               Opitutae  <NA>       T              3     2     0
## 460       Planctomycetacia  <NA>       T              3     2     0
## 461        Sphingobacteria  <NA>       T              3     2     1
## 462           Spirochaetes  <NA>       T              3     2    19
## 463           Subdivision3  <NA>       T              3     2     0
## 464            Synergistia  <NA>       T              3     2   125
## 465         Thermomicrobia  <NA>       T              3     2     1
## 466         Thermoplasmata  <NA>       T              3     2     0
## 467            Thermotogae  <NA>       T              3     2     0
## 468                Unknown  <NA>       T              3     2   676
## 469          Acidobacteria     1       T              3     3     0
## 470          Acidobacteria    10       T              3     3     0
## 471          Acidobacteria    14       T              3     3     0
## 472          Acidobacteria    16       T              3     3     0
## 473          Acidobacteria    17       T              3     3     0
## 474          Acidobacteria    18       T              3     3     1
## 475          Acidobacteria    21       T              3     3     0
## 476          Acidobacteria    22       T              3     3     0
## 477          Acidobacteria     3       T              3     3     0
## 478          Acidobacteria     4       T              3     3     0
## 479          Acidobacteria     5       T              3     3     0
## 480          Acidobacteria     6       T              3     3     0
## 481          Acidobacteria     7       T              3     3     0
## 482          Acidobacteria     9       T              3     3     0
## 483         Actinobacteria  <NA>       T              3     3    36
## 484    Alphaproteobacteria  <NA>       T              3     3    11
## 485           Anaerolineae  <NA>       T              3     3     5
## 486                Bacilli  <NA>       T              3     3    11
## 487            Bacteroidia  <NA>       T              3     3   138
## 488     Betaproteobacteria  <NA>       T              3     3     1
## 489            Caldilineae  <NA>       T              3     3     0
## 490             Chlamydiae  <NA>       T              3     3     0
## 491            Chloroflexi  <NA>       T              3     3     0
## 492         Chrysiogenetes  <NA>       T              3     3     0
## 493             Clostridia  <NA>       T              3     3  1277
## 494          Cyanobacteria  <NA>       T              3     3     0
## 495      Dehalococcoidetes  <NA>       T              3     3     0
## 496             Deinococci  <NA>       T              3     3     0
## 497    Deltaproteobacteria  <NA>       T              3     3     6
## 498  Epsilonproteobacteria  <NA>       T              3     3     0
## 499        Erysipelotrichi  <NA>       T              3     3    66
## 500          Fibrobacteria  <NA>       T              3     3     1
## 501          Flavobacteria  <NA>       T              3     3     0
## 502           Fusobacteria  <NA>       T              3     3     0
## 503    Gammaproteobacteria  <NA>       T              3     3     5
## 504       Gemmatimonadetes  <NA>       T              3     3     0
## 505             Holophagae  <NA>       T              3     3     0
## 506          Lentisphaeria  <NA>       T              3     3     0
## 507        Methanobacteria  <NA>       T              3     3     0
## 508        Methanomicrobia  <NA>       T              3     3     0
## 509             Mollicutes  <NA>       T              3     3     0
## 510             Nitrospira  <NA>       T              3     3     0
## 511               Opitutae  <NA>       T              3     3     0
## 512       Planctomycetacia  <NA>       T              3     3     0
## 513        Sphingobacteria  <NA>       T              3     3     0
## 514           Spirochaetes  <NA>       T              3     3     7
## 515           Subdivision3  <NA>       T              3     3     0
## 516            Synergistia  <NA>       T              3     3    70
## 517         Thermomicrobia  <NA>       T              3     3     0
## 518         Thermoplasmata  <NA>       T              3     3     0
## 519            Thermotogae  <NA>       T              3     3     0
## 520                Unknown  <NA>       T              3     3   306
## 521          Acidobacteria     1       T              3     5     0
## 522          Acidobacteria    10       T              3     5     0
## 523          Acidobacteria    14       T              3     5     0
## 524          Acidobacteria    16       T              3     5     0
## 525          Acidobacteria    17       T              3     5     0
## 526          Acidobacteria    18       T              3     5     0
## 527          Acidobacteria    21       T              3     5     0
## 528          Acidobacteria    22       T              3     5     0
## 529          Acidobacteria     3       T              3     5     0
## 530          Acidobacteria     4       T              3     5     0
## 531          Acidobacteria     5       T              3     5     0
## 532          Acidobacteria     6       T              3     5     0
## 533          Acidobacteria     7       T              3     5     0
## 534          Acidobacteria     9       T              3     5     0
## 535         Actinobacteria  <NA>       T              3     5     7
## 536    Alphaproteobacteria  <NA>       T              3     5     0
## 537           Anaerolineae  <NA>       T              3     5     2
## 538                Bacilli  <NA>       T              3     5    43
## 539            Bacteroidia  <NA>       T              3     5    22
## 540     Betaproteobacteria  <NA>       T              3     5     0
## 541            Caldilineae  <NA>       T              3     5     0
## 542             Chlamydiae  <NA>       T              3     5     0
## 543            Chloroflexi  <NA>       T              3     5     0
## 544         Chrysiogenetes  <NA>       T              3     5     0
## 545             Clostridia  <NA>       T              3     5   277
## 546          Cyanobacteria  <NA>       T              3     5     0
## 547      Dehalococcoidetes  <NA>       T              3     5     0
## 548             Deinococci  <NA>       T              3     5     0
## 549    Deltaproteobacteria  <NA>       T              3     5     1
## 550  Epsilonproteobacteria  <NA>       T              3     5     0
## 551        Erysipelotrichi  <NA>       T              3     5    20
## 552          Fibrobacteria  <NA>       T              3     5     0
## 553          Flavobacteria  <NA>       T              3     5     0
## 554           Fusobacteria  <NA>       T              3     5     0
## 555    Gammaproteobacteria  <NA>       T              3     5     4
## 556       Gemmatimonadetes  <NA>       T              3     5     0
## 557             Holophagae  <NA>       T              3     5     0
## 558          Lentisphaeria  <NA>       T              3     5     0
## 559        Methanobacteria  <NA>       T              3     5     0
## 560        Methanomicrobia  <NA>       T              3     5     0
## 561             Mollicutes  <NA>       T              3     5     0
## 562             Nitrospira  <NA>       T              3     5     0
## 563               Opitutae  <NA>       T              3     5     0
## 564       Planctomycetacia  <NA>       T              3     5     0
## 565        Sphingobacteria  <NA>       T              3     5     0
## 566           Spirochaetes  <NA>       T              3     5     0
## 567           Subdivision3  <NA>       T              3     5     0
## 568            Synergistia  <NA>       T              3     5    13
## 569         Thermomicrobia  <NA>       T              3     5     0
## 570         Thermoplasmata  <NA>       T              3     5     0
## 571            Thermotogae  <NA>       T              3     5     0
## 572                Unknown  <NA>       T              3     5    69
## 573          Acidobacteria     1       T              4     3     0
## 574          Acidobacteria    10       T              4     3     0
## 575          Acidobacteria    14       T              4     3     0
## 576          Acidobacteria    16       T              4     3     0
## 577          Acidobacteria    17       T              4     3     0
## 578          Acidobacteria    18       T              4     3     0
## 579          Acidobacteria    21       T              4     3     0
## 580          Acidobacteria    22       T              4     3     0
## 581          Acidobacteria     3       T              4     3     0
## 582          Acidobacteria     4       T              4     3     0
## 583          Acidobacteria     5       T              4     3     0
## 584          Acidobacteria     6       T              4     3     0
## 585          Acidobacteria     7       T              4     3     0
## 586          Acidobacteria     9       T              4     3     0
## 587         Actinobacteria  <NA>       T              4     3   498
## 588    Alphaproteobacteria  <NA>       T              4     3   112
## 589           Anaerolineae  <NA>       T              4     3     0
## 590                Bacilli  <NA>       T              4     3     3
## 591            Bacteroidia  <NA>       T              4     3     1
## 592     Betaproteobacteria  <NA>       T              4     3  7710
## 593            Caldilineae  <NA>       T              4     3     0
## 594             Chlamydiae  <NA>       T              4     3     0
## 595            Chloroflexi  <NA>       T              4     3     0
## 596         Chrysiogenetes  <NA>       T              4     3     0
## 597             Clostridia  <NA>       T              4     3     7
## 598          Cyanobacteria  <NA>       T              4     3     0
## 599      Dehalococcoidetes  <NA>       T              4     3     0
## 600             Deinococci  <NA>       T              4     3     0
## 601    Deltaproteobacteria  <NA>       T              4     3     0
## 602  Epsilonproteobacteria  <NA>       T              4     3     0
## 603        Erysipelotrichi  <NA>       T              4     3     0
## 604          Fibrobacteria  <NA>       T              4     3     0
## 605          Flavobacteria  <NA>       T              4     3     3
## 606           Fusobacteria  <NA>       T              4     3     0
## 607    Gammaproteobacteria  <NA>       T              4     3    10
## 608       Gemmatimonadetes  <NA>       T              4     3     0
## 609             Holophagae  <NA>       T              4     3     0
## 610          Lentisphaeria  <NA>       T              4     3     0
## 611        Methanobacteria  <NA>       T              4     3     0
## 612        Methanomicrobia  <NA>       T              4     3     0
## 613             Mollicutes  <NA>       T              4     3     0
## 614             Nitrospira  <NA>       T              4     3     0
## 615               Opitutae  <NA>       T              4     3     0
## 616       Planctomycetacia  <NA>       T              4     3     0
## 617        Sphingobacteria  <NA>       T              4     3     0
## 618           Spirochaetes  <NA>       T              4     3     0
## 619           Subdivision3  <NA>       T              4     3     0
## 620            Synergistia  <NA>       T              4     3     0
## 621         Thermomicrobia  <NA>       T              4     3     0
## 622         Thermoplasmata  <NA>       T              4     3     0
## 623            Thermotogae  <NA>       T              4     3     0
## 624                Unknown  <NA>       T              4     3     3
## 625          Acidobacteria     1       T              4     4     0
## 626          Acidobacteria    10       T              4     4     0
## 627          Acidobacteria    14       T              4     4     0
## 628          Acidobacteria    16       T              4     4     0
## 629          Acidobacteria    17       T              4     4     0
## 630          Acidobacteria    18       T              4     4     1
## 631          Acidobacteria    21       T              4     4     0
## 632          Acidobacteria    22       T              4     4     0
## 633          Acidobacteria     3       T              4     4     0
## 634          Acidobacteria     4       T              4     4     0
## 635          Acidobacteria     5       T              4     4     0
## 636          Acidobacteria     6       T              4     4     0
## 637          Acidobacteria     7       T              4     4     0
## 638          Acidobacteria     9       T              4     4     0
## 639         Actinobacteria  <NA>       T              4     4   573
## 640    Alphaproteobacteria  <NA>       T              4     4    65
## 641           Anaerolineae  <NA>       T              4     4    38
## 642                Bacilli  <NA>       T              4     4    60
## 643            Bacteroidia  <NA>       T              4     4   116
## 644     Betaproteobacteria  <NA>       T              4     4   518
## 645            Caldilineae  <NA>       T              4     4     2
## 646             Chlamydiae  <NA>       T              4     4     0
## 647            Chloroflexi  <NA>       T              4     4     0
## 648         Chrysiogenetes  <NA>       T              4     4     0
## 649             Clostridia  <NA>       T              4     4 10545
## 650          Cyanobacteria  <NA>       T              4     4     2
## 651      Dehalococcoidetes  <NA>       T              4     4     0
## 652             Deinococci  <NA>       T              4     4     7
## 653    Deltaproteobacteria  <NA>       T              4     4    38
## 654  Epsilonproteobacteria  <NA>       T              4     4     0
## 655        Erysipelotrichi  <NA>       T              4     4   127
## 656          Fibrobacteria  <NA>       T              4     4     0
## 657          Flavobacteria  <NA>       T              4     4    15
## 658           Fusobacteria  <NA>       T              4     4     0
## 659    Gammaproteobacteria  <NA>       T              4     4    37
## 660       Gemmatimonadetes  <NA>       T              4     4     0
## 661             Holophagae  <NA>       T              4     4     1
## 662          Lentisphaeria  <NA>       T              4     4     0
## 663        Methanobacteria  <NA>       T              4     4     0
## 664        Methanomicrobia  <NA>       T              4     4     0
## 665             Mollicutes  <NA>       T              4     4     6
## 666             Nitrospira  <NA>       T              4     4     0
## 667               Opitutae  <NA>       T              4     4     1
## 668       Planctomycetacia  <NA>       T              4     4     2
## 669        Sphingobacteria  <NA>       T              4     4     1
## 670           Spirochaetes  <NA>       T              4     4     8
## 671           Subdivision3  <NA>       T              4     4     0
## 672            Synergistia  <NA>       T              4     4   404
## 673         Thermomicrobia  <NA>       T              4     4    16
## 674         Thermoplasmata  <NA>       T              4     4     0
## 675            Thermotogae  <NA>       T              4     4     0
## 676                Unknown  <NA>       T              4     4   826
## 677          Acidobacteria     1       T              4     5     1
## 678          Acidobacteria    10       T              4     5     0
## 679          Acidobacteria    14       T              4     5     1
## 680          Acidobacteria    16       T              4     5     0
## 681          Acidobacteria    17       T              4     5     0
## 682          Acidobacteria    18       T              4     5     0
## 683          Acidobacteria    21       T              4     5     0
## 684          Acidobacteria    22       T              4     5     0
## 685          Acidobacteria     3       T              4     5    32
## 686          Acidobacteria     4       T              4     5     0
## 687          Acidobacteria     5       T              4     5     0
## 688          Acidobacteria     6       T              4     5     0
## 689          Acidobacteria     7       T              4     5     0
## 690          Acidobacteria     9       T              4     5     0
## 691         Actinobacteria  <NA>       T              4     5  1345
## 692    Alphaproteobacteria  <NA>       T              4     5   138
## 693           Anaerolineae  <NA>       T              4     5    44
## 694                Bacilli  <NA>       T              4     5   109
## 695            Bacteroidia  <NA>       T              4     5   156
## 696     Betaproteobacteria  <NA>       T              4     5   485
## 697            Caldilineae  <NA>       T              4     5     5
## 698             Chlamydiae  <NA>       T              4     5     0
## 699            Chloroflexi  <NA>       T              4     5     1
## 700         Chrysiogenetes  <NA>       T              4     5     0
## 701             Clostridia  <NA>       T              4     5  3612
## 702          Cyanobacteria  <NA>       T              4     5     0
## 703      Dehalococcoidetes  <NA>       T              4     5     1
## 704             Deinococci  <NA>       T              4     5    28
## 705    Deltaproteobacteria  <NA>       T              4     5    83
## 706  Epsilonproteobacteria  <NA>       T              4     5     0
## 707        Erysipelotrichi  <NA>       T              4     5    65
## 708          Fibrobacteria  <NA>       T              4     5     0
## 709          Flavobacteria  <NA>       T              4     5    16
## 710           Fusobacteria  <NA>       T              4     5     0
## 711    Gammaproteobacteria  <NA>       T              4     5    68
## 712       Gemmatimonadetes  <NA>       T              4     5     1
## 713             Holophagae  <NA>       T              4     5     0
## 714          Lentisphaeria  <NA>       T              4     5     0
## 715        Methanobacteria  <NA>       T              4     5     0
## 716        Methanomicrobia  <NA>       T              4     5     0
## 717             Mollicutes  <NA>       T              4     5     8
## 718             Nitrospira  <NA>       T              4     5     0
## 719               Opitutae  <NA>       T              4     5     0
## 720       Planctomycetacia  <NA>       T              4     5     0
## 721        Sphingobacteria  <NA>       T              4     5    10
## 722           Spirochaetes  <NA>       T              4     5     7
## 723           Subdivision3  <NA>       T              4     5     0
## 724            Synergistia  <NA>       T              4     5   297
## 725         Thermomicrobia  <NA>       T              4     5    42
## 726         Thermoplasmata  <NA>       T              4     5     0
## 727            Thermotogae  <NA>       T              4     5     0
## 728                Unknown  <NA>       T              4     5   676
## 729          Acidobacteria     1       T              4     6     0
## 730          Acidobacteria    10       T              4     6     0
## 731          Acidobacteria    14       T              4     6     0
## 732          Acidobacteria    16       T              4     6     0
## 733          Acidobacteria    17       T              4     6     0
## 734          Acidobacteria    18       T              4     6     0
## 735          Acidobacteria    21       T              4     6     0
## 736          Acidobacteria    22       T              4     6     0
## 737          Acidobacteria     3       T              4     6     2
## 738          Acidobacteria     4       T              4     6     1
## 739          Acidobacteria     5       T              4     6     0
## 740          Acidobacteria     6       T              4     6     0
## 741          Acidobacteria     7       T              4     6     0
## 742          Acidobacteria     9       T              4     6     0
## 743         Actinobacteria  <NA>       T              4     6   444
## 744    Alphaproteobacteria  <NA>       T              4     6    42
## 745           Anaerolineae  <NA>       T              4     6    16
## 746                Bacilli  <NA>       T              4     6    55
## 747            Bacteroidia  <NA>       T              4     6    49
## 748     Betaproteobacteria  <NA>       T              4     6  2048
## 749            Caldilineae  <NA>       T              4     6     2
## 750             Chlamydiae  <NA>       T              4     6     0
## 751            Chloroflexi  <NA>       T              4     6     0
## 752         Chrysiogenetes  <NA>       T              4     6     0
## 753             Clostridia  <NA>       T              4     6  1306
## 754          Cyanobacteria  <NA>       T              4     6     0
## 755      Dehalococcoidetes  <NA>       T              4     6     0
## 756             Deinococci  <NA>       T              4     6    15
## 757    Deltaproteobacteria  <NA>       T              4     6    24
## 758  Epsilonproteobacteria  <NA>       T              4     6     0
## 759        Erysipelotrichi  <NA>       T              4     6    25
## 760          Fibrobacteria  <NA>       T              4     6     0
## 761          Flavobacteria  <NA>       T              4     6     8
## 762           Fusobacteria  <NA>       T              4     6     0
## 763    Gammaproteobacteria  <NA>       T              4     6    39
## 764       Gemmatimonadetes  <NA>       T              4     6     2
## 765             Holophagae  <NA>       T              4     6     0
## 766          Lentisphaeria  <NA>       T              4     6     0
## 767        Methanobacteria  <NA>       T              4     6     0
## 768        Methanomicrobia  <NA>       T              4     6     0
## 769             Mollicutes  <NA>       T              4     6     1
## 770             Nitrospira  <NA>       T              4     6     0
## 771               Opitutae  <NA>       T              4     6     0
## 772       Planctomycetacia  <NA>       T              4     6     0
## 773        Sphingobacteria  <NA>       T              4     6     1
## 774           Spirochaetes  <NA>       T              4     6     2
## 775           Subdivision3  <NA>       T              4     6     1
## 776            Synergistia  <NA>       T              4     6    95
## 777         Thermomicrobia  <NA>       T              4     6    13
## 778         Thermoplasmata  <NA>       T              4     6     0
## 779            Thermotogae  <NA>       T              4     6     0
## 780                Unknown  <NA>       T              4     6   200
## 781          Acidobacteria     1       T              4     7     0
## 782          Acidobacteria    10       T              4     7     0
## 783          Acidobacteria    14       T              4     7     0
## 784          Acidobacteria    16       T              4     7     0
## 785          Acidobacteria    17       T              4     7     0
## 786          Acidobacteria    18       T              4     7     0
## 787          Acidobacteria    21       T              4     7     0
## 788          Acidobacteria    22       T              4     7     0
## 789          Acidobacteria     3       T              4     7     0
## 790          Acidobacteria     4       T              4     7     0
## 791          Acidobacteria     5       T              4     7     0
## 792          Acidobacteria     6       T              4     7     0
## 793          Acidobacteria     7       T              4     7     0
## 794          Acidobacteria     9       T              4     7     0
## 795         Actinobacteria  <NA>       T              4     7    57
## 796    Alphaproteobacteria  <NA>       T              4     7     4
## 797           Anaerolineae  <NA>       T              4     7     4
## 798                Bacilli  <NA>       T              4     7     8
## 799            Bacteroidia  <NA>       T              4     7    13
## 800     Betaproteobacteria  <NA>       T              4     7     2
## 801            Caldilineae  <NA>       T              4     7     0
## 802             Chlamydiae  <NA>       T              4     7     0
## 803            Chloroflexi  <NA>       T              4     7     0
## 804         Chrysiogenetes  <NA>       T              4     7     0
## 805             Clostridia  <NA>       T              4     7   198
## 806          Cyanobacteria  <NA>       T              4     7     0
## 807      Dehalococcoidetes  <NA>       T              4     7     0
## 808             Deinococci  <NA>       T              4     7     3
## 809    Deltaproteobacteria  <NA>       T              4     7     3
## 810  Epsilonproteobacteria  <NA>       T              4     7     0
## 811        Erysipelotrichi  <NA>       T              4     7     3
## 812          Fibrobacteria  <NA>       T              4     7     0
## 813          Flavobacteria  <NA>       T              4     7     0
## 814           Fusobacteria  <NA>       T              4     7     0
## 815    Gammaproteobacteria  <NA>       T              4     7    11
## 816       Gemmatimonadetes  <NA>       T              4     7     0
## 817             Holophagae  <NA>       T              4     7     0
## 818          Lentisphaeria  <NA>       T              4     7     0
## 819        Methanobacteria  <NA>       T              4     7     0
## 820        Methanomicrobia  <NA>       T              4     7     0
## 821             Mollicutes  <NA>       T              4     7     0
## 822             Nitrospira  <NA>       T              4     7     0
## 823               Opitutae  <NA>       T              4     7     0
## 824       Planctomycetacia  <NA>       T              4     7     0
## 825        Sphingobacteria  <NA>       T              4     7     2
## 826           Spirochaetes  <NA>       T              4     7     0
## 827           Subdivision3  <NA>       T              4     7     0
## 828            Synergistia  <NA>       T              4     7    22
## 829         Thermomicrobia  <NA>       T              4     7     1
## 830         Thermoplasmata  <NA>       T              4     7     0
## 831            Thermotogae  <NA>       T              4     7     0
## 832                Unknown  <NA>       T              4     7    44
## 833          Acidobacteria     1       T              5     2     0
## 834          Acidobacteria    10       T              5     2     0
## 835          Acidobacteria    14       T              5     2     0
## 836          Acidobacteria    16       T              5     2     0
## 837          Acidobacteria    17       T              5     2     0
## 838          Acidobacteria    18       T              5     2     0
## 839          Acidobacteria    21       T              5     2     0
## 840          Acidobacteria    22       T              5     2     0
## 841          Acidobacteria     3       T              5     2     0
## 842          Acidobacteria     4       T              5     2     0
## 843          Acidobacteria     5       T              5     2     0
## 844          Acidobacteria     6       T              5     2     0
## 845          Acidobacteria     7       T              5     2     0
## 846          Acidobacteria     9       T              5     2     0
## 847         Actinobacteria  <NA>       T              5     2   120
## 848    Alphaproteobacteria  <NA>       T              5     2    10
## 849           Anaerolineae  <NA>       T              5     2    11
## 850                Bacilli  <NA>       T              5     2    78
## 851            Bacteroidia  <NA>       T              5     2   964
## 852     Betaproteobacteria  <NA>       T              5     2   444
## 853            Caldilineae  <NA>       T              5     2     0
## 854             Chlamydiae  <NA>       T              5     2     0
## 855            Chloroflexi  <NA>       T              5     2     0
## 856         Chrysiogenetes  <NA>       T              5     2     0
## 857             Clostridia  <NA>       T              5     2  5985
## 858          Cyanobacteria  <NA>       T              5     2     0
## 859      Dehalococcoidetes  <NA>       T              5     2     0
## 860             Deinococci  <NA>       T              5     2     0
## 861    Deltaproteobacteria  <NA>       T              5     2     3
## 862  Epsilonproteobacteria  <NA>       T              5     2     0
## 863        Erysipelotrichi  <NA>       T              5     2   285
## 864          Fibrobacteria  <NA>       T              5     2    12
## 865          Flavobacteria  <NA>       T              5     2     2
## 866           Fusobacteria  <NA>       T              5     2     1
## 867    Gammaproteobacteria  <NA>       T              5     2    75
## 868       Gemmatimonadetes  <NA>       T              5     2     0
## 869             Holophagae  <NA>       T              5     2     0
## 870          Lentisphaeria  <NA>       T              5     2     0
## 871        Methanobacteria  <NA>       T              5     2     0
## 872        Methanomicrobia  <NA>       T              5     2     1
## 873             Mollicutes  <NA>       T              5     2    11
## 874             Nitrospira  <NA>       T              5     2     0
## 875               Opitutae  <NA>       T              5     2     0
## 876       Planctomycetacia  <NA>       T              5     2     1
## 877        Sphingobacteria  <NA>       T              5     2     1
## 878           Spirochaetes  <NA>       T              5     2   114
## 879           Subdivision3  <NA>       T              5     2     0
## 880            Synergistia  <NA>       T              5     2   218
## 881         Thermomicrobia  <NA>       T              5     2     1
## 882         Thermoplasmata  <NA>       T              5     2     1
## 883            Thermotogae  <NA>       T              5     2     0
## 884                Unknown  <NA>       T              5     2  1871
## 885          Acidobacteria     1       T              5     3     0
## 886          Acidobacteria    10       T              5     3     0
## 887          Acidobacteria    14       T              5     3     0
## 888          Acidobacteria    16       T              5     3     0
## 889          Acidobacteria    17       T              5     3     0
## 890          Acidobacteria    18       T              5     3     1
## 891          Acidobacteria    21       T              5     3     0
## 892          Acidobacteria    22       T              5     3     0
## 893          Acidobacteria     3       T              5     3     0
## 894          Acidobacteria     4       T              5     3     0
## 895          Acidobacteria     5       T              5     3     0
## 896          Acidobacteria     6       T              5     3     0
## 897          Acidobacteria     7       T              5     3     0
## 898          Acidobacteria     9       T              5     3     0
## 899         Actinobacteria  <NA>       T              5     3   139
## 900    Alphaproteobacteria  <NA>       T              5     3    10
## 901           Anaerolineae  <NA>       T              5     3    17
## 902                Bacilli  <NA>       T              5     3   100
## 903            Bacteroidia  <NA>       T              5     3  1377
## 904     Betaproteobacteria  <NA>       T              5     3   498
## 905            Caldilineae  <NA>       T              5     3     0
## 906             Chlamydiae  <NA>       T              5     3     0
## 907            Chloroflexi  <NA>       T              5     3     0
## 908         Chrysiogenetes  <NA>       T              5     3     0
## 909             Clostridia  <NA>       T              5     3  8981
## 910          Cyanobacteria  <NA>       T              5     3     0
## 911      Dehalococcoidetes  <NA>       T              5     3     0
## 912             Deinococci  <NA>       T              5     3     0
## 913    Deltaproteobacteria  <NA>       T              5     3     8
## 914  Epsilonproteobacteria  <NA>       T              5     3     0
## 915        Erysipelotrichi  <NA>       T              5     3   432
## 916          Fibrobacteria  <NA>       T              5     3    24
## 917          Flavobacteria  <NA>       T              5     3     7
## 918           Fusobacteria  <NA>       T              5     3     2
## 919    Gammaproteobacteria  <NA>       T              5     3    47
## 920       Gemmatimonadetes  <NA>       T              5     3     0
## 921             Holophagae  <NA>       T              5     3     0
## 922          Lentisphaeria  <NA>       T              5     3     0
## 923        Methanobacteria  <NA>       T              5     3     0
## 924        Methanomicrobia  <NA>       T              5     3     0
## 925             Mollicutes  <NA>       T              5     3    21
## 926             Nitrospira  <NA>       T              5     3     0
## 927               Opitutae  <NA>       T              5     3     0
## 928       Planctomycetacia  <NA>       T              5     3     0
## 929        Sphingobacteria  <NA>       T              5     3     3
## 930           Spirochaetes  <NA>       T              5     3   137
## 931           Subdivision3  <NA>       T              5     3     0
## 932            Synergistia  <NA>       T              5     3   324
## 933         Thermomicrobia  <NA>       T              5     3     1
## 934         Thermoplasmata  <NA>       T              5     3     0
## 935            Thermotogae  <NA>       T              5     3     0
## 936                Unknown  <NA>       T              5     3  3214
## 937          Acidobacteria     1       T              5     4     0
## 938          Acidobacteria    10       T              5     4     0
## 939          Acidobacteria    14       T              5     4     0
## 940          Acidobacteria    16       T              5     4     0
## 941          Acidobacteria    17       T              5     4     0
## 942          Acidobacteria    18       T              5     4     0
## 943          Acidobacteria    21       T              5     4     0
## 944          Acidobacteria    22       T              5     4     0
## 945          Acidobacteria     3       T              5     4     0
## 946          Acidobacteria     4       T              5     4     0
## 947          Acidobacteria     5       T              5     4     0
## 948          Acidobacteria     6       T              5     4     0
## 949          Acidobacteria     7       T              5     4     0
## 950          Acidobacteria     9       T              5     4     0
## 951         Actinobacteria  <NA>       T              5     4    20
## 952    Alphaproteobacteria  <NA>       T              5     4     0
## 953           Anaerolineae  <NA>       T              5     4     0
## 954                Bacilli  <NA>       T              5     4     6
## 955            Bacteroidia  <NA>       T              5     4    70
## 956     Betaproteobacteria  <NA>       T              5     4    11
## 957            Caldilineae  <NA>       T              5     4     0
## 958             Chlamydiae  <NA>       T              5     4     0
## 959            Chloroflexi  <NA>       T              5     4     0
## 960         Chrysiogenetes  <NA>       T              5     4     0
## 961             Clostridia  <NA>       T              5     4   763
## 962          Cyanobacteria  <NA>       T              5     4     0
## 963      Dehalococcoidetes  <NA>       T              5     4     0
## 964             Deinococci  <NA>       T              5     4     0
## 965    Deltaproteobacteria  <NA>       T              5     4     0
## 966  Epsilonproteobacteria  <NA>       T              5     4     0
## 967        Erysipelotrichi  <NA>       T              5     4    14
## 968          Fibrobacteria  <NA>       T              5     4     0
## 969          Flavobacteria  <NA>       T              5     4     0
## 970           Fusobacteria  <NA>       T              5     4     0
## 971    Gammaproteobacteria  <NA>       T              5     4    12
## 972       Gemmatimonadetes  <NA>       T              5     4     0
## 973             Holophagae  <NA>       T              5     4     0
## 974          Lentisphaeria  <NA>       T              5     4     0
## 975        Methanobacteria  <NA>       T              5     4     0
## 976        Methanomicrobia  <NA>       T              5     4     0
## 977             Mollicutes  <NA>       T              5     4     0
## 978             Nitrospira  <NA>       T              5     4     0
## 979               Opitutae  <NA>       T              5     4     0
## 980       Planctomycetacia  <NA>       T              5     4     0
## 981        Sphingobacteria  <NA>       T              5     4     0
## 982           Spirochaetes  <NA>       T              5     4    11
## 983           Subdivision3  <NA>       T              5     4     0
## 984            Synergistia  <NA>       T              5     4    20
## 985         Thermomicrobia  <NA>       T              5     4     1
## 986         Thermoplasmata  <NA>       T              5     4     0
## 987            Thermotogae  <NA>       T              5     4     0
## 988                Unknown  <NA>       T              5     4   131
## 989          Acidobacteria     1       T              5     5     0
## 990          Acidobacteria    10       T              5     5     0
## 991          Acidobacteria    14       T              5     5     0
## 992          Acidobacteria    16       T              5     5     0
## 993          Acidobacteria    17       T              5     5     0
## 994          Acidobacteria    18       T              5     5     0
## 995          Acidobacteria    21       T              5     5     0
## 996          Acidobacteria    22       T              5     5     0
## 997          Acidobacteria     3       T              5     5     0
## 998          Acidobacteria     4       T              5     5     0
## 999          Acidobacteria     5       T              5     5     0
## 1000         Acidobacteria     6       T              5     5     0
## 1001         Acidobacteria     7       T              5     5     0
## 1002         Acidobacteria     9       T              5     5     0
## 1003        Actinobacteria  <NA>       T              5     5     6
## 1004   Alphaproteobacteria  <NA>       T              5     5     1
## 1005          Anaerolineae  <NA>       T              5     5     0
## 1006               Bacilli  <NA>       T              5     5    36
## 1007           Bacteroidia  <NA>       T              5     5    41
## 1008    Betaproteobacteria  <NA>       T              5     5    18
## 1009           Caldilineae  <NA>       T              5     5     0
## 1010            Chlamydiae  <NA>       T              5     5     0
## 1011           Chloroflexi  <NA>       T              5     5     0
## 1012        Chrysiogenetes  <NA>       T              5     5     0
## 1013            Clostridia  <NA>       T              5     5   311
## 1014         Cyanobacteria  <NA>       T              5     5     0
## 1015     Dehalococcoidetes  <NA>       T              5     5     0
## 1016            Deinococci  <NA>       T              5     5     0
## 1017   Deltaproteobacteria  <NA>       T              5     5     0
## 1018 Epsilonproteobacteria  <NA>       T              5     5     0
## 1019       Erysipelotrichi  <NA>       T              5     5     5
## 1020         Fibrobacteria  <NA>       T              5     5     0
## 1021         Flavobacteria  <NA>       T              5     5     0
## 1022          Fusobacteria  <NA>       T              5     5     0
## 1023   Gammaproteobacteria  <NA>       T              5     5     2
## 1024      Gemmatimonadetes  <NA>       T              5     5     0
## 1025            Holophagae  <NA>       T              5     5     0
## 1026         Lentisphaeria  <NA>       T              5     5     0
## 1027       Methanobacteria  <NA>       T              5     5     0
## 1028       Methanomicrobia  <NA>       T              5     5     0
## 1029            Mollicutes  <NA>       T              5     5     0
## 1030            Nitrospira  <NA>       T              5     5     0
## 1031              Opitutae  <NA>       T              5     5     0
## 1032      Planctomycetacia  <NA>       T              5     5     0
## 1033       Sphingobacteria  <NA>       T              5     5     0
## 1034          Spirochaetes  <NA>       T              5     5     4
## 1035          Subdivision3  <NA>       T              5     5     0
## 1036           Synergistia  <NA>       T              5     5     8
## 1037        Thermomicrobia  <NA>       T              5     5     0
## 1038        Thermoplasmata  <NA>       T              5     5     0
## 1039           Thermotogae  <NA>       T              5     5     0
## 1040               Unknown  <NA>       T              5     5    94
## 1041         Acidobacteria     1       T              6     2     0
## 1042         Acidobacteria    10       T              6     2     0
## 1043         Acidobacteria    14       T              6     2     0
## 1044         Acidobacteria    16       T              6     2     0
## 1045         Acidobacteria    17       T              6     2     0
## 1046         Acidobacteria    18       T              6     2     0
## 1047         Acidobacteria    21       T              6     2     0
## 1048         Acidobacteria    22       T              6     2     0
## 1049         Acidobacteria     3       T              6     2     0
## 1050         Acidobacteria     4       T              6     2     0
## 1051         Acidobacteria     5       T              6     2     0
## 1052         Acidobacteria     6       T              6     2     0
## 1053         Acidobacteria     7       T              6     2     0
## 1054         Acidobacteria     9       T              6     2     0
## 1055        Actinobacteria  <NA>       T              6     2     2
## 1056   Alphaproteobacteria  <NA>       T              6     2     1
## 1057          Anaerolineae  <NA>       T              6     2     0
## 1058               Bacilli  <NA>       T              6     2     1
## 1059           Bacteroidia  <NA>       T              6     2     1
## 1060    Betaproteobacteria  <NA>       T              6     2     0
## 1061           Caldilineae  <NA>       T              6     2     0
## 1062            Chlamydiae  <NA>       T              6     2     0
## 1063           Chloroflexi  <NA>       T              6     2     0
## 1064        Chrysiogenetes  <NA>       T              6     2     0
## 1065            Clostridia  <NA>       T              6     2   106
## 1066         Cyanobacteria  <NA>       T              6     2     0
## 1067     Dehalococcoidetes  <NA>       T              6     2     0
## 1068            Deinococci  <NA>       T              6     2     0
## 1069   Deltaproteobacteria  <NA>       T              6     2     0
## 1070 Epsilonproteobacteria  <NA>       T              6     2     0
## 1071       Erysipelotrichi  <NA>       T              6     2     0
## 1072         Fibrobacteria  <NA>       T              6     2     0
## 1073         Flavobacteria  <NA>       T              6     2     1
## 1074          Fusobacteria  <NA>       T              6     2     0
## 1075   Gammaproteobacteria  <NA>       T              6     2     0
## 1076      Gemmatimonadetes  <NA>       T              6     2     0
## 1077            Holophagae  <NA>       T              6     2     0
## 1078         Lentisphaeria  <NA>       T              6     2     0
## 1079       Methanobacteria  <NA>       T              6     2     0
## 1080       Methanomicrobia  <NA>       T              6     2     0
## 1081            Mollicutes  <NA>       T              6     2     0
## 1082            Nitrospira  <NA>       T              6     2     0
## 1083              Opitutae  <NA>       T              6     2     0
## 1084      Planctomycetacia  <NA>       T              6     2     0
## 1085       Sphingobacteria  <NA>       T              6     2     0
## 1086          Spirochaetes  <NA>       T              6     2     1
## 1087          Subdivision3  <NA>       T              6     2     0
## 1088           Synergistia  <NA>       T              6     2     1
## 1089        Thermomicrobia  <NA>       T              6     2     0
## 1090        Thermoplasmata  <NA>       T              6     2     0
## 1091           Thermotogae  <NA>       T              6     2     0
## 1092               Unknown  <NA>       T              6     2    13
## 1093         Acidobacteria     1       T              6     5     0
## 1094         Acidobacteria    10       T              6     5     0
## 1095         Acidobacteria    14       T              6     5     0
## 1096         Acidobacteria    16       T              6     5     0
## 1097         Acidobacteria    17       T              6     5     0
## 1098         Acidobacteria    18       T              6     5     0
## 1099         Acidobacteria    21       T              6     5     0
## 1100         Acidobacteria    22       T              6     5     0
## 1101         Acidobacteria     3       T              6     5     0
## 1102         Acidobacteria     4       T              6     5     0
## 1103         Acidobacteria     5       T              6     5     0
## 1104         Acidobacteria     6       T              6     5     0
## 1105         Acidobacteria     7       T              6     5     0
## 1106         Acidobacteria     9       T              6     5     0
## 1107        Actinobacteria  <NA>       T              6     5     3
## 1108   Alphaproteobacteria  <NA>       T              6     5     1
## 1109          Anaerolineae  <NA>       T              6     5     2
## 1110               Bacilli  <NA>       T              6     5    30
## 1111           Bacteroidia  <NA>       T              6     5     3
## 1112    Betaproteobacteria  <NA>       T              6     5     6
## 1113           Caldilineae  <NA>       T              6     5     0
## 1114            Chlamydiae  <NA>       T              6     5     0
## 1115           Chloroflexi  <NA>       T              6     5     0
## 1116        Chrysiogenetes  <NA>       T              6     5     0
## 1117            Clostridia  <NA>       T              6     5   496
## 1118         Cyanobacteria  <NA>       T              6     5     0
## 1119     Dehalococcoidetes  <NA>       T              6     5     0
## 1120            Deinococci  <NA>       T              6     5     1
## 1121   Deltaproteobacteria  <NA>       T              6     5     2
## 1122 Epsilonproteobacteria  <NA>       T              6     5     0
## 1123       Erysipelotrichi  <NA>       T              6     5     7
## 1124         Fibrobacteria  <NA>       T              6     5     0
## 1125         Flavobacteria  <NA>       T              6     5     1
## 1126          Fusobacteria  <NA>       T              6     5     0
## 1127   Gammaproteobacteria  <NA>       T              6     5     0
## 1128      Gemmatimonadetes  <NA>       T              6     5     0
## 1129            Holophagae  <NA>       T              6     5     0
## 1130         Lentisphaeria  <NA>       T              6     5     0
## 1131       Methanobacteria  <NA>       T              6     5     0
## 1132       Methanomicrobia  <NA>       T              6     5     0
## 1133            Mollicutes  <NA>       T              6     5     1
## 1134            Nitrospira  <NA>       T              6     5     0
## 1135              Opitutae  <NA>       T              6     5     0
## 1136      Planctomycetacia  <NA>       T              6     5     0
## 1137       Sphingobacteria  <NA>       T              6     5     1
## 1138          Spirochaetes  <NA>       T              6     5     2
## 1139          Subdivision3  <NA>       T              6     5     0
## 1140           Synergistia  <NA>       T              6     5    47
## 1141        Thermomicrobia  <NA>       T              6     5     0
## 1142        Thermoplasmata  <NA>       T              6     5     0
## 1143           Thermotogae  <NA>       T              6     5     0
## 1144               Unknown  <NA>       T              6     5   128
## 1145         Acidobacteria     1       T              6     7     0
## 1146         Acidobacteria    10       T              6     7     0
## 1147         Acidobacteria    14       T              6     7     0
## 1148         Acidobacteria    16       T              6     7     0
## 1149         Acidobacteria    17       T              6     7     0
## 1150         Acidobacteria    18       T              6     7     1
## 1151         Acidobacteria    21       T              6     7     0
## 1152         Acidobacteria    22       T              6     7     0
## 1153         Acidobacteria     3       T              6     7     1
## 1154         Acidobacteria     4       T              6     7     1
## 1155         Acidobacteria     5       T              6     7     0
## 1156         Acidobacteria     6       T              6     7     0
## 1157         Acidobacteria     7       T              6     7     0
## 1158         Acidobacteria     9       T              6     7     0
## 1159        Actinobacteria  <NA>       T              6     7   160
## 1160   Alphaproteobacteria  <NA>       T              6     7    21
## 1161          Anaerolineae  <NA>       T              6     7     7
## 1162               Bacilli  <NA>       T              6     7    13
## 1163           Bacteroidia  <NA>       T              6     7   274
## 1164    Betaproteobacteria  <NA>       T              6     7    99
## 1165           Caldilineae  <NA>       T              6     7     2
## 1166            Chlamydiae  <NA>       T              6     7     0
## 1167           Chloroflexi  <NA>       T              6     7     0
## 1168        Chrysiogenetes  <NA>       T              6     7     0
## 1169            Clostridia  <NA>       T              6     7  3841
## 1170         Cyanobacteria  <NA>       T              6     7     0
## 1171     Dehalococcoidetes  <NA>       T              6     7     0
## 1172            Deinococci  <NA>       T              6     7    24
## 1173   Deltaproteobacteria  <NA>       T              6     7     6
## 1174 Epsilonproteobacteria  <NA>       T              6     7     0
## 1175       Erysipelotrichi  <NA>       T              6     7    97
## 1176         Fibrobacteria  <NA>       T              6     7     2
## 1177         Flavobacteria  <NA>       T              6     7     2
## 1178          Fusobacteria  <NA>       T              6     7     0
## 1179   Gammaproteobacteria  <NA>       T              6     7    27
## 1180      Gemmatimonadetes  <NA>       T              6     7     0
## 1181            Holophagae  <NA>       T              6     7     0
## 1182         Lentisphaeria  <NA>       T              6     7     0
## 1183       Methanobacteria  <NA>       T              6     7     0
## 1184       Methanomicrobia  <NA>       T              6     7     1
## 1185            Mollicutes  <NA>       T              6     7     2
## 1186            Nitrospira  <NA>       T              6     7     0
## 1187              Opitutae  <NA>       T              6     7     0
## 1188      Planctomycetacia  <NA>       T              6     7     0
## 1189       Sphingobacteria  <NA>       T              6     7     1
## 1190          Spirochaetes  <NA>       T              6     7    32
## 1191          Subdivision3  <NA>       T              6     7     0
## 1192           Synergistia  <NA>       T              6     7    80
## 1193        Thermomicrobia  <NA>       T              6     7     0
## 1194        Thermoplasmata  <NA>       T              6     7     0
## 1195           Thermotogae  <NA>       T              6     7     0
## 1196               Unknown  <NA>       T              6     7   602
## 1197         Acidobacteria     1       T              6     8     0
## 1198         Acidobacteria    10       T              6     8     0
## 1199         Acidobacteria    14       T              6     8     0
## 1200         Acidobacteria    16       T              6     8     0
## 1201         Acidobacteria    17       T              6     8     0
## 1202         Acidobacteria    18       T              6     8     0
## 1203         Acidobacteria    21       T              6     8     0
## 1204         Acidobacteria    22       T              6     8     0
## 1205         Acidobacteria     3       T              6     8     0
## 1206         Acidobacteria     4       T              6     8     1
## 1207         Acidobacteria     5       T              6     8     0
## 1208         Acidobacteria     6       T              6     8     0
## 1209         Acidobacteria     7       T              6     8     0
## 1210         Acidobacteria     9       T              6     8     0
## 1211        Actinobacteria  <NA>       T              6     8   193
## 1212   Alphaproteobacteria  <NA>       T              6     8   108
## 1213          Anaerolineae  <NA>       T              6     8     5
## 1214               Bacilli  <NA>       T              6     8    32
## 1215           Bacteroidia  <NA>       T              6     8    81
## 1216    Betaproteobacteria  <NA>       T              6     8  3055
## 1217           Caldilineae  <NA>       T              6     8     0
## 1218            Chlamydiae  <NA>       T              6     8     0
## 1219           Chloroflexi  <NA>       T              6     8     0
## 1220        Chrysiogenetes  <NA>       T              6     8     1
## 1221            Clostridia  <NA>       T              6     8  1264
## 1222         Cyanobacteria  <NA>       T              6     8     0
## 1223     Dehalococcoidetes  <NA>       T              6     8     0
## 1224            Deinococci  <NA>       T              6     8    86
## 1225   Deltaproteobacteria  <NA>       T              6     8     7
## 1226 Epsilonproteobacteria  <NA>       T              6     8     0
## 1227       Erysipelotrichi  <NA>       T              6     8    92
## 1228         Fibrobacteria  <NA>       T              6     8     0
## 1229         Flavobacteria  <NA>       T              6     8     1
## 1230          Fusobacteria  <NA>       T              6     8     0
## 1231   Gammaproteobacteria  <NA>       T              6     8    20
## 1232      Gemmatimonadetes  <NA>       T              6     8     0
## 1233            Holophagae  <NA>       T              6     8     0
## 1234         Lentisphaeria  <NA>       T              6     8     0
## 1235       Methanobacteria  <NA>       T              6     8     0
## 1236       Methanomicrobia  <NA>       T              6     8     0
## 1237            Mollicutes  <NA>       T              6     8     0
## 1238            Nitrospira  <NA>       T              6     8     0
## 1239              Opitutae  <NA>       T              6     8     0
## 1240      Planctomycetacia  <NA>       T              6     8     1
## 1241       Sphingobacteria  <NA>       T              6     8     5
## 1242          Spirochaetes  <NA>       T              6     8    13
## 1243          Subdivision3  <NA>       T              6     8     0
## 1244           Synergistia  <NA>       T              6     8    37
## 1245        Thermomicrobia  <NA>       T              6     8     6
## 1246        Thermoplasmata  <NA>       T              6     8     0
## 1247           Thermotogae  <NA>       T              6     8     0
## 1248               Unknown  <NA>       T              6     8   560
## 1249         Acidobacteria     1       T              9     1     0
## 1250         Acidobacteria    10       T              9     1     0
## 1251         Acidobacteria    14       T              9     1     0
## 1252         Acidobacteria    16       T              9     1     0
## 1253         Acidobacteria    17       T              9     1     0
## 1254         Acidobacteria    18       T              9     1     0
## 1255         Acidobacteria    21       T              9     1     0
## 1256         Acidobacteria    22       T              9     1     0
## 1257         Acidobacteria     3       T              9     1     0
## 1258         Acidobacteria     4       T              9     1     0
## 1259         Acidobacteria     5       T              9     1     0
## 1260         Acidobacteria     6       T              9     1     0
## 1261         Acidobacteria     7       T              9     1     0
## 1262         Acidobacteria     9       T              9     1     0
## 1263        Actinobacteria  <NA>       T              9     1     0
## 1264   Alphaproteobacteria  <NA>       T              9     1     0
## 1265          Anaerolineae  <NA>       T              9     1     0
## 1266               Bacilli  <NA>       T              9     1     0
## 1267           Bacteroidia  <NA>       T              9     1     0
## 1268    Betaproteobacteria  <NA>       T              9     1   827
## 1269           Caldilineae  <NA>       T              9     1     0
## 1270            Chlamydiae  <NA>       T              9     1     0
## 1271           Chloroflexi  <NA>       T              9     1     0
## 1272        Chrysiogenetes  <NA>       T              9     1     0
## 1273            Clostridia  <NA>       T              9     1     0
## 1274         Cyanobacteria  <NA>       T              9     1     0
## 1275     Dehalococcoidetes  <NA>       T              9     1     0
## 1276            Deinococci  <NA>       T              9     1     0
## 1277   Deltaproteobacteria  <NA>       T              9     1     0
## 1278 Epsilonproteobacteria  <NA>       T              9     1     0
## 1279       Erysipelotrichi  <NA>       T              9     1     0
## 1280         Fibrobacteria  <NA>       T              9     1     0
## 1281         Flavobacteria  <NA>       T              9     1     0
## 1282          Fusobacteria  <NA>       T              9     1     0
## 1283   Gammaproteobacteria  <NA>       T              9     1     9
## 1284      Gemmatimonadetes  <NA>       T              9     1     0
## 1285            Holophagae  <NA>       T              9     1     0
## 1286         Lentisphaeria  <NA>       T              9     1     0
## 1287       Methanobacteria  <NA>       T              9     1     0
## 1288       Methanomicrobia  <NA>       T              9     1     0
## 1289            Mollicutes  <NA>       T              9     1     0
## 1290            Nitrospira  <NA>       T              9     1     0
## 1291              Opitutae  <NA>       T              9     1     0
## 1292      Planctomycetacia  <NA>       T              9     1     0
## 1293       Sphingobacteria  <NA>       T              9     1     0
## 1294          Spirochaetes  <NA>       T              9     1     0
## 1295          Subdivision3  <NA>       T              9     1     0
## 1296           Synergistia  <NA>       T              9     1     0
## 1297        Thermomicrobia  <NA>       T              9     1     0
## 1298        Thermoplasmata  <NA>       T              9     1     0
## 1299           Thermotogae  <NA>       T              9     1     0
## 1300               Unknown  <NA>       T              9     1     0
## 1301         Acidobacteria     1       T              9     2     0
## 1302         Acidobacteria    10       T              9     2     0
## 1303         Acidobacteria    14       T              9     2     0
## 1304         Acidobacteria    16       T              9     2     0
## 1305         Acidobacteria    17       T              9     2     0
## 1306         Acidobacteria    18       T              9     2     0
## 1307         Acidobacteria    21       T              9     2     0
## 1308         Acidobacteria    22       T              9     2     0
## 1309         Acidobacteria     3       T              9     2     0
## 1310         Acidobacteria     4       T              9     2     0
## 1311         Acidobacteria     5       T              9     2     0
## 1312         Acidobacteria     6       T              9     2     0
## 1313         Acidobacteria     7       T              9     2     0
## 1314         Acidobacteria     9       T              9     2     0
## 1315        Actinobacteria  <NA>       T              9     2     2
## 1316   Alphaproteobacteria  <NA>       T              9     2     4
## 1317          Anaerolineae  <NA>       T              9     2     0
## 1318               Bacilli  <NA>       T              9     2    50
## 1319           Bacteroidia  <NA>       T              9     2   317
## 1320    Betaproteobacteria  <NA>       T              9     2     6
## 1321           Caldilineae  <NA>       T              9     2     0
## 1322            Chlamydiae  <NA>       T              9     2     0
## 1323           Chloroflexi  <NA>       T              9     2     0
## 1324        Chrysiogenetes  <NA>       T              9     2     0
## 1325            Clostridia  <NA>       T              9     2   740
## 1326         Cyanobacteria  <NA>       T              9     2     0
## 1327     Dehalococcoidetes  <NA>       T              9     2     0
## 1328            Deinococci  <NA>       T              9     2     1
## 1329   Deltaproteobacteria  <NA>       T              9     2     1
## 1330 Epsilonproteobacteria  <NA>       T              9     2     0
## 1331       Erysipelotrichi  <NA>       T              9     2    19
## 1332         Fibrobacteria  <NA>       T              9     2     5
## 1333         Flavobacteria  <NA>       T              9     2     2
## 1334          Fusobacteria  <NA>       T              9     2     0
## 1335   Gammaproteobacteria  <NA>       T              9     2    24
## 1336      Gemmatimonadetes  <NA>       T              9     2     0
## 1337            Holophagae  <NA>       T              9     2     0
## 1338         Lentisphaeria  <NA>       T              9     2     0
## 1339       Methanobacteria  <NA>       T              9     2     0
## 1340       Methanomicrobia  <NA>       T              9     2     0
## 1341            Mollicutes  <NA>       T              9     2    58
## 1342            Nitrospira  <NA>       T              9     2     0
## 1343              Opitutae  <NA>       T              9     2     0
## 1344      Planctomycetacia  <NA>       T              9     2     0
## 1345       Sphingobacteria  <NA>       T              9     2     0
## 1346          Spirochaetes  <NA>       T              9     2    21
## 1347          Subdivision3  <NA>       T              9     2     0
## 1348           Synergistia  <NA>       T              9     2     7
## 1349        Thermomicrobia  <NA>       T              9     2     0
## 1350        Thermoplasmata  <NA>       T              9     2     0
## 1351           Thermotogae  <NA>       T              9     2     0
## 1352               Unknown  <NA>       T              9     2 10624
## 1353         Acidobacteria     1       T              9     3     0
## 1354         Acidobacteria    10       T              9     3     0
## 1355         Acidobacteria    14       T              9     3     0
## 1356         Acidobacteria    16       T              9     3     0
## 1357         Acidobacteria    17       T              9     3     0
## 1358         Acidobacteria    18       T              9     3     0
## 1359         Acidobacteria    21       T              9     3     0
## 1360         Acidobacteria    22       T              9     3     0
## 1361         Acidobacteria     3       T              9     3     0
## 1362         Acidobacteria     4       T              9     3     0
## 1363         Acidobacteria     5       T              9     3     0
## 1364         Acidobacteria     6       T              9     3     0
## 1365         Acidobacteria     7       T              9     3     0
## 1366         Acidobacteria     9       T              9     3     0
## 1367        Actinobacteria  <NA>       T              9     3     2
## 1368   Alphaproteobacteria  <NA>       T              9     3    13
## 1369          Anaerolineae  <NA>       T              9     3     0
## 1370               Bacilli  <NA>       T              9     3    58
## 1371           Bacteroidia  <NA>       T              9     3    26
## 1372    Betaproteobacteria  <NA>       T              9     3  1763
## 1373           Caldilineae  <NA>       T              9     3     0
## 1374            Chlamydiae  <NA>       T              9     3     0
## 1375           Chloroflexi  <NA>       T              9     3     0
## 1376        Chrysiogenetes  <NA>       T              9     3     0
## 1377            Clostridia  <NA>       T              9     3    33
## 1378         Cyanobacteria  <NA>       T              9     3     0
## 1379     Dehalococcoidetes  <NA>       T              9     3     0
## 1380            Deinococci  <NA>       T              9     3     0
## 1381   Deltaproteobacteria  <NA>       T              9     3     0
## 1382 Epsilonproteobacteria  <NA>       T              9     3     0
## 1383       Erysipelotrichi  <NA>       T              9     3     0
## 1384         Fibrobacteria  <NA>       T              9     3     0
## 1385         Flavobacteria  <NA>       T              9     3     1
## 1386          Fusobacteria  <NA>       T              9     3     0
## 1387   Gammaproteobacteria  <NA>       T              9     3    20
## 1388      Gemmatimonadetes  <NA>       T              9     3     0
## 1389            Holophagae  <NA>       T              9     3     0
## 1390         Lentisphaeria  <NA>       T              9     3     0
## 1391       Methanobacteria  <NA>       T              9     3     0
## 1392       Methanomicrobia  <NA>       T              9     3     0
## 1393            Mollicutes  <NA>       T              9     3     1
## 1394            Nitrospira  <NA>       T              9     3     0
## 1395              Opitutae  <NA>       T              9     3     0
## 1396      Planctomycetacia  <NA>       T              9     3     0
## 1397       Sphingobacteria  <NA>       T              9     3     1
## 1398          Spirochaetes  <NA>       T              9     3     2
## 1399          Subdivision3  <NA>       T              9     3     0
## 1400           Synergistia  <NA>       T              9     3     3
## 1401        Thermomicrobia  <NA>       T              9     3     0
## 1402        Thermoplasmata  <NA>       T              9     3     0
## 1403           Thermotogae  <NA>       T              9     3     0
## 1404               Unknown  <NA>       T              9     3    75
## 1405         Acidobacteria     1       T              9     4     0
## 1406         Acidobacteria    10       T              9     4     0
## 1407         Acidobacteria    14       T              9     4     0
## 1408         Acidobacteria    16       T              9     4     0
## 1409         Acidobacteria    17       T              9     4     0
## 1410         Acidobacteria    18       T              9     4     0
## 1411         Acidobacteria    21       T              9     4     0
## 1412         Acidobacteria    22       T              9     4     0
## 1413         Acidobacteria     3       T              9     4     0
## 1414         Acidobacteria     4       T              9     4     0
## 1415         Acidobacteria     5       T              9     4     0
## 1416         Acidobacteria     6       T              9     4     0
## 1417         Acidobacteria     7       T              9     4     0
## 1418         Acidobacteria     9       T              9     4     0
## 1419        Actinobacteria  <NA>       T              9     4     6
## 1420   Alphaproteobacteria  <NA>       T              9     4    11
## 1421          Anaerolineae  <NA>       T              9     4     0
## 1422               Bacilli  <NA>       T              9     4    10
## 1423           Bacteroidia  <NA>       T              9     4   830
## 1424    Betaproteobacteria  <NA>       T              9     4     5
## 1425           Caldilineae  <NA>       T              9     4     0
## 1426            Chlamydiae  <NA>       T              9     4     0
## 1427           Chloroflexi  <NA>       T              9     4     0
## 1428        Chrysiogenetes  <NA>       T              9     4     0
## 1429            Clostridia  <NA>       T              9     4  1085
## 1430         Cyanobacteria  <NA>       T              9     4     0
## 1431     Dehalococcoidetes  <NA>       T              9     4     0
## 1432            Deinococci  <NA>       T              9     4     1
## 1433   Deltaproteobacteria  <NA>       T              9     4     1
## 1434 Epsilonproteobacteria  <NA>       T              9     4     4
## 1435       Erysipelotrichi  <NA>       T              9     4    23
## 1436         Fibrobacteria  <NA>       T              9     4     7
## 1437         Flavobacteria  <NA>       T              9     4     3
## 1438          Fusobacteria  <NA>       T              9     4     2
## 1439   Gammaproteobacteria  <NA>       T              9     4   353
## 1440      Gemmatimonadetes  <NA>       T              9     4     0
## 1441            Holophagae  <NA>       T              9     4     0
## 1442         Lentisphaeria  <NA>       T              9     4     0
## 1443       Methanobacteria  <NA>       T              9     4     0
## 1444       Methanomicrobia  <NA>       T              9     4     0
## 1445            Mollicutes  <NA>       T              9     4    55
## 1446            Nitrospira  <NA>       T              9     4     0
## 1447              Opitutae  <NA>       T              9     4     0
## 1448      Planctomycetacia  <NA>       T              9     4     0
## 1449       Sphingobacteria  <NA>       T              9     4     0
## 1450          Spirochaetes  <NA>       T              9     4    44
## 1451          Subdivision3  <NA>       T              9     4     0
## 1452           Synergistia  <NA>       T              9     4    16
## 1453        Thermomicrobia  <NA>       T              9     4     0
## 1454        Thermoplasmata  <NA>       T              9     4     0
## 1455           Thermotogae  <NA>       T              9     4     0
## 1456               Unknown  <NA>       T              9     4  2808
## 1457         Acidobacteria     1       T              9     5     0
## 1458         Acidobacteria    10       T              9     5     0
## 1459         Acidobacteria    14       T              9     5     0
## 1460         Acidobacteria    16       T              9     5     0
## 1461         Acidobacteria    17       T              9     5     0
## 1462         Acidobacteria    18       T              9     5     0
## 1463         Acidobacteria    21       T              9     5     0
## 1464         Acidobacteria    22       T              9     5     0
## 1465         Acidobacteria     3       T              9     5     0
## 1466         Acidobacteria     4       T              9     5     0
## 1467         Acidobacteria     5       T              9     5     0
## 1468         Acidobacteria     6       T              9     5     0
## 1469         Acidobacteria     7       T              9     5     0
## 1470         Acidobacteria     9       T              9     5     0
## 1471        Actinobacteria  <NA>       T              9     5     4
## 1472   Alphaproteobacteria  <NA>       T              9     5     3
## 1473          Anaerolineae  <NA>       T              9     5     0
## 1474               Bacilli  <NA>       T              9     5    56
## 1475           Bacteroidia  <NA>       T              9     5   504
## 1476    Betaproteobacteria  <NA>       T              9     5   144
## 1477           Caldilineae  <NA>       T              9     5     0
## 1478            Chlamydiae  <NA>       T              9     5     0
## 1479           Chloroflexi  <NA>       T              9     5     0
## 1480        Chrysiogenetes  <NA>       T              9     5     0
## 1481            Clostridia  <NA>       T              9     5  1064
## 1482         Cyanobacteria  <NA>       T              9     5    35
## 1483     Dehalococcoidetes  <NA>       T              9     5     1
## 1484            Deinococci  <NA>       T              9     5     2
## 1485   Deltaproteobacteria  <NA>       T              9     5     1
## 1486 Epsilonproteobacteria  <NA>       T              9     5     0
## 1487       Erysipelotrichi  <NA>       T              9     5    28
## 1488         Fibrobacteria  <NA>       T              9     5     2
## 1489         Flavobacteria  <NA>       T              9     5     5
## 1490          Fusobacteria  <NA>       T              9     5     0
## 1491   Gammaproteobacteria  <NA>       T              9     5    26
## 1492      Gemmatimonadetes  <NA>       T              9     5     0
## 1493            Holophagae  <NA>       T              9     5     0
## 1494         Lentisphaeria  <NA>       T              9     5     0
## 1495       Methanobacteria  <NA>       T              9     5     0
## 1496       Methanomicrobia  <NA>       T              9     5     0
## 1497            Mollicutes  <NA>       T              9     5    16
## 1498            Nitrospira  <NA>       T              9     5     0
## 1499              Opitutae  <NA>       T              9     5     0
## 1500      Planctomycetacia  <NA>       T              9     5     0
## 1501       Sphingobacteria  <NA>       T              9     5     0
## 1502          Spirochaetes  <NA>       T              9     5    26
## 1503          Subdivision3  <NA>       T              9     5     0
## 1504           Synergistia  <NA>       T              9     5    32
## 1505        Thermomicrobia  <NA>       T              9     5     0
## 1506        Thermoplasmata  <NA>       T              9     5     0
## 1507           Thermotogae  <NA>       T              9     5     0
## 1508               Unknown  <NA>       T              9     5  2817
## 1509         Acidobacteria     1       V              1     2     0
## 1510         Acidobacteria    10       V              1     2     0
## 1511         Acidobacteria    14       V              1     2     0
## 1512         Acidobacteria    16       V              1     2     0
## 1513         Acidobacteria    17       V              1     2     0
## 1514         Acidobacteria    18       V              1     2     0
## 1515         Acidobacteria    21       V              1     2     0
## 1516         Acidobacteria    22       V              1     2     0
## 1517         Acidobacteria     3       V              1     2     0
## 1518         Acidobacteria     4       V              1     2     0
## 1519         Acidobacteria     5       V              1     2     0
## 1520         Acidobacteria     6       V              1     2     0
## 1521         Acidobacteria     7       V              1     2     0
## 1522         Acidobacteria     9       V              1     2     0
## 1523        Actinobacteria  <NA>       V              1     2   182
## 1524   Alphaproteobacteria  <NA>       V              1     2    87
## 1525          Anaerolineae  <NA>       V              1     2     0
## 1526               Bacilli  <NA>       V              1     2   387
## 1527           Bacteroidia  <NA>       V              1     2   347
## 1528    Betaproteobacteria  <NA>       V              1     2    44
## 1529           Caldilineae  <NA>       V              1     2     0
## 1530            Chlamydiae  <NA>       V              1     2     0
## 1531           Chloroflexi  <NA>       V              1     2     0
## 1532        Chrysiogenetes  <NA>       V              1     2     0
## 1533            Clostridia  <NA>       V              1     2  3947
## 1534         Cyanobacteria  <NA>       V              1     2     0
## 1535     Dehalococcoidetes  <NA>       V              1     2     0
## 1536            Deinococci  <NA>       V              1     2     2
## 1537   Deltaproteobacteria  <NA>       V              1     2     0
## 1538 Epsilonproteobacteria  <NA>       V              1     2     0
## 1539       Erysipelotrichi  <NA>       V              1     2   242
## 1540         Fibrobacteria  <NA>       V              1     2     0
## 1541         Flavobacteria  <NA>       V              1     2   317
## 1542          Fusobacteria  <NA>       V              1     2    19
## 1543   Gammaproteobacteria  <NA>       V              1     2   472
## 1544      Gemmatimonadetes  <NA>       V              1     2     0
## 1545            Holophagae  <NA>       V              1     2     0
## 1546         Lentisphaeria  <NA>       V              1     2     0
## 1547       Methanobacteria  <NA>       V              1     2     0
## 1548       Methanomicrobia  <NA>       V              1     2     0
## 1549            Mollicutes  <NA>       V              1     2     3
## 1550            Nitrospira  <NA>       V              1     2     0
## 1551              Opitutae  <NA>       V              1     2     0
## 1552      Planctomycetacia  <NA>       V              1     2     0
## 1553       Sphingobacteria  <NA>       V              1     2    92
## 1554          Spirochaetes  <NA>       V              1     2     0
## 1555          Subdivision3  <NA>       V              1     2     0
## 1556           Synergistia  <NA>       V              1     2     0
## 1557        Thermomicrobia  <NA>       V              1     2     0
## 1558        Thermoplasmata  <NA>       V              1     2     0
## 1559           Thermotogae  <NA>       V              1     2     0
## 1560               Unknown  <NA>       V              1     2    89
## 1561         Acidobacteria     1       V             10     1     0
## 1562         Acidobacteria    10       V             10     1     0
## 1563         Acidobacteria    14       V             10     1     0
## 1564         Acidobacteria    16       V             10     1     0
## 1565         Acidobacteria    17       V             10     1     0
## 1566         Acidobacteria    18       V             10     1     0
## 1567         Acidobacteria    21       V             10     1     0
## 1568         Acidobacteria    22       V             10     1     0
## 1569         Acidobacteria     3       V             10     1     0
## 1570         Acidobacteria     4       V             10     1     0
## 1571         Acidobacteria     5       V             10     1     0
## 1572         Acidobacteria     6       V             10     1     0
## 1573         Acidobacteria     7       V             10     1     0
## 1574         Acidobacteria     9       V             10     1     0
## 1575        Actinobacteria  <NA>       V             10     1    94
## 1576   Alphaproteobacteria  <NA>       V             10     1    12
## 1577          Anaerolineae  <NA>       V             10     1     0
## 1578               Bacilli  <NA>       V             10     1   194
## 1579           Bacteroidia  <NA>       V             10     1  4221
## 1580    Betaproteobacteria  <NA>       V             10     1   133
## 1581           Caldilineae  <NA>       V             10     1     0
## 1582            Chlamydiae  <NA>       V             10     1     0
## 1583           Chloroflexi  <NA>       V             10     1     0
## 1584        Chrysiogenetes  <NA>       V             10     1     0
## 1585            Clostridia  <NA>       V             10     1 11180
## 1586         Cyanobacteria  <NA>       V             10     1     0
## 1587     Dehalococcoidetes  <NA>       V             10     1     0
## 1588            Deinococci  <NA>       V             10     1     7
## 1589   Deltaproteobacteria  <NA>       V             10     1     6
## 1590 Epsilonproteobacteria  <NA>       V             10     1     0
## 1591       Erysipelotrichi  <NA>       V             10     1   205
## 1592         Fibrobacteria  <NA>       V             10     1     0
## 1593         Flavobacteria  <NA>       V             10     1   195
## 1594          Fusobacteria  <NA>       V             10     1    92
## 1595   Gammaproteobacteria  <NA>       V             10     1   516
## 1596      Gemmatimonadetes  <NA>       V             10     1     0
## 1597            Holophagae  <NA>       V             10     1     0
## 1598         Lentisphaeria  <NA>       V             10     1     1
## 1599       Methanobacteria  <NA>       V             10     1     0
## 1600       Methanomicrobia  <NA>       V             10     1     0
## 1601            Mollicutes  <NA>       V             10     1    42
## 1602            Nitrospira  <NA>       V             10     1     0
## 1603              Opitutae  <NA>       V             10     1     1
## 1604      Planctomycetacia  <NA>       V             10     1     0
## 1605       Sphingobacteria  <NA>       V             10     1    34
## 1606          Spirochaetes  <NA>       V             10     1     0
## 1607          Subdivision3  <NA>       V             10     1     0
## 1608           Synergistia  <NA>       V             10     1     0
## 1609        Thermomicrobia  <NA>       V             10     1     1
## 1610        Thermoplasmata  <NA>       V             10     1     0
## 1611           Thermotogae  <NA>       V             10     1     0
## 1612               Unknown  <NA>       V             10     1   132
## 1613         Acidobacteria     1       V             11     1     0
## 1614         Acidobacteria    10       V             11     1     0
## 1615         Acidobacteria    14       V             11     1     0
## 1616         Acidobacteria    16       V             11     1     1
## 1617         Acidobacteria    17       V             11     1     1
## 1618         Acidobacteria    18       V             11     1     0
## 1619         Acidobacteria    21       V             11     1     0
## 1620         Acidobacteria    22       V             11     1     0
## 1621         Acidobacteria     3       V             11     1     1
## 1622         Acidobacteria     4       V             11     1     7
## 1623         Acidobacteria     5       V             11     1     0
## 1624         Acidobacteria     6       V             11     1    11
## 1625         Acidobacteria     7       V             11     1     0
## 1626         Acidobacteria     9       V             11     1     0
## 1627        Actinobacteria  <NA>       V             11     1  5182
## 1628   Alphaproteobacteria  <NA>       V             11     1  1326
## 1629          Anaerolineae  <NA>       V             11     1    15
## 1630               Bacilli  <NA>       V             11     1  4941
## 1631           Bacteroidia  <NA>       V             11     1    45
## 1632    Betaproteobacteria  <NA>       V             11     1   989
## 1633           Caldilineae  <NA>       V             11     1     5
## 1634            Chlamydiae  <NA>       V             11     1     0
## 1635           Chloroflexi  <NA>       V             11     1     0
## 1636        Chrysiogenetes  <NA>       V             11     1     0
## 1637            Clostridia  <NA>       V             11     1   790
## 1638         Cyanobacteria  <NA>       V             11     1     0
## 1639     Dehalococcoidetes  <NA>       V             11     1     0
## 1640            Deinococci  <NA>       V             11     1   448
## 1641   Deltaproteobacteria  <NA>       V             11     1    65
## 1642 Epsilonproteobacteria  <NA>       V             11     1     0
## 1643       Erysipelotrichi  <NA>       V             11     1    39
## 1644         Fibrobacteria  <NA>       V             11     1     0
## 1645         Flavobacteria  <NA>       V             11     1  3845
## 1646          Fusobacteria  <NA>       V             11     1     1
## 1647   Gammaproteobacteria  <NA>       V             11     1  6078
## 1648      Gemmatimonadetes  <NA>       V             11     1     2
## 1649            Holophagae  <NA>       V             11     1     0
## 1650         Lentisphaeria  <NA>       V             11     1     0
## 1651       Methanobacteria  <NA>       V             11     1     0
## 1652       Methanomicrobia  <NA>       V             11     1     0
## 1653            Mollicutes  <NA>       V             11     1   120
## 1654            Nitrospira  <NA>       V             11     1     1
## 1655              Opitutae  <NA>       V             11     1    80
## 1656      Planctomycetacia  <NA>       V             11     1     4
## 1657       Sphingobacteria  <NA>       V             11     1  2178
## 1658          Spirochaetes  <NA>       V             11     1     0
## 1659          Subdivision3  <NA>       V             11     1     0
## 1660           Synergistia  <NA>       V             11     1     0
## 1661        Thermomicrobia  <NA>       V             11     1   130
## 1662        Thermoplasmata  <NA>       V             11     1     0
## 1663           Thermotogae  <NA>       V             11     1     0
## 1664               Unknown  <NA>       V             11     1   425
## 1665         Acidobacteria     1       V             11     2     0
## 1666         Acidobacteria    10       V             11     2     0
## 1667         Acidobacteria    14       V             11     2     0
## 1668         Acidobacteria    16       V             11     2     0
## 1669         Acidobacteria    17       V             11     2     0
## 1670         Acidobacteria    18       V             11     2     0
## 1671         Acidobacteria    21       V             11     2     0
## 1672         Acidobacteria    22       V             11     2     0
## 1673         Acidobacteria     3       V             11     2     0
## 1674         Acidobacteria     4       V             11     2     0
## 1675         Acidobacteria     5       V             11     2     0
## 1676         Acidobacteria     6       V             11     2     0
## 1677         Acidobacteria     7       V             11     2     0
## 1678         Acidobacteria     9       V             11     2     0
## 1679        Actinobacteria  <NA>       V             11     2   452
## 1680   Alphaproteobacteria  <NA>       V             11     2   243
## 1681          Anaerolineae  <NA>       V             11     2     1
## 1682               Bacilli  <NA>       V             11     2    80
## 1683           Bacteroidia  <NA>       V             11     2   112
## 1684    Betaproteobacteria  <NA>       V             11     2    73
## 1685           Caldilineae  <NA>       V             11     2     0
## 1686            Chlamydiae  <NA>       V             11     2     0
## 1687           Chloroflexi  <NA>       V             11     2     0
## 1688        Chrysiogenetes  <NA>       V             11     2     0
## 1689            Clostridia  <NA>       V             11     2   278
## 1690         Cyanobacteria  <NA>       V             11     2     0
## 1691     Dehalococcoidetes  <NA>       V             11     2     0
## 1692            Deinococci  <NA>       V             11     2   135
## 1693   Deltaproteobacteria  <NA>       V             11     2    15
## 1694 Epsilonproteobacteria  <NA>       V             11     2     0
## 1695       Erysipelotrichi  <NA>       V             11     2    34
## 1696         Fibrobacteria  <NA>       V             11     2     0
## 1697         Flavobacteria  <NA>       V             11     2   770
## 1698          Fusobacteria  <NA>       V             11     2     0
## 1699   Gammaproteobacteria  <NA>       V             11     2   304
## 1700      Gemmatimonadetes  <NA>       V             11     2     0
## 1701            Holophagae  <NA>       V             11     2     0
## 1702         Lentisphaeria  <NA>       V             11     2     0
## 1703       Methanobacteria  <NA>       V             11     2     0
## 1704       Methanomicrobia  <NA>       V             11     2     0
## 1705            Mollicutes  <NA>       V             11     2    17
## 1706            Nitrospira  <NA>       V             11     2     0
## 1707              Opitutae  <NA>       V             11     2     6
## 1708      Planctomycetacia  <NA>       V             11     2     2
## 1709       Sphingobacteria  <NA>       V             11     2   259
## 1710          Spirochaetes  <NA>       V             11     2     0
## 1711          Subdivision3  <NA>       V             11     2     0
## 1712           Synergistia  <NA>       V             11     2     0
## 1713        Thermomicrobia  <NA>       V             11     2    20
## 1714        Thermoplasmata  <NA>       V             11     2     0
## 1715           Thermotogae  <NA>       V             11     2     0
## 1716               Unknown  <NA>       V             11     2   141
## 1717         Acidobacteria     1       V             11     3     0
## 1718         Acidobacteria    10       V             11     3     0
## 1719         Acidobacteria    14       V             11     3     0
## 1720         Acidobacteria    16       V             11     3     0
## 1721         Acidobacteria    17       V             11     3     0
## 1722         Acidobacteria    18       V             11     3     0
## 1723         Acidobacteria    21       V             11     3     0
## 1724         Acidobacteria    22       V             11     3     0
## 1725         Acidobacteria     3       V             11     3     1
## 1726         Acidobacteria     4       V             11     3     3
## 1727         Acidobacteria     5       V             11     3     1
## 1728         Acidobacteria     6       V             11     3    16
## 1729         Acidobacteria     7       V             11     3     0
## 1730         Acidobacteria     9       V             11     3     0
## 1731        Actinobacteria  <NA>       V             11     3  2364
## 1732   Alphaproteobacteria  <NA>       V             11     3  2564
## 1733          Anaerolineae  <NA>       V             11     3     3
## 1734               Bacilli  <NA>       V             11     3   383
## 1735           Bacteroidia  <NA>       V             11     3   366
## 1736    Betaproteobacteria  <NA>       V             11     3   509
## 1737           Caldilineae  <NA>       V             11     3    27
## 1738            Chlamydiae  <NA>       V             11     3     0
## 1739           Chloroflexi  <NA>       V             11     3     0
## 1740        Chrysiogenetes  <NA>       V             11     3     0
## 1741            Clostridia  <NA>       V             11     3  1608
## 1742         Cyanobacteria  <NA>       V             11     3     0
## 1743     Dehalococcoidetes  <NA>       V             11     3     0
## 1744            Deinococci  <NA>       V             11     3  2453
## 1745   Deltaproteobacteria  <NA>       V             11     3   189
## 1746 Epsilonproteobacteria  <NA>       V             11     3     0
## 1747       Erysipelotrichi  <NA>       V             11     3   106
## 1748         Fibrobacteria  <NA>       V             11     3     0
## 1749         Flavobacteria  <NA>       V             11     3  4813
## 1750          Fusobacteria  <NA>       V             11     3     0
## 1751   Gammaproteobacteria  <NA>       V             11     3  2806
## 1752      Gemmatimonadetes  <NA>       V             11     3     2
## 1753            Holophagae  <NA>       V             11     3     0
## 1754         Lentisphaeria  <NA>       V             11     3     0
## 1755       Methanobacteria  <NA>       V             11     3     0
## 1756       Methanomicrobia  <NA>       V             11     3     0
## 1757            Mollicutes  <NA>       V             11     3   180
## 1758            Nitrospira  <NA>       V             11     3     3
## 1759              Opitutae  <NA>       V             11     3    81
## 1760      Planctomycetacia  <NA>       V             11     3    24
## 1761       Sphingobacteria  <NA>       V             11     3  3057
## 1762          Spirochaetes  <NA>       V             11     3    26
## 1763          Subdivision3  <NA>       V             11     3     0
## 1764           Synergistia  <NA>       V             11     3     2
## 1765        Thermomicrobia  <NA>       V             11     3   209
## 1766        Thermoplasmata  <NA>       V             11     3     0
## 1767           Thermotogae  <NA>       V             11     3     0
## 1768               Unknown  <NA>       V             11     3  1304
## 1769         Acidobacteria     1       V             12     1     0
## 1770         Acidobacteria    10       V             12     1     0
## 1771         Acidobacteria    14       V             12     1     0
## 1772         Acidobacteria    16       V             12     1     0
## 1773         Acidobacteria    17       V             12     1     0
## 1774         Acidobacteria    18       V             12     1     0
## 1775         Acidobacteria    21       V             12     1     0
## 1776         Acidobacteria    22       V             12     1     0
## 1777         Acidobacteria     3       V             12     1     0
## 1778         Acidobacteria     4       V             12     1     0
## 1779         Acidobacteria     5       V             12     1     0
## 1780         Acidobacteria     6       V             12     1     0
## 1781         Acidobacteria     7       V             12     1     0
## 1782         Acidobacteria     9       V             12     1     0
## 1783        Actinobacteria  <NA>       V             12     1  1572
## 1784   Alphaproteobacteria  <NA>       V             12     1   195
## 1785          Anaerolineae  <NA>       V             12     1     0
## 1786               Bacilli  <NA>       V             12     1   776
## 1787           Bacteroidia  <NA>       V             12     1   126
## 1788    Betaproteobacteria  <NA>       V             12     1    46
## 1789           Caldilineae  <NA>       V             12     1     0
## 1790            Chlamydiae  <NA>       V             12     1     0
## 1791           Chloroflexi  <NA>       V             12     1     0
## 1792        Chrysiogenetes  <NA>       V             12     1     0
## 1793            Clostridia  <NA>       V             12     1  2165
## 1794         Cyanobacteria  <NA>       V             12     1     1
## 1795     Dehalococcoidetes  <NA>       V             12     1     0
## 1796            Deinococci  <NA>       V             12     1   224
## 1797   Deltaproteobacteria  <NA>       V             12     1   129
## 1798 Epsilonproteobacteria  <NA>       V             12     1     0
## 1799       Erysipelotrichi  <NA>       V             12     1   153
## 1800         Fibrobacteria  <NA>       V             12     1     0
## 1801         Flavobacteria  <NA>       V             12     1  4114
## 1802          Fusobacteria  <NA>       V             12     1     0
## 1803   Gammaproteobacteria  <NA>       V             12     1  3818
## 1804      Gemmatimonadetes  <NA>       V             12     1     0
## 1805            Holophagae  <NA>       V             12     1     0
## 1806         Lentisphaeria  <NA>       V             12     1     0
## 1807       Methanobacteria  <NA>       V             12     1     0
## 1808       Methanomicrobia  <NA>       V             12     1     0
## 1809            Mollicutes  <NA>       V             12     1    54
## 1810            Nitrospira  <NA>       V             12     1     0
## 1811              Opitutae  <NA>       V             12     1    25
## 1812      Planctomycetacia  <NA>       V             12     1     0
## 1813       Sphingobacteria  <NA>       V             12     1   890
## 1814          Spirochaetes  <NA>       V             12     1     0
## 1815          Subdivision3  <NA>       V             12     1     0
## 1816           Synergistia  <NA>       V             12     1     0
## 1817        Thermomicrobia  <NA>       V             12     1     1
## 1818        Thermoplasmata  <NA>       V             12     1     0
## 1819           Thermotogae  <NA>       V             12     1     0
## 1820               Unknown  <NA>       V             12     1   482
## 1821         Acidobacteria     1       V             12     2     0
## 1822         Acidobacteria    10       V             12     2     0
## 1823         Acidobacteria    14       V             12     2     0
## 1824         Acidobacteria    16       V             12     2     0
## 1825         Acidobacteria    17       V             12     2     0
## 1826         Acidobacteria    18       V             12     2     0
## 1827         Acidobacteria    21       V             12     2     0
## 1828         Acidobacteria    22       V             12     2     0
## 1829         Acidobacteria     3       V             12     2     0
## 1830         Acidobacteria     4       V             12     2     0
## 1831         Acidobacteria     5       V             12     2     0
## 1832         Acidobacteria     6       V             12     2     0
## 1833         Acidobacteria     7       V             12     2     0
## 1834         Acidobacteria     9       V             12     2     0
## 1835        Actinobacteria  <NA>       V             12     2   492
## 1836   Alphaproteobacteria  <NA>       V             12     2   185
## 1837          Anaerolineae  <NA>       V             12     2     0
## 1838               Bacilli  <NA>       V             12     2   331
## 1839           Bacteroidia  <NA>       V             12     2    21
## 1840    Betaproteobacteria  <NA>       V             12     2    86
## 1841           Caldilineae  <NA>       V             12     2     0
## 1842            Chlamydiae  <NA>       V             12     2     0
## 1843           Chloroflexi  <NA>       V             12     2     0
## 1844        Chrysiogenetes  <NA>       V             12     2     0
## 1845            Clostridia  <NA>       V             12     2   622
## 1846         Cyanobacteria  <NA>       V             12     2     0
## 1847     Dehalococcoidetes  <NA>       V             12     2     0
## 1848            Deinococci  <NA>       V             12     2   311
## 1849   Deltaproteobacteria  <NA>       V             12     2    35
## 1850 Epsilonproteobacteria  <NA>       V             12     2     0
## 1851       Erysipelotrichi  <NA>       V             12     2    21
## 1852         Fibrobacteria  <NA>       V             12     2     0
## 1853         Flavobacteria  <NA>       V             12     2   818
## 1854          Fusobacteria  <NA>       V             12     2     0
## 1855   Gammaproteobacteria  <NA>       V             12     2   906
## 1856      Gemmatimonadetes  <NA>       V             12     2     0
## 1857            Holophagae  <NA>       V             12     2     0
## 1858         Lentisphaeria  <NA>       V             12     2     0
## 1859       Methanobacteria  <NA>       V             12     2     0
## 1860       Methanomicrobia  <NA>       V             12     2     0
## 1861            Mollicutes  <NA>       V             12     2    68
## 1862            Nitrospira  <NA>       V             12     2     0
## 1863              Opitutae  <NA>       V             12     2    26
## 1864      Planctomycetacia  <NA>       V             12     2     0
## 1865       Sphingobacteria  <NA>       V             12     2   664
## 1866          Spirochaetes  <NA>       V             12     2     0
## 1867          Subdivision3  <NA>       V             12     2     0
## 1868           Synergistia  <NA>       V             12     2     0
## 1869        Thermomicrobia  <NA>       V             12     2     7
## 1870        Thermoplasmata  <NA>       V             12     2     0
## 1871           Thermotogae  <NA>       V             12     2     0
## 1872               Unknown  <NA>       V             12     2   196
## 1873         Acidobacteria     1       V             13     1     0
## 1874         Acidobacteria    10       V             13     1     0
## 1875         Acidobacteria    14       V             13     1     0
## 1876         Acidobacteria    16       V             13     1     0
## 1877         Acidobacteria    17       V             13     1     0
## 1878         Acidobacteria    18       V             13     1     0
## 1879         Acidobacteria    21       V             13     1     0
## 1880         Acidobacteria    22       V             13     1     0
## 1881         Acidobacteria     3       V             13     1     0
## 1882         Acidobacteria     4       V             13     1     0
## 1883         Acidobacteria     5       V             13     1     0
## 1884         Acidobacteria     6       V             13     1     0
## 1885         Acidobacteria     7       V             13     1     0
## 1886         Acidobacteria     9       V             13     1     0
## 1887        Actinobacteria  <NA>       V             13     1    25
## 1888   Alphaproteobacteria  <NA>       V             13     1    25
## 1889          Anaerolineae  <NA>       V             13     1     0
## 1890               Bacilli  <NA>       V             13     1    48
## 1891           Bacteroidia  <NA>       V             13     1    49
## 1892    Betaproteobacteria  <NA>       V             13     1    14
## 1893           Caldilineae  <NA>       V             13     1     0
## 1894            Chlamydiae  <NA>       V             13     1     0
## 1895           Chloroflexi  <NA>       V             13     1     0
## 1896        Chrysiogenetes  <NA>       V             13     1     0
## 1897            Clostridia  <NA>       V             13     1  1008
## 1898         Cyanobacteria  <NA>       V             13     1     0
## 1899     Dehalococcoidetes  <NA>       V             13     1     0
## 1900            Deinococci  <NA>       V             13     1    22
## 1901   Deltaproteobacteria  <NA>       V             13     1     1
## 1902 Epsilonproteobacteria  <NA>       V             13     1     0
## 1903       Erysipelotrichi  <NA>       V             13     1     9
## 1904         Fibrobacteria  <NA>       V             13     1     0
## 1905         Flavobacteria  <NA>       V             13     1   114
## 1906          Fusobacteria  <NA>       V             13     1     0
## 1907   Gammaproteobacteria  <NA>       V             13     1   193
## 1908      Gemmatimonadetes  <NA>       V             13     1     0
## 1909            Holophagae  <NA>       V             13     1     0
## 1910         Lentisphaeria  <NA>       V             13     1     0
## 1911       Methanobacteria  <NA>       V             13     1     0
## 1912       Methanomicrobia  <NA>       V             13     1     0
## 1913            Mollicutes  <NA>       V             13     1    11
## 1914            Nitrospira  <NA>       V             13     1     0
## 1915              Opitutae  <NA>       V             13     1     0
## 1916      Planctomycetacia  <NA>       V             13     1     0
## 1917       Sphingobacteria  <NA>       V             13     1    20
## 1918          Spirochaetes  <NA>       V             13     1     0
## 1919          Subdivision3  <NA>       V             13     1     0
## 1920           Synergistia  <NA>       V             13     1     2
## 1921        Thermomicrobia  <NA>       V             13     1     2
## 1922        Thermoplasmata  <NA>       V             13     1     0
## 1923           Thermotogae  <NA>       V             13     1     0
## 1924               Unknown  <NA>       V             13     1   123
## 1925         Acidobacteria     1       V             13     2     0
## 1926         Acidobacteria    10       V             13     2     0
## 1927         Acidobacteria    14       V             13     2     0
## 1928         Acidobacteria    16       V             13     2     0
## 1929         Acidobacteria    17       V             13     2     0
## 1930         Acidobacteria    18       V             13     2     0
## 1931         Acidobacteria    21       V             13     2     0
## 1932         Acidobacteria    22       V             13     2     0
## 1933         Acidobacteria     3       V             13     2     0
## 1934         Acidobacteria     4       V             13     2     0
## 1935         Acidobacteria     5       V             13     2     0
## 1936         Acidobacteria     6       V             13     2     0
## 1937         Acidobacteria     7       V             13     2     0
## 1938         Acidobacteria     9       V             13     2     0
## 1939        Actinobacteria  <NA>       V             13     2   214
## 1940   Alphaproteobacteria  <NA>       V             13     2   184
## 1941          Anaerolineae  <NA>       V             13     2     0
## 1942               Bacilli  <NA>       V             13     2   121
## 1943           Bacteroidia  <NA>       V             13     2   542
## 1944    Betaproteobacteria  <NA>       V             13     2   116
## 1945           Caldilineae  <NA>       V             13     2     0
## 1946            Chlamydiae  <NA>       V             13     2     0
## 1947           Chloroflexi  <NA>       V             13     2     0
## 1948        Chrysiogenetes  <NA>       V             13     2     0
## 1949            Clostridia  <NA>       V             13     2  4648
## 1950         Cyanobacteria  <NA>       V             13     2     0
## 1951     Dehalococcoidetes  <NA>       V             13     2     0
## 1952            Deinococci  <NA>       V             13     2   195
## 1953   Deltaproteobacteria  <NA>       V             13     2    22
## 1954 Epsilonproteobacteria  <NA>       V             13     2     0
## 1955       Erysipelotrichi  <NA>       V             13     2    94
## 1956         Fibrobacteria  <NA>       V             13     2     0
## 1957         Flavobacteria  <NA>       V             13     2   794
## 1958          Fusobacteria  <NA>       V             13     2     3
## 1959   Gammaproteobacteria  <NA>       V             13     2   450
## 1960      Gemmatimonadetes  <NA>       V             13     2     0
## 1961            Holophagae  <NA>       V             13     2     0
## 1962         Lentisphaeria  <NA>       V             13     2     3
## 1963       Methanobacteria  <NA>       V             13     2     0
## 1964       Methanomicrobia  <NA>       V             13     2     0
## 1965            Mollicutes  <NA>       V             13     2   159
## 1966            Nitrospira  <NA>       V             13     2     0
## 1967              Opitutae  <NA>       V             13     2     4
## 1968      Planctomycetacia  <NA>       V             13     2     0
## 1969       Sphingobacteria  <NA>       V             13     2   106
## 1970          Spirochaetes  <NA>       V             13     2     0
## 1971          Subdivision3  <NA>       V             13     2     0
## 1972           Synergistia  <NA>       V             13     2     5
## 1973        Thermomicrobia  <NA>       V             13     2     3
## 1974        Thermoplasmata  <NA>       V             13     2     0
## 1975           Thermotogae  <NA>       V             13     2     0
## 1976               Unknown  <NA>       V             13     2   914
## 1977         Acidobacteria     1       V             14     1     0
## 1978         Acidobacteria    10       V             14     1     0
## 1979         Acidobacteria    14       V             14     1     0
## 1980         Acidobacteria    16       V             14     1     0
## 1981         Acidobacteria    17       V             14     1     0
## 1982         Acidobacteria    18       V             14     1     0
## 1983         Acidobacteria    21       V             14     1     0
## 1984         Acidobacteria    22       V             14     1     0
## 1985         Acidobacteria     3       V             14     1     0
## 1986         Acidobacteria     4       V             14     1     0
## 1987         Acidobacteria     5       V             14     1     0
## 1988         Acidobacteria     6       V             14     1     0
## 1989         Acidobacteria     7       V             14     1     0
## 1990         Acidobacteria     9       V             14     1     0
## 1991        Actinobacteria  <NA>       V             14     1    77
## 1992   Alphaproteobacteria  <NA>       V             14     1    90
## 1993          Anaerolineae  <NA>       V             14     1     0
## 1994               Bacilli  <NA>       V             14     1   251
## 1995           Bacteroidia  <NA>       V             14     1   722
## 1996    Betaproteobacteria  <NA>       V             14     1    12
## 1997           Caldilineae  <NA>       V             14     1     0
## 1998            Chlamydiae  <NA>       V             14     1     0
## 1999           Chloroflexi  <NA>       V             14     1     0
## 2000        Chrysiogenetes  <NA>       V             14     1     0
## 2001            Clostridia  <NA>       V             14     1  3449
## 2002         Cyanobacteria  <NA>       V             14     1     0
## 2003     Dehalococcoidetes  <NA>       V             14     1     0
## 2004            Deinococci  <NA>       V             14     1     4
## 2005   Deltaproteobacteria  <NA>       V             14     1     8
## 2006 Epsilonproteobacteria  <NA>       V             14     1     0
## 2007       Erysipelotrichi  <NA>       V             14     1   169
## 2008         Fibrobacteria  <NA>       V             14     1     2
## 2009         Flavobacteria  <NA>       V             14     1    83
## 2010          Fusobacteria  <NA>       V             14     1     6
## 2011   Gammaproteobacteria  <NA>       V             14     1   421
## 2012      Gemmatimonadetes  <NA>       V             14     1     0
## 2013            Holophagae  <NA>       V             14     1     0
## 2014         Lentisphaeria  <NA>       V             14     1     3
## 2015       Methanobacteria  <NA>       V             14     1     0
## 2016       Methanomicrobia  <NA>       V             14     1     0
## 2017            Mollicutes  <NA>       V             14     1   104
## 2018            Nitrospira  <NA>       V             14     1     0
## 2019              Opitutae  <NA>       V             14     1     1
## 2020      Planctomycetacia  <NA>       V             14     1     0
## 2021       Sphingobacteria  <NA>       V             14     1    34
## 2022          Spirochaetes  <NA>       V             14     1     6
## 2023          Subdivision3  <NA>       V             14     1     0
## 2024           Synergistia  <NA>       V             14     1     1
## 2025        Thermomicrobia  <NA>       V             14     1     0
## 2026        Thermoplasmata  <NA>       V             14     1     0
## 2027           Thermotogae  <NA>       V             14     1     0
## 2028               Unknown  <NA>       V             14     1   416
## 2029         Acidobacteria     1       V             14     2     0
## 2030         Acidobacteria    10       V             14     2     0
## 2031         Acidobacteria    14       V             14     2     0
## 2032         Acidobacteria    16       V             14     2     0
## 2033         Acidobacteria    17       V             14     2     0
## 2034         Acidobacteria    18       V             14     2     0
## 2035         Acidobacteria    21       V             14     2     0
## 2036         Acidobacteria    22       V             14     2     0
## 2037         Acidobacteria     3       V             14     2     0
## 2038         Acidobacteria     4       V             14     2     0
## 2039         Acidobacteria     5       V             14     2     0
## 2040         Acidobacteria     6       V             14     2     0
## 2041         Acidobacteria     7       V             14     2     0
## 2042         Acidobacteria     9       V             14     2     0
## 2043        Actinobacteria  <NA>       V             14     2     2
## 2044   Alphaproteobacteria  <NA>       V             14     2     0
## 2045          Anaerolineae  <NA>       V             14     2     0
## 2046               Bacilli  <NA>       V             14     2     3
## 2047           Bacteroidia  <NA>       V             14     2     4
## 2048    Betaproteobacteria  <NA>       V             14     2     1
## 2049           Caldilineae  <NA>       V             14     2     0
## 2050            Chlamydiae  <NA>       V             14     2     0
## 2051           Chloroflexi  <NA>       V             14     2     0
## 2052        Chrysiogenetes  <NA>       V             14     2     0
## 2053            Clostridia  <NA>       V             14     2    33
## 2054         Cyanobacteria  <NA>       V             14     2     0
## 2055     Dehalococcoidetes  <NA>       V             14     2     0
## 2056            Deinococci  <NA>       V             14     2     0
## 2057   Deltaproteobacteria  <NA>       V             14     2     0
## 2058 Epsilonproteobacteria  <NA>       V             14     2     0
## 2059       Erysipelotrichi  <NA>       V             14     2     1
## 2060         Fibrobacteria  <NA>       V             14     2     0
## 2061         Flavobacteria  <NA>       V             14     2     2
## 2062          Fusobacteria  <NA>       V             14     2     1
## 2063   Gammaproteobacteria  <NA>       V             14     2     6
## 2064      Gemmatimonadetes  <NA>       V             14     2     0
## 2065            Holophagae  <NA>       V             14     2     0
## 2066         Lentisphaeria  <NA>       V             14     2     0
## 2067       Methanobacteria  <NA>       V             14     2     0
## 2068       Methanomicrobia  <NA>       V             14     2     0
## 2069            Mollicutes  <NA>       V             14     2     0
## 2070            Nitrospira  <NA>       V             14     2     0
## 2071              Opitutae  <NA>       V             14     2     0
## 2072      Planctomycetacia  <NA>       V             14     2     0
## 2073       Sphingobacteria  <NA>       V             14     2     0
## 2074          Spirochaetes  <NA>       V             14     2     0
## 2075          Subdivision3  <NA>       V             14     2     0
## 2076           Synergistia  <NA>       V             14     2     0
## 2077        Thermomicrobia  <NA>       V             14     2     0
## 2078        Thermoplasmata  <NA>       V             14     2     0
## 2079           Thermotogae  <NA>       V             14     2     0
## 2080               Unknown  <NA>       V             14     2     0
## 2081         Acidobacteria     1       V             14     3     0
## 2082         Acidobacteria    10       V             14     3     0
## 2083         Acidobacteria    14       V             14     3     0
## 2084         Acidobacteria    16       V             14     3     0
## 2085         Acidobacteria    17       V             14     3     0
## 2086         Acidobacteria    18       V             14     3     0
## 2087         Acidobacteria    21       V             14     3     0
## 2088         Acidobacteria    22       V             14     3     0
## 2089         Acidobacteria     3       V             14     3     0
## 2090         Acidobacteria     4       V             14     3     0
## 2091         Acidobacteria     5       V             14     3     0
## 2092         Acidobacteria     6       V             14     3     1
## 2093         Acidobacteria     7       V             14     3     0
## 2094         Acidobacteria     9       V             14     3     0
## 2095        Actinobacteria  <NA>       V             14     3    87
## 2096   Alphaproteobacteria  <NA>       V             14     3    76
## 2097          Anaerolineae  <NA>       V             14     3     0
## 2098               Bacilli  <NA>       V             14     3   214
## 2099           Bacteroidia  <NA>       V             14     3   399
## 2100    Betaproteobacteria  <NA>       V             14     3    64
## 2101           Caldilineae  <NA>       V             14     3     0
## 2102            Chlamydiae  <NA>       V             14     3     0
## 2103           Chloroflexi  <NA>       V             14     3     0
## 2104        Chrysiogenetes  <NA>       V             14     3     0
## 2105            Clostridia  <NA>       V             14     3  1712
## 2106         Cyanobacteria  <NA>       V             14     3     0
## 2107     Dehalococcoidetes  <NA>       V             14     3     0
## 2108            Deinococci  <NA>       V             14     3    11
## 2109   Deltaproteobacteria  <NA>       V             14     3     6
## 2110 Epsilonproteobacteria  <NA>       V             14     3     0
## 2111       Erysipelotrichi  <NA>       V             14     3    64
## 2112         Fibrobacteria  <NA>       V             14     3     0
## 2113         Flavobacteria  <NA>       V             14     3   209
## 2114          Fusobacteria  <NA>       V             14     3    55
## 2115   Gammaproteobacteria  <NA>       V             14     3   409
## 2116      Gemmatimonadetes  <NA>       V             14     3     0
## 2117            Holophagae  <NA>       V             14     3     0
## 2118         Lentisphaeria  <NA>       V             14     3     0
## 2119       Methanobacteria  <NA>       V             14     3     0
## 2120       Methanomicrobia  <NA>       V             14     3     0
## 2121            Mollicutes  <NA>       V             14     3    45
## 2122            Nitrospira  <NA>       V             14     3     0
## 2123              Opitutae  <NA>       V             14     3     0
## 2124      Planctomycetacia  <NA>       V             14     3     0
## 2125       Sphingobacteria  <NA>       V             14     3    28
## 2126          Spirochaetes  <NA>       V             14     3     3
## 2127          Subdivision3  <NA>       V             14     3     0
## 2128           Synergistia  <NA>       V             14     3     5
## 2129        Thermomicrobia  <NA>       V             14     3     2
## 2130        Thermoplasmata  <NA>       V             14     3     0
## 2131           Thermotogae  <NA>       V             14     3     0
## 2132               Unknown  <NA>       V             14     3    81
## 2133         Acidobacteria     1       V             15     1     0
## 2134         Acidobacteria    10       V             15     1     0
## 2135         Acidobacteria    14       V             15     1     0
## 2136         Acidobacteria    16       V             15     1     0
## 2137         Acidobacteria    17       V             15     1     0
## 2138         Acidobacteria    18       V             15     1     0
## 2139         Acidobacteria    21       V             15     1     0
## 2140         Acidobacteria    22       V             15     1     0
## 2141         Acidobacteria     3       V             15     1     0
## 2142         Acidobacteria     4       V             15     1     0
## 2143         Acidobacteria     5       V             15     1     0
## 2144         Acidobacteria     6       V             15     1     0
## 2145         Acidobacteria     7       V             15     1     0
## 2146         Acidobacteria     9       V             15     1     0
## 2147        Actinobacteria  <NA>       V             15     1   237
## 2148   Alphaproteobacteria  <NA>       V             15     1   120
## 2149          Anaerolineae  <NA>       V             15     1     0
## 2150               Bacilli  <NA>       V             15     1   323
## 2151           Bacteroidia  <NA>       V             15     1  1003
## 2152    Betaproteobacteria  <NA>       V             15     1   141
## 2153           Caldilineae  <NA>       V             15     1     0
## 2154            Chlamydiae  <NA>       V             15     1     0
## 2155           Chloroflexi  <NA>       V             15     1     0
## 2156        Chrysiogenetes  <NA>       V             15     1     0
## 2157            Clostridia  <NA>       V             15     1  8244
## 2158         Cyanobacteria  <NA>       V             15     1     0
## 2159     Dehalococcoidetes  <NA>       V             15     1     0
## 2160            Deinococci  <NA>       V             15     1   104
## 2161   Deltaproteobacteria  <NA>       V             15     1    26
## 2162 Epsilonproteobacteria  <NA>       V             15     1     0
## 2163       Erysipelotrichi  <NA>       V             15     1   592
## 2164         Fibrobacteria  <NA>       V             15     1     0
## 2165         Flavobacteria  <NA>       V             15     1   599
## 2166          Fusobacteria  <NA>       V             15     1     1
## 2167   Gammaproteobacteria  <NA>       V             15     1  1915
## 2168      Gemmatimonadetes  <NA>       V             15     1     0
## 2169            Holophagae  <NA>       V             15     1     0
## 2170         Lentisphaeria  <NA>       V             15     1    33
## 2171       Methanobacteria  <NA>       V             15     1     0
## 2172       Methanomicrobia  <NA>       V             15     1     0
## 2173            Mollicutes  <NA>       V             15     1   147
## 2174            Nitrospira  <NA>       V             15     1     0
## 2175              Opitutae  <NA>       V             15     1    10
## 2176      Planctomycetacia  <NA>       V             15     1     1
## 2177       Sphingobacteria  <NA>       V             15     1   123
## 2178          Spirochaetes  <NA>       V             15     1     0
## 2179          Subdivision3  <NA>       V             15     1     0
## 2180           Synergistia  <NA>       V             15     1    50
## 2181        Thermomicrobia  <NA>       V             15     1     5
## 2182        Thermoplasmata  <NA>       V             15     1     0
## 2183           Thermotogae  <NA>       V             15     1     0
## 2184               Unknown  <NA>       V             15     1   837
## 2185         Acidobacteria     1       V             15     2     0
## 2186         Acidobacteria    10       V             15     2     0
## 2187         Acidobacteria    14       V             15     2     0
## 2188         Acidobacteria    16       V             15     2     0
## 2189         Acidobacteria    17       V             15     2     0
## 2190         Acidobacteria    18       V             15     2     0
## 2191         Acidobacteria    21       V             15     2     0
## 2192         Acidobacteria    22       V             15     2     0
## 2193         Acidobacteria     3       V             15     2     0
## 2194         Acidobacteria     4       V             15     2     0
## 2195         Acidobacteria     5       V             15     2     0
## 2196         Acidobacteria     6       V             15     2     2
## 2197         Acidobacteria     7       V             15     2     0
## 2198         Acidobacteria     9       V             15     2     0
## 2199        Actinobacteria  <NA>       V             15     2   379
## 2200   Alphaproteobacteria  <NA>       V             15     2   404
## 2201          Anaerolineae  <NA>       V             15     2     2
## 2202               Bacilli  <NA>       V             15     2   106
## 2203           Bacteroidia  <NA>       V             15     2   541
## 2204    Betaproteobacteria  <NA>       V             15     2    79
## 2205           Caldilineae  <NA>       V             15     2    11
## 2206            Chlamydiae  <NA>       V             15     2     0
## 2207           Chloroflexi  <NA>       V             15     2     0
## 2208        Chrysiogenetes  <NA>       V             15     2     3
## 2209            Clostridia  <NA>       V             15     2  4761
## 2210         Cyanobacteria  <NA>       V             15     2     0
## 2211     Dehalococcoidetes  <NA>       V             15     2     0
## 2212            Deinococci  <NA>       V             15     2   160
## 2213   Deltaproteobacteria  <NA>       V             15     2    59
## 2214 Epsilonproteobacteria  <NA>       V             15     2     0
## 2215       Erysipelotrichi  <NA>       V             15     2   226
## 2216         Fibrobacteria  <NA>       V             15     2     7
## 2217         Flavobacteria  <NA>       V             15     2   587
## 2218          Fusobacteria  <NA>       V             15     2     0
## 2219   Gammaproteobacteria  <NA>       V             15     2  1206
## 2220      Gemmatimonadetes  <NA>       V             15     2     0
## 2221            Holophagae  <NA>       V             15     2     0
## 2222         Lentisphaeria  <NA>       V             15     2     4
## 2223       Methanobacteria  <NA>       V             15     2     0
## 2224       Methanomicrobia  <NA>       V             15     2     0
## 2225            Mollicutes  <NA>       V             15     2   202
## 2226            Nitrospira  <NA>       V             15     2     2
## 2227              Opitutae  <NA>       V             15     2     7
## 2228      Planctomycetacia  <NA>       V             15     2    52
## 2229       Sphingobacteria  <NA>       V             15     2   193
## 2230          Spirochaetes  <NA>       V             15     2    25
## 2231          Subdivision3  <NA>       V             15     2     0
## 2232           Synergistia  <NA>       V             15     2     5
## 2233        Thermomicrobia  <NA>       V             15     2    35
## 2234        Thermoplasmata  <NA>       V             15     2     0
## 2235           Thermotogae  <NA>       V             15     2     0
## 2236               Unknown  <NA>       V             15     2   504
## 2237         Acidobacteria     1       V             15     3     0
## 2238         Acidobacteria    10       V             15     3     0
## 2239         Acidobacteria    14       V             15     3     0
## 2240         Acidobacteria    16       V             15     3     0
## 2241         Acidobacteria    17       V             15     3     0
## 2242         Acidobacteria    18       V             15     3     0
## 2243         Acidobacteria    21       V             15     3     0
## 2244         Acidobacteria    22       V             15     3     0
## 2245         Acidobacteria     3       V             15     3     2
## 2246         Acidobacteria     4       V             15     3     0
## 2247         Acidobacteria     5       V             15     3     0
## 2248         Acidobacteria     6       V             15     3     1
## 2249         Acidobacteria     7       V             15     3     0
## 2250         Acidobacteria     9       V             15     3     0
## 2251        Actinobacteria  <NA>       V             15     3   273
## 2252   Alphaproteobacteria  <NA>       V             15     3   336
## 2253          Anaerolineae  <NA>       V             15     3     5
## 2254               Bacilli  <NA>       V             15     3   126
## 2255           Bacteroidia  <NA>       V             15     3   540
## 2256    Betaproteobacteria  <NA>       V             15     3    76
## 2257           Caldilineae  <NA>       V             15     3     4
## 2258            Chlamydiae  <NA>       V             15     3     0
## 2259           Chloroflexi  <NA>       V             15     3     0
## 2260        Chrysiogenetes  <NA>       V             15     3    37
## 2261            Clostridia  <NA>       V             15     3  3910
## 2262         Cyanobacteria  <NA>       V             15     3     0
## 2263     Dehalococcoidetes  <NA>       V             15     3     0
## 2264            Deinococci  <NA>       V             15     3   128
## 2265   Deltaproteobacteria  <NA>       V             15     3    40
## 2266 Epsilonproteobacteria  <NA>       V             15     3     0
## 2267       Erysipelotrichi  <NA>       V             15     3   184
## 2268         Fibrobacteria  <NA>       V             15     3     0
## 2269         Flavobacteria  <NA>       V             15     3   615
## 2270          Fusobacteria  <NA>       V             15     3     0
## 2271   Gammaproteobacteria  <NA>       V             15     3  1031
## 2272      Gemmatimonadetes  <NA>       V             15     3     0
## 2273            Holophagae  <NA>       V             15     3     0
## 2274         Lentisphaeria  <NA>       V             15     3     3
## 2275       Methanobacteria  <NA>       V             15     3     0
## 2276       Methanomicrobia  <NA>       V             15     3     0
## 2277            Mollicutes  <NA>       V             15     3   151
## 2278            Nitrospira  <NA>       V             15     3     3
## 2279              Opitutae  <NA>       V             15     3     3
## 2280      Planctomycetacia  <NA>       V             15     3    15
## 2281       Sphingobacteria  <NA>       V             15     3   192
## 2282          Spirochaetes  <NA>       V             15     3    88
## 2283          Subdivision3  <NA>       V             15     3     0
## 2284           Synergistia  <NA>       V             15     3     3
## 2285        Thermomicrobia  <NA>       V             15     3    23
## 2286        Thermoplasmata  <NA>       V             15     3     0
## 2287           Thermotogae  <NA>       V             15     3     0
## 2288               Unknown  <NA>       V             15     3   429
## 2289         Acidobacteria     1       V             16     1     0
## 2290         Acidobacteria    10       V             16     1     0
## 2291         Acidobacteria    14       V             16     1     0
## 2292         Acidobacteria    16       V             16     1     0
## 2293         Acidobacteria    17       V             16     1     0
## 2294         Acidobacteria    18       V             16     1     0
## 2295         Acidobacteria    21       V             16     1     0
## 2296         Acidobacteria    22       V             16     1     0
## 2297         Acidobacteria     3       V             16     1     0
## 2298         Acidobacteria     4       V             16     1     0
## 2299         Acidobacteria     5       V             16     1     0
## 2300         Acidobacteria     6       V             16     1     0
## 2301         Acidobacteria     7       V             16     1     0
## 2302         Acidobacteria     9       V             16     1     0
## 2303        Actinobacteria  <NA>       V             16     1   138
## 2304   Alphaproteobacteria  <NA>       V             16     1    27
## 2305          Anaerolineae  <NA>       V             16     1     0
## 2306               Bacilli  <NA>       V             16     1  1280
## 2307           Bacteroidia  <NA>       V             16     1  4267
## 2308    Betaproteobacteria  <NA>       V             16     1    39
## 2309           Caldilineae  <NA>       V             16     1     0
## 2310            Chlamydiae  <NA>       V             16     1     0
## 2311           Chloroflexi  <NA>       V             16     1     0
## 2312        Chrysiogenetes  <NA>       V             16     1     0
## 2313            Clostridia  <NA>       V             16     1 10043
## 2314         Cyanobacteria  <NA>       V             16     1     0
## 2315     Dehalococcoidetes  <NA>       V             16     1     0
## 2316            Deinococci  <NA>       V             16     1     5
## 2317   Deltaproteobacteria  <NA>       V             16     1     0
## 2318 Epsilonproteobacteria  <NA>       V             16     1     0
## 2319       Erysipelotrichi  <NA>       V             16     1   253
## 2320         Fibrobacteria  <NA>       V             16     1     0
## 2321         Flavobacteria  <NA>       V             16     1   475
## 2322          Fusobacteria  <NA>       V             16     1   115
## 2323   Gammaproteobacteria  <NA>       V             16     1   776
## 2324      Gemmatimonadetes  <NA>       V             16     1     0
## 2325            Holophagae  <NA>       V             16     1     0
## 2326         Lentisphaeria  <NA>       V             16     1     1
## 2327       Methanobacteria  <NA>       V             16     1     0
## 2328       Methanomicrobia  <NA>       V             16     1     0
## 2329            Mollicutes  <NA>       V             16     1    87
## 2330            Nitrospira  <NA>       V             16     1     0
## 2331              Opitutae  <NA>       V             16     1     0
## 2332      Planctomycetacia  <NA>       V             16     1     0
## 2333       Sphingobacteria  <NA>       V             16     1    35
## 2334          Spirochaetes  <NA>       V             16     1    20
## 2335          Subdivision3  <NA>       V             16     1     0
## 2336           Synergistia  <NA>       V             16     1     0
## 2337        Thermomicrobia  <NA>       V             16     1     1
## 2338        Thermoplasmata  <NA>       V             16     1     0
## 2339           Thermotogae  <NA>       V             16     1     0
## 2340               Unknown  <NA>       V             16     1   345
## 2341         Acidobacteria     1       V             16     2     0
## 2342         Acidobacteria    10       V             16     2     0
## 2343         Acidobacteria    14       V             16     2     0
## 2344         Acidobacteria    16       V             16     2     0
## 2345         Acidobacteria    17       V             16     2     0
## 2346         Acidobacteria    18       V             16     2     0
## 2347         Acidobacteria    21       V             16     2     0
## 2348         Acidobacteria    22       V             16     2     0
## 2349         Acidobacteria     3       V             16     2     0
## 2350         Acidobacteria     4       V             16     2     0
## 2351         Acidobacteria     5       V             16     2     0
## 2352         Acidobacteria     6       V             16     2     0
## 2353         Acidobacteria     7       V             16     2     0
## 2354         Acidobacteria     9       V             16     2     0
## 2355        Actinobacteria  <NA>       V             16     2   391
## 2356   Alphaproteobacteria  <NA>       V             16     2    22
## 2357          Anaerolineae  <NA>       V             16     2     0
## 2358               Bacilli  <NA>       V             16     2   717
## 2359           Bacteroidia  <NA>       V             16     2  2556
## 2360    Betaproteobacteria  <NA>       V             16     2    78
## 2361           Caldilineae  <NA>       V             16     2     0
## 2362            Chlamydiae  <NA>       V             16     2     0
## 2363           Chloroflexi  <NA>       V             16     2     0
## 2364        Chrysiogenetes  <NA>       V             16     2     0
## 2365            Clostridia  <NA>       V             16     2 17572
## 2366         Cyanobacteria  <NA>       V             16     2     1
## 2367     Dehalococcoidetes  <NA>       V             16     2     0
## 2368            Deinococci  <NA>       V             16     2    11
## 2369   Deltaproteobacteria  <NA>       V             16     2     8
## 2370 Epsilonproteobacteria  <NA>       V             16     2     0
## 2371       Erysipelotrichi  <NA>       V             16     2   496
## 2372         Fibrobacteria  <NA>       V             16     2     0
## 2373         Flavobacteria  <NA>       V             16     2    51
## 2374          Fusobacteria  <NA>       V             16     2    32
## 2375   Gammaproteobacteria  <NA>       V             16     2   607
## 2376      Gemmatimonadetes  <NA>       V             16     2     0
## 2377            Holophagae  <NA>       V             16     2     0
## 2378         Lentisphaeria  <NA>       V             16     2     2
## 2379       Methanobacteria  <NA>       V             16     2     0
## 2380       Methanomicrobia  <NA>       V             16     2     0
## 2381            Mollicutes  <NA>       V             16     2    11
## 2382            Nitrospira  <NA>       V             16     2     0
## 2383              Opitutae  <NA>       V             16     2     2
## 2384      Planctomycetacia  <NA>       V             16     2     0
## 2385       Sphingobacteria  <NA>       V             16     2    29
## 2386          Spirochaetes  <NA>       V             16     2     3
## 2387          Subdivision3  <NA>       V             16     2     0
## 2388           Synergistia  <NA>       V             16     2     9
## 2389        Thermomicrobia  <NA>       V             16     2     0
## 2390        Thermoplasmata  <NA>       V             16     2     0
## 2391           Thermotogae  <NA>       V             16     2     0
## 2392               Unknown  <NA>       V             16     2  1365
## 2393         Acidobacteria     1       V             17     1     0
## 2394         Acidobacteria    10       V             17     1     0
## 2395         Acidobacteria    14       V             17     1     0
## 2396         Acidobacteria    16       V             17     1     0
## 2397         Acidobacteria    17       V             17     1     0
## 2398         Acidobacteria    18       V             17     1     0
## 2399         Acidobacteria    21       V             17     1     0
## 2400         Acidobacteria    22       V             17     1     0
## 2401         Acidobacteria     3       V             17     1     0
## 2402         Acidobacteria     4       V             17     1     0
## 2403         Acidobacteria     5       V             17     1     0
## 2404         Acidobacteria     6       V             17     1     0
## 2405         Acidobacteria     7       V             17     1     0
## 2406         Acidobacteria     9       V             17     1     0
## 2407        Actinobacteria  <NA>       V             17     1   112
## 2408   Alphaproteobacteria  <NA>       V             17     1    24
## 2409          Anaerolineae  <NA>       V             17     1     0
## 2410               Bacilli  <NA>       V             17     1  1624
## 2411           Bacteroidia  <NA>       V             17     1 11392
## 2412    Betaproteobacteria  <NA>       V             17     1    95
## 2413           Caldilineae  <NA>       V             17     1     0
## 2414            Chlamydiae  <NA>       V             17     1     0
## 2415           Chloroflexi  <NA>       V             17     1     0
## 2416        Chrysiogenetes  <NA>       V             17     1     0
## 2417            Clostridia  <NA>       V             17     1  7722
## 2418         Cyanobacteria  <NA>       V             17     1     0
## 2419     Dehalococcoidetes  <NA>       V             17     1     0
## 2420            Deinococci  <NA>       V             17     1    19
## 2421   Deltaproteobacteria  <NA>       V             17     1     1
## 2422 Epsilonproteobacteria  <NA>       V             17     1     0
## 2423       Erysipelotrichi  <NA>       V             17     1   292
## 2424         Fibrobacteria  <NA>       V             17     1     0
## 2425         Flavobacteria  <NA>       V             17     1   341
## 2426          Fusobacteria  <NA>       V             17     1   152
## 2427   Gammaproteobacteria  <NA>       V             17     1   482
## 2428      Gemmatimonadetes  <NA>       V             17     1     0
## 2429            Holophagae  <NA>       V             17     1     0
## 2430         Lentisphaeria  <NA>       V             17     1     0
## 2431       Methanobacteria  <NA>       V             17     1     0
## 2432       Methanomicrobia  <NA>       V             17     1     0
## 2433            Mollicutes  <NA>       V             17     1    54
## 2434            Nitrospira  <NA>       V             17     1     0
## 2435              Opitutae  <NA>       V             17     1     1
## 2436      Planctomycetacia  <NA>       V             17     1     0
## 2437       Sphingobacteria  <NA>       V             17     1    17
## 2438          Spirochaetes  <NA>       V             17     1     1
## 2439          Subdivision3  <NA>       V             17     1     0
## 2440           Synergistia  <NA>       V             17     1     0
## 2441        Thermomicrobia  <NA>       V             17     1     1
## 2442        Thermoplasmata  <NA>       V             17     1     0
## 2443           Thermotogae  <NA>       V             17     1     0
## 2444               Unknown  <NA>       V             17     1    87
## 2445         Acidobacteria     1       V             17     2     0
## 2446         Acidobacteria    10       V             17     2     0
## 2447         Acidobacteria    14       V             17     2     0
## 2448         Acidobacteria    16       V             17     2     0
## 2449         Acidobacteria    17       V             17     2     0
## 2450         Acidobacteria    18       V             17     2     0
## 2451         Acidobacteria    21       V             17     2     0
## 2452         Acidobacteria    22       V             17     2     0
## 2453         Acidobacteria     3       V             17     2     0
## 2454         Acidobacteria     4       V             17     2     0
## 2455         Acidobacteria     5       V             17     2     0
## 2456         Acidobacteria     6       V             17     2     0
## 2457         Acidobacteria     7       V             17     2     0
## 2458         Acidobacteria     9       V             17     2     0
## 2459        Actinobacteria  <NA>       V             17     2   248
## 2460   Alphaproteobacteria  <NA>       V             17     2    89
## 2461          Anaerolineae  <NA>       V             17     2     0
## 2462               Bacilli  <NA>       V             17     2  1060
## 2463           Bacteroidia  <NA>       V             17     2  2140
## 2464    Betaproteobacteria  <NA>       V             17     2   172
## 2465           Caldilineae  <NA>       V             17     2     0
## 2466            Chlamydiae  <NA>       V             17     2     0
## 2467           Chloroflexi  <NA>       V             17     2     0
## 2468        Chrysiogenetes  <NA>       V             17     2     0
## 2469            Clostridia  <NA>       V             17     2 13875
## 2470         Cyanobacteria  <NA>       V             17     2     0
## 2471     Dehalococcoidetes  <NA>       V             17     2     0
## 2472            Deinococci  <NA>       V             17     2    21
## 2473   Deltaproteobacteria  <NA>       V             17     2     1
## 2474 Epsilonproteobacteria  <NA>       V             17     2     0
## 2475       Erysipelotrichi  <NA>       V             17     2   328
## 2476         Fibrobacteria  <NA>       V             17     2     0
## 2477         Flavobacteria  <NA>       V             17     2   395
## 2478          Fusobacteria  <NA>       V             17     2   207
## 2479   Gammaproteobacteria  <NA>       V             17     2  1710
## 2480      Gemmatimonadetes  <NA>       V             17     2     0
## 2481            Holophagae  <NA>       V             17     2     0
## 2482         Lentisphaeria  <NA>       V             17     2     9
## 2483       Methanobacteria  <NA>       V             17     2     0
## 2484       Methanomicrobia  <NA>       V             17     2     0
## 2485            Mollicutes  <NA>       V             17     2   114
## 2486            Nitrospira  <NA>       V             17     2     0
## 2487              Opitutae  <NA>       V             17     2     1
## 2488      Planctomycetacia  <NA>       V             17     2     0
## 2489       Sphingobacteria  <NA>       V             17     2    41
## 2490          Spirochaetes  <NA>       V             17     2     3
## 2491          Subdivision3  <NA>       V             17     2     0
## 2492           Synergistia  <NA>       V             17     2     5
## 2493        Thermomicrobia  <NA>       V             17     2     1
## 2494        Thermoplasmata  <NA>       V             17     2     0
## 2495           Thermotogae  <NA>       V             17     2     0
## 2496               Unknown  <NA>       V             17     2   285
## 2497         Acidobacteria     1       V             18     1     0
## 2498         Acidobacteria    10       V             18     1     0
## 2499         Acidobacteria    14       V             18     1     0
## 2500         Acidobacteria    16       V             18     1     0
## 2501         Acidobacteria    17       V             18     1     0
## 2502         Acidobacteria    18       V             18     1     0
## 2503         Acidobacteria    21       V             18     1     0
## 2504         Acidobacteria    22       V             18     1     0
## 2505         Acidobacteria     3       V             18     1     0
## 2506         Acidobacteria     4       V             18     1     0
## 2507         Acidobacteria     5       V             18     1     0
## 2508         Acidobacteria     6       V             18     1     0
## 2509         Acidobacteria     7       V             18     1     0
## 2510         Acidobacteria     9       V             18     1     0
## 2511        Actinobacteria  <NA>       V             18     1   116
## 2512   Alphaproteobacteria  <NA>       V             18     1    10
## 2513          Anaerolineae  <NA>       V             18     1     0
## 2514               Bacilli  <NA>       V             18     1  2301
## 2515           Bacteroidia  <NA>       V             18     1   389
## 2516    Betaproteobacteria  <NA>       V             18     1    76
## 2517           Caldilineae  <NA>       V             18     1     0
## 2518            Chlamydiae  <NA>       V             18     1     0
## 2519           Chloroflexi  <NA>       V             18     1     0
## 2520        Chrysiogenetes  <NA>       V             18     1     0
## 2521            Clostridia  <NA>       V             18     1  7481
## 2522         Cyanobacteria  <NA>       V             18     1     0
## 2523     Dehalococcoidetes  <NA>       V             18     1     0
## 2524            Deinococci  <NA>       V             18     1     1
## 2525   Deltaproteobacteria  <NA>       V             18     1     0
## 2526 Epsilonproteobacteria  <NA>       V             18     1     0
## 2527       Erysipelotrichi  <NA>       V             18     1   219
## 2528         Fibrobacteria  <NA>       V             18     1     0
## 2529         Flavobacteria  <NA>       V             18     1    54
## 2530          Fusobacteria  <NA>       V             18     1    10
## 2531   Gammaproteobacteria  <NA>       V             18     1  1449
## 2532      Gemmatimonadetes  <NA>       V             18     1     0
## 2533            Holophagae  <NA>       V             18     1     0
## 2534         Lentisphaeria  <NA>       V             18     1     4
## 2535       Methanobacteria  <NA>       V             18     1     0
## 2536       Methanomicrobia  <NA>       V             18     1     0
## 2537            Mollicutes  <NA>       V             18     1     2
## 2538            Nitrospira  <NA>       V             18     1     0
## 2539              Opitutae  <NA>       V             18     1     0
## 2540      Planctomycetacia  <NA>       V             18     1     0
## 2541       Sphingobacteria  <NA>       V             18     1    17
## 2542          Spirochaetes  <NA>       V             18     1     0
## 2543          Subdivision3  <NA>       V             18     1     0
## 2544           Synergistia  <NA>       V             18     1     0
## 2545        Thermomicrobia  <NA>       V             18     1     1
## 2546        Thermoplasmata  <NA>       V             18     1     0
## 2547           Thermotogae  <NA>       V             18     1     0
## 2548               Unknown  <NA>       V             18     1    55
## 2549         Acidobacteria     1       V             18     2     0
## 2550         Acidobacteria    10       V             18     2     0
## 2551         Acidobacteria    14       V             18     2     0
## 2552         Acidobacteria    16       V             18     2     0
## 2553         Acidobacteria    17       V             18     2     0
## 2554         Acidobacteria    18       V             18     2     0
## 2555         Acidobacteria    21       V             18     2     0
## 2556         Acidobacteria    22       V             18     2     0
## 2557         Acidobacteria     3       V             18     2     0
## 2558         Acidobacteria     4       V             18     2     0
## 2559         Acidobacteria     5       V             18     2     0
## 2560         Acidobacteria     6       V             18     2     0
## 2561         Acidobacteria     7       V             18     2     0
## 2562         Acidobacteria     9       V             18     2     0
## 2563        Actinobacteria  <NA>       V             18     2    77
## 2564   Alphaproteobacteria  <NA>       V             18     2    14
## 2565          Anaerolineae  <NA>       V             18     2     0
## 2566               Bacilli  <NA>       V             18     2  1549
## 2567           Bacteroidia  <NA>       V             18     2   368
## 2568    Betaproteobacteria  <NA>       V             18     2   276
## 2569           Caldilineae  <NA>       V             18     2     0
## 2570            Chlamydiae  <NA>       V             18     2     0
## 2571           Chloroflexi  <NA>       V             18     2     0
## 2572        Chrysiogenetes  <NA>       V             18     2     0
## 2573            Clostridia  <NA>       V             18     2  6071
## 2574         Cyanobacteria  <NA>       V             18     2     0
## 2575     Dehalococcoidetes  <NA>       V             18     2     0
## 2576            Deinococci  <NA>       V             18     2    21
## 2577   Deltaproteobacteria  <NA>       V             18     2     6
## 2578 Epsilonproteobacteria  <NA>       V             18     2     0
## 2579       Erysipelotrichi  <NA>       V             18     2    66
## 2580         Fibrobacteria  <NA>       V             18     2     0
## 2581         Flavobacteria  <NA>       V             18     2   170
## 2582          Fusobacteria  <NA>       V             18     2     3
## 2583   Gammaproteobacteria  <NA>       V             18     2  2491
## 2584      Gemmatimonadetes  <NA>       V             18     2     0
## 2585            Holophagae  <NA>       V             18     2     0
## 2586         Lentisphaeria  <NA>       V             18     2     1
## 2587       Methanobacteria  <NA>       V             18     2     0
## 2588       Methanomicrobia  <NA>       V             18     2     0
## 2589            Mollicutes  <NA>       V             18     2    38
## 2590            Nitrospira  <NA>       V             18     2     0
## 2591              Opitutae  <NA>       V             18     2     1
## 2592      Planctomycetacia  <NA>       V             18     2     0
## 2593       Sphingobacteria  <NA>       V             18     2    38
## 2594          Spirochaetes  <NA>       V             18     2     0
## 2595          Subdivision3  <NA>       V             18     2     0
## 2596           Synergistia  <NA>       V             18     2     0
## 2597        Thermomicrobia  <NA>       V             18     2     1
## 2598        Thermoplasmata  <NA>       V             18     2     0
## 2599           Thermotogae  <NA>       V             18     2     0
## 2600               Unknown  <NA>       V             18     2    54
## 2601         Acidobacteria     1       V             18     3     0
## 2602         Acidobacteria    10       V             18     3     0
## 2603         Acidobacteria    14       V             18     3     0
## 2604         Acidobacteria    16       V             18     3     0
## 2605         Acidobacteria    17       V             18     3     0
## 2606         Acidobacteria    18       V             18     3     0
## 2607         Acidobacteria    21       V             18     3     0
## 2608         Acidobacteria    22       V             18     3     0
## 2609         Acidobacteria     3       V             18     3     0
## 2610         Acidobacteria     4       V             18     3     0
## 2611         Acidobacteria     5       V             18     3     0
## 2612         Acidobacteria     6       V             18     3     1
## 2613         Acidobacteria     7       V             18     3     0
## 2614         Acidobacteria     9       V             18     3     0
## 2615        Actinobacteria  <NA>       V             18     3   288
## 2616   Alphaproteobacteria  <NA>       V             18     3   441
## 2617          Anaerolineae  <NA>       V             18     3     0
## 2618               Bacilli  <NA>       V             18     3    14
## 2619           Bacteroidia  <NA>       V             18     3   176
## 2620    Betaproteobacteria  <NA>       V             18     3    37
## 2621           Caldilineae  <NA>       V             18     3    24
## 2622            Chlamydiae  <NA>       V             18     3     0
## 2623           Chloroflexi  <NA>       V             18     3     0
## 2624        Chrysiogenetes  <NA>       V             18     3     0
## 2625            Clostridia  <NA>       V             18     3  1044
## 2626         Cyanobacteria  <NA>       V             18     3     0
## 2627     Dehalococcoidetes  <NA>       V             18     3     0
## 2628            Deinococci  <NA>       V             18     3   101
## 2629   Deltaproteobacteria  <NA>       V             18     3   135
## 2630 Epsilonproteobacteria  <NA>       V             18     3     0
## 2631       Erysipelotrichi  <NA>       V             18     3     4
## 2632         Fibrobacteria  <NA>       V             18     3     0
## 2633         Flavobacteria  <NA>       V             18     3   280
## 2634          Fusobacteria  <NA>       V             18     3     0
## 2635   Gammaproteobacteria  <NA>       V             18     3   866
## 2636      Gemmatimonadetes  <NA>       V             18     3     0
## 2637            Holophagae  <NA>       V             18     3     0
## 2638         Lentisphaeria  <NA>       V             18     3     0
## 2639       Methanobacteria  <NA>       V             18     3     0
## 2640       Methanomicrobia  <NA>       V             18     3     0
## 2641            Mollicutes  <NA>       V             18     3     0
## 2642            Nitrospira  <NA>       V             18     3     0
## 2643              Opitutae  <NA>       V             18     3     5
## 2644      Planctomycetacia  <NA>       V             18     3     2
## 2645       Sphingobacteria  <NA>       V             18     3   236
## 2646          Spirochaetes  <NA>       V             18     3     0
## 2647          Subdivision3  <NA>       V             18     3     0
## 2648           Synergistia  <NA>       V             18     3     0
## 2649        Thermomicrobia  <NA>       V             18     3    32
## 2650        Thermoplasmata  <NA>       V             18     3     0
## 2651           Thermotogae  <NA>       V             18     3     0
## 2652               Unknown  <NA>       V             18     3   404
## 2653         Acidobacteria     1       V             18     4     0
## 2654         Acidobacteria    10       V             18     4     0
## 2655         Acidobacteria    14       V             18     4     0
## 2656         Acidobacteria    16       V             18     4     0
## 2657         Acidobacteria    17       V             18     4     0
## 2658         Acidobacteria    18       V             18     4     0
## 2659         Acidobacteria    21       V             18     4     0
## 2660         Acidobacteria    22       V             18     4     0
## 2661         Acidobacteria     3       V             18     4    10
## 2662         Acidobacteria     4       V             18     4     0
## 2663         Acidobacteria     5       V             18     4     0
## 2664         Acidobacteria     6       V             18     4    11
## 2665         Acidobacteria     7       V             18     4     0
## 2666         Acidobacteria     9       V             18     4     0
## 2667        Actinobacteria  <NA>       V             18     4   683
## 2668   Alphaproteobacteria  <NA>       V             18     4   865
## 2669          Anaerolineae  <NA>       V             18     4     0
## 2670               Bacilli  <NA>       V             18     4   103
## 2671           Bacteroidia  <NA>       V             18     4   976
## 2672    Betaproteobacteria  <NA>       V             18     4   198
## 2673           Caldilineae  <NA>       V             18     4    68
## 2674            Chlamydiae  <NA>       V             18     4     3
## 2675           Chloroflexi  <NA>       V             18     4     0
## 2676        Chrysiogenetes  <NA>       V             18     4     0
## 2677            Clostridia  <NA>       V             18     4  6246
## 2678         Cyanobacteria  <NA>       V             18     4     1
## 2679     Dehalococcoidetes  <NA>       V             18     4     0
## 2680            Deinococci  <NA>       V             18     4    86
## 2681   Deltaproteobacteria  <NA>       V             18     4   105
## 2682 Epsilonproteobacteria  <NA>       V             18     4     0
## 2683       Erysipelotrichi  <NA>       V             18     4   112
## 2684         Fibrobacteria  <NA>       V             18     4     0
## 2685         Flavobacteria  <NA>       V             18     4  1708
## 2686          Fusobacteria  <NA>       V             18     4     2
## 2687   Gammaproteobacteria  <NA>       V             18     4  1225
## 2688      Gemmatimonadetes  <NA>       V             18     4     1
## 2689            Holophagae  <NA>       V             18     4     0
## 2690         Lentisphaeria  <NA>       V             18     4     2
## 2691       Methanobacteria  <NA>       V             18     4     0
## 2692       Methanomicrobia  <NA>       V             18     4     0
## 2693            Mollicutes  <NA>       V             18     4    28
## 2694            Nitrospira  <NA>       V             18     4     0
## 2695              Opitutae  <NA>       V             18     4    52
## 2696      Planctomycetacia  <NA>       V             18     4    14
## 2697       Sphingobacteria  <NA>       V             18     4   305
## 2698          Spirochaetes  <NA>       V             18     4    19
## 2699          Subdivision3  <NA>       V             18     4     0
## 2700           Synergistia  <NA>       V             18     4     0
## 2701        Thermomicrobia  <NA>       V             18     4    84
## 2702        Thermoplasmata  <NA>       V             18     4     0
## 2703           Thermotogae  <NA>       V             18     4     0
## 2704               Unknown  <NA>       V             18     4  1483
## 2705         Acidobacteria     1       V             19     1     0
## 2706         Acidobacteria    10       V             19     1     0
## 2707         Acidobacteria    14       V             19     1     0
## 2708         Acidobacteria    16       V             19     1     0
## 2709         Acidobacteria    17       V             19     1     0
## 2710         Acidobacteria    18       V             19     1     0
## 2711         Acidobacteria    21       V             19     1     0
## 2712         Acidobacteria    22       V             19     1     0
## 2713         Acidobacteria     3       V             19     1     0
## 2714         Acidobacteria     4       V             19     1     0
## 2715         Acidobacteria     5       V             19     1     0
## 2716         Acidobacteria     6       V             19     1     0
## 2717         Acidobacteria     7       V             19     1     0
## 2718         Acidobacteria     9       V             19     1     0
## 2719        Actinobacteria  <NA>       V             19     1   313
## 2720   Alphaproteobacteria  <NA>       V             19     1   196
## 2721          Anaerolineae  <NA>       V             19     1     0
## 2722               Bacilli  <NA>       V             19     1   277
## 2723           Bacteroidia  <NA>       V             19     1  2560
## 2724    Betaproteobacteria  <NA>       V             19     1   103
## 2725           Caldilineae  <NA>       V             19     1     0
## 2726            Chlamydiae  <NA>       V             19     1     0
## 2727           Chloroflexi  <NA>       V             19     1     0
## 2728        Chrysiogenetes  <NA>       V             19     1     0
## 2729            Clostridia  <NA>       V             19     1  1720
## 2730         Cyanobacteria  <NA>       V             19     1     0
## 2731     Dehalococcoidetes  <NA>       V             19     1     0
## 2732            Deinococci  <NA>       V             19     1    13
## 2733   Deltaproteobacteria  <NA>       V             19     1     9
## 2734 Epsilonproteobacteria  <NA>       V             19     1     0
## 2735       Erysipelotrichi  <NA>       V             19     1   234
## 2736         Fibrobacteria  <NA>       V             19     1     0
## 2737         Flavobacteria  <NA>       V             19     1  1546
## 2738          Fusobacteria  <NA>       V             19     1    27
## 2739   Gammaproteobacteria  <NA>       V             19     1  1145
## 2740      Gemmatimonadetes  <NA>       V             19     1     0
## 2741            Holophagae  <NA>       V             19     1     0
## 2742         Lentisphaeria  <NA>       V             19     1     3
## 2743       Methanobacteria  <NA>       V             19     1     0
## 2744       Methanomicrobia  <NA>       V             19     1     0
## 2745            Mollicutes  <NA>       V             19     1   736
## 2746            Nitrospira  <NA>       V             19     1     0
## 2747              Opitutae  <NA>       V             19     1     6
## 2748      Planctomycetacia  <NA>       V             19     1     0
## 2749       Sphingobacteria  <NA>       V             19     1   141
## 2750          Spirochaetes  <NA>       V             19     1   557
## 2751          Subdivision3  <NA>       V             19     1     0
## 2752           Synergistia  <NA>       V             19     1     3
## 2753        Thermomicrobia  <NA>       V             19     1     0
## 2754        Thermoplasmata  <NA>       V             19     1     0
## 2755           Thermotogae  <NA>       V             19     1     0
## 2756               Unknown  <NA>       V             19     1   484
## 2757         Acidobacteria     1       V             19     2     0
## 2758         Acidobacteria    10       V             19     2     0
## 2759         Acidobacteria    14       V             19     2     0
## 2760         Acidobacteria    16       V             19     2     0
## 2761         Acidobacteria    17       V             19     2     0
## 2762         Acidobacteria    18       V             19     2     0
## 2763         Acidobacteria    21       V             19     2     0
## 2764         Acidobacteria    22       V             19     2     0
## 2765         Acidobacteria     3       V             19     2     0
## 2766         Acidobacteria     4       V             19     2     0
## 2767         Acidobacteria     5       V             19     2     0
## 2768         Acidobacteria     6       V             19     2     0
## 2769         Acidobacteria     7       V             19     2     0
## 2770         Acidobacteria     9       V             19     2     0
## 2771        Actinobacteria  <NA>       V             19     2   221
## 2772   Alphaproteobacteria  <NA>       V             19     2   109
## 2773          Anaerolineae  <NA>       V             19     2     0
## 2774               Bacilli  <NA>       V             19     2    63
## 2775           Bacteroidia  <NA>       V             19     2   800
## 2776    Betaproteobacteria  <NA>       V             19     2    21
## 2777           Caldilineae  <NA>       V             19     2     2
## 2778            Chlamydiae  <NA>       V             19     2     0
## 2779           Chloroflexi  <NA>       V             19     2     0
## 2780        Chrysiogenetes  <NA>       V             19     2     0
## 2781            Clostridia  <NA>       V             19     2   493
## 2782         Cyanobacteria  <NA>       V             19     2     0
## 2783     Dehalococcoidetes  <NA>       V             19     2     0
## 2784            Deinococci  <NA>       V             19     2    87
## 2785   Deltaproteobacteria  <NA>       V             19     2    10
## 2786 Epsilonproteobacteria  <NA>       V             19     2     0
## 2787       Erysipelotrichi  <NA>       V             19     2    52
## 2788         Fibrobacteria  <NA>       V             19     2     0
## 2789         Flavobacteria  <NA>       V             19     2   257
## 2790          Fusobacteria  <NA>       V             19     2     5
## 2791   Gammaproteobacteria  <NA>       V             19     2   274
## 2792      Gemmatimonadetes  <NA>       V             19     2     0
## 2793            Holophagae  <NA>       V             19     2     0
## 2794         Lentisphaeria  <NA>       V             19     2     0
## 2795       Methanobacteria  <NA>       V             19     2     0
## 2796       Methanomicrobia  <NA>       V             19     2     0
## 2797            Mollicutes  <NA>       V             19     2    31
## 2798            Nitrospira  <NA>       V             19     2     0
## 2799              Opitutae  <NA>       V             19     2     2
## 2800      Planctomycetacia  <NA>       V             19     2     2
## 2801       Sphingobacteria  <NA>       V             19     2    44
## 2802          Spirochaetes  <NA>       V             19     2   176
## 2803          Subdivision3  <NA>       V             19     2     0
## 2804           Synergistia  <NA>       V             19     2     0
## 2805        Thermomicrobia  <NA>       V             19     2    15
## 2806        Thermoplasmata  <NA>       V             19     2     0
## 2807           Thermotogae  <NA>       V             19     2     0
## 2808               Unknown  <NA>       V             19     2   176
## 2809         Acidobacteria     1       V             19     3     0
## 2810         Acidobacteria    10       V             19     3     0
## 2811         Acidobacteria    14       V             19     3     0
## 2812         Acidobacteria    16       V             19     3     0
## 2813         Acidobacteria    17       V             19     3     0
## 2814         Acidobacteria    18       V             19     3     0
## 2815         Acidobacteria    21       V             19     3     0
## 2816         Acidobacteria    22       V             19     3     0
## 2817         Acidobacteria     3       V             19     3     9
## 2818         Acidobacteria     4       V             19     3     0
## 2819         Acidobacteria     5       V             19     3     0
## 2820         Acidobacteria     6       V             19     3     2
## 2821         Acidobacteria     7       V             19     3     0
## 2822         Acidobacteria     9       V             19     3     0
## 2823        Actinobacteria  <NA>       V             19     3   352
## 2824   Alphaproteobacteria  <NA>       V             19     3   656
## 2825          Anaerolineae  <NA>       V             19     3     0
## 2826               Bacilli  <NA>       V             19     3    32
## 2827           Bacteroidia  <NA>       V             19     3   262
## 2828    Betaproteobacteria  <NA>       V             19     3    61
## 2829           Caldilineae  <NA>       V             19     3    53
## 2830            Chlamydiae  <NA>       V             19     3     0
## 2831           Chloroflexi  <NA>       V             19     3     0
## 2832        Chrysiogenetes  <NA>       V             19     3     0
## 2833            Clostridia  <NA>       V             19     3  5970
## 2834         Cyanobacteria  <NA>       V             19     3     0
## 2835     Dehalococcoidetes  <NA>       V             19     3     0
## 2836            Deinococci  <NA>       V             19     3    73
## 2837   Deltaproteobacteria  <NA>       V             19     3    89
## 2838 Epsilonproteobacteria  <NA>       V             19     3     0
## 2839       Erysipelotrichi  <NA>       V             19     3    35
## 2840         Fibrobacteria  <NA>       V             19     3     0
## 2841         Flavobacteria  <NA>       V             19     3  1995
## 2842          Fusobacteria  <NA>       V             19     3     0
## 2843   Gammaproteobacteria  <NA>       V             19     3   356
## 2844      Gemmatimonadetes  <NA>       V             19     3     0
## 2845            Holophagae  <NA>       V             19     3     0
## 2846         Lentisphaeria  <NA>       V             19     3     0
## 2847       Methanobacteria  <NA>       V             19     3     0
## 2848       Methanomicrobia  <NA>       V             19     3     0
## 2849            Mollicutes  <NA>       V             19     3     3
## 2850            Nitrospira  <NA>       V             19     3     0
## 2851              Opitutae  <NA>       V             19     3     1
## 2852      Planctomycetacia  <NA>       V             19     3    29
## 2853       Sphingobacteria  <NA>       V             19     3   123
## 2854          Spirochaetes  <NA>       V             19     3     6
## 2855          Subdivision3  <NA>       V             19     3     0
## 2856           Synergistia  <NA>       V             19     3     0
## 2857        Thermomicrobia  <NA>       V             19     3    29
## 2858        Thermoplasmata  <NA>       V             19     3     0
## 2859           Thermotogae  <NA>       V             19     3     0
## 2860               Unknown  <NA>       V             19     3   371
## 2861         Acidobacteria     1       V              2     1     0
## 2862         Acidobacteria    10       V              2     1     0
## 2863         Acidobacteria    14       V              2     1     0
## 2864         Acidobacteria    16       V              2     1     0
## 2865         Acidobacteria    17       V              2     1     0
## 2866         Acidobacteria    18       V              2     1     0
## 2867         Acidobacteria    21       V              2     1     0
## 2868         Acidobacteria    22       V              2     1     0
## 2869         Acidobacteria     3       V              2     1     0
## 2870         Acidobacteria     4       V              2     1     0
## 2871         Acidobacteria     5       V              2     1     0
## 2872         Acidobacteria     6       V              2     1     0
## 2873         Acidobacteria     7       V              2     1     0
## 2874         Acidobacteria     9       V              2     1     0
## 2875        Actinobacteria  <NA>       V              2     1    15
## 2876   Alphaproteobacteria  <NA>       V              2     1    14
## 2877          Anaerolineae  <NA>       V              2     1     0
## 2878               Bacilli  <NA>       V              2     1    18
## 2879           Bacteroidia  <NA>       V              2     1    48
## 2880    Betaproteobacteria  <NA>       V              2     1     0
## 2881           Caldilineae  <NA>       V              2     1     0
## 2882            Chlamydiae  <NA>       V              2     1     0
## 2883           Chloroflexi  <NA>       V              2     1     0
## 2884        Chrysiogenetes  <NA>       V              2     1     0
## 2885            Clostridia  <NA>       V              2     1   174
## 2886         Cyanobacteria  <NA>       V              2     1     0
## 2887     Dehalococcoidetes  <NA>       V              2     1     0
## 2888            Deinococci  <NA>       V              2     1     0
## 2889   Deltaproteobacteria  <NA>       V              2     1     0
## 2890 Epsilonproteobacteria  <NA>       V              2     1     0
## 2891       Erysipelotrichi  <NA>       V              2     1     6
## 2892         Fibrobacteria  <NA>       V              2     1     0
## 2893         Flavobacteria  <NA>       V              2     1    32
## 2894          Fusobacteria  <NA>       V              2     1     0
## 2895   Gammaproteobacteria  <NA>       V              2     1    60
## 2896      Gemmatimonadetes  <NA>       V              2     1     0
## 2897            Holophagae  <NA>       V              2     1     0
## 2898         Lentisphaeria  <NA>       V              2     1     1
## 2899       Methanobacteria  <NA>       V              2     1     0
## 2900       Methanomicrobia  <NA>       V              2     1     0
## 2901            Mollicutes  <NA>       V              2     1    18
## 2902            Nitrospira  <NA>       V              2     1     0
## 2903              Opitutae  <NA>       V              2     1     0
## 2904      Planctomycetacia  <NA>       V              2     1     0
## 2905       Sphingobacteria  <NA>       V              2     1     4
## 2906          Spirochaetes  <NA>       V              2     1     0
## 2907          Subdivision3  <NA>       V              2     1     0
## 2908           Synergistia  <NA>       V              2     1     0
## 2909        Thermomicrobia  <NA>       V              2     1     0
## 2910        Thermoplasmata  <NA>       V              2     1     0
## 2911           Thermotogae  <NA>       V              2     1     0
## 2912               Unknown  <NA>       V              2     1    16
## 2913         Acidobacteria     1       V              2     2     0
## 2914         Acidobacteria    10       V              2     2     0
## 2915         Acidobacteria    14       V              2     2     0
## 2916         Acidobacteria    16       V              2     2     0
## 2917         Acidobacteria    17       V              2     2     0
## 2918         Acidobacteria    18       V              2     2     0
## 2919         Acidobacteria    21       V              2     2     0
## 2920         Acidobacteria    22       V              2     2     0
## 2921         Acidobacteria     3       V              2     2     0
## 2922         Acidobacteria     4       V              2     2     0
## 2923         Acidobacteria     5       V              2     2     0
## 2924         Acidobacteria     6       V              2     2     0
## 2925         Acidobacteria     7       V              2     2     0
## 2926         Acidobacteria     9       V              2     2     0
## 2927        Actinobacteria  <NA>       V              2     2  1717
## 2928   Alphaproteobacteria  <NA>       V              2     2   532
## 2929          Anaerolineae  <NA>       V              2     2     0
## 2930               Bacilli  <NA>       V              2     2   177
## 2931           Bacteroidia  <NA>       V              2     2    37
## 2932    Betaproteobacteria  <NA>       V              2     2    73
## 2933           Caldilineae  <NA>       V              2     2     0
## 2934            Chlamydiae  <NA>       V              2     2     0
## 2935           Chloroflexi  <NA>       V              2     2     0
## 2936        Chrysiogenetes  <NA>       V              2     2     0
## 2937            Clostridia  <NA>       V              2     2    93
## 2938         Cyanobacteria  <NA>       V              2     2     0
## 2939     Dehalococcoidetes  <NA>       V              2     2     0
## 2940            Deinococci  <NA>       V              2     2   205
## 2941   Deltaproteobacteria  <NA>       V              2     2    66
## 2942 Epsilonproteobacteria  <NA>       V              2     2     0
## 2943       Erysipelotrichi  <NA>       V              2     2    13
## 2944         Fibrobacteria  <NA>       V              2     2     0
## 2945         Flavobacteria  <NA>       V              2     2   325
## 2946          Fusobacteria  <NA>       V              2     2     0
## 2947   Gammaproteobacteria  <NA>       V              2     2   354
## 2948      Gemmatimonadetes  <NA>       V              2     2     0
## 2949            Holophagae  <NA>       V              2     2     0
## 2950         Lentisphaeria  <NA>       V              2     2     0
## 2951       Methanobacteria  <NA>       V              2     2     0
## 2952       Methanomicrobia  <NA>       V              2     2     0
## 2953            Mollicutes  <NA>       V              2     2    44
## 2954            Nitrospira  <NA>       V              2     2     1
## 2955              Opitutae  <NA>       V              2     2   139
## 2956      Planctomycetacia  <NA>       V              2     2     2
## 2957       Sphingobacteria  <NA>       V              2     2  1141
## 2958          Spirochaetes  <NA>       V              2     2     0
## 2959          Subdivision3  <NA>       V              2     2     0
## 2960           Synergistia  <NA>       V              2     2     0
## 2961        Thermomicrobia  <NA>       V              2     2     9
## 2962        Thermoplasmata  <NA>       V              2     2     0
## 2963           Thermotogae  <NA>       V              2     2     0
## 2964               Unknown  <NA>       V              2     2   167
## 2965         Acidobacteria     1       V              2     3     0
## 2966         Acidobacteria    10       V              2     3     0
## 2967         Acidobacteria    14       V              2     3     0
## 2968         Acidobacteria    16       V              2     3     0
## 2969         Acidobacteria    17       V              2     3     0
## 2970         Acidobacteria    18       V              2     3     0
## 2971         Acidobacteria    21       V              2     3     0
## 2972         Acidobacteria    22       V              2     3     0
## 2973         Acidobacteria     3       V              2     3     0
## 2974         Acidobacteria     4       V              2     3     0
## 2975         Acidobacteria     5       V              2     3     0
## 2976         Acidobacteria     6       V              2     3     0
## 2977         Acidobacteria     7       V              2     3     0
## 2978         Acidobacteria     9       V              2     3     0
## 2979        Actinobacteria  <NA>       V              2     3   260
## 2980   Alphaproteobacteria  <NA>       V              2     3    90
## 2981          Anaerolineae  <NA>       V              2     3     0
## 2982               Bacilli  <NA>       V              2     3    49
## 2983           Bacteroidia  <NA>       V              2     3   100
## 2984    Betaproteobacteria  <NA>       V              2     3    17
## 2985           Caldilineae  <NA>       V              2     3     0
## 2986            Chlamydiae  <NA>       V              2     3     0
## 2987           Chloroflexi  <NA>       V              2     3     0
## 2988        Chrysiogenetes  <NA>       V              2     3     0
## 2989            Clostridia  <NA>       V              2     3   716
## 2990         Cyanobacteria  <NA>       V              2     3     0
## 2991     Dehalococcoidetes  <NA>       V              2     3     0
## 2992            Deinococci  <NA>       V              2     3    30
## 2993   Deltaproteobacteria  <NA>       V              2     3     6
## 2994 Epsilonproteobacteria  <NA>       V              2     3     0
## 2995       Erysipelotrichi  <NA>       V              2     3    14
## 2996         Fibrobacteria  <NA>       V              2     3     0
## 2997         Flavobacteria  <NA>       V              2     3   853
## 2998          Fusobacteria  <NA>       V              2     3     0
## 2999   Gammaproteobacteria  <NA>       V              2     3   165
## 3000      Gemmatimonadetes  <NA>       V              2     3     1
## 3001            Holophagae  <NA>       V              2     3     0
## 3002         Lentisphaeria  <NA>       V              2     3     0
## 3003       Methanobacteria  <NA>       V              2     3     0
## 3004       Methanomicrobia  <NA>       V              2     3     0
## 3005            Mollicutes  <NA>       V              2     3    85
## 3006            Nitrospira  <NA>       V              2     3     0
## 3007              Opitutae  <NA>       V              2     3     7
## 3008      Planctomycetacia  <NA>       V              2     3     0
## 3009       Sphingobacteria  <NA>       V              2     3   156
## 3010          Spirochaetes  <NA>       V              2     3     0
## 3011          Subdivision3  <NA>       V              2     3     0
## 3012           Synergistia  <NA>       V              2     3     0
## 3013        Thermomicrobia  <NA>       V              2     3     1
## 3014        Thermoplasmata  <NA>       V              2     3     0
## 3015           Thermotogae  <NA>       V              2     3     0
## 3016               Unknown  <NA>       V              2     3   150
## 3017         Acidobacteria     1       V             20     1     0
## 3018         Acidobacteria    10       V             20     1     0
## 3019         Acidobacteria    14       V             20     1     0
## 3020         Acidobacteria    16       V             20     1     0
## 3021         Acidobacteria    17       V             20     1     0
## 3022         Acidobacteria    18       V             20     1     0
## 3023         Acidobacteria    21       V             20     1     0
## 3024         Acidobacteria    22       V             20     1     0
## 3025         Acidobacteria     3       V             20     1     0
## 3026         Acidobacteria     4       V             20     1     0
## 3027         Acidobacteria     5       V             20     1     0
## 3028         Acidobacteria     6       V             20     1     0
## 3029         Acidobacteria     7       V             20     1     0
## 3030         Acidobacteria     9       V             20     1     0
## 3031        Actinobacteria  <NA>       V             20     1   425
## 3032   Alphaproteobacteria  <NA>       V             20     1   317
## 3033          Anaerolineae  <NA>       V             20     1     0
## 3034               Bacilli  <NA>       V             20     1  2266
## 3035           Bacteroidia  <NA>       V             20     1  1652
## 3036    Betaproteobacteria  <NA>       V             20     1   108
## 3037           Caldilineae  <NA>       V             20     1     0
## 3038            Chlamydiae  <NA>       V             20     1     0
## 3039           Chloroflexi  <NA>       V             20     1     0
## 3040        Chrysiogenetes  <NA>       V             20     1     0
## 3041            Clostridia  <NA>       V             20     1  5878
## 3042         Cyanobacteria  <NA>       V             20     1     5
## 3043     Dehalococcoidetes  <NA>       V             20     1     0
## 3044            Deinococci  <NA>       V             20     1    43
## 3045   Deltaproteobacteria  <NA>       V             20     1     4
## 3046 Epsilonproteobacteria  <NA>       V             20     1     0
## 3047       Erysipelotrichi  <NA>       V             20     1   306
## 3048         Fibrobacteria  <NA>       V             20     1     0
## 3049         Flavobacteria  <NA>       V             20     1  1515
## 3050          Fusobacteria  <NA>       V             20     1     1
## 3051   Gammaproteobacteria  <NA>       V             20     1  2184
## 3052      Gemmatimonadetes  <NA>       V             20     1     0
## 3053            Holophagae  <NA>       V             20     1     0
## 3054         Lentisphaeria  <NA>       V             20     1     1
## 3055       Methanobacteria  <NA>       V             20     1     0
## 3056       Methanomicrobia  <NA>       V             20     1     0
## 3057            Mollicutes  <NA>       V             20     1  1721
## 3058            Nitrospira  <NA>       V             20     1     0
## 3059              Opitutae  <NA>       V             20     1    14
## 3060      Planctomycetacia  <NA>       V             20     1     0
## 3061       Sphingobacteria  <NA>       V             20     1   270
## 3062          Spirochaetes  <NA>       V             20     1     0
## 3063          Subdivision3  <NA>       V             20     1     0
## 3064           Synergistia  <NA>       V             20     1     0
## 3065        Thermomicrobia  <NA>       V             20     1     1
## 3066        Thermoplasmata  <NA>       V             20     1     0
## 3067           Thermotogae  <NA>       V             20     1     0
## 3068               Unknown  <NA>       V             20     1   725
## 3069         Acidobacteria     1       V             21     1     0
## 3070         Acidobacteria    10       V             21     1     0
## 3071         Acidobacteria    14       V             21     1     0
## 3072         Acidobacteria    16       V             21     1     0
## 3073         Acidobacteria    17       V             21     1     0
## 3074         Acidobacteria    18       V             21     1     0
## 3075         Acidobacteria    21       V             21     1     0
## 3076         Acidobacteria    22       V             21     1     0
## 3077         Acidobacteria     3       V             21     1     0
## 3078         Acidobacteria     4       V             21     1     0
## 3079         Acidobacteria     5       V             21     1     0
## 3080         Acidobacteria     6       V             21     1     0
## 3081         Acidobacteria     7       V             21     1     0
## 3082         Acidobacteria     9       V             21     1     0
## 3083        Actinobacteria  <NA>       V             21     1   608
## 3084   Alphaproteobacteria  <NA>       V             21     1   127
## 3085          Anaerolineae  <NA>       V             21     1     0
## 3086               Bacilli  <NA>       V             21     1   217
## 3087           Bacteroidia  <NA>       V             21     1   200
## 3088    Betaproteobacteria  <NA>       V             21     1    64
## 3089           Caldilineae  <NA>       V             21     1     0
## 3090            Chlamydiae  <NA>       V             21     1     0
## 3091           Chloroflexi  <NA>       V             21     1     0
## 3092        Chrysiogenetes  <NA>       V             21     1     0
## 3093            Clostridia  <NA>       V             21     1  4052
## 3094         Cyanobacteria  <NA>       V             21     1     0
## 3095     Dehalococcoidetes  <NA>       V             21     1     0
## 3096            Deinococci  <NA>       V             21     1    56
## 3097   Deltaproteobacteria  <NA>       V             21     1     9
## 3098 Epsilonproteobacteria  <NA>       V             21     1     0
## 3099       Erysipelotrichi  <NA>       V             21     1    66
## 3100         Fibrobacteria  <NA>       V             21     1     0
## 3101         Flavobacteria  <NA>       V             21     1  1489
## 3102          Fusobacteria  <NA>       V             21     1     0
## 3103   Gammaproteobacteria  <NA>       V             21     1  1131
## 3104      Gemmatimonadetes  <NA>       V             21     1     0
## 3105            Holophagae  <NA>       V             21     1     0
## 3106         Lentisphaeria  <NA>       V             21     1     1
## 3107       Methanobacteria  <NA>       V             21     1     0
## 3108       Methanomicrobia  <NA>       V             21     1     0
## 3109            Mollicutes  <NA>       V             21     1   406
## 3110            Nitrospira  <NA>       V             21     1     0
## 3111              Opitutae  <NA>       V             21     1    11
## 3112      Planctomycetacia  <NA>       V             21     1     0
## 3113       Sphingobacteria  <NA>       V             21     1   241
## 3114          Spirochaetes  <NA>       V             21     1     0
## 3115          Subdivision3  <NA>       V             21     1     0
## 3116           Synergistia  <NA>       V             21     1     0
## 3117        Thermomicrobia  <NA>       V             21     1     5
## 3118        Thermoplasmata  <NA>       V             21     1     0
## 3119           Thermotogae  <NA>       V             21     1     0
## 3120               Unknown  <NA>       V             21     1    58
## 3121         Acidobacteria     1       V             21     4     0
## 3122         Acidobacteria    10       V             21     4     0
## 3123         Acidobacteria    14       V             21     4     0
## 3124         Acidobacteria    16       V             21     4     0
## 3125         Acidobacteria    17       V             21     4     0
## 3126         Acidobacteria    18       V             21     4     0
## 3127         Acidobacteria    21       V             21     4     0
## 3128         Acidobacteria    22       V             21     4     0
## 3129         Acidobacteria     3       V             21     4     0
## 3130         Acidobacteria     4       V             21     4     0
## 3131         Acidobacteria     5       V             21     4     0
## 3132         Acidobacteria     6       V             21     4     0
## 3133         Acidobacteria     7       V             21     4     0
## 3134         Acidobacteria     9       V             21     4     0
## 3135        Actinobacteria  <NA>       V             21     4   160
## 3136   Alphaproteobacteria  <NA>       V             21     4    67
## 3137          Anaerolineae  <NA>       V             21     4     0
## 3138               Bacilli  <NA>       V             21     4    39
## 3139           Bacteroidia  <NA>       V             21     4    84
## 3140    Betaproteobacteria  <NA>       V             21     4    17
## 3141           Caldilineae  <NA>       V             21     4     0
## 3142            Chlamydiae  <NA>       V             21     4     0
## 3143           Chloroflexi  <NA>       V             21     4     0
## 3144        Chrysiogenetes  <NA>       V             21     4     0
## 3145            Clostridia  <NA>       V             21     4  3797
## 3146         Cyanobacteria  <NA>       V             21     4     0
## 3147     Dehalococcoidetes  <NA>       V             21     4     0
## 3148            Deinococci  <NA>       V             21     4    47
## 3149   Deltaproteobacteria  <NA>       V             21     4    10
## 3150 Epsilonproteobacteria  <NA>       V             21     4     0
## 3151       Erysipelotrichi  <NA>       V             21     4    96
## 3152         Fibrobacteria  <NA>       V             21     4     0
## 3153         Flavobacteria  <NA>       V             21     4   229
## 3154          Fusobacteria  <NA>       V             21     4     0
## 3155   Gammaproteobacteria  <NA>       V             21     4   226
## 3156      Gemmatimonadetes  <NA>       V             21     4     0
## 3157            Holophagae  <NA>       V             21     4     0
## 3158         Lentisphaeria  <NA>       V             21     4     1
## 3159       Methanobacteria  <NA>       V             21     4     0
## 3160       Methanomicrobia  <NA>       V             21     4     0
## 3161            Mollicutes  <NA>       V             21     4    10
## 3162            Nitrospira  <NA>       V             21     4     0
## 3163              Opitutae  <NA>       V             21     4     2
## 3164      Planctomycetacia  <NA>       V             21     4     1
## 3165       Sphingobacteria  <NA>       V             21     4   119
## 3166          Spirochaetes  <NA>       V             21     4     0
## 3167          Subdivision3  <NA>       V             21     4     0
## 3168           Synergistia  <NA>       V             21     4     0
## 3169        Thermomicrobia  <NA>       V             21     4     8
## 3170        Thermoplasmata  <NA>       V             21     4     0
## 3171           Thermotogae  <NA>       V             21     4     0
## 3172               Unknown  <NA>       V             21     4    72
## 3173         Acidobacteria     1       V             22     1     1
## 3174         Acidobacteria    10       V             22     1     3
## 3175         Acidobacteria    14       V             22     1     0
## 3176         Acidobacteria    16       V             22     1     0
## 3177         Acidobacteria    17       V             22     1     0
## 3178         Acidobacteria    18       V             22     1     0
## 3179         Acidobacteria    21       V             22     1     0
## 3180         Acidobacteria    22       V             22     1     1
## 3181         Acidobacteria     3       V             22     1     2
## 3182         Acidobacteria     4       V             22     1     7
## 3183         Acidobacteria     5       V             22     1     1
## 3184         Acidobacteria     6       V             22     1    37
## 3185         Acidobacteria     7       V             22     1     1
## 3186         Acidobacteria     9       V             22     1     1
## 3187        Actinobacteria  <NA>       V             22     1  1771
## 3188   Alphaproteobacteria  <NA>       V             22     1  1122
## 3189          Anaerolineae  <NA>       V             22     1    20
## 3190               Bacilli  <NA>       V             22     1   113
## 3191           Bacteroidia  <NA>       V             22     1    31
## 3192    Betaproteobacteria  <NA>       V             22     1   108
## 3193           Caldilineae  <NA>       V             22     1   113
## 3194            Chlamydiae  <NA>       V             22     1     0
## 3195           Chloroflexi  <NA>       V             22     1     0
## 3196        Chrysiogenetes  <NA>       V             22     1     0
## 3197            Clostridia  <NA>       V             22     1  1093
## 3198         Cyanobacteria  <NA>       V             22     1     0
## 3199     Dehalococcoidetes  <NA>       V             22     1     0
## 3200            Deinococci  <NA>       V             22     1   369
## 3201   Deltaproteobacteria  <NA>       V             22     1   133
## 3202 Epsilonproteobacteria  <NA>       V             22     1     0
## 3203       Erysipelotrichi  <NA>       V             22     1    96
## 3204         Fibrobacteria  <NA>       V             22     1     0
## 3205         Flavobacteria  <NA>       V             22     1   309
## 3206          Fusobacteria  <NA>       V             22     1     0
## 3207   Gammaproteobacteria  <NA>       V             22     1  1070
## 3208      Gemmatimonadetes  <NA>       V             22     1     6
## 3209            Holophagae  <NA>       V             22     1     0
## 3210         Lentisphaeria  <NA>       V             22     1     0
## 3211       Methanobacteria  <NA>       V             22     1     0
## 3212       Methanomicrobia  <NA>       V             22     1     0
## 3213            Mollicutes  <NA>       V             22     1     2
## 3214            Nitrospira  <NA>       V             22     1     2
## 3215              Opitutae  <NA>       V             22     1    12
## 3216      Planctomycetacia  <NA>       V             22     1    50
## 3217       Sphingobacteria  <NA>       V             22     1   403
## 3218          Spirochaetes  <NA>       V             22     1     3
## 3219          Subdivision3  <NA>       V             22     1     0
## 3220           Synergistia  <NA>       V             22     1     0
## 3221        Thermomicrobia  <NA>       V             22     1   190
## 3222        Thermoplasmata  <NA>       V             22     1     0
## 3223           Thermotogae  <NA>       V             22     1     0
## 3224               Unknown  <NA>       V             22     1  1013
## 3225         Acidobacteria     1       V             22     3     0
## 3226         Acidobacteria    10       V             22     3     0
## 3227         Acidobacteria    14       V             22     3     0
## 3228         Acidobacteria    16       V             22     3     0
## 3229         Acidobacteria    17       V             22     3     0
## 3230         Acidobacteria    18       V             22     3     0
## 3231         Acidobacteria    21       V             22     3     0
## 3232         Acidobacteria    22       V             22     3     0
## 3233         Acidobacteria     3       V             22     3     0
## 3234         Acidobacteria     4       V             22     3     1
## 3235         Acidobacteria     5       V             22     3     0
## 3236         Acidobacteria     6       V             22     3     0
## 3237         Acidobacteria     7       V             22     3     0
## 3238         Acidobacteria     9       V             22     3     0
## 3239        Actinobacteria  <NA>       V             22     3   751
## 3240   Alphaproteobacteria  <NA>       V             22     3   240
## 3241          Anaerolineae  <NA>       V             22     3     0
## 3242               Bacilli  <NA>       V             22     3    19
## 3243           Bacteroidia  <NA>       V             22     3   311
## 3244    Betaproteobacteria  <NA>       V             22     3    38
## 3245           Caldilineae  <NA>       V             22     3     4
## 3246            Chlamydiae  <NA>       V             22     3     0
## 3247           Chloroflexi  <NA>       V             22     3     0
## 3248        Chrysiogenetes  <NA>       V             22     3     0
## 3249            Clostridia  <NA>       V             22     3  1046
## 3250         Cyanobacteria  <NA>       V             22     3     1
## 3251     Dehalococcoidetes  <NA>       V             22     3     0
## 3252            Deinococci  <NA>       V             22     3   250
## 3253   Deltaproteobacteria  <NA>       V             22     3    55
## 3254 Epsilonproteobacteria  <NA>       V             22     3     0
## 3255       Erysipelotrichi  <NA>       V             22     3    33
## 3256         Fibrobacteria  <NA>       V             22     3     0
## 3257         Flavobacteria  <NA>       V             22     3   588
## 3258          Fusobacteria  <NA>       V             22     3     0
## 3259   Gammaproteobacteria  <NA>       V             22     3  1114
## 3260      Gemmatimonadetes  <NA>       V             22     3     0
## 3261            Holophagae  <NA>       V             22     3     0
## 3262         Lentisphaeria  <NA>       V             22     3     0
## 3263       Methanobacteria  <NA>       V             22     3     0
## 3264       Methanomicrobia  <NA>       V             22     3     0
## 3265            Mollicutes  <NA>       V             22     3     0
## 3266            Nitrospira  <NA>       V             22     3     0
## 3267              Opitutae  <NA>       V             22     3    18
## 3268      Planctomycetacia  <NA>       V             22     3     4
## 3269       Sphingobacteria  <NA>       V             22     3   150
## 3270          Spirochaetes  <NA>       V             22     3    11
## 3271          Subdivision3  <NA>       V             22     3     0
## 3272           Synergistia  <NA>       V             22     3     0
## 3273        Thermomicrobia  <NA>       V             22     3     9
## 3274        Thermoplasmata  <NA>       V             22     3     0
## 3275           Thermotogae  <NA>       V             22     3     0
## 3276               Unknown  <NA>       V             22     3   670
## 3277         Acidobacteria     1       V             22     4     0
## 3278         Acidobacteria    10       V             22     4     0
## 3279         Acidobacteria    14       V             22     4     0
## 3280         Acidobacteria    16       V             22     4     0
## 3281         Acidobacteria    17       V             22     4     0
## 3282         Acidobacteria    18       V             22     4     0
## 3283         Acidobacteria    21       V             22     4     0
## 3284         Acidobacteria    22       V             22     4     0
## 3285         Acidobacteria     3       V             22     4     0
## 3286         Acidobacteria     4       V             22     4     0
## 3287         Acidobacteria     5       V             22     4     1
## 3288         Acidobacteria     6       V             22     4     3
## 3289         Acidobacteria     7       V             22     4     0
## 3290         Acidobacteria     9       V             22     4     0
## 3291        Actinobacteria  <NA>       V             22     4   387
## 3292   Alphaproteobacteria  <NA>       V             22     4   507
## 3293          Anaerolineae  <NA>       V             22     4     0
## 3294               Bacilli  <NA>       V             22     4   399
## 3295           Bacteroidia  <NA>       V             22     4    53
## 3296    Betaproteobacteria  <NA>       V             22     4   254
## 3297           Caldilineae  <NA>       V             22     4     3
## 3298            Chlamydiae  <NA>       V             22     4     0
## 3299           Chloroflexi  <NA>       V             22     4     0
## 3300        Chrysiogenetes  <NA>       V             22     4     0
## 3301            Clostridia  <NA>       V             22     4   324
## 3302         Cyanobacteria  <NA>       V             22     4     5
## 3303     Dehalococcoidetes  <NA>       V             22     4     0
## 3304            Deinococci  <NA>       V             22     4   203
## 3305   Deltaproteobacteria  <NA>       V             22     4    13
## 3306 Epsilonproteobacteria  <NA>       V             22     4     0
## 3307       Erysipelotrichi  <NA>       V             22     4    15
## 3308         Fibrobacteria  <NA>       V             22     4     0
## 3309         Flavobacteria  <NA>       V             22     4   479
## 3310          Fusobacteria  <NA>       V             22     4     0
## 3311   Gammaproteobacteria  <NA>       V             22     4  1408
## 3312      Gemmatimonadetes  <NA>       V             22     4     0
## 3313            Holophagae  <NA>       V             22     4     0
## 3314         Lentisphaeria  <NA>       V             22     4     0
## 3315       Methanobacteria  <NA>       V             22     4     0
## 3316       Methanomicrobia  <NA>       V             22     4     0
## 3317            Mollicutes  <NA>       V             22     4    28
## 3318            Nitrospira  <NA>       V             22     4     0
## 3319              Opitutae  <NA>       V             22     4    13
## 3320      Planctomycetacia  <NA>       V             22     4    10
## 3321       Sphingobacteria  <NA>       V             22     4   323
## 3322          Spirochaetes  <NA>       V             22     4     3
## 3323          Subdivision3  <NA>       V             22     4     0
## 3324           Synergistia  <NA>       V             22     4     0
## 3325        Thermomicrobia  <NA>       V             22     4     9
## 3326        Thermoplasmata  <NA>       V             22     4     0
## 3327           Thermotogae  <NA>       V             22     4     0
## 3328               Unknown  <NA>       V             22     4   784
## 3329         Acidobacteria     1       V              3     1     0
## 3330         Acidobacteria    10       V              3     1     0
## 3331         Acidobacteria    14       V              3     1     0
## 3332         Acidobacteria    16       V              3     1     0
## 3333         Acidobacteria    17       V              3     1     0
## 3334         Acidobacteria    18       V              3     1     0
## 3335         Acidobacteria    21       V              3     1     0
## 3336         Acidobacteria    22       V              3     1     0
## 3337         Acidobacteria     3       V              3     1     0
## 3338         Acidobacteria     4       V              3     1     0
## 3339         Acidobacteria     5       V              3     1     0
## 3340         Acidobacteria     6       V              3     1     0
## 3341         Acidobacteria     7       V              3     1     0
## 3342         Acidobacteria     9       V              3     1     0
## 3343        Actinobacteria  <NA>       V              3     1  2312
## 3344   Alphaproteobacteria  <NA>       V              3     1  7322
## 3345          Anaerolineae  <NA>       V              3     1     0
## 3346               Bacilli  <NA>       V              3     1  2435
## 3347           Bacteroidia  <NA>       V              3     1     4
## 3348    Betaproteobacteria  <NA>       V              3     1   543
## 3349           Caldilineae  <NA>       V              3     1     8
## 3350            Chlamydiae  <NA>       V              3     1     0
## 3351           Chloroflexi  <NA>       V              3     1     0
## 3352        Chrysiogenetes  <NA>       V              3     1     0
## 3353            Clostridia  <NA>       V              3     1   237
## 3354         Cyanobacteria  <NA>       V              3     1     3
## 3355     Dehalococcoidetes  <NA>       V              3     1     0
## 3356            Deinococci  <NA>       V              3     1  1241
## 3357   Deltaproteobacteria  <NA>       V              3     1    77
## 3358 Epsilonproteobacteria  <NA>       V              3     1     0
## 3359       Erysipelotrichi  <NA>       V              3     1     5
## 3360         Fibrobacteria  <NA>       V              3     1     0
## 3361         Flavobacteria  <NA>       V              3     1   701
## 3362          Fusobacteria  <NA>       V              3     1     0
## 3363   Gammaproteobacteria  <NA>       V              3     1  5191
## 3364      Gemmatimonadetes  <NA>       V              3     1     0
## 3365            Holophagae  <NA>       V              3     1     0
## 3366         Lentisphaeria  <NA>       V              3     1     0
## 3367       Methanobacteria  <NA>       V              3     1     0
## 3368       Methanomicrobia  <NA>       V              3     1     0
## 3369            Mollicutes  <NA>       V              3     1     8
## 3370            Nitrospira  <NA>       V              3     1     0
## 3371              Opitutae  <NA>       V              3     1    32
## 3372      Planctomycetacia  <NA>       V              3     1    17
## 3373       Sphingobacteria  <NA>       V              3     1  2292
## 3374          Spirochaetes  <NA>       V              3     1     2
## 3375          Subdivision3  <NA>       V              3     1     0
## 3376           Synergistia  <NA>       V              3     1     0
## 3377        Thermomicrobia  <NA>       V              3     1   309
## 3378        Thermoplasmata  <NA>       V              3     1     0
## 3379           Thermotogae  <NA>       V              3     1     0
## 3380               Unknown  <NA>       V              3     1   814
## 3381         Acidobacteria     1       V              3     2     0
## 3382         Acidobacteria    10       V              3     2     0
## 3383         Acidobacteria    14       V              3     2     0
## 3384         Acidobacteria    16       V              3     2     0
## 3385         Acidobacteria    17       V              3     2     0
## 3386         Acidobacteria    18       V              3     2     0
## 3387         Acidobacteria    21       V              3     2     3
## 3388         Acidobacteria    22       V              3     2     0
## 3389         Acidobacteria     3       V              3     2     0
## 3390         Acidobacteria     4       V              3     2     0
## 3391         Acidobacteria     5       V              3     2     0
## 3392         Acidobacteria     6       V              3     2     3
## 3393         Acidobacteria     7       V              3     2     0
## 3394         Acidobacteria     9       V              3     2     0
## 3395        Actinobacteria  <NA>       V              3     2  2649
## 3396   Alphaproteobacteria  <NA>       V              3     2  8660
## 3397          Anaerolineae  <NA>       V              3     2     0
## 3398               Bacilli  <NA>       V              3     2  1040
## 3399           Bacteroidia  <NA>       V              3     2    11
## 3400    Betaproteobacteria  <NA>       V              3     2   268
## 3401           Caldilineae  <NA>       V              3     2     5
## 3402            Chlamydiae  <NA>       V              3     2     0
## 3403           Chloroflexi  <NA>       V              3     2     0
## 3404        Chrysiogenetes  <NA>       V              3     2     0
## 3405            Clostridia  <NA>       V              3     2   688
## 3406         Cyanobacteria  <NA>       V              3     2     0
## 3407     Dehalococcoidetes  <NA>       V              3     2     0
## 3408            Deinococci  <NA>       V              3     2   748
## 3409   Deltaproteobacteria  <NA>       V              3     2    98
## 3410 Epsilonproteobacteria  <NA>       V              3     2     0
## 3411       Erysipelotrichi  <NA>       V              3     2    16
## 3412         Fibrobacteria  <NA>       V              3     2     0
## 3413         Flavobacteria  <NA>       V              3     2  1096
## 3414          Fusobacteria  <NA>       V              3     2     0
## 3415   Gammaproteobacteria  <NA>       V              3     2  4515
## 3416      Gemmatimonadetes  <NA>       V              3     2     0
## 3417            Holophagae  <NA>       V              3     2     0
## 3418         Lentisphaeria  <NA>       V              3     2     0
## 3419       Methanobacteria  <NA>       V              3     2     0
## 3420       Methanomicrobia  <NA>       V              3     2     0
## 3421            Mollicutes  <NA>       V              3     2    14
## 3422            Nitrospira  <NA>       V              3     2     0
## 3423              Opitutae  <NA>       V              3     2    48
## 3424      Planctomycetacia  <NA>       V              3     2     1
## 3425       Sphingobacteria  <NA>       V              3     2  2073
## 3426          Spirochaetes  <NA>       V              3     2     0
## 3427          Subdivision3  <NA>       V              3     2     0
## 3428           Synergistia  <NA>       V              3     2     2
## 3429        Thermomicrobia  <NA>       V              3     2   196
## 3430        Thermoplasmata  <NA>       V              3     2     0
## 3431           Thermotogae  <NA>       V              3     2     0
## 3432               Unknown  <NA>       V              3     2   645
## 3433         Acidobacteria     1       V              4     1     0
## 3434         Acidobacteria    10       V              4     1     0
## 3435         Acidobacteria    14       V              4     1     0
## 3436         Acidobacteria    16       V              4     1     0
## 3437         Acidobacteria    17       V              4     1     0
## 3438         Acidobacteria    18       V              4     1     0
## 3439         Acidobacteria    21       V              4     1     0
## 3440         Acidobacteria    22       V              4     1     0
## 3441         Acidobacteria     3       V              4     1     0
## 3442         Acidobacteria     4       V              4     1     1
## 3443         Acidobacteria     5       V              4     1     0
## 3444         Acidobacteria     6       V              4     1     0
## 3445         Acidobacteria     7       V              4     1     0
## 3446         Acidobacteria     9       V              4     1     0
## 3447        Actinobacteria  <NA>       V              4     1    30
## 3448   Alphaproteobacteria  <NA>       V              4     1    62
## 3449          Anaerolineae  <NA>       V              4     1     0
## 3450               Bacilli  <NA>       V              4     1    25
## 3451           Bacteroidia  <NA>       V              4     1     3
## 3452    Betaproteobacteria  <NA>       V              4     1     3
## 3453           Caldilineae  <NA>       V              4     1     7
## 3454            Chlamydiae  <NA>       V              4     1     0
## 3455           Chloroflexi  <NA>       V              4     1     0
## 3456        Chrysiogenetes  <NA>       V              4     1     0
## 3457            Clostridia  <NA>       V              4     1   233
## 3458         Cyanobacteria  <NA>       V              4     1     0
## 3459     Dehalococcoidetes  <NA>       V              4     1     0
## 3460            Deinococci  <NA>       V              4     1    20
## 3461   Deltaproteobacteria  <NA>       V              4     1    15
## 3462 Epsilonproteobacteria  <NA>       V              4     1     0
## 3463       Erysipelotrichi  <NA>       V              4     1     7
## 3464         Fibrobacteria  <NA>       V              4     1     0
## 3465         Flavobacteria  <NA>       V              4     1    25
## 3466          Fusobacteria  <NA>       V              4     1     0
## 3467   Gammaproteobacteria  <NA>       V              4     1    68
## 3468      Gemmatimonadetes  <NA>       V              4     1     0
## 3469            Holophagae  <NA>       V              4     1     0
## 3470         Lentisphaeria  <NA>       V              4     1     0
## 3471       Methanobacteria  <NA>       V              4     1     0
## 3472       Methanomicrobia  <NA>       V              4     1     0
## 3473            Mollicutes  <NA>       V              4     1     0
## 3474            Nitrospira  <NA>       V              4     1     0
## 3475              Opitutae  <NA>       V              4     1     2
## 3476      Planctomycetacia  <NA>       V              4     1     0
## 3477       Sphingobacteria  <NA>       V              4     1    90
## 3478          Spirochaetes  <NA>       V              4     1     1
## 3479          Subdivision3  <NA>       V              4     1     0
## 3480           Synergistia  <NA>       V              4     1     0
## 3481        Thermomicrobia  <NA>       V              4     1     6
## 3482        Thermoplasmata  <NA>       V              4     1     0
## 3483           Thermotogae  <NA>       V              4     1     0
## 3484               Unknown  <NA>       V              4     1    79
## 3485         Acidobacteria     1       V              4     2     0
## 3486         Acidobacteria    10       V              4     2     2
## 3487         Acidobacteria    14       V              4     2     0
## 3488         Acidobacteria    16       V              4     2     1
## 3489         Acidobacteria    17       V              4     2     0
## 3490         Acidobacteria    18       V              4     2     0
## 3491         Acidobacteria    21       V              4     2     2
## 3492         Acidobacteria    22       V              4     2     0
## 3493         Acidobacteria     3       V              4     2     3
## 3494         Acidobacteria     4       V              4     2     2
## 3495         Acidobacteria     5       V              4     2     0
## 3496         Acidobacteria     6       V              4     2     3
## 3497         Acidobacteria     7       V              4     2     0
## 3498         Acidobacteria     9       V              4     2     0
## 3499        Actinobacteria  <NA>       V              4     2    70
## 3500   Alphaproteobacteria  <NA>       V              4     2   153
## 3501          Anaerolineae  <NA>       V              4     2     0
## 3502               Bacilli  <NA>       V              4     2    48
## 3503           Bacteroidia  <NA>       V              4     2     3
## 3504    Betaproteobacteria  <NA>       V              4     2    24
## 3505           Caldilineae  <NA>       V              4     2    26
## 3506            Chlamydiae  <NA>       V              4     2     0
## 3507           Chloroflexi  <NA>       V              4     2     0
## 3508        Chrysiogenetes  <NA>       V              4     2     0
## 3509            Clostridia  <NA>       V              4     2   571
## 3510         Cyanobacteria  <NA>       V              4     2     0
## 3511     Dehalococcoidetes  <NA>       V              4     2     0
## 3512            Deinococci  <NA>       V              4     2    19
## 3513   Deltaproteobacteria  <NA>       V              4     2    11
## 3514 Epsilonproteobacteria  <NA>       V              4     2     0
## 3515       Erysipelotrichi  <NA>       V              4     2    49
## 3516         Fibrobacteria  <NA>       V              4     2     0
## 3517         Flavobacteria  <NA>       V              4     2    29
## 3518          Fusobacteria  <NA>       V              4     2     0
## 3519   Gammaproteobacteria  <NA>       V              4     2    90
## 3520      Gemmatimonadetes  <NA>       V              4     2     2
## 3521            Holophagae  <NA>       V              4     2     0
## 3522         Lentisphaeria  <NA>       V              4     2     0
## 3523       Methanobacteria  <NA>       V              4     2     0
## 3524       Methanomicrobia  <NA>       V              4     2     0
## 3525            Mollicutes  <NA>       V              4     2     1
## 3526            Nitrospira  <NA>       V              4     2     0
## 3527              Opitutae  <NA>       V              4     2     1
## 3528      Planctomycetacia  <NA>       V              4     2    14
## 3529       Sphingobacteria  <NA>       V              4     2   235
## 3530          Spirochaetes  <NA>       V              4     2     1
## 3531          Subdivision3  <NA>       V              4     2     0
## 3532           Synergistia  <NA>       V              4     2     0
## 3533        Thermomicrobia  <NA>       V              4     2    29
## 3534        Thermoplasmata  <NA>       V              4     2     0
## 3535           Thermotogae  <NA>       V              4     2     0
## 3536               Unknown  <NA>       V              4     2   242
## 3537         Acidobacteria     1       V              5     1     0
## 3538         Acidobacteria    10       V              5     1     0
## 3539         Acidobacteria    14       V              5     1     0
## 3540         Acidobacteria    16       V              5     1     0
## 3541         Acidobacteria    17       V              5     1     0
## 3542         Acidobacteria    18       V              5     1     0
## 3543         Acidobacteria    21       V              5     1     0
## 3544         Acidobacteria    22       V              5     1     0
## 3545         Acidobacteria     3       V              5     1     0
## 3546         Acidobacteria     4       V              5     1     0
## 3547         Acidobacteria     5       V              5     1     0
## 3548         Acidobacteria     6       V              5     1     0
## 3549         Acidobacteria     7       V              5     1     0
## 3550         Acidobacteria     9       V              5     1     0
## 3551        Actinobacteria  <NA>       V              5     1    12
## 3552   Alphaproteobacteria  <NA>       V              5     1     6
## 3553          Anaerolineae  <NA>       V              5     1     0
## 3554               Bacilli  <NA>       V              5     1    40
## 3555           Bacteroidia  <NA>       V              5     1   274
## 3556    Betaproteobacteria  <NA>       V              5     1    14
## 3557           Caldilineae  <NA>       V              5     1     0
## 3558            Chlamydiae  <NA>       V              5     1     0
## 3559           Chloroflexi  <NA>       V              5     1     0
## 3560        Chrysiogenetes  <NA>       V              5     1     0
## 3561            Clostridia  <NA>       V              5     1   794
## 3562         Cyanobacteria  <NA>       V              5     1     0
## 3563     Dehalococcoidetes  <NA>       V              5     1     0
## 3564            Deinococci  <NA>       V              5     1     1
## 3565   Deltaproteobacteria  <NA>       V              5     1     0
## 3566 Epsilonproteobacteria  <NA>       V              5     1     0
## 3567       Erysipelotrichi  <NA>       V              5     1    12
## 3568         Fibrobacteria  <NA>       V              5     1     0
## 3569         Flavobacteria  <NA>       V              5     1    48
## 3570          Fusobacteria  <NA>       V              5     1    10
## 3571   Gammaproteobacteria  <NA>       V              5     1    64
## 3572      Gemmatimonadetes  <NA>       V              5     1     0
## 3573            Holophagae  <NA>       V              5     1     0
## 3574         Lentisphaeria  <NA>       V              5     1     0
## 3575       Methanobacteria  <NA>       V              5     1     0
## 3576       Methanomicrobia  <NA>       V              5     1     0
## 3577            Mollicutes  <NA>       V              5     1     5
## 3578            Nitrospira  <NA>       V              5     1     0
## 3579              Opitutae  <NA>       V              5     1     2
## 3580      Planctomycetacia  <NA>       V              5     1     0
## 3581       Sphingobacteria  <NA>       V              5     1     5
## 3582          Spirochaetes  <NA>       V              5     1     0
## 3583          Subdivision3  <NA>       V              5     1     0
## 3584           Synergistia  <NA>       V              5     1     0
## 3585        Thermomicrobia  <NA>       V              5     1     0
## 3586        Thermoplasmata  <NA>       V              5     1     0
## 3587           Thermotogae  <NA>       V              5     1     0
## 3588               Unknown  <NA>       V              5     1    30
## 3589         Acidobacteria     1       V              5     3     0
## 3590         Acidobacteria    10       V              5     3     0
## 3591         Acidobacteria    14       V              5     3     0
## 3592         Acidobacteria    16       V              5     3     0
## 3593         Acidobacteria    17       V              5     3     0
## 3594         Acidobacteria    18       V              5     3     0
## 3595         Acidobacteria    21       V              5     3     0
## 3596         Acidobacteria    22       V              5     3     0
## 3597         Acidobacteria     3       V              5     3     0
## 3598         Acidobacteria     4       V              5     3     0
## 3599         Acidobacteria     5       V              5     3     0
## 3600         Acidobacteria     6       V              5     3     2
## 3601         Acidobacteria     7       V              5     3     0
## 3602         Acidobacteria     9       V              5     3     0
## 3603        Actinobacteria  <NA>       V              5     3  1671
## 3604   Alphaproteobacteria  <NA>       V              5     3   602
## 3605          Anaerolineae  <NA>       V              5     3     1
## 3606               Bacilli  <NA>       V              5     3   286
## 3607           Bacteroidia  <NA>       V              5     3   217
## 3608    Betaproteobacteria  <NA>       V              5     3   162
## 3609           Caldilineae  <NA>       V              5     3     3
## 3610            Chlamydiae  <NA>       V              5     3     0
## 3611           Chloroflexi  <NA>       V              5     3     0
## 3612        Chrysiogenetes  <NA>       V              5     3     0
## 3613            Clostridia  <NA>       V              5     3  4461
## 3614         Cyanobacteria  <NA>       V              5     3     0
## 3615     Dehalococcoidetes  <NA>       V              5     3     0
## 3616            Deinococci  <NA>       V              5     3  2074
## 3617   Deltaproteobacteria  <NA>       V              5     3    73
## 3618 Epsilonproteobacteria  <NA>       V              5     3     0
## 3619       Erysipelotrichi  <NA>       V              5     3   114
## 3620         Fibrobacteria  <NA>       V              5     3     0
## 3621         Flavobacteria  <NA>       V              5     3   972
## 3622          Fusobacteria  <NA>       V              5     3     2
## 3623   Gammaproteobacteria  <NA>       V              5     3  1762
## 3624      Gemmatimonadetes  <NA>       V              5     3     0
## 3625            Holophagae  <NA>       V              5     3     0
## 3626         Lentisphaeria  <NA>       V              5     3     0
## 3627       Methanobacteria  <NA>       V              5     3     0
## 3628       Methanomicrobia  <NA>       V              5     3     0
## 3629            Mollicutes  <NA>       V              5     3   119
## 3630            Nitrospira  <NA>       V              5     3     0
## 3631              Opitutae  <NA>       V              5     3    59
## 3632      Planctomycetacia  <NA>       V              5     3    22
## 3633       Sphingobacteria  <NA>       V              5     3  1225
## 3634          Spirochaetes  <NA>       V              5     3     3
## 3635          Subdivision3  <NA>       V              5     3     0
## 3636           Synergistia  <NA>       V              5     3     0
## 3637        Thermomicrobia  <NA>       V              5     3   212
## 3638        Thermoplasmata  <NA>       V              5     3     0
## 3639           Thermotogae  <NA>       V              5     3     0
## 3640               Unknown  <NA>       V              5     3  1139
## 3641         Acidobacteria     1       V              6     1     0
## 3642         Acidobacteria    10       V              6     1     0
## 3643         Acidobacteria    14       V              6     1     0
## 3644         Acidobacteria    16       V              6     1     0
## 3645         Acidobacteria    17       V              6     1     0
## 3646         Acidobacteria    18       V              6     1     0
## 3647         Acidobacteria    21       V              6     1     0
## 3648         Acidobacteria    22       V              6     1     0
## 3649         Acidobacteria     3       V              6     1     0
## 3650         Acidobacteria     4       V              6     1     0
## 3651         Acidobacteria     5       V              6     1     0
## 3652         Acidobacteria     6       V              6     1     0
## 3653         Acidobacteria     7       V              6     1     0
## 3654         Acidobacteria     9       V              6     1     0
## 3655        Actinobacteria  <NA>       V              6     1  1367
## 3656   Alphaproteobacteria  <NA>       V              6     1   410
## 3657          Anaerolineae  <NA>       V              6     1     0
## 3658               Bacilli  <NA>       V              6     1    86
## 3659           Bacteroidia  <NA>       V              6     1    48
## 3660    Betaproteobacteria  <NA>       V              6     1    90
## 3661           Caldilineae  <NA>       V              6     1     2
## 3662            Chlamydiae  <NA>       V              6     1     0
## 3663           Chloroflexi  <NA>       V              6     1     0
## 3664        Chrysiogenetes  <NA>       V              6     1     0
## 3665            Clostridia  <NA>       V              6     1  1134
## 3666         Cyanobacteria  <NA>       V              6     1     0
## 3667     Dehalococcoidetes  <NA>       V              6     1     0
## 3668            Deinococci  <NA>       V              6     1   861
## 3669   Deltaproteobacteria  <NA>       V              6     1    33
## 3670 Epsilonproteobacteria  <NA>       V              6     1     0
## 3671       Erysipelotrichi  <NA>       V              6     1    38
## 3672         Fibrobacteria  <NA>       V              6     1     0
## 3673         Flavobacteria  <NA>       V              6     1   415
## 3674          Fusobacteria  <NA>       V              6     1     6
## 3675   Gammaproteobacteria  <NA>       V              6     1   995
## 3676      Gemmatimonadetes  <NA>       V              6     1     0
## 3677            Holophagae  <NA>       V              6     1     0
## 3678         Lentisphaeria  <NA>       V              6     1     0
## 3679       Methanobacteria  <NA>       V              6     1     0
## 3680       Methanomicrobia  <NA>       V              6     1     0
## 3681            Mollicutes  <NA>       V              6     1    24
## 3682            Nitrospira  <NA>       V              6     1     0
## 3683              Opitutae  <NA>       V              6     1    24
## 3684      Planctomycetacia  <NA>       V              6     1     6
## 3685       Sphingobacteria  <NA>       V              6     1   853
## 3686          Spirochaetes  <NA>       V              6     1     0
## 3687          Subdivision3  <NA>       V              6     1     0
## 3688           Synergistia  <NA>       V              6     1     3
## 3689        Thermomicrobia  <NA>       V              6     1   325
## 3690        Thermoplasmata  <NA>       V              6     1     0
## 3691           Thermotogae  <NA>       V              6     1     0
## 3692               Unknown  <NA>       V              6     1   227
## 3693         Acidobacteria     1       V              6     2     0
## 3694         Acidobacteria    10       V              6     2     0
## 3695         Acidobacteria    14       V              6     2     0
## 3696         Acidobacteria    16       V              6     2     0
## 3697         Acidobacteria    17       V              6     2     0
## 3698         Acidobacteria    18       V              6     2     0
## 3699         Acidobacteria    21       V              6     2     0
## 3700         Acidobacteria    22       V              6     2     0
## 3701         Acidobacteria     3       V              6     2     0
## 3702         Acidobacteria     4       V              6     2     0
## 3703         Acidobacteria     5       V              6     2     0
## 3704         Acidobacteria     6       V              6     2     0
## 3705         Acidobacteria     7       V              6     2     0
## 3706         Acidobacteria     9       V              6     2     0
## 3707        Actinobacteria  <NA>       V              6     2   779
## 3708   Alphaproteobacteria  <NA>       V              6     2   592
## 3709          Anaerolineae  <NA>       V              6     2     0
## 3710               Bacilli  <NA>       V              6     2   232
## 3711           Bacteroidia  <NA>       V              6     2   468
## 3712    Betaproteobacteria  <NA>       V              6     2    87
## 3713           Caldilineae  <NA>       V              6     2     0
## 3714            Chlamydiae  <NA>       V              6     2     0
## 3715           Chloroflexi  <NA>       V              6     2     0
## 3716        Chrysiogenetes  <NA>       V              6     2     0
## 3717            Clostridia  <NA>       V              6     2  6048
## 3718         Cyanobacteria  <NA>       V              6     2     0
## 3719     Dehalococcoidetes  <NA>       V              6     2     0
## 3720            Deinococci  <NA>       V              6     2   104
## 3721   Deltaproteobacteria  <NA>       V              6     2     3
## 3722 Epsilonproteobacteria  <NA>       V              6     2     0
## 3723       Erysipelotrichi  <NA>       V              6     2   217
## 3724         Fibrobacteria  <NA>       V              6     2     0
## 3725         Flavobacteria  <NA>       V              6     2   302
## 3726          Fusobacteria  <NA>       V              6     2     1
## 3727   Gammaproteobacteria  <NA>       V              6     2  2616
## 3728      Gemmatimonadetes  <NA>       V              6     2     0
## 3729            Holophagae  <NA>       V              6     2     0
## 3730         Lentisphaeria  <NA>       V              6     2     0
## 3731       Methanobacteria  <NA>       V              6     2     0
## 3732       Methanomicrobia  <NA>       V              6     2     0
## 3733            Mollicutes  <NA>       V              6     2    50
## 3734            Nitrospira  <NA>       V              6     2     0
## 3735              Opitutae  <NA>       V              6     2     9
## 3736      Planctomycetacia  <NA>       V              6     2     5
## 3737       Sphingobacteria  <NA>       V              6     2   203
## 3738          Spirochaetes  <NA>       V              6     2     1
## 3739          Subdivision3  <NA>       V              6     2     0
## 3740           Synergistia  <NA>       V              6     2    22
## 3741        Thermomicrobia  <NA>       V              6     2    12
## 3742        Thermoplasmata  <NA>       V              6     2     0
## 3743           Thermotogae  <NA>       V              6     2     0
## 3744               Unknown  <NA>       V              6     2   187
## 3745         Acidobacteria     1       V              6     3     0
## 3746         Acidobacteria    10       V              6     3     0
## 3747         Acidobacteria    14       V              6     3     0
## 3748         Acidobacteria    16       V              6     3     0
## 3749         Acidobacteria    17       V              6     3     0
## 3750         Acidobacteria    18       V              6     3     0
## 3751         Acidobacteria    21       V              6     3     0
## 3752         Acidobacteria    22       V              6     3     0
## 3753         Acidobacteria     3       V              6     3    11
## 3754         Acidobacteria     4       V              6     3     1
## 3755         Acidobacteria     5       V              6     3     0
## 3756         Acidobacteria     6       V              6     3     8
## 3757         Acidobacteria     7       V              6     3     0
## 3758         Acidobacteria     9       V              6     3     0
## 3759        Actinobacteria  <NA>       V              6     3  2280
## 3760   Alphaproteobacteria  <NA>       V              6     3   589
## 3761          Anaerolineae  <NA>       V              6     3     0
## 3762               Bacilli  <NA>       V              6     3    78
## 3763           Bacteroidia  <NA>       V              6     3   134
## 3764    Betaproteobacteria  <NA>       V              6     3   140
## 3765           Caldilineae  <NA>       V              6     3    24
## 3766            Chlamydiae  <NA>       V              6     3     0
## 3767           Chloroflexi  <NA>       V              6     3     0
## 3768        Chrysiogenetes  <NA>       V              6     3     0
## 3769            Clostridia  <NA>       V              6     3  1432
## 3770         Cyanobacteria  <NA>       V              6     3     1
## 3771     Dehalococcoidetes  <NA>       V              6     3     0
## 3772            Deinococci  <NA>       V              6     3   292
## 3773   Deltaproteobacteria  <NA>       V              6     3    74
## 3774 Epsilonproteobacteria  <NA>       V              6     3     0
## 3775       Erysipelotrichi  <NA>       V              6     3    76
## 3776         Fibrobacteria  <NA>       V              6     3     0
## 3777         Flavobacteria  <NA>       V              6     3   526
## 3778          Fusobacteria  <NA>       V              6     3     0
## 3779   Gammaproteobacteria  <NA>       V              6     3  1346
## 3780      Gemmatimonadetes  <NA>       V              6     3     2
## 3781            Holophagae  <NA>       V              6     3     0
## 3782         Lentisphaeria  <NA>       V              6     3     0
## 3783       Methanobacteria  <NA>       V              6     3     0
## 3784       Methanomicrobia  <NA>       V              6     3     0
## 3785            Mollicutes  <NA>       V              6     3    38
## 3786            Nitrospira  <NA>       V              6     3     0
## 3787              Opitutae  <NA>       V              6     3     7
## 3788      Planctomycetacia  <NA>       V              6     3    18
## 3789       Sphingobacteria  <NA>       V              6     3   321
## 3790          Spirochaetes  <NA>       V              6     3    11
## 3791          Subdivision3  <NA>       V              6     3     0
## 3792           Synergistia  <NA>       V              6     3     2
## 3793        Thermomicrobia  <NA>       V              6     3    78
## 3794        Thermoplasmata  <NA>       V              6     3     0
## 3795           Thermotogae  <NA>       V              6     3     0
## 3796               Unknown  <NA>       V              6     3   527
## 3797         Acidobacteria     1       V              7     1     0
## 3798         Acidobacteria    10       V              7     1     0
## 3799         Acidobacteria    14       V              7     1     0
## 3800         Acidobacteria    16       V              7     1     0
## 3801         Acidobacteria    17       V              7     1     0
## 3802         Acidobacteria    18       V              7     1     0
## 3803         Acidobacteria    21       V              7     1     0
## 3804         Acidobacteria    22       V              7     1     0
## 3805         Acidobacteria     3       V              7     1     0
## 3806         Acidobacteria     4       V              7     1     0
## 3807         Acidobacteria     5       V              7     1     0
## 3808         Acidobacteria     6       V              7     1     0
## 3809         Acidobacteria     7       V              7     1     0
## 3810         Acidobacteria     9       V              7     1     0
## 3811        Actinobacteria  <NA>       V              7     1   376
## 3812   Alphaproteobacteria  <NA>       V              7     1    90
## 3813          Anaerolineae  <NA>       V              7     1     0
## 3814               Bacilli  <NA>       V              7     1   157
## 3815           Bacteroidia  <NA>       V              7     1  2231
## 3816    Betaproteobacteria  <NA>       V              7     1    70
## 3817           Caldilineae  <NA>       V              7     1     0
## 3818            Chlamydiae  <NA>       V              7     1     0
## 3819           Chloroflexi  <NA>       V              7     1     0
## 3820        Chrysiogenetes  <NA>       V              7     1     0
## 3821            Clostridia  <NA>       V              7     1  4213
## 3822         Cyanobacteria  <NA>       V              7     1     1
## 3823     Dehalococcoidetes  <NA>       V              7     1     0
## 3824            Deinococci  <NA>       V              7     1    51
## 3825   Deltaproteobacteria  <NA>       V              7     1     1
## 3826 Epsilonproteobacteria  <NA>       V              7     1     0
## 3827       Erysipelotrichi  <NA>       V              7     1    20
## 3828         Fibrobacteria  <NA>       V              7     1     0
## 3829         Flavobacteria  <NA>       V              7     1   257
## 3830          Fusobacteria  <NA>       V              7     1    92
## 3831   Gammaproteobacteria  <NA>       V              7     1   316
## 3832      Gemmatimonadetes  <NA>       V              7     1     0
## 3833            Holophagae  <NA>       V              7     1     0
## 3834         Lentisphaeria  <NA>       V              7     1     0
## 3835       Methanobacteria  <NA>       V              7     1     0
## 3836       Methanomicrobia  <NA>       V              7     1     0
## 3837            Mollicutes  <NA>       V              7     1     2
## 3838            Nitrospira  <NA>       V              7     1     0
## 3839              Opitutae  <NA>       V              7     1     0
## 3840      Planctomycetacia  <NA>       V              7     1     0
## 3841       Sphingobacteria  <NA>       V              7     1   297
## 3842          Spirochaetes  <NA>       V              7     1     0
## 3843          Subdivision3  <NA>       V              7     1     0
## 3844           Synergistia  <NA>       V              7     1     0
## 3845        Thermomicrobia  <NA>       V              7     1    25
## 3846        Thermoplasmata  <NA>       V              7     1     0
## 3847           Thermotogae  <NA>       V              7     1     0
## 3848               Unknown  <NA>       V              7     1    50
## 3849         Acidobacteria     1       V              7     2     1
## 3850         Acidobacteria    10       V              7     2     1
## 3851         Acidobacteria    14       V              7     2     0
## 3852         Acidobacteria    16       V              7     2     0
## 3853         Acidobacteria    17       V              7     2     0
## 3854         Acidobacteria    18       V              7     2     0
## 3855         Acidobacteria    21       V              7     2     1
## 3856         Acidobacteria    22       V              7     2     0
## 3857         Acidobacteria     3       V              7     2     1
## 3858         Acidobacteria     4       V              7     2     0
## 3859         Acidobacteria     5       V              7     2     0
## 3860         Acidobacteria     6       V              7     2    13
## 3861         Acidobacteria     7       V              7     2     0
## 3862         Acidobacteria     9       V              7     2     0
## 3863        Actinobacteria  <NA>       V              7     2  1005
## 3864   Alphaproteobacteria  <NA>       V              7     2   632
## 3865          Anaerolineae  <NA>       V              7     2     1
## 3866               Bacilli  <NA>       V              7     2   315
## 3867           Bacteroidia  <NA>       V              7     2   141
## 3868    Betaproteobacteria  <NA>       V              7     2   147
## 3869           Caldilineae  <NA>       V              7     2    95
## 3870            Chlamydiae  <NA>       V              7     2     0
## 3871           Chloroflexi  <NA>       V              7     2     0
## 3872        Chrysiogenetes  <NA>       V              7     2     0
## 3873            Clostridia  <NA>       V              7     2   717
## 3874         Cyanobacteria  <NA>       V              7     2     3
## 3875     Dehalococcoidetes  <NA>       V              7     2     0
## 3876            Deinococci  <NA>       V              7     2   197
## 3877   Deltaproteobacteria  <NA>       V              7     2    58
## 3878 Epsilonproteobacteria  <NA>       V              7     2     0
## 3879       Erysipelotrichi  <NA>       V              7     2    18
## 3880         Fibrobacteria  <NA>       V              7     2     0
## 3881         Flavobacteria  <NA>       V              7     2  1320
## 3882          Fusobacteria  <NA>       V              7     2     1
## 3883   Gammaproteobacteria  <NA>       V              7     2  1154
## 3884      Gemmatimonadetes  <NA>       V              7     2     1
## 3885            Holophagae  <NA>       V              7     2     0
## 3886         Lentisphaeria  <NA>       V              7     2     0
## 3887       Methanobacteria  <NA>       V              7     2     0
## 3888       Methanomicrobia  <NA>       V              7     2     0
## 3889            Mollicutes  <NA>       V              7     2     8
## 3890            Nitrospira  <NA>       V              7     2     1
## 3891              Opitutae  <NA>       V              7     2    18
## 3892      Planctomycetacia  <NA>       V              7     2    45
## 3893       Sphingobacteria  <NA>       V              7     2   506
## 3894          Spirochaetes  <NA>       V              7     2     4
## 3895          Subdivision3  <NA>       V              7     2     0
## 3896           Synergistia  <NA>       V              7     2     0
## 3897        Thermomicrobia  <NA>       V              7     2    64
## 3898        Thermoplasmata  <NA>       V              7     2     0
## 3899           Thermotogae  <NA>       V              7     2     0
## 3900               Unknown  <NA>       V              7     2   696
## 3901         Acidobacteria     1       V              7     3     7
## 3902         Acidobacteria    10       V              7     3     9
## 3903         Acidobacteria    14       V              7     3     1
## 3904         Acidobacteria    16       V              7     3     0
## 3905         Acidobacteria    17       V              7     3     0
## 3906         Acidobacteria    18       V              7     3     1
## 3907         Acidobacteria    21       V              7     3     3
## 3908         Acidobacteria    22       V              7     3     4
## 3909         Acidobacteria     3       V              7     3    68
## 3910         Acidobacteria     4       V              7     3     8
## 3911         Acidobacteria     5       V              7     3     8
## 3912         Acidobacteria     6       V              7     3    42
## 3913         Acidobacteria     7       V              7     3     0
## 3914         Acidobacteria     9       V              7     3     0
## 3915        Actinobacteria  <NA>       V              7     3   337
## 3916   Alphaproteobacteria  <NA>       V              7     3   510
## 3917          Anaerolineae  <NA>       V              7     3   223
## 3918               Bacilli  <NA>       V              7     3   161
## 3919           Bacteroidia  <NA>       V              7     3   166
## 3920    Betaproteobacteria  <NA>       V              7     3   600
## 3921           Caldilineae  <NA>       V              7     3    60
## 3922            Chlamydiae  <NA>       V              7     3     0
## 3923           Chloroflexi  <NA>       V              7     3     0
## 3924        Chrysiogenetes  <NA>       V              7     3     0
## 3925            Clostridia  <NA>       V              7     3  3134
## 3926         Cyanobacteria  <NA>       V              7     3     0
## 3927     Dehalococcoidetes  <NA>       V              7     3     2
## 3928            Deinococci  <NA>       V              7     3    81
## 3929   Deltaproteobacteria  <NA>       V              7     3   178
## 3930 Epsilonproteobacteria  <NA>       V              7     3     0
## 3931       Erysipelotrichi  <NA>       V              7     3    81
## 3932         Fibrobacteria  <NA>       V              7     3     0
## 3933         Flavobacteria  <NA>       V              7     3   198
## 3934          Fusobacteria  <NA>       V              7     3    16
## 3935   Gammaproteobacteria  <NA>       V              7     3   406
## 3936      Gemmatimonadetes  <NA>       V              7     3    30
## 3937            Holophagae  <NA>       V              7     3     2
## 3938         Lentisphaeria  <NA>       V              7     3     0
## 3939       Methanobacteria  <NA>       V              7     3     0
## 3940       Methanomicrobia  <NA>       V              7     3     0
## 3941            Mollicutes  <NA>       V              7     3     1
## 3942            Nitrospira  <NA>       V              7     3    33
## 3943              Opitutae  <NA>       V              7     3     4
## 3944      Planctomycetacia  <NA>       V              7     3    52
## 3945       Sphingobacteria  <NA>       V              7     3   512
## 3946          Spirochaetes  <NA>       V              7     3     4
## 3947          Subdivision3  <NA>       V              7     3     0
## 3948           Synergistia  <NA>       V              7     3     2
## 3949        Thermomicrobia  <NA>       V              7     3    54
## 3950        Thermoplasmata  <NA>       V              7     3     0
## 3951           Thermotogae  <NA>       V              7     3     0
## 3952               Unknown  <NA>       V              7     3  1170
## 3953         Acidobacteria     1       V              8     2     0
## 3954         Acidobacteria    10       V              8     2     0
## 3955         Acidobacteria    14       V              8     2     0
## 3956         Acidobacteria    16       V              8     2     0
## 3957         Acidobacteria    17       V              8     2     0
## 3958         Acidobacteria    18       V              8     2     0
## 3959         Acidobacteria    21       V              8     2     0
## 3960         Acidobacteria    22       V              8     2     0
## 3961         Acidobacteria     3       V              8     2     0
## 3962         Acidobacteria     4       V              8     2     0
## 3963         Acidobacteria     5       V              8     2     0
## 3964         Acidobacteria     6       V              8     2     1
## 3965         Acidobacteria     7       V              8     2     0
## 3966         Acidobacteria     9       V              8     2     0
## 3967        Actinobacteria  <NA>       V              8     2   675
## 3968   Alphaproteobacteria  <NA>       V              8     2  1000
## 3969          Anaerolineae  <NA>       V              8     2     0
## 3970               Bacilli  <NA>       V              8     2    53
## 3971           Bacteroidia  <NA>       V              8     2  1346
## 3972    Betaproteobacteria  <NA>       V              8     2   150
## 3973           Caldilineae  <NA>       V              8     2    31
## 3974            Chlamydiae  <NA>       V              8     2     0
## 3975           Chloroflexi  <NA>       V              8     2     0
## 3976        Chrysiogenetes  <NA>       V              8     2     0
## 3977            Clostridia  <NA>       V              8     2  3084
## 3978         Cyanobacteria  <NA>       V              8     2     0
## 3979     Dehalococcoidetes  <NA>       V              8     2     0
## 3980            Deinococci  <NA>       V              8     2  1102
## 3981   Deltaproteobacteria  <NA>       V              8     2   121
## 3982 Epsilonproteobacteria  <NA>       V              8     2     0
## 3983       Erysipelotrichi  <NA>       V              8     2   172
## 3984         Fibrobacteria  <NA>       V              8     2     0
## 3985         Flavobacteria  <NA>       V              8     2  2003
## 3986          Fusobacteria  <NA>       V              8     2     0
## 3987   Gammaproteobacteria  <NA>       V              8     2  1163
## 3988      Gemmatimonadetes  <NA>       V              8     2     0
## 3989            Holophagae  <NA>       V              8     2     0
## 3990         Lentisphaeria  <NA>       V              8     2     0
## 3991       Methanobacteria  <NA>       V              8     2     0
## 3992       Methanomicrobia  <NA>       V              8     2     0
## 3993            Mollicutes  <NA>       V              8     2    30
## 3994            Nitrospira  <NA>       V              8     2     0
## 3995              Opitutae  <NA>       V              8     2    16
## 3996      Planctomycetacia  <NA>       V              8     2    18
## 3997       Sphingobacteria  <NA>       V              8     2   466
## 3998          Spirochaetes  <NA>       V              8     2     2
## 3999          Subdivision3  <NA>       V              8     2     0
## 4000           Synergistia  <NA>       V              8     2     0
## 4001        Thermomicrobia  <NA>       V              8     2    71
## 4002        Thermoplasmata  <NA>       V              8     2     0
## 4003           Thermotogae  <NA>       V              8     2     0
## 4004               Unknown  <NA>       V              8     2   792
## 4005         Acidobacteria     1       V              9     1     0
## 4006         Acidobacteria    10       V              9     1     0
## 4007         Acidobacteria    14       V              9     1     0
## 4008         Acidobacteria    16       V              9     1     0
## 4009         Acidobacteria    17       V              9     1     0
## 4010         Acidobacteria    18       V              9     1     0
## 4011         Acidobacteria    21       V              9     1     0
## 4012         Acidobacteria    22       V              9     1     0
## 4013         Acidobacteria     3       V              9     1     0
## 4014         Acidobacteria     4       V              9     1     0
## 4015         Acidobacteria     5       V              9     1     0
## 4016         Acidobacteria     6       V              9     1     0
## 4017         Acidobacteria     7       V              9     1     0
## 4018         Acidobacteria     9       V              9     1     0
## 4019        Actinobacteria  <NA>       V              9     1    84
## 4020   Alphaproteobacteria  <NA>       V              9     1    27
## 4021          Anaerolineae  <NA>       V              9     1     0
## 4022               Bacilli  <NA>       V              9     1    76
## 4023           Bacteroidia  <NA>       V              9     1  3582
## 4024    Betaproteobacteria  <NA>       V              9     1     7
## 4025           Caldilineae  <NA>       V              9     1     0
## 4026            Chlamydiae  <NA>       V              9     1     0
## 4027           Chloroflexi  <NA>       V              9     1     0
## 4028        Chrysiogenetes  <NA>       V              9     1     0
## 4029            Clostridia  <NA>       V              9     1  2356
## 4030         Cyanobacteria  <NA>       V              9     1     0
## 4031     Dehalococcoidetes  <NA>       V              9     1     0
## 4032            Deinococci  <NA>       V              9     1     9
## 4033   Deltaproteobacteria  <NA>       V              9     1     1
## 4034 Epsilonproteobacteria  <NA>       V              9     1     1
## 4035       Erysipelotrichi  <NA>       V              9     1    23
## 4036         Fibrobacteria  <NA>       V              9     1     1
## 4037         Flavobacteria  <NA>       V              9     1   122
## 4038          Fusobacteria  <NA>       V              9     1     3
## 4039   Gammaproteobacteria  <NA>       V              9     1    69
## 4040      Gemmatimonadetes  <NA>       V              9     1     0
## 4041            Holophagae  <NA>       V              9     1     0
## 4042         Lentisphaeria  <NA>       V              9     1     2
## 4043       Methanobacteria  <NA>       V              9     1     0
## 4044       Methanomicrobia  <NA>       V              9     1     0
## 4045            Mollicutes  <NA>       V              9     1    11
## 4046            Nitrospira  <NA>       V              9     1     0
## 4047              Opitutae  <NA>       V              9     1     1
## 4048      Planctomycetacia  <NA>       V              9     1     0
## 4049       Sphingobacteria  <NA>       V              9     1    19
## 4050          Spirochaetes  <NA>       V              9     1     3
## 4051          Subdivision3  <NA>       V              9     1     0
## 4052           Synergistia  <NA>       V              9     1     0
## 4053        Thermomicrobia  <NA>       V              9     1     1
## 4054        Thermoplasmata  <NA>       V              9     1     0
## 4055           Thermotogae  <NA>       V              9     1     0
## 4056               Unknown  <NA>       V              9     1    41
## 4057         Acidobacteria     1       V              9     2    18
## 4058         Acidobacteria    10       V              9     2     0
## 4059         Acidobacteria    14       V              9     2     0
## 4060         Acidobacteria    16       V              9     2     0
## 4061         Acidobacteria    17       V              9     2     0
## 4062         Acidobacteria    18       V              9     2     0
## 4063         Acidobacteria    21       V              9     2     0
## 4064         Acidobacteria    22       V              9     2     0
## 4065         Acidobacteria     3       V              9     2     0
## 4066         Acidobacteria     4       V              9     2     0
## 4067         Acidobacteria     5       V              9     2     0
## 4068         Acidobacteria     6       V              9     2     0
## 4069         Acidobacteria     7       V              9     2     0
## 4070         Acidobacteria     9       V              9     2     0
## 4071        Actinobacteria  <NA>       V              9     2   870
## 4072   Alphaproteobacteria  <NA>       V              9     2   122
## 4073          Anaerolineae  <NA>       V              9     2     0
## 4074               Bacilli  <NA>       V              9     2    44
## 4075           Bacteroidia  <NA>       V              9     2    56
## 4076    Betaproteobacteria  <NA>       V              9     2   271
## 4077           Caldilineae  <NA>       V              9     2     0
## 4078            Chlamydiae  <NA>       V              9     2     0
## 4079           Chloroflexi  <NA>       V              9     2     0
## 4080        Chrysiogenetes  <NA>       V              9     2     0
## 4081            Clostridia  <NA>       V              9     2   143
## 4082         Cyanobacteria  <NA>       V              9     2     0
## 4083     Dehalococcoidetes  <NA>       V              9     2     0
## 4084            Deinococci  <NA>       V              9     2    61
## 4085   Deltaproteobacteria  <NA>       V              9     2     0
## 4086 Epsilonproteobacteria  <NA>       V              9     2     0
## 4087       Erysipelotrichi  <NA>       V              9     2    40
## 4088         Fibrobacteria  <NA>       V              9     2     1
## 4089         Flavobacteria  <NA>       V              9     2  1178
## 4090          Fusobacteria  <NA>       V              9     2     0
## 4091   Gammaproteobacteria  <NA>       V              9     2  2668
## 4092      Gemmatimonadetes  <NA>       V              9     2     0
## 4093            Holophagae  <NA>       V              9     2     0
## 4094         Lentisphaeria  <NA>       V              9     2     0
## 4095       Methanobacteria  <NA>       V              9     2     0
## 4096       Methanomicrobia  <NA>       V              9     2     0
## 4097            Mollicutes  <NA>       V              9     2     3
## 4098            Nitrospira  <NA>       V              9     2     0
## 4099              Opitutae  <NA>       V              9     2     6
## 4100      Planctomycetacia  <NA>       V              9     2    14
## 4101       Sphingobacteria  <NA>       V              9     2  1061
## 4102          Spirochaetes  <NA>       V              9     2     0
## 4103          Subdivision3  <NA>       V              9     2     0
## 4104           Synergistia  <NA>       V              9     2     0
## 4105        Thermomicrobia  <NA>       V              9     2     2
## 4106        Thermoplasmata  <NA>       V              9     2     0
## 4107           Thermotogae  <NA>       V              9     2     0
## 4108               Unknown  <NA>       V              9     2   954
## 4109         Acidobacteria     1       V              9     3     0
## 4110         Acidobacteria    10       V              9     3     0
## 4111         Acidobacteria    14       V              9     3     0
## 4112         Acidobacteria    16       V              9     3     0
## 4113         Acidobacteria    17       V              9     3     0
## 4114         Acidobacteria    18       V              9     3     0
## 4115         Acidobacteria    21       V              9     3     0
## 4116         Acidobacteria    22       V              9     3     0
## 4117         Acidobacteria     3       V              9     3     0
## 4118         Acidobacteria     4       V              9     3     0
## 4119         Acidobacteria     5       V              9     3     0
## 4120         Acidobacteria     6       V              9     3     0
## 4121         Acidobacteria     7       V              9     3     0
## 4122         Acidobacteria     9       V              9     3     0
## 4123        Actinobacteria  <NA>       V              9     3     6
## 4124   Alphaproteobacteria  <NA>       V              9     3     1
## 4125          Anaerolineae  <NA>       V              9     3     0
## 4126               Bacilli  <NA>       V              9     3     9
## 4127           Bacteroidia  <NA>       V              9     3     2
## 4128    Betaproteobacteria  <NA>       V              9     3     0
## 4129           Caldilineae  <NA>       V              9     3     0
## 4130            Chlamydiae  <NA>       V              9     3     0
## 4131           Chloroflexi  <NA>       V              9     3     0
## 4132        Chrysiogenetes  <NA>       V              9     3     0
## 4133            Clostridia  <NA>       V              9     3    18
## 4134         Cyanobacteria  <NA>       V              9     3     0
## 4135     Dehalococcoidetes  <NA>       V              9     3     0
## 4136            Deinococci  <NA>       V              9     3     2
## 4137   Deltaproteobacteria  <NA>       V              9     3     0
## 4138 Epsilonproteobacteria  <NA>       V              9     3     0
## 4139       Erysipelotrichi  <NA>       V              9     3     1
## 4140         Fibrobacteria  <NA>       V              9     3     0
## 4141         Flavobacteria  <NA>       V              9     3     5
## 4142          Fusobacteria  <NA>       V              9     3     0
## 4143   Gammaproteobacteria  <NA>       V              9     3    10
## 4144      Gemmatimonadetes  <NA>       V              9     3     0
## 4145            Holophagae  <NA>       V              9     3     0
## 4146         Lentisphaeria  <NA>       V              9     3     0
## 4147       Methanobacteria  <NA>       V              9     3     0
## 4148       Methanomicrobia  <NA>       V              9     3     0
## 4149            Mollicutes  <NA>       V              9     3     1
## 4150            Nitrospira  <NA>       V              9     3     0
## 4151              Opitutae  <NA>       V              9     3     0
## 4152      Planctomycetacia  <NA>       V              9     3     0
## 4153       Sphingobacteria  <NA>       V              9     3     3
## 4154          Spirochaetes  <NA>       V              9     3     0
## 4155          Subdivision3  <NA>       V              9     3     0
## 4156           Synergistia  <NA>       V              9     3     0
## 4157        Thermomicrobia  <NA>       V              9     3     0
## 4158        Thermoplasmata  <NA>       V              9     3     0
## 4159           Thermotogae  <NA>       V              9     3     0
## 4160               Unknown  <NA>       V              9     3     2
## 4161         Acidobacteria     1       V              9     4    38
## 4162         Acidobacteria    10       V              9     4     0
## 4163         Acidobacteria    14       V              9     4    17
## 4164         Acidobacteria    16       V              9     4     0
## 4165         Acidobacteria    17       V              9     4     0
## 4166         Acidobacteria    18       V              9     4     0
## 4167         Acidobacteria    21       V              9     4     0
## 4168         Acidobacteria    22       V              9     4     0
## 4169         Acidobacteria     3       V              9     4    19
## 4170         Acidobacteria     4       V              9     4     0
## 4171         Acidobacteria     5       V              9     4     0
## 4172         Acidobacteria     6       V              9     4     5
## 4173         Acidobacteria     7       V              9     4     0
## 4174         Acidobacteria     9       V              9     4     0
## 4175        Actinobacteria  <NA>       V              9     4   273
## 4176   Alphaproteobacteria  <NA>       V              9     4   411
## 4177          Anaerolineae  <NA>       V              9     4     0
## 4178               Bacilli  <NA>       V              9     4    82
## 4179           Bacteroidia  <NA>       V              9     4     7
## 4180    Betaproteobacteria  <NA>       V              9     4   108
## 4181           Caldilineae  <NA>       V              9     4     6
## 4182            Chlamydiae  <NA>       V              9     4     0
## 4183           Chloroflexi  <NA>       V              9     4     0
## 4184        Chrysiogenetes  <NA>       V              9     4     0
## 4185            Clostridia  <NA>       V              9     4  3051
## 4186         Cyanobacteria  <NA>       V              9     4     1
## 4187     Dehalococcoidetes  <NA>       V              9     4     0
## 4188            Deinococci  <NA>       V              9     4    88
## 4189   Deltaproteobacteria  <NA>       V              9     4    11
## 4190 Epsilonproteobacteria  <NA>       V              9     4     0
## 4191       Erysipelotrichi  <NA>       V              9     4    43
## 4192         Fibrobacteria  <NA>       V              9     4     0
## 4193         Flavobacteria  <NA>       V              9     4    56
## 4194          Fusobacteria  <NA>       V              9     4     0
## 4195   Gammaproteobacteria  <NA>       V              9     4   559
## 4196      Gemmatimonadetes  <NA>       V              9     4    38
## 4197            Holophagae  <NA>       V              9     4     0
## 4198         Lentisphaeria  <NA>       V              9     4     0
## 4199       Methanobacteria  <NA>       V              9     4     0
## 4200       Methanomicrobia  <NA>       V              9     4     0
## 4201            Mollicutes  <NA>       V              9     4     3
## 4202            Nitrospira  <NA>       V              9     4     0
## 4203              Opitutae  <NA>       V              9     4     3
## 4204      Planctomycetacia  <NA>       V              9     4    95
## 4205       Sphingobacteria  <NA>       V              9     4   146
## 4206          Spirochaetes  <NA>       V              9     4    18
## 4207          Subdivision3  <NA>       V              9     4     0
## 4208           Synergistia  <NA>       V              9     4     0
## 4209        Thermomicrobia  <NA>       V              9     4    35
## 4210        Thermoplasmata  <NA>       V              9     4     0
## 4211           Thermotogae  <NA>       V              9     4     0
## 4212               Unknown  <NA>       V              9     4   303
```
We get a warning from R that it has filled in 'NA' for the bacteria that did not have groups. Note that I chose to split Taxa using '_Gp' since I did not need 'Gp'. 


***
__Challenge__ 


<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/pug_challenge1.jpeg){width=200px}

</div>

Use the `glimpse()` function to look  at the type of each variable in our new data frame. Are those the types you expected? Why or why not? How is `glimpse()` different from the `str()` function?

</br>

</br>

***




Now that we have tidy data:

    - Which latrine depth has the greatest mean number of OTUs?
    - Is there more Clostridia in Tanzania or Vietnam?
    - Which site had the greatest number of bacteria?


__Okay, Go!__

<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/giphy.gif){width=200px}

</div>

</br>
</br>



Which latrine depth has the greatest mean number of OTUs?



```r
split_dat %>% group_by(Latrine_Number) %>% summarize(mean = mean(OTUs)) %>% arrange(desc(mean))
```

```
## # A tibble: 22 x 2
##    Latrine_Number  mean
##    <chr>          <dbl>
##  1 17               415
##  2 16               403
##  3 11               338
##  4 20               335
##  5 10               328
##  6 8                236
##  7 15               207
##  8 3                206
##  9 18               201
## 10 12               188
## # ... with 12 more rows
```


Is there more Clostridia in Tanzania or Vietnam?


```r
split_dat %>% filter(Taxa == "Clostridia") %>% group_by(Country) %>% summarise(sum = sum(OTUs)) %>% arrange(desc(sum))
```

```
## # A tibble: 2 x 2
##   Country    sum
##   <chr>    <int>
## 1 V       176079
## 2 T       101217
```

Which site had the greatest number of bacteria? (Calculate the sum of and the mean of OTUs at for each combination of Country, Latrine_Number and Depth. Order the results by the highest sum, followed by the highest mean.)



```r
split_dat %>% group_by(Country, Latrine_Number, Depth) %>% summarize(sum = sum(OTUs), mean = mean(OTUs)) %>% arrange(desc(sum), desc(mean))
```

```
## # A tibble: 81 x 5
## # Groups:   Country, Latrine_Number [28]
##    Country Latrine_Number Depth   sum  mean
##    <chr>   <chr>          <chr> <int> <dbl>
##  1 V       11             1     26730   514
##  2 T       2              9     24953   480
##  3 V       16             2     23963   461
##  4 V       3              1     23553   453
##  5 V       11             3     23100   444
##  6 V       3              2     22779   438
##  7 V       17             1     22417   431
##  8 V       17             2     20705   398
##  9 V       16             1     17907   344
## 10 V       20             1     17436   335
## # ... with 71 more rows
```

***

<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/easy-1.png){width=100px}

</div>

</br>

</br>

***



To get data back into its original format, there are reciprocal functions in the tidyr package, making it possible to switch between wide and long formats. 

__Fair question:__ But you've just been telling me how great the 'long' format is?!?! Why would I want the wide format???

__Honest answer:__ Note that our original data frame was 52 rows and expanded to 4212 rows in the long format. When you have, say, a genomics dataset you might end up with 6,000 rows expanding to 600,000 rows. You probably want to do your calculations and switch back to the more 'human readable' format. Sure, I can save a data frame with 600,000 rows, but I can't really send it to anyone because LibreOffice or Excel will crash opening it. Also, sometimes you just can't fight against conventional formatting...and win.


***

__Challenge__ 


<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/pug_challenge1.jpeg){width=200px}

</div>

Collapse Country, Latrine_Number and Depth back into one variable, 'Site', using the `unite()` function. Store the output in a data frame called unite_dat.

</br>
</br>

***
__Challenge__ 


<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/pug_challenge1.jpeg){width=200px}

</div>

Use the `spread()` function to turn unite_dat into the wide shape of our original dataset. 

</br>
</br>

***

##Adding rows and columns to data frames

We are going to use a subset of a second data frame from the same study to use in our join lesson. We are going to remove some observations and add an observation so the names of the samples we are working with are not exactly equal.


```r
jdat <- read.csv("data/ENV_pitlatrine.csv", stringsAsFactors = FALSE)

str(jdat)
```

```
## 'data.frame':	81 obs. of  12 variables:
##  $ Samples   : chr  "T_2_1" "T_2_10" "T_2_12" "T_2_2" ...
##  $ pH        : num  7.82 9.08 8.84 6.49 6.46 7.69 7.48 7.6 7.55 7.68 ...
##  $ Temp      : num  25.1 24.2 25.1 29.6 27.9 28.7 29.8 25 28.8 28.9 ...
##  $ TS        : num  14.5 37.8 71.1 13.9 29.4 ...
##  $ VS        : num  71.33 31.52 5.94 64.93 26.85 ...
##  $ VFA       : num  71 2 1 3.7 27.5 1.5 1.1 1.1 30.9 24.2 ...
##  $ CODt      : int  874 102 35 389 161 57 107 62 384 372 ...
##  $ CODs      : int  311 9 4 180 35 3 9 8 57 57 ...
##  $ perCODsbyt: int  36 9 10 46 22 6 8 13 15 15 ...
##  $ NH4       : num  3.3 1.2 0.5 6.2 2.4 0.8 0.7 0.9 21.6 20.4 ...
##  $ Prot      : num  35.4 18.4 0 29.3 19.4 0 14.1 7.6 33.1 44.5 ...
##  $ Carbo     : num  22 43 17 25 31 14 28 28 47 48 ...
```

To remove some observations and variables, we can specify which rows/columns we do/do not want to keep.


```r
jdat <- jdat[-c(4,7,9,12,20,22) , 1:4]
```
To add an observation, we need to add a row of data. `rbind()` is a base R function that will add a row to the end of a data frame. 

Public Service Announcement: IF YOU ADD A VECTOR TO YOUR DATA FRAME rbind() does not check to make sure your value belongs to a column and will not throw an error if the length of the added row is longer or shorter than your data frame. For example, I want to add an extra row to my data frame which is in the form of a vector which is supposed to be of length 4 (the number of columns in my data frame). Here, I have simply created a vector with a new sample name, and then have used the `rep()` function to repeat the value 5, 3 times. This is added to the data frame jdat.


```r
rbind(jdat, c("V_2_10", rep(5, 3))) %>% tail()
```

```
##     Samples   pH Temp   TS
## 77    V_8_2  9.3 19.5 36.8
## 78    V_9_1  7.3 18.8 31.3
## 79    V_9_2 4.04 20.5   32
## 80    V_9_3 4.36 19.9 92.6
## 81    V_9_4  4.3 19.8 36.5
## 761  V_2_10    5    5    5
```
However, if I had created a vector that was too short, the vector would be recycled to match the number of columns in the data frame. We can see that the sample name has been recycled in the TS column.


```r
rbind(jdat, c("V_2_10", rep(5, 2))) %>% tail()
```

```
##     Samples   pH Temp     TS
## 77    V_8_2  9.3 19.5   36.8
## 78    V_9_1  7.3 18.8   31.3
## 79    V_9_2 4.04 20.5     32
## 80    V_9_3 4.36 19.9   92.6
## 81    V_9_4  4.3 19.8   36.5
## 761  V_2_10    5    5 V_2_10
```

If the vector is too long, it will simply be truncated to the match the number of columns in the data frame.

```r
rbind(jdat, c("V_2_10", rep(5, 16))) %>% tail()
```

```
##     Samples   pH Temp   TS
## 77    V_8_2  9.3 19.5 36.8
## 78    V_9_1  7.3 18.8 31.3
## 79    V_9_2 4.04 20.5   32
## 80    V_9_3 4.36 19.9 92.6
## 81    V_9_4  4.3 19.8 36.5
## 761  V_2_10    5    5    5
```


If you give rbind() your column information AS A VECTOR, it ignores it. This is the correct column information with the order of the columns altered. Note that the number 6 ends up in the Temp column despite being labelled pH.


```r
rbind(jdat, c(Samples = "V_2_10", Temp = 5, pH = 6, TS = 5)) %>% tail()
```

```
##     Samples   pH Temp   TS
## 77    V_8_2  9.3 19.5 36.8
## 78    V_9_1  7.3 18.8 31.3
## 79    V_9_2 4.04 20.5   32
## 80    V_9_3 4.36 19.9 92.6
## 81    V_9_4  4.3 19.8 36.5
## 761  V_2_10    5    6    5
```

This is the incorrect column information. Note that the row is added regardless. One other note of importance is that, because vectors must be coerced to one data type, in this case a character vector. We started with both character and numeric data in jdat. In adding a vector, the entire data frame (think of each column as a vector) has been coerced to character data.


```r
rbind(jdat, c(Turtles = "V_2_10", pH = 5, Volatility = 5, TS = 5)) %>% tail()
```

```
##     Samples   pH Temp   TS
## 77    V_8_2  9.3 19.5 36.8
## 78    V_9_1  7.3 18.8 31.3
## 79    V_9_2 4.04 20.5   32
## 80    V_9_3 4.36 19.9 92.6
## 81    V_9_4  4.3 19.8 36.5
## 761  V_2_10    5    5    5
```
This will not happen if you USE A LIST with rbind(), because lists can hold multiple types of data. This is a lesson in using correct data structures. USING A LIST rbind() will warn us appropriately if our row is of an inappropriate length.


```r
rbind(jdat, list("V_2_10", rep(5, 16))) %>% tail()
```

```
## Error in rbind(deparse.level, ...): invalid list argument: all variables should have the same length
```
And it will warn us when our names do not match.


```r
rbind(jdat, list(Turtles = "V_2_10", pH = 5, Volatility = 5, TS = 5)) %>% tail()
```

```
## Error in match.names(clabs, nmi): names do not match previous names
```


There is an equivalent function from dplyr, `bind_rows()', which tries to save you from errors by ensuring that your column identifiers match. If you do not give column identifiers, whether you are trying to add a vector or a list, it will not add your row to the frame.


```r
bind_rows(jdat, c("V_2_10", rep(5, 2))) %>% tail()
```

```
## Error in bind_rows_(x, .id): Argument 2 must have names
```



```r
bind_rows(jdat, list("V_2_10", rep(5, 2))) %>% tail()
```

```
## Error in bind_rows_(x, .id): Argument 2 must have names
```
If you give bind_rows() the correct column information in vector format, it will only add a vector as a row IF THE CHARACTER TYPE MATCHES ALL DATA FRAME COLUMN TYPES (ie. if our data frame was all character data). Otherwise, it actually gives you the useful error that your character types are not matching. 


```r
bind_rows(jdat, c(Samples = "V_2_10", pH = 5, Temp = 5, TS = 5)) %>% tail()
```

```
## Error in bind_rows_(x, .id): Column `pH` can't be converted from numeric to character
```

_Sanity check:_ A sanity check is a check to make sure things are turning out as you expect them to - it is a way of checking your (or others') assumptions. It is particularly useful in the data exploration stage when you are getting familiar with your data before you try to run any type of model. However, it is also good to make sure a function is behaving as you expect it to, or trouble-shooting odd behaviours.  

If we coerce the entire data frame to character type (using our dangerous rbind + vector syntax), we can now use bind_rows() since our the vector will be coerced to a character type AND the data frame matches this type in every column.


```r
jdat2 <- rbind(jdat, c("V_2_10", rep(5, 3))) 

bind_rows(jdat2, c(Samples = "V_2_10", pH = 5, Temp = 5, TS = 5)) %>% tail()
```

```
##    Samples   pH Temp   TS
## 72   V_9_1  7.3 18.8 31.3
## 73   V_9_2 4.04 20.5   32
## 74   V_9_3 4.36 19.9 92.6
## 75   V_9_4  4.3 19.8 36.5
## 76  V_2_10    5    5    5
## 77  V_2_10    5    5    5
```


If you give bind_rows() the correct column information in list format, it will add your row. Here is a sanity check on switching the order of the columns again.


```r
bind_rows(jdat, list(Samples = "V_2_10", Temp = 5, pH = 6, TS = 5)) %>% tail()
```

```
##    Samples   pH Temp   TS
## 71   V_8_2 9.30 19.5 36.8
## 72   V_9_1 7.30 18.8 31.3
## 73   V_9_2 4.04 20.5 32.0
## 74   V_9_3 4.36 19.9 92.6
## 75   V_9_4 4.30 19.8 36.5
## 76  V_2_10 6.00  5.0  5.0
```

bind_rows() has a different behaviour than rbind() when column names do not match. It will match your columns as much as possible, and then create new columns for the data that does not fit at the end of your data frame. Not that 'NA's will be created for all missing data.


```r
bind_rows(jdat, list(Turtles = "V_2_10", pH = 5, Volatility = 5, TS = 5)) %>% tail()
```

```
##    Samples   pH Temp   TS Turtles Volatility
## 71   V_8_2 9.30 19.5 36.8    <NA>         NA
## 72   V_9_1 7.30 18.8 31.3    <NA>         NA
## 73   V_9_2 4.04 20.5 32.0    <NA>         NA
## 74   V_9_3 4.36 19.9 92.6    <NA>         NA
## 75   V_9_4 4.30 19.8 36.5    <NA>         NA
## 76    <NA> 5.00   NA  5.0  V_2_10          5
```
Whenever you are adding rows or columns, I strongly advise checking to see that the dimensions of the resulting data frame are what you expect. 

```r
jdat <- bind_rows(jdat, list(Samples = "V_2_10", pH = 5, Temp = 5, TS = 5)) 
dim(jdat)
```

```
## [1] 76  4
```



##Intro to joins

Often we have more than one data table that shares a common attribute. For example, with our current dataset, we have other variables (such as pH) for a sample, as well as our OTU table, both of which have site IDs (ie. T_2_9). We want to mergee these into one table.


Joins can be tricky, so we are going to use a subset of our tidy data such that we can easily observe the output of our join.


```r
str(spread_dat)
```

```
## 'data.frame':	4212 obs. of  3 variables:
##  $ Taxa: chr  "Acidobacteria_Gp1" "Acidobacteria_Gp10" "Acidobacteria_Gp14" "Acidobacteria_Gp16" ...
##  $ Site: chr  "T_2_1" "T_2_1" "T_2_1" "T_2_1" ...
##  $ OTUs: int  0 0 0 0 0 0 0 0 0 0 ...
```
Joins use a 'key' by which we can match up our data frames. When we look at our data frames we can see that they have matching information in 'Samples'.  We are going to reduce our dataset by only keeping non-zero values so we can see how the join functions work a bit more easily. We have already removed some observations from jdat and added a row, just so our key columns don't match perfectly.

***
__Challenge__ 


<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/pug_challenge1.jpeg){width=100px}

</div>

Filter spread_dat to remove all non-zero values, and store it in an object ndat. How many rows in spread_dat had the value of zero? Sort ndat to keep the top 20 rows with the highest OTUs.

</br>

</br>

***




There are 2 types of joins:

1. mutating joins - uses a key to match observations and combines variables from 2 tables (adding columns and potentially rows)
2. filtering joins - uses a key to match observations, to subset observations (rows)


Inner join is a mutating join.  Inner join "returns all rows from x where there are matching values in y, and all columns from x and y. If there are multiple matches between x and y, all combination of the matches are returned."

A set of graphics from R for Data Science makes the description clearer:
![](img/join-inner.png)  



```r
inner_join(ndat, jdat, by = c("Site" = "Samples"))
```

```
##         Taxa  Site OTUs   pH Temp    TS
## 1 Clostridia T_2_1 6213 7.82 25.1 14.53
```

We can see that there are 18 rows in the resulting data frame. and that columns from jdat have been added. Rows from ndat that did not have a matching site in jdat were removed.

Outer joins are a set of mutating joins. There are 3 outer joins: left, right, and full.
![](img/join-outer.png)


left_join() return all rows from x, and all columns from x and y. Rows in x with no match in y will have NA values in the new columns. If there are multiple matches between x and y, all combinations of the matches are returned.



```r
left_join(ndat, jdat, by = c("Site" = "Samples"))
```

```
##         Taxa  Site OTUs   pH Temp    TS
## 1 Clostridia T_2_1 6213 7.82 25.1 14.53
```
That means that we will have our 20 rows from ndat, and any items that weren't found in jdat, in this case T_2_2 and T_4_3 will be filled with NA.

right_join() "returns all rows from y, and all columns from x and y. Rows in y with no match in x will have NA values in the new columns. If there are multiple matches between x and y, all combinations of the matches are returned."


```r
right_join(ndat, jdat, by = c("Site" = "Samples"))
```

```
##          Taxa   Site OTUs    pH Temp    TS
## 1  Clostridia  T_2_1 6213  7.82 25.1 14.53
## 2        <NA> T_2_10   NA  9.08 24.2 37.76
## 3        <NA> T_2_12   NA  8.84 25.1 71.11
## 4        <NA>  T_2_3   NA  6.46 27.9 29.45
## 5        <NA>  T_2_6   NA  7.69 28.7 65.52
## 6        <NA>  T_2_9   NA  7.60 25.0 46.87
## 7        <NA>  T_3_3   NA  7.68 28.9 14.65
## 8        <NA>  T_3_5   NA  7.69 28.7 14.87
## 9        <NA>  T_4_4   NA  7.84 26.3 28.85
## 10       <NA>  T_4_5   NA  7.95 27.9 46.85
## 11       <NA>  T_4_6   NA  7.58 30.1 38.38
## 12       <NA>  T_4_7   NA  7.68 28.3 26.54
## 13       <NA>  T_5_2   NA  7.58 29.5 12.48
## 14       <NA>  T_5_3   NA  7.53 27.5 12.55
## 15       <NA>  T_5_4   NA  7.40 29.4 15.10
## 16       <NA>  T_6_2   NA  7.77 27.9 46.87
## 17       <NA>  T_6_7   NA  8.09 31.7 68.33
## 18       <NA>  T_6_8   NA  8.26 29.7 64.90
## 19       <NA>  T_9_1   NA  7.85 29.3  9.12
## 20       <NA>  T_9_2   NA  7.86 28.5 13.56
## 21       <NA>  T_9_3   NA  8.35 29.5 12.67
## 22       <NA>  T_9_4   NA  8.43 29.5 58.76
## 23       <NA>  T_9_5   NA  7.90 29.3 56.12
## 24       <NA>  V_1_2   NA  6.67 29.2 43.30
## 25       <NA> V_10_1   NA  9.12 18.6 46.30
## 26       <NA> V_11_1   NA  9.00 18.5 63.00
## 27       <NA> V_11_2   NA  9.64 18.3 56.70
## 28       <NA> V_11_3   NA  8.45 18.2 55.20
## 29       <NA> V_12_1   NA  9.16 19.6 56.60
## 30       <NA> V_12_2   NA  9.54 18.3 49.00
## 31       <NA> V_13_1   NA  8.58 19.0 26.00
## 32       <NA> V_13_2   NA  7.98 18.6 46.80
## 33       <NA> V_14_1   NA  7.21 20.0 37.80
## 34       <NA> V_14_2   NA  7.74 18.5 51.70
## 35       <NA> V_14_3   NA  8.50 19.1 55.80
## 36       <NA> V_15_1   NA  7.44 18.9 25.40
## 37       <NA> V_15_2   NA  8.36 17.9 32.80
## 38       <NA> V_15_3   NA  8.15 18.8 31.80
## 39       <NA> V_16_1   NA  7.83 17.7 25.10
## 40       <NA> V_16_2   NA  6.26 16.3 24.00
## 41       <NA> V_17_1   NA  7.39 15.7 25.30
## 42       <NA> V_17_2   NA  8.14 15.4 25.60
## 43       <NA> V_18_1   NA  7.09 22.5 35.10
## 44       <NA> V_18_2   NA  8.54 24.9 34.90
## 45       <NA> V_18_3   NA  8.37 21.4 35.50
## 46       <NA> V_18_4   NA  8.25 19.4 29.90
## 47       <NA> V_19_1   NA  7.19 17.6 24.80
## 48       <NA> V_19_2   NA  7.68 17.4 31.80
## 49       <NA> V_19_3   NA  7.38 16.6 37.00
## 50       <NA>  V_2_1   NA  9.42 21.3 63.40
## 51       <NA>  V_2_2   NA  9.40 20.7 51.60
## 52       <NA>  V_2_3   NA  9.15 20.8 44.20
## 53       <NA> V_20_1   NA  9.04 17.0  9.60
## 54       <NA> V_21_1   NA 10.09 17.7 65.30
## 55       <NA> V_21_4   NA  9.58 17.1 40.10
## 56       <NA> V_22_1   NA  7.14 16.8 58.10
## 57       <NA> V_22_3   NA  6.67 17.1 84.40
## 58       <NA> V_22_4   NA  6.79 15.9 80.60
## 59       <NA>  V_3_1   NA  8.90 22.4 56.20
## 60       <NA>  V_3_2   NA  8.08 20.7 52.00
## 61       <NA>  V_4_1   NA  9.49 22.6 36.10
## 62       <NA>  V_4_2   NA  7.81 20.9 47.20
## 63       <NA>  V_5_1   NA  7.35 24.3 49.70
## 64       <NA>  V_5_3   NA  9.47 20.7 63.60
## 65       <NA>  V_6_1   NA  8.99 22.9 56.60
## 66       <NA>  V_6_2   NA  8.46 24.2 58.90
## 67       <NA>  V_6_3   NA  8.08 22.8 55.20
## 68       <NA>  V_7_1   NA  7.85 25.8 60.60
## 69       <NA>  V_7_2   NA  8.11 25.8 73.90
## 70       <NA>  V_7_3   NA  7.41 23.7 59.40
## 71       <NA>  V_8_2   NA  9.30 19.5 36.80
## 72       <NA>  V_9_1   NA  7.30 18.8 31.30
## 73       <NA>  V_9_2   NA  4.04 20.5 32.00
## 74       <NA>  V_9_3   NA  4.36 19.9 92.60
## 75       <NA>  V_9_4   NA  4.30 19.8 36.50
## 76       <NA> V_2_10   NA  5.00  5.0  5.00
```

That means that we will have our 75 rows from jdat, and any items that weren't found in ndat will be filled with NA. Since there are 76 rows in the final data frame, this means there must have been multiple rows matching from ndat. In other words, we had a duplicate key (Site) in ndat.

![](img/join-one-to-many.png)


Let's try to find which Site was duplicated. n() is a special dplyr function that counts the number of observations in a group. It can also be used with summarize() and mutate().


```r
right_join(ndat, jdat, by = c("Site" = "Samples")) %>% 
  group_by(Site) %>% 
  filter(n()>1)
```

```
## # A tibble: 0 x 6
## # Groups:   Site [0]
## # ... with 6 variables: Taxa <chr>, Site <chr>, OTUs <int>, pH <dbl>,
## #   Temp <dbl>, TS <dbl>
```

Note that Bacteriodia and Clostridia have different OTUs (from ndat), but the same pH, Temp and TS (from jdat). 


***
__Challenge__
<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/pug_challenge1.jpeg){width=200px}

</div>

Use mutate() and summarise() with n() to find the duplicated Site.

</br>

</br>

***

Note that if both of our data frames had duplicated keys, all possible matches would be retruned.

![](img/join-many-to-many.png)


full_join "returns all rows and all columns from both x and y. Where there are not matching values, returns NA for the one missing."



```r
full_join(ndat, jdat, by = c("Site" = "Samples"))
```

```
##          Taxa   Site OTUs    pH Temp    TS
## 1  Clostridia  T_2_1 6213  7.82 25.1 14.53
## 2        <NA> T_2_10   NA  9.08 24.2 37.76
## 3        <NA> T_2_12   NA  8.84 25.1 71.11
## 4        <NA>  T_2_3   NA  6.46 27.9 29.45
## 5        <NA>  T_2_6   NA  7.69 28.7 65.52
## 6        <NA>  T_2_9   NA  7.60 25.0 46.87
## 7        <NA>  T_3_3   NA  7.68 28.9 14.65
## 8        <NA>  T_3_5   NA  7.69 28.7 14.87
## 9        <NA>  T_4_4   NA  7.84 26.3 28.85
## 10       <NA>  T_4_5   NA  7.95 27.9 46.85
## 11       <NA>  T_4_6   NA  7.58 30.1 38.38
## 12       <NA>  T_4_7   NA  7.68 28.3 26.54
## 13       <NA>  T_5_2   NA  7.58 29.5 12.48
## 14       <NA>  T_5_3   NA  7.53 27.5 12.55
## 15       <NA>  T_5_4   NA  7.40 29.4 15.10
## 16       <NA>  T_6_2   NA  7.77 27.9 46.87
## 17       <NA>  T_6_7   NA  8.09 31.7 68.33
## 18       <NA>  T_6_8   NA  8.26 29.7 64.90
## 19       <NA>  T_9_1   NA  7.85 29.3  9.12
## 20       <NA>  T_9_2   NA  7.86 28.5 13.56
## 21       <NA>  T_9_3   NA  8.35 29.5 12.67
## 22       <NA>  T_9_4   NA  8.43 29.5 58.76
## 23       <NA>  T_9_5   NA  7.90 29.3 56.12
## 24       <NA>  V_1_2   NA  6.67 29.2 43.30
## 25       <NA> V_10_1   NA  9.12 18.6 46.30
## 26       <NA> V_11_1   NA  9.00 18.5 63.00
## 27       <NA> V_11_2   NA  9.64 18.3 56.70
## 28       <NA> V_11_3   NA  8.45 18.2 55.20
## 29       <NA> V_12_1   NA  9.16 19.6 56.60
## 30       <NA> V_12_2   NA  9.54 18.3 49.00
## 31       <NA> V_13_1   NA  8.58 19.0 26.00
## 32       <NA> V_13_2   NA  7.98 18.6 46.80
## 33       <NA> V_14_1   NA  7.21 20.0 37.80
## 34       <NA> V_14_2   NA  7.74 18.5 51.70
## 35       <NA> V_14_3   NA  8.50 19.1 55.80
## 36       <NA> V_15_1   NA  7.44 18.9 25.40
## 37       <NA> V_15_2   NA  8.36 17.9 32.80
## 38       <NA> V_15_3   NA  8.15 18.8 31.80
## 39       <NA> V_16_1   NA  7.83 17.7 25.10
## 40       <NA> V_16_2   NA  6.26 16.3 24.00
## 41       <NA> V_17_1   NA  7.39 15.7 25.30
## 42       <NA> V_17_2   NA  8.14 15.4 25.60
## 43       <NA> V_18_1   NA  7.09 22.5 35.10
## 44       <NA> V_18_2   NA  8.54 24.9 34.90
## 45       <NA> V_18_3   NA  8.37 21.4 35.50
## 46       <NA> V_18_4   NA  8.25 19.4 29.90
## 47       <NA> V_19_1   NA  7.19 17.6 24.80
## 48       <NA> V_19_2   NA  7.68 17.4 31.80
## 49       <NA> V_19_3   NA  7.38 16.6 37.00
## 50       <NA>  V_2_1   NA  9.42 21.3 63.40
## 51       <NA>  V_2_2   NA  9.40 20.7 51.60
## 52       <NA>  V_2_3   NA  9.15 20.8 44.20
## 53       <NA> V_20_1   NA  9.04 17.0  9.60
## 54       <NA> V_21_1   NA 10.09 17.7 65.30
## 55       <NA> V_21_4   NA  9.58 17.1 40.10
## 56       <NA> V_22_1   NA  7.14 16.8 58.10
## 57       <NA> V_22_3   NA  6.67 17.1 84.40
## 58       <NA> V_22_4   NA  6.79 15.9 80.60
## 59       <NA>  V_3_1   NA  8.90 22.4 56.20
## 60       <NA>  V_3_2   NA  8.08 20.7 52.00
## 61       <NA>  V_4_1   NA  9.49 22.6 36.10
## 62       <NA>  V_4_2   NA  7.81 20.9 47.20
## 63       <NA>  V_5_1   NA  7.35 24.3 49.70
## 64       <NA>  V_5_3   NA  9.47 20.7 63.60
## 65       <NA>  V_6_1   NA  8.99 22.9 56.60
## 66       <NA>  V_6_2   NA  8.46 24.2 58.90
## 67       <NA>  V_6_3   NA  8.08 22.8 55.20
## 68       <NA>  V_7_1   NA  7.85 25.8 60.60
## 69       <NA>  V_7_2   NA  8.11 25.8 73.90
## 70       <NA>  V_7_3   NA  7.41 23.7 59.40
## 71       <NA>  V_8_2   NA  9.30 19.5 36.80
## 72       <NA>  V_9_1   NA  7.30 18.8 31.30
## 73       <NA>  V_9_2   NA  4.04 20.5 32.00
## 74       <NA>  V_9_3   NA  4.36 19.9 92.60
## 75       <NA>  V_9_4   NA  4.30 19.8 36.50
## 76       <NA> V_2_10   NA  5.00  5.0  5.00
```
The full join returns all of the rows from both ndat and jdat - we have the 75 rows from jdat, plus the second V_17_1 as seen in the right_join and T_2_2 and T_4_3 that we present in ndat but NA in jdat for a total of 78 rows.

Lastly, we have the 2 filtering joins. These will not add columns, but rather filter the rows based on what is present in the second data frame.

semi_join() "returns all rows from x where there are matching values in y, keeping just columns from x. A semi join differs from an inner join because an inner join will return one row of x for each matching row of y, where a semi join will never duplicate rows of x."


```r
semi_join(ndat, jdat, by = c("Site" = "Samples"))
```

```
##         Taxa  Site OTUs
## 1 Clostridia T_2_1 6213
```
semi_join() returns the 18 rows of ndat that have a Site match in jdat. Note that the columns from jdat have not been added.

anti_join() "returns all rows from x where there are not matching values in y, keeping just columns from x."


```r
anti_join(ndat, jdat, by = c("Site" = "Samples"))
```

```
## [1] Taxa Site OTUs
## <0 rows> (or 0-length row.names)
```
This returns our 2 rows in ndat that did not have a match in jdat. Note that the columns from jdat have not been added.

***
__Challenge__
<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/pug_challenge1.jpeg){width=200px}

</div>

Given the definitions for the inner_, left_, right_, full_, semi_ and anti_joins, what would you expect the resulting data frame to be if jdat and ndat were reversed? Write down the number of rows and columns you would expect the data frame to have, then run the code. Did you find any surprises?

</br>

</br>

***

__Challenge__
<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/pug_challenge1.jpeg){width=200px}

</div>

Base R has a function that does join operations called `merge()`. What would be the code equivalent to the left_join of ndat and jdat? 

</br>

</br>

***

      

      
_Simple Statistics_
  

 + using summarize() to get mean, median, modes, quantiles and standard deviations, variance, skew

    
- revisitng the apply() function

- performing t-tests in R
        
__Challenge:__     
Take one of the provided test sets and calculate an average that requires subsetting and grouping. Perhaps make a separate question for say, a choice of 4 datasets (cars, iris, gapminder, lotr). (Add t-test question with the gapminder dataset).
  
#Resources:  
https://github.com/wmhall/tidyr_lesson/blob/master/tidyr_lesson.md     
http://stat545.com/block009_dplyr-intro.html     
http://stat545.com/block010_dplyr-end-single-table.html
http://vita.had.co.nz/papers/tidy-data.pdf
https://thinkr.fr/tidyverse-hadleyverse/
http://stat545.com/bit001_dplyr-cheatsheet.html
http://dplyr.tidyverse.org/articles/two-table.html
http://r4ds.had.co.nz/relational-data.html#join-problems


#Post-Lesson Assessment
***

Your feedback is essential to help the next cohort of trainees. Please take a minute to complete the following short survey:
https://www.surveymonkey.com/r/SMGKMCS

</br>

***

</br>

Thanks for coming!!!

![](img/rstudio-bomb.png){width=300px}


