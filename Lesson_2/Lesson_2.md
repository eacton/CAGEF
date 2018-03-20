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

***

##A quick intro to base R subsetting

First, I am going to show you how to subset data in __base R__. Then I will show you how do the same thing with the popular packages `dplyr` and `tidyr`. These packages are great for data wrangling with __data frames__. While a lot of new packages play nicely with the functions we are going to use today, but not all packages or data structures will work with `dplyr` functions. You will see `dplyr` and `tidyr` used for data cleaning and the manipulation of data frames.


###Our Dataset

Metagenomic 16SrRNA sequencing of latrines from Tanzania and Vietnam at different depths (multiples of 20cm). 

We have 2 csv files (change one to tsv or xlsx - maybe both and make an additional files and get a google spreadsheet): 
1. A metadata file (Naming conventions: [Country_LatrineNo_Depth]) with sample names and environmental variables.
2. A table of species abundance.

B Torondel, JHJ Ensink, O Gunvirusdu, UZ Ijaz, J Parkhill, F Abdelahi, V-A Nguyen, S Sudgen, W Gibson, AW Walker, and C Quince.
Assessment of the influence of intrinsic environmental and geographical factors on the bacterial ecology of pit latrines
Microbial Biotechnology, 9(2):209-223, 2016. DOI:10.1111/1751-7915.12334

***

In this lesson we want to answer 3 simple questions: 

   
    - Which latrine depth has the greatest mean number of OTUs?
    - Is there more Clostridia in Tanzania or Vietnam?
    - Which site had the greatest number of bacteria?


To help us be able to answer these questions, we are going to learn how to manipulate our data.

![](img/making_progress.png){width=200px} 
</br>
</br>

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



***

<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/pause.jpg){width=100px}

</div>
Wait a second - why is this answer different? Why do we have 0 rows instead of 2?

</br>

</br>




###A reminder/warning about vectors 


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
Vectors recycle. In this case, R gave us a warning that our vectors don't match. However, R will assume that you know what you are doing as long as your one of your vector lengths is a multiple of your other vector length.


```r
c(1,2,3,4) + c(10,11)
```

```
## [1] 11 13 13 15
```

Let's go back to our example. In this code, I am looking through the Taxa column for when Taxa is equal to Fusobacteria OR Taxa is equal to Methanobacteria.


```r
dat[dat$Taxa == "Fusobacteria" | dat$Taxa == "Methanobacteria", ]
```

However, with a vector, I am alternately going through all values of Taxa and asking: does the first value match Fusobacteria? does the second value match Methanobacteria? Then the vector recycles and asks: does the third value match Fusobacteria? does the 4th value match Methanobacteria? We end up with a data frame of zero observations when we are expecting a data frame of 2 observations.


```r
dat[dat$Taxa == c("Fusobacteria", "Methanobacteria"), ]
```



Be careful when filtering. You have been warned.


***
</br>
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

You can select columns by name or position, and reorder them as well (you can also do this for rows). I want to to compare the depth of latrine 2 at 9cm compared to 10cm, but I want Taxa in the last column. To inspect the first rows of an output, you can use the `head()` function. Likewise, to inspect the last rows, you can use the `tail()` function. Try changing the output to show only the first 5 rows of your data frame.


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
You can arrange your data frame alphabetically or by value using `order()`. Let's take the first 10 columns for ease of visualization.


```r
head(dat[order(dat$Taxa, decreasing = TRUE), 1:10]) 
```

```
##              Taxa T_2_1 T_2_10 T_2_12 T_2_2 T_2_3 T_2_6 T_2_7 T_2_9 T_3_2
## 52        Unknown   759     24      6  1342  1555  1832     7  3240   676
## 51    Thermotogae     0      0      0     0     0     1     0     1     0
## 50 Thermoplasmata     0      0      0     0     0     0     0     0     0
## 49 Thermomicrobia     0      0      0     3     3     3     0     2     1
## 48    Synergistia    21      4      0    84   110   333     0   658   125
## 47   Subdivision3     0      0      0     0     0     0     0     0     0
```

```r
head(dat[order(dat$T_2_1, decreasing = TRUE), 1:10])
```

```
##               Taxa T_2_1 T_2_10 T_2_12 T_2_2 T_2_3 T_2_6 T_2_7 T_2_9 T_3_2
## 25      Clostridia  6213     71      0  8999 10944 12169    28 17471  3431
## 19     Bacteroidia  1547      8      0   718   679   143     1   924   314
## 52         Unknown   759     24      6  1342  1555  1832     7  3240   676
## 31 Erysipelotrichi   433      0      0   495   643   629     0   933   193
## 15  Actinobacteria   110      3      5   240   414   227     1   811    89
## 46    Spirochaetes    62      0      0    72   266    43     1   175    19
```
You can order your data frame by multiple variables.


```r
head(dat[order(dat$T_2_1, dat$T_2_12, dat$T_2_9, decreasing = TRUE), 1:10])
```

```
##               Taxa T_2_1 T_2_10 T_2_12 T_2_2 T_2_3 T_2_6 T_2_7 T_2_9 T_3_2
## 25      Clostridia  6213     71      0  8999 10944 12169    28 17471  3431
## 19     Bacteroidia  1547      8      0   718   679   143     1   924   314
## 52         Unknown   759     24      6  1342  1555  1832     7  3240   676
## 31 Erysipelotrichi   433      0      0   495   643   629     0   933   193
## 15  Actinobacteria   110      3      5   240   414   227     1   811    89
## 46    Spirochaetes    62      0      0    72   266    43     1   175    19
```
Now that we have some basic data-wrangling skills:

    - Which latrine depth has the greatest mean number of OTUs?
    - Is there more Clostridia in Tanzania or Vietnam?
    - Which site had the greatest number of bacteria?


How easy is it to answer these questions with the data in this 'messy' format?

***
__Challenge__ 


<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/pug_challenge1.jpeg){width=150px}

</div>

Answer our 3 questions using the base R.


</br>
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
  
  
The `dplyr` package, and some other common packages for data frame manipulation allow the use of the pipe function, `%>%`. This is equivalent to `|` for any unix peeps. __Piping__ allows the output of a function to be passed to the next function without making intermediate variables. Piping can save typing, make your code more readable, and reduce clutter in your global environment from variables you don't need.

Let's load the library.


```r
library(dplyr)
```

We are going to see how pipes work in conjunction with our first function, `filter()`. We are going to use the same subsetting examples so you can see how the syntax differs from base R. In this case, we want to keep all rows that have either Fusobacteria or Methanobacteria. 


```r
filter(dat, Taxa == "Fusobacteria" | Taxa == "Methanobacteria")
#equivalent to
dat %>% filter(Taxa == "Fusobacteria" | Taxa == "Methanobacteria")
#equivalent to
```

```r
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
If I wanted to perform a calculation, I would want to exclude Taxa since it is of character type and not used in the calculation. If your data is unique you may want to retain your character data as rownames. Note: you cannot use a positive and negative selection in the same function call.


```r
rownames(dat) <- dat$Taxa
dat %>% select(-Taxa) %>% select(T_2_1:T_2_9) %>% head()
```

```
##                    T_2_1 T_2_10 T_2_12 T_2_2 T_2_3 T_2_6 T_2_7 T_2_9
## Acidobacteria_Gp1      0      0      0     0     0     0     0     0
## Acidobacteria_Gp10     0      0      0     0     0     0     0     0
## Acidobacteria_Gp14     0      0      0     0     0     0     0     0
## Acidobacteria_Gp16     0      0      0     0     0     0     0     0
## Acidobacteria_Gp17     0      0      0     0     0     0     0     0
## Acidobacteria_Gp18     0      0      0     2     2     5     0    15
```

```r
#equivalent to
## dat %>% select(T_2_1:T_2_9) %>% head()
```
`dplyr` also includes some helper functions that allow you to select variables based on their names. For example, if we only wanted the samples from Vietnam, we could use `starts_with()`.


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

Or all latrines with depths of 4 cm using `ends_with()`.


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
![](img/pug_challenge1.jpeg){width=150px}

</div>

Check out 'select_helpers' in the help menu. Grab all of the columns that contain depths for Well 2, whether it is from Vietnam or Tanzania.

</br>
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

`unique()` is a function that removes duplicate rows. How many rows did it remove in this case?


`mutate()` is a function to create new column, most often the product of a calculation. For example, let's calculate the total number of OTUs for each bacteria using `rowSums()`. You must specify a column name for the column you are creating. `transmute()` will also create a new variable, but it will drop the existing variables (it will give you a single column of your new variable).


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

You may have noticed that I included "." in the bracket for `rowSums()`. In this case, an error would be generated with empty brackets that argument 'x' is missing with no default. You need to specify your input if you are inside a nested function. Note that if I use `rowSums()` outside of another function, I do not need to specify the data frame.

Note: it is up to you whether you want to keep your data in a data frame or switch to a vector if you are dealing with a single variable. Using a `dplyr` function will maintain your data in a data frame. Using non-dplyr functions will switch your data to a vector if you have a single variable.


`dplyr` has one more super-useful function, `summarize()` which allows us to get summary statistics on data. I'll give one example and then we'll come back to this function once our data is in 'tidy' format. `n()` is a `dplyr` function to count the number of observations in a group - we are simply going to count the instances of a Taxa. We can arrange the results in descending order to see if there is more than one row per Taxa. Can anyone think of another way to see if there is more than one row per Taxa? 


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


![](img/tidyverse1.png){width=600px}

</br>
</br>

Hadley has a large fan-base. Someone even made a plot of Hadley using his own package, `ggplot2`.


![](img/HadleyObama2.png){width=300px}

</br>
</br>

Back to the normalverse...

    - Which latrine depth has the greatest mean number of OTUs?
    - Is there more Clostridia in Tanzania or Vietnam?
    - Which site had the greatest number of bacteria?


How easy is it to answer these questions with the data in its 'messy' format?

***
__Challenge__ 


<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/pug_challenge1.jpeg){width=150px}

</div>

Answer our 3 questions using the `dplyr`.

</br>
</br>
</br>

***

###Assessing our data frame

Which tidy data rules might our data frame break?

At first glance we can see that the column names are actually 3 different variables: 'Country', 'LatrineNumber', and 'Depth'. This information will likely be useful in our study, as we expect different bacteria at different depths, sites, and geographical locations. Each of these is a variable and should have its own separate column.

We could keep the column names as the sample names (as they are meaningful to the researcher) and add the extra variable columns, or we could make up sample names (ie. Sample_1) knowing that the information is not being lost, but rather stored in a more useful format.

Some of the Taxa also appear to have an additional variable of information (ie. _Gp1), but not all taxa have this information. We can also make a separate column for this information.

Each result is the same observational unit (ie. relative abundances of bacteria), so having one table is fine.

###Intro to tidyr

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

We can use the `gather()` function to collect our columns. This will make our dataset 'long' instead of 'wide'. 
We need to provide `gather()` with information on our new columns. The first argument is our data frame, the second argument is the __key__, which is our named variable. In this case we want the column names that represent our Sites. The next argument is the __value__, which are our measurements; relative abundance values or OTUs. The third argument is all of the columns that we need to gather. You can specify the columns by listing their names or positions. In this example "-" means every column except Taxa.


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
#equivalent to
dat %>% gather(Site, OTUs, -Taxa) %>% head()
#equivalent to
dat %>% gather(Site, OTUs, -1) %>% head()
```



Note how the dimensions of your dataframe have changed. spread_dat is now in a long format instead of wide.

Next, we can use the `separate()` function to get the Country, Latrine_Number, and Depth information from our Site column. `separate()` takes in your dataframe, the name of the column to be split, the name of your new columns, and the character that you want to split the columns by (in this case an underscore). Note that the default is to remove your original column - if you want to keep it, you can add the additional argument `remove = FALSE`, keeping in mind that you now have redundant data. We may also want to do this for the 'Group' of Acidobacteria. Try the code, but do not save the answer in a variable.


```r
split_dat <- spread_dat %>% separate(Site, c("Country", "Latrine_Number", "Depth"), sep = "_")
#equivalent to
split_dat <- spread_dat %>% separate(Site, c("Country", "Latrine_Number", "Depth"), sep = "_", remove = TRUE)

split_dat %>% separate(Taxa, c("Taxa", "Group"), sep = "_Gp") %>% head(20)
```

```
## Warning: Expected 2 pieces. Missing pieces filled with `NA` in 3078 rows
## [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
## 33, 34, ...].
```

```
##                   Taxa Group Country Latrine_Number Depth OTUs
## 1        Acidobacteria     1       T              2     1    0
## 2        Acidobacteria    10       T              2     1    0
## 3        Acidobacteria    14       T              2     1    0
## 4        Acidobacteria    16       T              2     1    0
## 5        Acidobacteria    17       T              2     1    0
## 6        Acidobacteria    18       T              2     1    0
## 7        Acidobacteria    21       T              2     1    0
## 8        Acidobacteria    22       T              2     1    0
## 9        Acidobacteria     3       T              2     1    0
## 10       Acidobacteria     4       T              2     1    0
## 11       Acidobacteria     5       T              2     1    0
## 12       Acidobacteria     6       T              2     1    0
## 13       Acidobacteria     7       T              2     1    0
## 14       Acidobacteria     9       T              2     1    0
## 15      Actinobacteria  <NA>       T              2     1  110
## 16 Alphaproteobacteria  <NA>       T              2     1   11
## 17        Anaerolineae  <NA>       T              2     1    2
## 18             Bacilli  <NA>       T              2     1   19
## 19         Bacteroidia  <NA>       T              2     1 1547
## 20  Betaproteobacteria  <NA>       T              2     1    2
```
We get a warning from R that it has filled in 'NA' for the bacteria that did not have groups. Note that I chose to split Taxa using '_Gp' since I did not need 'Gp'. 


***
__Challenge__ 


<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/pug_challenge1.jpeg){width=150px}

</div>

Use the `glimpse()` function to look  at the type of each variable in our new data frame. Are those the types you expected? Why or why not? How is `glimpse()` different from the `str()` function?

</br>
</br>
</br>

***

There is a useful function `group_by()` that you can use to group variables or sets of variables together. This is useful for calculations and plotting on subsets of your data without having to turn your variables into factors. Say I wanted to look at a combination of Country and Well Depth. While visually, you wouldn't notice any changes to your data frame, if you look at the structure it will now be a 'grouped_df'. There are 15 groupings resulting from Country and Depth. After I have performed my desired operation, I can return my data frame to its original structure by calling `ungroup()`. We will see an example of this in action with `summarize()`. 


```r
str(split_dat)
```

```
## 'data.frame':	4212 obs. of  5 variables:
##  $ Taxa          : chr  "Acidobacteria_Gp1" "Acidobacteria_Gp10" "Acidobacteria_Gp14" "Acidobacteria_Gp16" ...
##  $ Country       : chr  "T" "T" "T" "T" ...
##  $ Latrine_Number: chr  "2" "2" "2" "2" ...
##  $ Depth         : chr  "1" "1" "1" "1" ...
##  $ OTUs          : int  0 0 0 0 0 0 0 0 0 0 ...
```

```r
str(split_dat %>% group_by(Country, Depth))
```

```
## Classes 'grouped_df', 'tbl_df', 'tbl' and 'data.frame':	4212 obs. of  5 variables:
##  $ Taxa          : chr  "Acidobacteria_Gp1" "Acidobacteria_Gp10" "Acidobacteria_Gp14" "Acidobacteria_Gp16" ...
##  $ Country       : chr  "T" "T" "T" "T" ...
##  $ Latrine_Number: chr  "2" "2" "2" "2" ...
##  $ Depth         : chr  "1" "1" "1" "1" ...
##  $ OTUs          : int  0 0 0 0 0 0 0 0 0 0 ...
##  - attr(*, "vars")= chr  "Country" "Depth"
##  - attr(*, "drop")= logi TRUE
##  - attr(*, "indices")=List of 15
##   ..$ : int  0 1 2 3 4 5 6 7 8 9 ...
##   ..$ : int  52 53 54 55 56 57 58 59 60 61 ...
##   ..$ : int  104 105 106 107 108 109 110 111 112 113 ...
##   ..$ : int  156 157 158 159 160 161 162 163 164 165 ...
##   ..$ : int  208 209 210 211 212 213 214 215 216 217 ...
##   ..$ : int  624 625 626 627 628 629 630 631 632 633 ...
##   ..$ : int  520 521 522 523 524 525 526 527 528 529 ...
##   ..$ : int  260 261 262 263 264 265 266 267 268 269 ...
##   ..$ : int  312 313 314 315 316 317 318 319 320 321 ...
##   ..$ : int  1196 1197 1198 1199 1200 1201 1202 1203 1204 1205 ...
##   ..$ : int  364 365 366 367 368 369 370 371 372 373 ...
##   ..$ : int  1560 1561 1562 1563 1564 1565 1566 1567 1568 1569 ...
##   ..$ : int  1508 1509 1510 1511 1512 1513 1514 1515 1516 1517 ...
##   ..$ : int  1716 1717 1718 1719 1720 1721 1722 1723 1724 1725 ...
##   ..$ : int  2652 2653 2654 2655 2656 2657 2658 2659 2660 2661 ...
##  - attr(*, "group_sizes")= int  104 52 52 260 260 156 260 104 156 52 ...
##  - attr(*, "biggest_group_size")= int 1040
##  - attr(*, "labels")='data.frame':	15 obs. of  2 variables:
##   ..$ Country: chr  "T" "T" "T" "T" ...
##   ..$ Depth  : chr  "1" "10" "12" "2" ...
##   ..- attr(*, "vars")= chr  "Country" "Depth"
##   ..- attr(*, "drop")= logi TRUE
```

```r
str(split_dat %>% group_by(Country, Depth) %>% ungroup())
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	4212 obs. of  5 variables:
##  $ Taxa          : chr  "Acidobacteria_Gp1" "Acidobacteria_Gp10" "Acidobacteria_Gp14" "Acidobacteria_Gp16" ...
##  $ Country       : chr  "T" "T" "T" "T" ...
##  $ Latrine_Number: chr  "2" "2" "2" "2" ...
##  $ Depth         : chr  "1" "1" "1" "1" ...
##  $ OTUs          : int  0 0 0 0 0 0 0 0 0 0 ...
```



Going back to `summarize()`, summary statistics can easily calculated for groups of data. Whereas in our messy data frame it was difficult to do calculations based on Country, Well Number or Latrine Depth, this is now an easy task. Let's get the mean, median, standard deviation and maximum for the number of OTUs collected in Tanzania vs Vietnam.


```r
split_dat %>% 
  group_by(Country) %>% 
  summarize(mean = mean(OTUs), median = median(OTUs), sd = sd(OTUs), maximum = max(OTUs))
```

```
## # A tibble: 2 x 5
##   Country  mean median    sd maximum
##   <chr>   <dbl>  <dbl> <dbl>   <dbl>
## 1 T         122      0   896   17471
## 2 V         186      0   863   17572
```




***
Now that we have tidy data, let's answer our questions:

    - Which latrine depth has the greatest mean number of OTUs?
    - Is there more Clostridia in Tanzania or Vietnam?
    - Which site had the greatest number of bacteria?


__Okay, Go!__

![](img/giphy.gif){width=200px}

</br>

Which latrine depth has the greatest mean number of OTUs?



```r
split_dat %>% 
  group_by(Latrine_Number) %>% 
  summarize(mean = mean(OTUs)) %>% 
  arrange(desc(mean))
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
split_dat %>% 
  filter(Taxa == "Clostridia") %>% 
  group_by(Country) %>% 
  summarise(sum = sum(OTUs)) %>% 
  arrange(desc(sum))
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
split_dat %>% 
  group_by(Country, Latrine_Number, Depth) %>% 
  summarize(sum = sum(OTUs), mean = mean(OTUs)) %>% 
  arrange(desc(sum), desc(mean))
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

</br>

![](img/easy-1.png){width=300px}

***

</br>


To get data back into its original format, there are reciprocal functions in the tidyr package, making it possible to switch between wide and long formats. 

__Fair question:__ But you've just been telling me how great the 'long' format is?!?! Why would I want the wide format again???

__Honest answer:__ Note that our original data frame was 52 rows and expanded to 4212 rows in the long format. When you have, say, a genomics dataset you might end up with 6,000 rows expanding to 600,000 rows. You probably want to do your calculations and switch back to the more 'human readable' format. Sure, I can save a data frame with 600,000 rows, but I can't really send it to anyone because LibreOffice or Excel might crash opening it.


***

__Challenge__ 


<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/pug_challenge1.jpeg){width=150px}

</div>

Collapse Country, Latrine_Number and Depth back into one variable, 'Site', using the `unite()` function. Store the output in a data frame called unite_dat.

</br>
</br>
</br>

***
__Challenge__ 


<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/pug_challenge1.jpeg){width=150px}

</div>

Use the `spread()` function to turn unite_dat into the wide shape of our original dataset. 

</br>
</br>
</br>

***

##Adding rows and columns to data frames

We are going to use a subset of a second data frame from the same study to use in our join lesson. We are going to add and remove some observations so the names of the samples we are working with are not exactly equal.


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

![](img/pause.jpg){width=100px}

###A lesson in data structures

IF YOU ADD A VECTOR TO YOUR DATA FRAME `rbind()` does not check to make sure your value belongs to a column and will not throw an error if the length of the added row is longer or shorter than your data frame. For example, I want to add an extra row to my data frame which has 4 columns. If I use a vector it should have a length of 4 to match the number of columns in my data frame. Here, I have simply created a vector with a new sample name, and then have used the `rep()` function to repeat the value 5, 3 times. This is added to the data frame jdat.


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


If you give `rbind()` your column information AS A VECTOR, it ignores it. This is the correct column information with the order of the columns altered. Note that the number 6 ends up in the Temp column despite being labelled pH.


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

This is the incorrect column information. Note that the row is added regardless. Also, because vectors must be coerced to one data type our added vector was a character vector. We started with both character and numeric data in jdat. In adding a vector, the entire data frame (think of each column as a vector) has been coerced to character data.


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
This will not happen if you USE A LIST with `rbind()`, because lists can hold multiple types of data. USING A LIST `rbind()` will warn us appropriately if our row is of an inappropriate length.


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
This is a lesson in using correct data structures.

***

There is an equivalent function from `dplyr`, `bind_rows()`, which tries to save you from errors by ensuring that your column identifiers match. If you do not give column identifiers, whether you are trying to add a vector or a list, it will not add your row to the frame.


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
If you give `bind_rows()` the correct column information in vector format, it will only add a vector as a row IF THE CHARACTER TYPE MATCHES ALL DATA FRAME COLUMN TYPES (ie. if our data frame was all character data). Otherwise, it actually gives you the useful error that your character types are not matching. 


```r
bind_rows(jdat, c(Samples = "V_2_10", pH = 5, Temp = 5, TS = 5)) %>% tail()
```

```
## Error in bind_rows_(x, .id): Column `pH` can't be converted from numeric to character
```

A _sanity check_ is making sure things are turning out as you expect them to - it is a way of checking your (or others') assumptions. It is particularly useful in the data exploration stage when you are getting familiar with your data set before you try to run any type of model. However, it is also good to make sure a function is behaving as you expect it to, or trouble-shooting odd behaviours. Let's check what I just said about being able to add a character vector as long as it matches the data frame data type.  

If we coerce the entire data frame to character type (using our dangerous rbind + vector syntax), we can now use `bind_rows()` since our the vector will be coerced to a character type AND the data frame matches this type in every column.


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


If you give `bind_rows()` the correct column information in list format, it will add your row. Here is a sanity check on switching the order of the columns again.


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

`bind_rows()` has a different behaviour than `rbind()` when column names do not match. It will match your columns as much as possible, and then create new columns for the data that does not fit at the end of your data frame. Note that 'NA's will be created for all missing data.


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

***
__Challenge__ 


<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/pug_challenge1.jpeg){width=150px}
</div>

Make a column and add it to jdat using the base R function `cbind()` and the `dplyr` function `bind_cols()`. Do you forsee any problems in using either of these functions?

</br>
</br>
</br>

***


##All of the joins

Often we have more than one data table that shares a common attribute. For example, with our current dataset, we have other variables (such as pH) for a sample, as well as our OTU table, both of which have site IDs (ie. T_2_9). We want to merge these into one table.


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
![](img/pug_challenge1.jpeg){width=150px}

</div>

Filter spread_dat to remove all non-zero values, and store it in an object ndat. How many rows in spread_dat had the value of zero? Sort ndat to keep the top 20 rows with the highest OTUs.

</br>
</br>
</br>

***




There are 2 types of joins:

1. _mutating joins_ - uses a key to match observations and combines variables from 2 tables (adding columns and potentially rows)
2. _filtering joins_ - uses a key to match observations, to subset observations (rows)

In these examples we are joining 2 dataframes: x and y.

__Inner join__ is a mutating join.  Inner join returns all rows from x where there are matching values in y, and all columns from x and y. If there are multiple matches between x and y, all combination of the matches are returned.

A set of graphics from _'R for Data Science'_ makes the description clearer:
![](img/join-inner.png){width=500px}  



```r
inner_join(ndat, jdat, by = c("Site" = "Samples"))
```

```
##                   Taxa   Site  OTUs   pH Temp    TS
## 1           Clostridia V_16_2 17572 6.26 16.3 24.00
## 2           Clostridia  T_2_9 17471 7.60 25.0 46.87
## 3           Clostridia V_17_2 13875 8.14 15.4 25.60
## 4           Clostridia  T_2_6 12169 7.69 28.7 65.52
## 5          Bacteroidia V_17_1 11392 7.39 15.7 25.30
## 6           Clostridia V_10_1 11180 9.12 18.6 46.30
## 7           Clostridia  T_2_3 10944 6.46 27.9 29.45
## 8              Unknown  T_9_2 10624 7.86 28.5 13.56
## 9           Clostridia  T_4_4 10545 7.84 26.3 28.85
## 10          Clostridia V_16_1 10043 7.83 17.7 25.10
## 11          Clostridia  T_5_3  8981 7.53 27.5 12.55
## 12 Alphaproteobacteria  V_3_2  8660 8.08 20.7 52.00
## 13          Clostridia V_15_1  8244 7.44 18.9 25.40
## 14          Clostridia V_17_1  7722 7.39 15.7 25.30
## 15          Clostridia V_18_1  7481 7.09 22.5 35.10
## 16 Alphaproteobacteria  V_3_1  7322 8.90 22.4 56.20
## 17          Clostridia V_18_4  6246 8.25 19.4 29.90
## 18          Clostridia  T_2_1  6213 7.82 25.1 14.53
```

We can see that there are 18 rows in the resulting data frame. and that columns from jdat have been added. Rows from ndat that did not have a matching site in jdat were removed.

</br>

__Outer joins__ are a set of mutating joins. There are 3 outer joins: left, right, and full.


![](img/join-outer.png){width=500px}
</br>

__Left join__ returns all rows from x, and all columns from x and y. Rows in x with no match in y will have NA values in the new columns. If there are multiple matches between x and y, all combinations of the matches are returned.



```r
left_join(ndat, jdat, by = c("Site" = "Samples"))
```

```
##                   Taxa   Site  OTUs   pH Temp    TS
## 1           Clostridia V_16_2 17572 6.26 16.3 24.00
## 2           Clostridia  T_2_9 17471 7.60 25.0 46.87
## 3           Clostridia V_17_2 13875 8.14 15.4 25.60
## 4           Clostridia  T_2_6 12169 7.69 28.7 65.52
## 5          Bacteroidia V_17_1 11392 7.39 15.7 25.30
## 6           Clostridia V_10_1 11180 9.12 18.6 46.30
## 7           Clostridia  T_2_3 10944 6.46 27.9 29.45
## 8              Unknown  T_9_2 10624 7.86 28.5 13.56
## 9           Clostridia  T_4_4 10545 7.84 26.3 28.85
## 10          Clostridia V_16_1 10043 7.83 17.7 25.10
## 11          Clostridia  T_2_2  8999   NA   NA    NA
## 12          Clostridia  T_5_3  8981 7.53 27.5 12.55
## 13 Alphaproteobacteria  V_3_2  8660 8.08 20.7 52.00
## 14          Clostridia V_15_1  8244 7.44 18.9 25.40
## 15          Clostridia V_17_1  7722 7.39 15.7 25.30
## 16  Betaproteobacteria  T_4_3  7710   NA   NA    NA
## 17          Clostridia V_18_1  7481 7.09 22.5 35.10
## 18 Alphaproteobacteria  V_3_1  7322 8.90 22.4 56.20
## 19          Clostridia V_18_4  6246 8.25 19.4 29.90
## 20          Clostridia  T_2_1  6213 7.82 25.1 14.53
```
That means that we will have our 20 rows from ndat, and any items that weren't found in jdat, in this case T_2_2 and T_4_3 will be filled with NA.

__Right join__ returns all rows from y, and all columns from x and y. Rows in y with no match in x will have NA values in the new columns. If there are multiple matches between x and y, all combinations of the matches are returned.


```r
right_join(ndat, jdat, by = c("Site" = "Samples"))
```

```
##                   Taxa   Site  OTUs    pH Temp    TS
## 1           Clostridia  T_2_1  6213  7.82 25.1 14.53
## 2                 <NA> T_2_10    NA  9.08 24.2 37.76
## 3                 <NA> T_2_12    NA  8.84 25.1 71.11
## 4           Clostridia  T_2_3 10944  6.46 27.9 29.45
## 5           Clostridia  T_2_6 12169  7.69 28.7 65.52
## 6           Clostridia  T_2_9 17471  7.60 25.0 46.87
## 7                 <NA>  T_3_3    NA  7.68 28.9 14.65
## 8                 <NA>  T_3_5    NA  7.69 28.7 14.87
## 9           Clostridia  T_4_4 10545  7.84 26.3 28.85
## 10                <NA>  T_4_5    NA  7.95 27.9 46.85
## 11                <NA>  T_4_6    NA  7.58 30.1 38.38
## 12                <NA>  T_4_7    NA  7.68 28.3 26.54
## 13                <NA>  T_5_2    NA  7.58 29.5 12.48
## 14          Clostridia  T_5_3  8981  7.53 27.5 12.55
## 15                <NA>  T_5_4    NA  7.40 29.4 15.10
## 16                <NA>  T_6_2    NA  7.77 27.9 46.87
## 17                <NA>  T_6_7    NA  8.09 31.7 68.33
## 18                <NA>  T_6_8    NA  8.26 29.7 64.90
## 19                <NA>  T_9_1    NA  7.85 29.3  9.12
## 20             Unknown  T_9_2 10624  7.86 28.5 13.56
## 21                <NA>  T_9_3    NA  8.35 29.5 12.67
## 22                <NA>  T_9_4    NA  8.43 29.5 58.76
## 23                <NA>  T_9_5    NA  7.90 29.3 56.12
## 24                <NA>  V_1_2    NA  6.67 29.2 43.30
## 25          Clostridia V_10_1 11180  9.12 18.6 46.30
## 26                <NA> V_11_1    NA  9.00 18.5 63.00
## 27                <NA> V_11_2    NA  9.64 18.3 56.70
## 28                <NA> V_11_3    NA  8.45 18.2 55.20
## 29                <NA> V_12_1    NA  9.16 19.6 56.60
## 30                <NA> V_12_2    NA  9.54 18.3 49.00
## 31                <NA> V_13_1    NA  8.58 19.0 26.00
## 32                <NA> V_13_2    NA  7.98 18.6 46.80
## 33                <NA> V_14_1    NA  7.21 20.0 37.80
## 34                <NA> V_14_2    NA  7.74 18.5 51.70
## 35                <NA> V_14_3    NA  8.50 19.1 55.80
## 36          Clostridia V_15_1  8244  7.44 18.9 25.40
## 37                <NA> V_15_2    NA  8.36 17.9 32.80
## 38                <NA> V_15_3    NA  8.15 18.8 31.80
## 39          Clostridia V_16_1 10043  7.83 17.7 25.10
## 40          Clostridia V_16_2 17572  6.26 16.3 24.00
## 41         Bacteroidia V_17_1 11392  7.39 15.7 25.30
## 42          Clostridia V_17_1  7722  7.39 15.7 25.30
## 43          Clostridia V_17_2 13875  8.14 15.4 25.60
## 44          Clostridia V_18_1  7481  7.09 22.5 35.10
## 45                <NA> V_18_2    NA  8.54 24.9 34.90
## 46                <NA> V_18_3    NA  8.37 21.4 35.50
## 47          Clostridia V_18_4  6246  8.25 19.4 29.90
## 48                <NA> V_19_1    NA  7.19 17.6 24.80
## 49                <NA> V_19_2    NA  7.68 17.4 31.80
## 50                <NA> V_19_3    NA  7.38 16.6 37.00
## 51                <NA>  V_2_1    NA  9.42 21.3 63.40
## 52                <NA>  V_2_2    NA  9.40 20.7 51.60
## 53                <NA>  V_2_3    NA  9.15 20.8 44.20
## 54                <NA> V_20_1    NA  9.04 17.0  9.60
## 55                <NA> V_21_1    NA 10.09 17.7 65.30
## 56                <NA> V_21_4    NA  9.58 17.1 40.10
## 57                <NA> V_22_1    NA  7.14 16.8 58.10
## 58                <NA> V_22_3    NA  6.67 17.1 84.40
## 59                <NA> V_22_4    NA  6.79 15.9 80.60
## 60 Alphaproteobacteria  V_3_1  7322  8.90 22.4 56.20
## 61 Alphaproteobacteria  V_3_2  8660  8.08 20.7 52.00
## 62                <NA>  V_4_1    NA  9.49 22.6 36.10
## 63                <NA>  V_4_2    NA  7.81 20.9 47.20
## 64                <NA>  V_5_1    NA  7.35 24.3 49.70
## 65                <NA>  V_5_3    NA  9.47 20.7 63.60
## 66                <NA>  V_6_1    NA  8.99 22.9 56.60
## 67                <NA>  V_6_2    NA  8.46 24.2 58.90
## 68                <NA>  V_6_3    NA  8.08 22.8 55.20
## 69                <NA>  V_7_1    NA  7.85 25.8 60.60
## 70                <NA>  V_7_2    NA  8.11 25.8 73.90
## 71                <NA>  V_7_3    NA  7.41 23.7 59.40
## 72                <NA>  V_8_2    NA  9.30 19.5 36.80
## 73                <NA>  V_9_1    NA  7.30 18.8 31.30
## 74                <NA>  V_9_2    NA  4.04 20.5 32.00
## 75                <NA>  V_9_3    NA  4.36 19.9 92.60
## 76                <NA>  V_9_4    NA  4.30 19.8 36.50
## 77                <NA> V_2_10    NA  5.00  5.0  5.00
```

That means that we will have our 75 rows from jdat, and any items that weren't found in ndat will be filled with NA. Since there are 76 rows in the final data frame, this means there must have been multiple rows matching from ndat. In other words, we had a duplicate key (Site) in ndat.

</br>

![](img/join-one-to-many.png){width=500px}

</br>

</br>

Let's try to find which Site was duplicated by using `n()`.


```r
right_join(ndat, jdat, by = c("Site" = "Samples")) %>% 
  group_by(Site) %>% 
  filter(n()>1)
```

```
## # A tibble: 2 x 6
## # Groups:   Site [1]
##   Taxa        Site    OTUs    pH  Temp    TS
##   <chr>       <chr>  <int> <dbl> <dbl> <dbl>
## 1 Bacteroidia V_17_1 11392  7.39  15.7  25.3
## 2 Clostridia  V_17_1  7722  7.39  15.7  25.3
```

Note that Bacteriodia and Clostridia have different OTUs (from ndat), but the same pH, Temp and TS (from jdat). 


***
__Challenge__
<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/pug_challenge1.jpeg){width=150px}

</div>

Use a function other than `filter()` with `n()` to find the duplicated Site.

</br>
</br>
</br>

***

Note that if both of our data frames had duplicated keys, all possible matches would be retruned.

</br>

![](img/join-many-to-many.png){width=500px}

</br>

__Full join__ returns all rows and all columns from both x and y. Where there are not matching values, returns NA for the one missing.



```r
full_join(ndat, jdat, by = c("Site" = "Samples"))
```

```
##                   Taxa   Site  OTUs    pH Temp    TS
## 1           Clostridia V_16_2 17572  6.26 16.3 24.00
## 2           Clostridia  T_2_9 17471  7.60 25.0 46.87
## 3           Clostridia V_17_2 13875  8.14 15.4 25.60
## 4           Clostridia  T_2_6 12169  7.69 28.7 65.52
## 5          Bacteroidia V_17_1 11392  7.39 15.7 25.30
## 6           Clostridia V_10_1 11180  9.12 18.6 46.30
## 7           Clostridia  T_2_3 10944  6.46 27.9 29.45
## 8              Unknown  T_9_2 10624  7.86 28.5 13.56
## 9           Clostridia  T_4_4 10545  7.84 26.3 28.85
## 10          Clostridia V_16_1 10043  7.83 17.7 25.10
## 11          Clostridia  T_2_2  8999    NA   NA    NA
## 12          Clostridia  T_5_3  8981  7.53 27.5 12.55
## 13 Alphaproteobacteria  V_3_2  8660  8.08 20.7 52.00
## 14          Clostridia V_15_1  8244  7.44 18.9 25.40
## 15          Clostridia V_17_1  7722  7.39 15.7 25.30
## 16  Betaproteobacteria  T_4_3  7710    NA   NA    NA
## 17          Clostridia V_18_1  7481  7.09 22.5 35.10
## 18 Alphaproteobacteria  V_3_1  7322  8.90 22.4 56.20
## 19          Clostridia V_18_4  6246  8.25 19.4 29.90
## 20          Clostridia  T_2_1  6213  7.82 25.1 14.53
## 21                <NA> T_2_10    NA  9.08 24.2 37.76
## 22                <NA> T_2_12    NA  8.84 25.1 71.11
## 23                <NA>  T_3_3    NA  7.68 28.9 14.65
## 24                <NA>  T_3_5    NA  7.69 28.7 14.87
## 25                <NA>  T_4_5    NA  7.95 27.9 46.85
## 26                <NA>  T_4_6    NA  7.58 30.1 38.38
## 27                <NA>  T_4_7    NA  7.68 28.3 26.54
## 28                <NA>  T_5_2    NA  7.58 29.5 12.48
## 29                <NA>  T_5_4    NA  7.40 29.4 15.10
## 30                <NA>  T_6_2    NA  7.77 27.9 46.87
## 31                <NA>  T_6_7    NA  8.09 31.7 68.33
## 32                <NA>  T_6_8    NA  8.26 29.7 64.90
## 33                <NA>  T_9_1    NA  7.85 29.3  9.12
## 34                <NA>  T_9_3    NA  8.35 29.5 12.67
## 35                <NA>  T_9_4    NA  8.43 29.5 58.76
## 36                <NA>  T_9_5    NA  7.90 29.3 56.12
## 37                <NA>  V_1_2    NA  6.67 29.2 43.30
## 38                <NA> V_11_1    NA  9.00 18.5 63.00
## 39                <NA> V_11_2    NA  9.64 18.3 56.70
## 40                <NA> V_11_3    NA  8.45 18.2 55.20
## 41                <NA> V_12_1    NA  9.16 19.6 56.60
## 42                <NA> V_12_2    NA  9.54 18.3 49.00
## 43                <NA> V_13_1    NA  8.58 19.0 26.00
## 44                <NA> V_13_2    NA  7.98 18.6 46.80
## 45                <NA> V_14_1    NA  7.21 20.0 37.80
## 46                <NA> V_14_2    NA  7.74 18.5 51.70
## 47                <NA> V_14_3    NA  8.50 19.1 55.80
## 48                <NA> V_15_2    NA  8.36 17.9 32.80
## 49                <NA> V_15_3    NA  8.15 18.8 31.80
## 50                <NA> V_18_2    NA  8.54 24.9 34.90
## 51                <NA> V_18_3    NA  8.37 21.4 35.50
## 52                <NA> V_19_1    NA  7.19 17.6 24.80
## 53                <NA> V_19_2    NA  7.68 17.4 31.80
## 54                <NA> V_19_3    NA  7.38 16.6 37.00
## 55                <NA>  V_2_1    NA  9.42 21.3 63.40
## 56                <NA>  V_2_2    NA  9.40 20.7 51.60
## 57                <NA>  V_2_3    NA  9.15 20.8 44.20
## 58                <NA> V_20_1    NA  9.04 17.0  9.60
## 59                <NA> V_21_1    NA 10.09 17.7 65.30
## 60                <NA> V_21_4    NA  9.58 17.1 40.10
## 61                <NA> V_22_1    NA  7.14 16.8 58.10
## 62                <NA> V_22_3    NA  6.67 17.1 84.40
## 63                <NA> V_22_4    NA  6.79 15.9 80.60
## 64                <NA>  V_4_1    NA  9.49 22.6 36.10
## 65                <NA>  V_4_2    NA  7.81 20.9 47.20
## 66                <NA>  V_5_1    NA  7.35 24.3 49.70
## 67                <NA>  V_5_3    NA  9.47 20.7 63.60
## 68                <NA>  V_6_1    NA  8.99 22.9 56.60
## 69                <NA>  V_6_2    NA  8.46 24.2 58.90
## 70                <NA>  V_6_3    NA  8.08 22.8 55.20
## 71                <NA>  V_7_1    NA  7.85 25.8 60.60
## 72                <NA>  V_7_2    NA  8.11 25.8 73.90
## 73                <NA>  V_7_3    NA  7.41 23.7 59.40
## 74                <NA>  V_8_2    NA  9.30 19.5 36.80
## 75                <NA>  V_9_1    NA  7.30 18.8 31.30
## 76                <NA>  V_9_2    NA  4.04 20.5 32.00
## 77                <NA>  V_9_3    NA  4.36 19.9 92.60
## 78                <NA>  V_9_4    NA  4.30 19.8 36.50
## 79                <NA> V_2_10    NA  5.00  5.0  5.00
```
The full join returns all of the rows from both ndat and jdat - we have the 75 rows from jdat, plus the second V_17_1 as seen in the right_join and T_2_2 and T_4_3 that we present in ndat but NA in jdat for a total of 78 rows.

Lastly, we have the 2 filtering joins. These will not add columns, but rather filter the rows based on what is present in the second data frame.

__Semi join__ returns all rows from x where there are matching values in y, keeping just columns from x. A semi join differs from an inner join because an inner join will return one row of x for each matching row of y, where a semi join will never duplicate rows of x.


```r
semi_join(ndat, jdat, by = c("Site" = "Samples"))
```

```
##                   Taxa   Site  OTUs
## 1           Clostridia V_16_2 17572
## 2           Clostridia  T_2_9 17471
## 3           Clostridia V_17_2 13875
## 4           Clostridia  T_2_6 12169
## 5          Bacteroidia V_17_1 11392
## 6           Clostridia V_10_1 11180
## 7           Clostridia  T_2_3 10944
## 8              Unknown  T_9_2 10624
## 9           Clostridia  T_4_4 10545
## 10          Clostridia V_16_1 10043
## 11          Clostridia  T_5_3  8981
## 12 Alphaproteobacteria  V_3_2  8660
## 13          Clostridia V_15_1  8244
## 14          Clostridia V_17_1  7722
## 15          Clostridia V_18_1  7481
## 16 Alphaproteobacteria  V_3_1  7322
## 17          Clostridia V_18_4  6246
## 18          Clostridia  T_2_1  6213
```
`semi_join()` returns the 18 rows of ndat that have a Site match in jdat. Note that the columns from jdat have not been added.

</br>

__Anti join__ returns all rows from x where there are not matching values in y, keeping just columns from x.


```r
anti_join(ndat, jdat, by = c("Site" = "Samples"))
```

```
##                 Taxa  Site OTUs
## 1         Clostridia T_2_2 8999
## 2 Betaproteobacteria T_4_3 7710
```
This returns our 2 rows in ndat that did not have a match in jdat. Note that the columns from jdat have not been added.

***
__Challenge__
<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/pug_challenge1.jpeg){width=150px}

</div>

Given the definitions for the inner_, left_, right_, full_, semi_ and anti_joins, what would you expect the resulting data frame to be if jdat and ndat were reversed? Write down the number of rows and columns you would expect the data frame to have, then run the code. Did you find any surprises?

</br>
</br>
</br>

***

__Challenge__
<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/pug_challenge1.jpeg){width=150px}

</div>

Base R has a function that does join operations called `merge()`. What would be the code equivalent to the left_join of ndat and jdat? 

</br>
</br>
</br>

***


__Challenge__
<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/bonus_pow.jpg){width=100px}

</div>

Read in the gapminder_wide.csv. What rules of tidy data does it break? Tidy this dataset and save it as gapminder_long.csv.

</br>

</br>

***      
        

  
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


