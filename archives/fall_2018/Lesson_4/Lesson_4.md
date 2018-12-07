---
title: Lesson 4 - Of Data Cleaning and Documentation - Conquer Regular Expressions
  and Challenge yourself with a 'Real' Dataset
output:
  html_document:
    keep_md: yes
    toc: yes
    toc_depth: 3
---
***
![](img/big-data-borat.png){width=400px} 

</br>

##A quick intro to the intro to R Lesson Series

</br>

This 'Intro to R Lesson Series' is brought to you by the Centre for the Analysis of Genome Evolution & Function's (CAGEF) bioinformatics training initiative. This course was developed based on feedback on the needs and interests of the Department of Cell & Systems Biology and the Department of Ecology and Evolutionary Biology. 



This lesson is the fourth in a 6-part series. The idea is that at the end of the series, you will be able to import and manipulate your data, make exploratory plots, perform some basic statistical tests, and test a regression model. 


![](img/data-science-explore.png)

</br>

How do we get there? Today we are going to be learning data cleaning and string manipulation; this is really the battleground of coding - getting your data into the format where you can analyse it. In the next lesson we will learn how to do t-tests and perform regression and modeling in R. 


![](img/spotify-howtobuildmvp.gif)

</br>

The structure of the class is a code-along style. It is hands on. The lecture AND code we are going through are available on GitHub for download at https://github.com/eacton/CAGEF, so you can spend the time coding and not taking notes. As we go along, there will be some challenge questions and multiple choice questions on Socrative. At the end of the class if you could please fill out a post-lesson survey (https://www.surveymonkey.com/r/PVHDKDB), it will help me further develop this course and would be greatly appreciated. 

***

####Packages Used in This Lesson

The following packages are used in this lesson:

`tidyverse` (`stringr`, `dplyr`)     

Please install and load these packages for the lesson. In this document I will load each package separately, but I will not be reminding you to install the package. Remember: these packages may be from CRAN OR Bioconductor. 


***
####Highlighting

`grey background` - a package, function, code or command      
*italics* - an important term or concept     
**bold** - heading or 'grammar of graphics' term      
<span style="color:blue">blue text</span> - named or unnamed hyperlink     

***

####Data Files Used in This Lesson

-University returns_for_figshare_FINAL.xlsx     
-Readme_file.docx

These files can be downloaded at <https://github.com/eacton/CAGEF/tree/master/Lesson_4/data>. Right-click on the filename and select 'Save Link As...' to save the file locally. The files should be saved in the same folder you plan on using for your R script for this lesson.

Or click on the blue hyperlink at the start of the README.md at <https://github.com/eacton/CAGEF/tree/master/Lesson_4> to download the entire folder at DownGit.

***
__Objective:__ At the end of this session you will be able to use regular expressions to 'clean' your data. 

***

####Load libraries

Since we are moving along in the world, we are now going to start loading our libraries at the start of our script. This is a 'best practice' and makes it much easier for someone to reproduce your work efficiently by knowing exactly what packages they need to run your code. 


```r
library("tidyverse")
```




***

##Data Cleaning or Data Munging or Data Wrangling

Why do we need to do this?

'Raw' data is seldom (never) in a useable format. Data in tutorials or demos has already been meticulously filtered, transformed and readied to showcase that specific analysis. How many people have done a tutorial only to find they can't get their own data in the format to use the tool they have just spend an hour learning about???

Data cleaning requires us to:

- get rid of inconsistencies in our data. 
- have labels that make sense. 
- check for invalid character/numeric values.
- check for incomplete data.
- remove data we do not need.
- get our data in a proper format to be analyzed by the tools we are using. 
- flag/remove data that does not make sense.

Some definitions might take this a bit farther and include normalizing data and removing outliers, but I consider data cleaning as getting data into a format where we can start actively doing 'the maths or the graphs' - whether it be statistical calculations, normalization or exploratory plots. 

Today we are going to mostly be focusing on the **data cleaning of text**. This step is crucial to taking control of your dataset and your metadata. I have included the functions I find most useful for these tasks but I encourage you to take a look at the [Strings Chapter](http://r4ds.had.co.nz/strings.html) in *R for Data Science* for an exhaustive list of functions. We have learned how to transform data into a tidy format in Lesson 2, but the prelude to transforming data is doing the grunt work of data cleaning. So let's get to it!

<div style="float:center;margin: 10px 0 10px 0" markdown="1">
![](img/cleaning.gif){width=300px}
</div>

</br>

</br>


##Intro to regular expressions


**Regular expressions**

"A God-awful and powerful language for expressing patterns to match in text or for search-and-replace. Frequently described as 'write only', because regular expressions are easier to write than to read/understand. And they are not particularly easy to write."  - Jenny Bryan

</br>

![](img/xkcd-1171-perl_problems.png)

</br>

So why do regular expressions or 'regex' get so much flak if it is so powerful for text matching?

Scary example: how to get an email in different programming languages <http://emailregex.com/>. 

Regex is definitely one of those times when it is important to annotate your code. There are many jokes related to people coming back to their code the next day and having no idea what their code means.

<div style="left;margin:0 20px 20px 0" markdown="1">
![](img/yesterdays-regex.png){width=400px} 
</div>

There are sites available to help you make up your regular expressions and validate them against text. These are usually not R specific, but they will get you close and the expression will only need a slight modification for R (like an extra backslash - described below).

Regex testers:

<https://regex101.com/>     
<https://regexr.com/>


Today we will be practicing regex at Simon Goring's R-specific demo tester:     
<https://simongoring.shinyapps.io/RegularExpressionR/>



__What does the language look like?__ 

The language is based on _meta-characters_ which have a special meaning rather than their literal meaning. For example, '$' is used to match the end of a string, and this use supercedes its use as a character in a string (ie 'Joe paid \$2.99 for chips.'). 


###Classes

What kind of character is it?

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Expression </th>
   <th style="text-align:left;"> Meaning </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> \\w, [A-z0-9], [[:alnum:]] </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> word characters (letters + digits) </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> \\d, [0-9], [[:digit:]] </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> digits </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> [A-z], [:alpha:] </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> alphabetical characters </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> \\s, [[:space:]] </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> space </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> [[:punct:]] </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> punctuation </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> [[:lower:]] </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> lowercase </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> [[:upper:]] </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> uppercase </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> \\W, [^A-z0-9] </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> not word characters </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> \\S </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> not space </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> \\D, [^0-9] </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> not digits </td>
  </tr>
</tbody>
</table>


###Quantifiers

How many times will a character appear?

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Expression </th>
   <th style="text-align:left;"> Meaning </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> ? </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> 0 or 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> \* </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> 0 or more </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> \+ </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> 1 or more </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> {n} </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> exactly n </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> {n,} </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> at least n </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> {,n} </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> at most n </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> {n,m} </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> between n and m (inclusive) </td>
  </tr>
</tbody>
</table>


###Operators

Helper actions to match your characters.

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Expression </th>
   <th style="text-align:left;"> Meaning </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> | </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> or </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> . </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> matches any single character </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> [  ] </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> matches ANY of the characters inside the brackets </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> [ - ] </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> matches a RANGE of characters inside the brackets </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> [^ ] </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> matches any character EXCEPT those inside the bracket </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> ( ) </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> grouping - used for [backreferencing](https://www.regular-expressions.info/backref.html) </td>
  </tr>
</tbody>
</table>

###Matching by position

Where is the character in the string?

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Expression </th>
   <th style="text-align:left;"> Meaning </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> ^ </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> start of string </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> $ </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> end of string </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> \\b </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> empty string at either edge of a word </td>
  </tr>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> \\B </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> empty string that is NOT at the edge of a word </td>
  </tr>
</tbody>
</table>

###Escape characters

Sometimes a meta-character is just a character. _Escaping_ allows you to use a character 'as is' rather than its special function. In R, regex gets evaluated as a string before a regular expression, and a backslash is used to escape the string - so you really need 2 backslashes to escape, say, a '$' sign (`"\\\$"`). 

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Expression </th>
   <th style="text-align:left;"> Meaning </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;border-right:1px solid;"> \\ </td>
   <td style="text-align:left;width: 40em; font-style: italic;"> escape for meta-characters to be used as characters (*, $, ^, ., ?, |, \\, [, ], {, }, (, )). 
              Note: the backslash is also a meta-character. </td>
  </tr>
</tbody>
</table>

Trouble-shooting with escaping meta-characters means adding backslashes until something works. 

![Joking/Not Joking (xkcd)](img/backslashes.png)

While you can always refer back to this lesson for making your regular expressions, you can also use this [regex cheatsheet](https://www.rstudio.com/wp-content/uploads/2016/09/RegExCheatsheet.pdf).

</br>
</br>

<div style="float:left;margin:0 10px 10px 0" markdown="1">
![](img/80170c11996bd58e422dbb6631b73c4b.jpg){width=350px} 
</div>

<div style="float:right;margin:0 10px 10px 0" markdown="1">
![](img/regexbytrialanderror-big-smaller.png){width=350px} 
</div>

</br>

</br>

</br>

</br>
</br>

</br>
</br>


</br>

</br>

</br>
</br>

</br>
</br>

</br>

</br>

</br>
</br>

</br>
</br>

What I would like to get across it that it is okay to google and use resources early on for regex, and that even experts still use these resources.  

***

##Intro to string manipulation with stringr

Common uses of string manipulation are: searching, replacing or removing (making substitutions), and splitting and combining substrings.

As an example, we are going to play with a string of DNA. 


```r
dino <-">DinoDNA from Crichton JURASSIC PARK  p. 103 nt 1-1200 GCGTTGCTGGCGTTTTTCCATAGGCTCCGCCCCCCTGACGAGCATCACAAAAATCGACGCGGTGGCGAAACCCGACAGGACTATAAAGATACCAGGCGTTTCCCCCTGGAAGCTCCCTCGTGTTCCGACCCTGCCGCTTACCGGATACCTGTCCGCCTTTCTCCCTTCGGGAAGCGTGGCTGCTCACGCTGTACCTATCTCAGTTCGGTGTAGGTCGTTCGCTCCAAGCTGGGCTGTGTGCCGTTCAGCCCGACCGCTGCGCCTTATCCGGTAACTATCGTCTTGAGTCCAACCCGGTAAAGTAGGACAGGTGCCGGCAGCGCTCTGGGTCATTTTCGGCGAGGACCGCTTTCGCTGGAGATCGGCCTGTCGCTTGCGGTATTCGGAATCTTGCACGCCCTCGCTCAAGCCTTCGTCACTCCAAACGTTTCGGCGAGAAGCAGGCCATTATCGCCGGCATGGCGGCCGACGCGCTGGGCTGGCGTTCGCGACGCGAGGCTGGATGGCCTTCCCCATTATGATTCTTCTCGCTTCCGGCGGCCCGCGTTGCAGGCCATGCTGTCCAGGCAGGTAGATGACGACCATCAGGGACAGCTTCAACGGCTCTTACCAGCCTAACTTCGATCACTGGACCGCTGATCGTCACGGCGATTTATGCCGCACATGGACGCGTTGCTGGCGTTTTTCCATAGGCTCCGCCCCCCTGACGAGCATCACAAACAAGTCAGAGGTGGCGAAACCCGACAGGACTATAAAGATACCAGGCGTTTCCCCCTGGAAGCGCTCTCCTGTTCCGACCCTGCCGCTTACCGGATACCTGTCCGCCTTTCTCCCTTCGGGCTTTCTCAATGCTCACGCTGTAGGTATCTCAGTTCGGTGTAGGTCGTTCGCTCCAAGCTGACGAACCCCCCGTTCAGCCCGACCGCTGCGCCTTATCCGGTAACTATCGTCTTGAGTCCAACACGACTTAACGGGTTGGCATGGATTGTAGGCGCCGCCCTATACCTTGTCTGCCTCCCCGCGGTGCATGGAGCCGGGCCACCTCGACCTGAATGGAAGCCGGCGGCACCTCGCTAACGGCCAAGAATTGGAGCCAATCAATTCTTGCGGAGAACTGTGAATGCGCAAACCAACCCTTGGCCATCGCGTCCGCCATCTCCAGCAGCCGCACGCGGCGCATCTCGGGCAGCGTTGGGTCCT"
```


This piece of DNA is from the book Jurassic park, and was supposed to be dinosaur DNA, but is actually just a cloning vector. Bummer.

</br>

<div style="float:left;margin:0 10px 10px 0" markdown="1">
![nope](img/jurassicpark-trex-statue-photo1-700x376.jpg){width=450px} 
</div>

<div style="float:right;margin:0 10px 10px 0" markdown="1">
![yep](img/pBR328.png){width=300px} 
</div>
</br>

</br>

</br>
</br>

</br>
</br>

</br>

</br>

</br>
</br>

</br>
</br>


__Removing:__

This string is in FASTA format, but we don't need the header - we just want to deal with the DNA sequence. The header begins with '>' and ends with a number, '1200', with a space between the header and the sequence. Let's practice capturing each of these parts of a string, and then we'll make a regular expression to remove the entire header. 

All `stringr` functions take in as arguments the __string__ you are manipulating and the __pattern__ you are capturing. `str_remove` replaces the matched pattern with an empty character string "". In our first search we remove '>' from our string, dino.


```r
str_remove(string = dino, pattern = ">") 
```

```
## [1] "DinoDNA from Crichton JURASSIC PARK  p. 103 nt 1-1200 GCGTTGCTGGCGTTTTTCCATAGGCTCCGCCCCCCTGACGAGCATCACAAAAATCGACGCGGTGGCGAAACCCGACAGGACTATAAAGATACCAGGCGTTTCCCCCTGGAAGCTCCCTCGTGTTCCGACCCTGCCGCTTACCGGATACCTGTCCGCCTTTCTCCCTTCGGGAAGCGTGGCTGCTCACGCTGTACCTATCTCAGTTCGGTGTAGGTCGTTCGCTCCAAGCTGGGCTGTGTGCCGTTCAGCCCGACCGCTGCGCCTTATCCGGTAACTATCGTCTTGAGTCCAACCCGGTAAAGTAGGACAGGTGCCGGCAGCGCTCTGGGTCATTTTCGGCGAGGACCGCTTTCGCTGGAGATCGGCCTGTCGCTTGCGGTATTCGGAATCTTGCACGCCCTCGCTCAAGCCTTCGTCACTCCAAACGTTTCGGCGAGAAGCAGGCCATTATCGCCGGCATGGCGGCCGACGCGCTGGGCTGGCGTTCGCGACGCGAGGCTGGATGGCCTTCCCCATTATGATTCTTCTCGCTTCCGGCGGCCCGCGTTGCAGGCCATGCTGTCCAGGCAGGTAGATGACGACCATCAGGGACAGCTTCAACGGCTCTTACCAGCCTAACTTCGATCACTGGACCGCTGATCGTCACGGCGATTTATGCCGCACATGGACGCGTTGCTGGCGTTTTTCCATAGGCTCCGCCCCCCTGACGAGCATCACAAACAAGTCAGAGGTGGCGAAACCCGACAGGACTATAAAGATACCAGGCGTTTCCCCCTGGAAGCGCTCTCCTGTTCCGACCCTGCCGCTTACCGGATACCTGTCCGCCTTTCTCCCTTCGGGCTTTCTCAATGCTCACGCTGTAGGTATCTCAGTTCGGTGTAGGTCGTTCGCTCCAAGCTGACGAACCCCCCGTTCAGCCCGACCGCTGCGCCTTATCCGGTAACTATCGTCTTGAGTCCAACACGACTTAACGGGTTGGCATGGATTGTAGGCGCCGCCCTATACCTTGTCTGCCTCCCCGCGGTGCATGGAGCCGGGCCACCTCGACCTGAATGGAAGCCGGCGGCACCTCGCTAACGGCCAAGAATTGGAGCCAATCAATTCTTGCGGAGAACTGTGAATGCGCAAACCAACCCTTGGCCATCGCGTCCGCCATCTCCAGCAGCCGCACGCGGCGCATCTCGGGCAGCGTTGGGTCCT"
```
Next we can search for numbers. The expression '[0-9]' is looking for any number. Always make sure to check that the pattern you are using gives you the output you expect.


```r
str_remove(string = dino, pattern = "[0-9]") 
```

```
## [1] ">DinoDNA from Crichton JURASSIC PARK  p. 03 nt 1-1200 GCGTTGCTGGCGTTTTTCCATAGGCTCCGCCCCCCTGACGAGCATCACAAAAATCGACGCGGTGGCGAAACCCGACAGGACTATAAAGATACCAGGCGTTTCCCCCTGGAAGCTCCCTCGTGTTCCGACCCTGCCGCTTACCGGATACCTGTCCGCCTTTCTCCCTTCGGGAAGCGTGGCTGCTCACGCTGTACCTATCTCAGTTCGGTGTAGGTCGTTCGCTCCAAGCTGGGCTGTGTGCCGTTCAGCCCGACCGCTGCGCCTTATCCGGTAACTATCGTCTTGAGTCCAACCCGGTAAAGTAGGACAGGTGCCGGCAGCGCTCTGGGTCATTTTCGGCGAGGACCGCTTTCGCTGGAGATCGGCCTGTCGCTTGCGGTATTCGGAATCTTGCACGCCCTCGCTCAAGCCTTCGTCACTCCAAACGTTTCGGCGAGAAGCAGGCCATTATCGCCGGCATGGCGGCCGACGCGCTGGGCTGGCGTTCGCGACGCGAGGCTGGATGGCCTTCCCCATTATGATTCTTCTCGCTTCCGGCGGCCCGCGTTGCAGGCCATGCTGTCCAGGCAGGTAGATGACGACCATCAGGGACAGCTTCAACGGCTCTTACCAGCCTAACTTCGATCACTGGACCGCTGATCGTCACGGCGATTTATGCCGCACATGGACGCGTTGCTGGCGTTTTTCCATAGGCTCCGCCCCCCTGACGAGCATCACAAACAAGTCAGAGGTGGCGAAACCCGACAGGACTATAAAGATACCAGGCGTTTCCCCCTGGAAGCGCTCTCCTGTTCCGACCCTGCCGCTTACCGGATACCTGTCCGCCTTTCTCCCTTCGGGCTTTCTCAATGCTCACGCTGTAGGTATCTCAGTTCGGTGTAGGTCGTTCGCTCCAAGCTGACGAACCCCCCGTTCAGCCCGACCGCTGCGCCTTATCCGGTAACTATCGTCTTGAGTCCAACACGACTTAACGGGTTGGCATGGATTGTAGGCGCCGCCCTATACCTTGTCTGCCTCCCCGCGGTGCATGGAGCCGGGCCACCTCGACCTGAATGGAAGCCGGCGGCACCTCGCTAACGGCCAAGAATTGGAGCCAATCAATTCTTGCGGAGAACTGTGAATGCGCAAACCAACCCTTGGCCATCGCGTCCGCCATCTCCAGCAGCCGCACGCGGCGCATCTCGGGCAGCGTTGGGTCCT"
```

Why aren't all of the numbers replaced? `str_remove` only replaces the first match in a character string. Switching to `str_remove_all` replaces all instances of numbers in the character string.


```r
str_remove_all(string = dino, pattern = "[0-9]") 
```

```
## [1] ">DinoDNA from Crichton JURASSIC PARK  p.  nt - GCGTTGCTGGCGTTTTTCCATAGGCTCCGCCCCCCTGACGAGCATCACAAAAATCGACGCGGTGGCGAAACCCGACAGGACTATAAAGATACCAGGCGTTTCCCCCTGGAAGCTCCCTCGTGTTCCGACCCTGCCGCTTACCGGATACCTGTCCGCCTTTCTCCCTTCGGGAAGCGTGGCTGCTCACGCTGTACCTATCTCAGTTCGGTGTAGGTCGTTCGCTCCAAGCTGGGCTGTGTGCCGTTCAGCCCGACCGCTGCGCCTTATCCGGTAACTATCGTCTTGAGTCCAACCCGGTAAAGTAGGACAGGTGCCGGCAGCGCTCTGGGTCATTTTCGGCGAGGACCGCTTTCGCTGGAGATCGGCCTGTCGCTTGCGGTATTCGGAATCTTGCACGCCCTCGCTCAAGCCTTCGTCACTCCAAACGTTTCGGCGAGAAGCAGGCCATTATCGCCGGCATGGCGGCCGACGCGCTGGGCTGGCGTTCGCGACGCGAGGCTGGATGGCCTTCCCCATTATGATTCTTCTCGCTTCCGGCGGCCCGCGTTGCAGGCCATGCTGTCCAGGCAGGTAGATGACGACCATCAGGGACAGCTTCAACGGCTCTTACCAGCCTAACTTCGATCACTGGACCGCTGATCGTCACGGCGATTTATGCCGCACATGGACGCGTTGCTGGCGTTTTTCCATAGGCTCCGCCCCCCTGACGAGCATCACAAACAAGTCAGAGGTGGCGAAACCCGACAGGACTATAAAGATACCAGGCGTTTCCCCCTGGAAGCGCTCTCCTGTTCCGACCCTGCCGCTTACCGGATACCTGTCCGCCTTTCTCCCTTCGGGCTTTCTCAATGCTCACGCTGTAGGTATCTCAGTTCGGTGTAGGTCGTTCGCTCCAAGCTGACGAACCCCCCGTTCAGCCCGACCGCTGCGCCTTATCCGGTAACTATCGTCTTGAGTCCAACACGACTTAACGGGTTGGCATGGATTGTAGGCGCCGCCCTATACCTTGTCTGCCTCCCCGCGGTGCATGGAGCCGGGCCACCTCGACCTGAATGGAAGCCGGCGGCACCTCGCTAACGGCCAAGAATTGGAGCCAATCAATTCTTGCGGAGAACTGTGAATGCGCAAACCAACCCTTGGCCATCGCGTCCGCCATCTCCAGCAGCCGCACGCGGCGCATCTCGGGCAGCGTTGGGTCCT"
```

How do we capture spaces? The pattern '\\s' replaces a space. However, for the backslash to not be used as an escape character (its special function), we need to add another backslash, making our pattern '\\\\s'.


```r
str_remove_all(string = dino, pattern = "\\s") 
```

```
## [1] ">DinoDNAfromCrichtonJURASSICPARKp.103nt1-1200GCGTTGCTGGCGTTTTTCCATAGGCTCCGCCCCCCTGACGAGCATCACAAAAATCGACGCGGTGGCGAAACCCGACAGGACTATAAAGATACCAGGCGTTTCCCCCTGGAAGCTCCCTCGTGTTCCGACCCTGCCGCTTACCGGATACCTGTCCGCCTTTCTCCCTTCGGGAAGCGTGGCTGCTCACGCTGTACCTATCTCAGTTCGGTGTAGGTCGTTCGCTCCAAGCTGGGCTGTGTGCCGTTCAGCCCGACCGCTGCGCCTTATCCGGTAACTATCGTCTTGAGTCCAACCCGGTAAAGTAGGACAGGTGCCGGCAGCGCTCTGGGTCATTTTCGGCGAGGACCGCTTTCGCTGGAGATCGGCCTGTCGCTTGCGGTATTCGGAATCTTGCACGCCCTCGCTCAAGCCTTCGTCACTCCAAACGTTTCGGCGAGAAGCAGGCCATTATCGCCGGCATGGCGGCCGACGCGCTGGGCTGGCGTTCGCGACGCGAGGCTGGATGGCCTTCCCCATTATGATTCTTCTCGCTTCCGGCGGCCCGCGTTGCAGGCCATGCTGTCCAGGCAGGTAGATGACGACCATCAGGGACAGCTTCAACGGCTCTTACCAGCCTAACTTCGATCACTGGACCGCTGATCGTCACGGCGATTTATGCCGCACATGGACGCGTTGCTGGCGTTTTTCCATAGGCTCCGCCCCCCTGACGAGCATCACAAACAAGTCAGAGGTGGCGAAACCCGACAGGACTATAAAGATACCAGGCGTTTCCCCCTGGAAGCGCTCTCCTGTTCCGACCCTGCCGCTTACCGGATACCTGTCCGCCTTTCTCCCTTCGGGCTTTCTCAATGCTCACGCTGTAGGTATCTCAGTTCGGTGTAGGTCGTTCGCTCCAAGCTGACGAACCCCCCGTTCAGCCCGACCGCTGCGCCTTATCCGGTAACTATCGTCTTGAGTCCAACACGACTTAACGGGTTGGCATGGATTGTAGGCGCCGCCCTATACCTTGTCTGCCTCCCCGCGGTGCATGGAGCCGGGCCACCTCGACCTGAATGGAAGCCGGCGGCACCTCGCTAACGGCCAAGAATTGGAGCCAATCAATTCTTGCGGAGAACTGTGAATGCGCAAACCAACCCTTGGCCATCGCGTCCGCCATCTCCAGCAGCCGCACGCGGCGCATCTCGGGCAGCGTTGGGTCCT"
```

To remove the entire header, we need to combine these patterns. The header is everything in between '>' and the number '1200' followed by a space. The operator `.` captures any single character and the quantifier `*` is any number of times (including zero). 


```r
str_remove(string = dino, pattern = ">.*[0-9]\\s")
```

```
## [1] "GCGTTGCTGGCGTTTTTCCATAGGCTCCGCCCCCCTGACGAGCATCACAAAAATCGACGCGGTGGCGAAACCCGACAGGACTATAAAGATACCAGGCGTTTCCCCCTGGAAGCTCCCTCGTGTTCCGACCCTGCCGCTTACCGGATACCTGTCCGCCTTTCTCCCTTCGGGAAGCGTGGCTGCTCACGCTGTACCTATCTCAGTTCGGTGTAGGTCGTTCGCTCCAAGCTGGGCTGTGTGCCGTTCAGCCCGACCGCTGCGCCTTATCCGGTAACTATCGTCTTGAGTCCAACCCGGTAAAGTAGGACAGGTGCCGGCAGCGCTCTGGGTCATTTTCGGCGAGGACCGCTTTCGCTGGAGATCGGCCTGTCGCTTGCGGTATTCGGAATCTTGCACGCCCTCGCTCAAGCCTTCGTCACTCCAAACGTTTCGGCGAGAAGCAGGCCATTATCGCCGGCATGGCGGCCGACGCGCTGGGCTGGCGTTCGCGACGCGAGGCTGGATGGCCTTCCCCATTATGATTCTTCTCGCTTCCGGCGGCCCGCGTTGCAGGCCATGCTGTCCAGGCAGGTAGATGACGACCATCAGGGACAGCTTCAACGGCTCTTACCAGCCTAACTTCGATCACTGGACCGCTGATCGTCACGGCGATTTATGCCGCACATGGACGCGTTGCTGGCGTTTTTCCATAGGCTCCGCCCCCCTGACGAGCATCACAAACAAGTCAGAGGTGGCGAAACCCGACAGGACTATAAAGATACCAGGCGTTTCCCCCTGGAAGCGCTCTCCTGTTCCGACCCTGCCGCTTACCGGATACCTGTCCGCCTTTCTCCCTTCGGGCTTTCTCAATGCTCACGCTGTAGGTATCTCAGTTCGGTGTAGGTCGTTCGCTCCAAGCTGACGAACCCCCCGTTCAGCCCGACCGCTGCGCCTTATCCGGTAACTATCGTCTTGAGTCCAACACGACTTAACGGGTTGGCATGGATTGTAGGCGCCGCCCTATACCTTGTCTGCCTCCCCGCGGTGCATGGAGCCGGGCCACCTCGACCTGAATGGAAGCCGGCGGCACCTCGCTAACGGCCAAGAATTGGAGCCAATCAATTCTTGCGGAGAACTGTGAATGCGCAAACCAACCCTTGGCCATCGCGTCCGCCATCTCCAGCAGCCGCACGCGGCGCATCTCGGGCAGCGTTGGGTCCT"
```

You may have noticed that we also have a number followed by a space earlier in the header, '103 '. Why didn't the replacement end at that first match? The first instance is an example of _greedy_ matching - it will take the longest possible string. To curtail this behaviour and use _lazy_ matching - the shortest possible string - you can add the `?` quantifier.





```r
str_remove(string = dino, pattern = ">.*?[0-9]\\s")
```

```
## [1] "nt 1-1200 GCGTTGCTGGCGTTTTTCCATAGGCTCCGCCCCCCTGACGAGCATCACAAAAATCGACGCGGTGGCGAAACCCGACAGGACTATAAAGATACCAGGCGTTTCCCCCTGGAAGCTCCCTCGTGTTCCGACCCTGCCGCTTACCGGATACCTGTCCGCCTTTCTCCCTTCGGGAAGCGTGGCTGCTCACGCTGTACCTATCTCAGTTCGGTGTAGGTCGTTCGCTCCAAGCTGGGCTGTGTGCCGTTCAGCCCGACCGCTGCGCCTTATCCGGTAACTATCGTCTTGAGTCCAACCCGGTAAAGTAGGACAGGTGCCGGCAGCGCTCTGGGTCATTTTCGGCGAGGACCGCTTTCGCTGGAGATCGGCCTGTCGCTTGCGGTATTCGGAATCTTGCACGCCCTCGCTCAAGCCTTCGTCACTCCAAACGTTTCGGCGAGAAGCAGGCCATTATCGCCGGCATGGCGGCCGACGCGCTGGGCTGGCGTTCGCGACGCGAGGCTGGATGGCCTTCCCCATTATGATTCTTCTCGCTTCCGGCGGCCCGCGTTGCAGGCCATGCTGTCCAGGCAGGTAGATGACGACCATCAGGGACAGCTTCAACGGCTCTTACCAGCCTAACTTCGATCACTGGACCGCTGATCGTCACGGCGATTTATGCCGCACATGGACGCGTTGCTGGCGTTTTTCCATAGGCTCCGCCCCCCTGACGAGCATCACAAACAAGTCAGAGGTGGCGAAACCCGACAGGACTATAAAGATACCAGGCGTTTCCCCCTGGAAGCGCTCTCCTGTTCCGACCCTGCCGCTTACCGGATACCTGTCCGCCTTTCTCCCTTCGGGCTTTCTCAATGCTCACGCTGTAGGTATCTCAGTTCGGTGTAGGTCGTTCGCTCCAAGCTGACGAACCCCCCGTTCAGCCCGACCGCTGCGCCTTATCCGGTAACTATCGTCTTGAGTCCAACACGACTTAACGGGTTGGCATGGATTGTAGGCGCCGCCCTATACCTTGTCTGCCTCCCCGCGGTGCATGGAGCCGGGCCACCTCGACCTGAATGGAAGCCGGCGGCACCTCGCTAACGGCCAAGAATTGGAGCCAATCAATTCTTGCGGAGAACTGTGAATGCGCAAACCAACCCTTGGCCATCGCGTCCGCCATCTCCAGCAGCCGCACGCGGCGCATCTCGGGCAGCGTTGGGTCCT"
```
In this case, we want the greedy matching to replace the entire header. Let's save the dna into its own object.


```r
dna <- str_remove(string = dino, pattern = ">.*[0-9]\\s")
```

__Extracting:__

We may also want to retain our header in a separate string. `str_extract` will retain the string that matches our pattern instead of removing it. We can save this in an object called header (I removed the final space from our expresssion).



```r
header <- str_extract(string = dino, pattern = ">.*[0-9]")
header
```

```
## [1] ">DinoDNA from Crichton JURASSIC PARK  p. 103 nt 1-1200"
```


__Searching:__

Now we can look for patterns in our (dino) DNA!

Does this DNA have balanced GC content? We can use `str_extract_all` to capture every character that is either a G or a C.


```r
str_extract_all(dino, pattern = "G|C")
```

```
## [[1]]
##   [1] "C" "C" "G" "C" "G" "G" "C" "G" "G" "C" "G" "C" "C" "G" "G" "C" "C"
##  [18] "C" "G" "C" "C" "C" "C" "C" "C" "G" "C" "G" "G" "C" "C" "C" "C" "G"
##  [35] "C" "G" "C" "G" "G" "G" "G" "C" "G" "C" "C" "C" "G" "C" "G" "G" "C"
##  [52] "G" "C" "C" "G" "G" "C" "G" "C" "C" "C" "C" "C" "G" "G" "G" "C" "C"
##  [69] "C" "C" "C" "G" "G" "C" "C" "G" "C" "C" "C" "G" "C" "C" "G" "C" "C"
##  [86] "C" "G" "G" "C" "C" "G" "C" "C" "G" "C" "C" "C" "C" "C" "C" "C" "G"
## [103] "G" "G" "G" "C" "G" "G" "G" "C" "G" "C" "C" "C" "G" "C" "G" "C" "C"
## [120] "C" "C" "G" "C" "G" "G" "G" "G" "G" "C" "G" "C" "G" "C" "C" "C" "G"
## [137] "C" "G" "G" "G" "C" "G" "G" "G" "C" "C" "G" "C" "G" "C" "C" "C" "G"
## [154] "C" "C" "G" "C" "G" "C" "G" "C" "C" "C" "C" "G" "G" "C" "C" "G" "C"
## [171] "G" "G" "C" "C" "C" "C" "C" "G" "G" "G" "G" "G" "C" "G" "G" "G" "C"
## [188] "C" "G" "G" "C" "G" "C" "G" "C" "C" "G" "G" "G" "C" "C" "G" "G" "C"
## [205] "G" "G" "G" "C" "C" "G" "C" "C" "G" "C" "G" "G" "G" "C" "G" "G" "C"
## [222] "C" "G" "C" "G" "C" "G" "C" "G" "G" "C" "G" "G" "C" "G" "C" "C" "G"
## [239] "C" "C" "C" "C" "G" "C" "C" "G" "C" "C" "C" "G" "C" "C" "C" "C" "C"
## [256] "G" "C" "G" "G" "C" "G" "G" "G" "C" "G" "G" "C" "C" "C" "G" "C" "C"
## [273] "G" "G" "C" "G" "G" "C" "G" "G" "C" "C" "G" "C" "G" "C" "G" "C" "G"
## [290] "G" "G" "C" "G" "G" "C" "G" "C" "G" "C" "G" "C" "G" "C" "G" "G" "G"
## [307] "C" "G" "G" "G" "G" "C" "C" "C" "C" "C" "C" "G" "C" "C" "C" "G" "C"
## [324] "C" "C" "G" "G" "C" "G" "G" "C" "C" "C" "G" "C" "G" "G" "C" "G" "G"
## [341] "C" "C" "G" "C" "G" "C" "C" "G" "G" "C" "G" "G" "G" "G" "C" "G" "C"
## [358] "C" "C" "G" "G" "G" "C" "G" "C" "C" "C" "G" "G" "C" "C" "C" "C" "G"
## [375] "C" "C" "C" "C" "G" "C" "C" "G" "G" "C" "C" "G" "C" "G" "C" "G" "C"
## [392] "C" "G" "G" "C" "G" "G" "C" "C" "G" "C" "C" "G" "G" "C" "G" "C" "G"
## [409] "G" "C" "G" "G" "C" "G" "C" "C" "G" "G" "C" "C" "C" "G" "C" "C" "C"
## [426] "C" "C" "C" "G" "C" "G" "G" "C" "C" "C" "C" "G" "C" "G" "G" "G" "G"
## [443] "G" "C" "G" "C" "C" "C" "G" "C" "G" "G" "C" "G" "C" "C" "G" "G" "C"
## [460] "G" "C" "C" "C" "C" "C" "G" "G" "G" "C" "G" "C" "C" "C" "C" "G" "C"
## [477] "C" "G" "C" "C" "C" "G" "C" "C" "G" "C" "C" "C" "G" "G" "C" "C" "G"
## [494] "C" "C" "G" "C" "C" "C" "C" "C" "C" "C" "G" "G" "G" "C" "C" "C" "G"
## [511] "C" "C" "C" "G" "C" "G" "G" "G" "C" "C" "G" "C" "G" "G" "G" "G" "G"
## [528] "C" "G" "C" "G" "C" "C" "C" "G" "C" "G" "C" "G" "C" "C" "C" "C" "C"
## [545] "C" "G" "C" "G" "C" "C" "C" "G" "C" "C" "G" "C" "G" "C" "G" "C" "C"
## [562] "C" "C" "G" "G" "C" "C" "G" "C" "G" "G" "C" "C" "C" "C" "G" "C" "C"
## [579] "G" "G" "G" "G" "G" "C" "G" "G" "G" "G" "G" "C" "G" "C" "C" "G" "C"
## [596] "C" "C" "C" "C" "G" "C" "G" "C" "C" "C" "C" "C" "C" "G" "C" "G" "G"
## [613] "G" "C" "G" "G" "G" "C" "C" "G" "G" "G" "C" "C" "C" "C" "C" "G" "C"
## [630] "C" "G" "G" "G" "G" "C" "C" "G" "G" "C" "G" "G" "C" "C" "C" "C" "G"
## [647] "C" "C" "G" "G" "C" "C" "G" "G" "G" "G" "C" "C" "C" "C" "G" "C" "G"
## [664] "G" "G" "C" "G" "G" "G" "C" "G" "C" "C" "C" "C" "C" "C" "G" "G" "C"
## [681] "C" "C" "G" "C" "G" "C" "C" "G" "C" "C" "C" "C" "C" "G" "C" "G" "C"
## [698] "C" "G" "C" "C" "G" "C" "G" "G" "C" "G" "C" "C" "C" "G" "G" "G" "C"
## [715] "G" "C" "G" "G" "G" "G" "C" "C"
```

The output is a list object in which is stored an entry for each G or C extracted. We count the number of occurences of G and C using `str_count` and divide by the total number of characters in our string to get the %GC content. 



```r
str_count(dna, pattern = "G|C")/str_length(dna) * 100
```

```
## [1] 60
```



Let's translate this into mRNA! 

__Replacement:__

To replace multiple patterns at once, a character vector is supplied to `str_replace_all` of patterns and their matched replacements. This allows us to perform multiple replacements multiple times.


```r
mrna <- str_replace_all(dna, c("G" = "C", "C" = "G", "A" = "U", "T" = "A"))
```


__More Searching:__

Is there even a start codon in this thing? `str_detect` can be used to get a local (TRUE or FALSE) answer to whether or not a match is found.


```r
str_detect(mrna, "AUG")
```

```
## [1] TRUE
```

It might be more useful to know exactly how many possible start codons we have. `str_count` will count the number of matches in the string for our pattern.


```r
str_count(mrna, "AUG")
```

```
## [1] 17
```



To get the position of a possible start codon we can use `str_locate` which will return the indices of where the start and end of our substring occurs (`str_locate_all` can be used to find the all possible locations).



```r
str_locate(mrna, "AUG")
```

```
##      start end
## [1,]    21  23
```


__Splitting:__

Let's split this string into substrings of codons, starting at the position of our start codon. We have the position of our start codon from `str_locate`. We can use `str_sub` to subset the string by position (we will just go to the end of the string for now).


```r
str_sub(mrna, 21, 1200)
```

```
## [1] "AUGGGAGGGGGGGGGAGUGGUGGUAGUGUUUUUAGGUGGGGGAGGGGUUUGGGGUGUGGUGAUAUUUGUAUGGUGGGGAAAGGGGGAGGUUGGAGGGAGGAGAAGGGUGGGAGGGGGAAUGGGGUAUGGAGAGGGGGAAAGAGGGAAGGGGUUGGGAGGGAGGAGUGGGAGAUGGAUAGAGUGAAGGGAGAUGGAGGAAGGGAGGUUGGAGGGGAGAGAGGGGAAGUGGGGGUGGGGAGGGGGAAUAGGGGAUUGAUAGGAGAAGUGAGGUUGGGGGAUUUGAUGGUGUGGAGGGGGGUGGGGAGAGGGAGUAAAAGGGGGUGGUGGGGAAAGGGAGGUGUAGGGGGAGAGGGAAGGGGAUAAGGGUUAGAAGGUGGGGGAGGGAGUUGGGAAGGAGUGAGGUUUGGAAAGGGGGUGUUGGUGGGGUAAUAGGGGGGGUAGGGGGGGGUGGGGGAGGGGAGGGGAAGGGGUGGGGUGGGAGGUAGGGGAAGGGGUAAUAGUAAGAAGAGGGAAGGGGGGGGGGGGGAAGGUGGGGUAGGAGAGGUGGGUGGAUGUAGUGGUGGUAGUGGGUGUGGAAGUUGGGGAGAAUGGUGGGAUUGAAGGUAGUGAGGUGGGGAGUAGGAGUGGGGGUAAAUAGGGGGUGUAGGUGGGGAAGGAGGGGAAAAAGGUAUGGGAGGGGGGGGGAGUGGUGGUAGUGUUUGUUGAGUGUGGAGGGGUUUGGGGUGUGGUGAUAUUUGUAUGGUGGGGAAAGGGGGAGGUUGGGGAGAGGAGAAGGGUGGGAGGGGGAAUGGGGUAUGGAGAGGGGGAAAGAGGGAAGGGGGAAAGAGUUAGGAGUGGGAGAUGGAUAGAGUGAAGGGAGAUGGAGGAAGGGAGGUUGGAGUGGUUGGGGGGGAAGUGGGGGUGGGGAGGGGGAAUAGGGGAUUGAUAGGAGAAGUGAGGUUGUGGUGAAUUGGGGAAGGGUAGGUAAGAUGGGGGGGGGGAUAUGGAAGAGAGGGAGGGGGGGGAGGUAGGUGGGGGGGGUGGAGGUGGAGUUAGGUUGGGGGGGGGUGGAGGGAUUGGGGGUUGUUAAGGUGGGUUAGUUAAGAAGGGGUGUUGAGAGUUAGGGGUUUGGUUGGGAAGGGGUAGGGGAGGGGGUAGAGGUGGUGGGGGUGGGGGGGGUAGAGGGGGUGGGAAGGGAGGA"
```

```r
#is equivalent to
mrna <- str_sub(mrna, str_locate(mrna, "AUG")[1])
```

We can get codons by extracting groups of (any) 3 nucleotides/characters in our reading frame.


```r
str_extract_all(mrna, "...")
```

```
## [[1]]
##   [1] "AUG" "GGA" "GGG" "GGG" "GGG" "AGU" "GGU" "GGU" "AGU" "GUU" "UUU"
##  [12] "AGG" "UGG" "GGG" "AGG" "GGU" "UUG" "GGG" "UGU" "GGU" "GAU" "AUU"
##  [23] "UGU" "AUG" "GUG" "GGG" "AAA" "GGG" "GGA" "GGU" "UGG" "AGG" "GAG"
##  [34] "GAG" "AAG" "GGU" "GGG" "AGG" "GGG" "AAU" "GGG" "GUA" "UGG" "AGA"
##  [45] "GGG" "GGA" "AAG" "AGG" "GAA" "GGG" "GUU" "GGG" "AGG" "GAG" "GAG"
##  [56] "UGG" "GAG" "AUG" "GAU" "AGA" "GUG" "AAG" "GGA" "GAU" "GGA" "GGA"
##  [67] "AGG" "GAG" "GUU" "GGA" "GGG" "GAG" "AGA" "GGG" "GAA" "GUG" "GGG"
##  [78] "GUG" "GGG" "AGG" "GGG" "AAU" "AGG" "GGA" "UUG" "AUA" "GGA" "GAA"
##  [89] "GUG" "AGG" "UUG" "GGG" "GAU" "UUG" "AUG" "GUG" "UGG" "AGG" "GGG"
## [100] "GUG" "GGG" "AGA" "GGG" "AGU" "AAA" "AGG" "GGG" "UGG" "UGG" "GGA"
## [111] "AAG" "GGA" "GGU" "GUA" "GGG" "GGA" "GAG" "GGA" "AGG" "GGA" "UAA"
## [122] "GGG" "UUA" "GAA" "GGU" "GGG" "GGA" "GGG" "AGU" "UGG" "GAA" "GGA"
## [133] "GUG" "AGG" "UUU" "GGA" "AAG" "GGG" "GUG" "UUG" "GUG" "GGG" "UAA"
## [144] "UAG" "GGG" "GGG" "UAG" "GGG" "GGG" "GUG" "GGG" "GAG" "GGG" "AGG"
## [155] "GGA" "AGG" "GGU" "GGG" "GUG" "GGA" "GGU" "AGG" "GGA" "AGG" "GGU"
## [166] "AAU" "AGU" "AAG" "AAG" "AGG" "GAA" "GGG" "GGG" "GGG" "GGG" "GAA"
## [177] "GGU" "GGG" "GUA" "GGA" "GAG" "GUG" "GGU" "GGA" "UGU" "AGU" "GGU"
## [188] "GGU" "AGU" "GGG" "UGU" "GGA" "AGU" "UGG" "GGA" "GAA" "UGG" "UGG"
## [199] "GAU" "UGA" "AGG" "UAG" "UGA" "GGU" "GGG" "GAG" "UAG" "GAG" "UGG"
## [210] "GGG" "UAA" "AUA" "GGG" "GGU" "GUA" "GGU" "GGG" "GAA" "GGA" "GGG"
## [221] "GAA" "AAA" "GGU" "AUG" "GGA" "GGG" "GGG" "GGG" "AGU" "GGU" "GGU"
## [232] "AGU" "GUU" "UGU" "UGA" "GUG" "UGG" "AGG" "GGU" "UUG" "GGG" "UGU"
## [243] "GGU" "GAU" "AUU" "UGU" "AUG" "GUG" "GGG" "AAA" "GGG" "GGA" "GGU"
## [254] "UGG" "GGA" "GAG" "GAG" "AAG" "GGU" "GGG" "AGG" "GGG" "AAU" "GGG"
## [265] "GUA" "UGG" "AGA" "GGG" "GGA" "AAG" "AGG" "GAA" "GGG" "GGA" "AAG"
## [276] "AGU" "UAG" "GAG" "UGG" "GAG" "AUG" "GAU" "AGA" "GUG" "AAG" "GGA"
## [287] "GAU" "GGA" "GGA" "AGG" "GAG" "GUU" "GGA" "GUG" "GUU" "GGG" "GGG"
## [298] "GAA" "GUG" "GGG" "GUG" "GGG" "AGG" "GGG" "AAU" "AGG" "GGA" "UUG"
## [309] "AUA" "GGA" "GAA" "GUG" "AGG" "UUG" "UGG" "UGA" "AUU" "GGG" "GAA"
## [320] "GGG" "UAG" "GUA" "AGA" "UGG" "GGG" "GGG" "GGA" "UAU" "GGA" "AGA"
## [331] "GAG" "GGA" "GGG" "GGG" "GGA" "GGU" "AGG" "UGG" "GGG" "GGG" "UGG"
## [342] "AGG" "UGG" "AGU" "UAG" "GUU" "GGG" "GGG" "GGG" "UGG" "AGG" "GAU"
## [353] "UGG" "GGG" "UUG" "UUA" "AGG" "UGG" "GUU" "AGU" "UAA" "GAA" "GGG"
## [364] "GUG" "UUG" "AGA" "GUU" "AGG" "GGU" "UUG" "GUU" "GGG" "AAG" "GGG"
## [375] "UAG" "GGG" "AGG" "GGG" "UAG" "AGG" "UGG" "UGG" "GGG" "UGG" "GGG"
## [386] "GGG" "UAG" "AGG" "GGG" "UGG" "GAA" "GGG" "AGG"
```
The codons are extracted into a list, but we can get our character substrings using `unlist`. 


```r
codons <- unlist(str_extract_all(mrna, "..."))
```

We now have a vector with 393 codons.

Do we have a stop codon in our reading frame? Let's check with `str_detect`. We can use round brackets `( )` to separately group the different stop codons.


```r
str_detect(codons, "(UAG)|(UGA)|(UAA)")
```

```
##   [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [12] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [23] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [34] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [45] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [56] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [67] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [78] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [89] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [100] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [111] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
## [122] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [133] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
## [144]  TRUE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [155] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [166] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [177] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [188] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [199] FALSE  TRUE FALSE  TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE
## [210] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [221] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [232] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [243] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [254] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [265] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [276] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [287] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [298] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [309] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
## [320] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [331] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [342] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [353] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
## [364] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [375]  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
## [386] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
```
Looks like we have many matches. We can subset the codons using `str_detect` (instances where the presence of a stop codon is equal to TRUE) to see which stop codons are represented. We can use the `which` function to find the which indices the stop codons are positioned at.


```r
which(str_detect(codons, "(UAG)|(UGA)|(UAA)") == TRUE)
```

```
##  [1] 121 143 144 147 200 202 203 207 211 235 277 316 321 345 361 375 379
## [18] 387
```

Let's subset our codon strings to end at the first stop codon. 


```r
translation <- codons[1:121]

#equivalent to 
translation <- codons[1:which(str_detect(codons, "(UAG)|(UGA)|(UAA)") == TRUE)[1]]
```



__More Replacing:__

After finding our unique codons, we can translate codons into their respective proteins by using `str_replace_all` using multiple patterns and replacements as before.



```r
unique(translation)
```

```
##  [1] "AUG" "GGA" "GGG" "AGU" "GGU" "GUU" "UUU" "AGG" "UGG" "UUG" "UGU"
## [12] "GAU" "AUU" "GUG" "AAA" "GAG" "AAG" "AAU" "GUA" "AGA" "GAA" "AUA"
## [23] "UAA"
```

```r
translation <- str_replace_all(translation, c("AUG"="M", "GGA" = "G",  "GGG" = "G",  "AGU" = "S",  "GGU" = "G",  "GUU" = "V",  "UUU" = "F", "AGG" = "R", "UGG" = "W",  "UUG" = "L", "UGU" = "C",  "GAU" = "D", "AUU" = "I",  "GUG" = "V", "AAA"="K",  "GAG" = "E",  "AAG" = "K",  "AAU" = "N",  "GUA" = "V", "AGA" = "R", "GAA" = "E", "AUA" = "M", "UAA" = ""))

translation
```

```
##   [1] "M" "G" "G" "G" "G" "S" "G" "G" "S" "V" "F" "R" "W" "G" "R" "G" "L"
##  [18] "G" "C" "G" "D" "I" "C" "M" "V" "G" "K" "G" "G" "G" "W" "R" "E" "E"
##  [35] "K" "G" "G" "R" "G" "N" "G" "V" "W" "R" "G" "G" "K" "R" "E" "G" "V"
##  [52] "G" "R" "E" "E" "W" "E" "M" "D" "R" "V" "K" "G" "D" "G" "G" "R" "E"
##  [69] "V" "G" "G" "E" "R" "G" "E" "V" "G" "V" "G" "R" "G" "N" "R" "G" "L"
##  [86] "M" "G" "E" "V" "R" "L" "G" "D" "L" "M" "V" "W" "R" "G" "V" "G" "R"
## [103] "G" "S" "K" "R" "G" "W" "W" "G" "K" "G" "G" "V" "G" "G" "E" "G" "R"
## [120] "G" ""
```


__Combining:__

What is our final protein string? `str_flatten` allows us to collapse our individual protein strings into one long string.


```r
translation <- str_flatten(translation)
translation
```

```
## [1] "MGGGGSGGSVFRWGRGLGCGDICMVGKGGGWREEKGGRGNGVWRGGKREGVGREEWEMDRVKGDGGREVGGERGEVGVGRGNRGLMGEVRLGDLMVWRGVGRGSKRGWWGKGGVGGEGRG"
```

We can add our header back using `str_c`, which allows us to combine strings. We can use a space to separate our original strings.


```r
str_c(header, translation, sep = " ")
```

```
## [1] ">DinoDNA from Crichton JURASSIC PARK  p. 103 nt 1-1200 MGGGGSGGSVFRWGRGLGCGDICMVGKGGGWREEKGGRGNGVWRGGKREGVGREEWEMDRVKGDGGREVGGERGEVGVGRGNRGLMGEVRLGDLMVWRGVGRGSKRGWWGKGGVGGEGRG"
```

</br>
</br>



***

##A Real Messy Dataset

I looked for a messy dataset for data cleaning and found it in a blog titled:     
["Biologists: this is why bioinformaticians hate you..."](http://www.opiniomics.org/biologists-this-is-why-bioinformaticians-hate-you/) 
     
     
__Challenge:__      

This is [Wellcome Trust APC dataset](https://github.com/eacton/CAGEF/blob/master/Lesson_4/data/University%20returns_for_figshare_FINAL.xlsx) on the costs of open access publishing by providing article processing charge (APC) data. 

https://figshare.com/articles/Wellcome_Trust_APC_spend_2012_13_data_file/963054     
     
     
The main and common issue with this dataset is that when data entry was done there was no _structured vocabulary_; people could type whatever they wanted into free text answer boxes instead of using dropdown menus with limited options, giving an error if something is formatted incorrectly, or stipulating some rules (ie. must be all lowercase, uppercase, no numbers, spacing, etc). 

I must admit I have been guilty of messing with people who have made databases without rules. For example, giving an emergency contact, there was a line to input 'Relationship', which could easily have been a dropdown menu: 'parent, partner, friend, other'. Instead I was allowed to write in a free text box 'lifelong kindred spirit, soulmate and doggy-daddy'. I don't think anyone here was trying to be a nuisance, this messy data is just a consequence of poor data collection. 

    

</br>


<div style="float:right;margin:0 10px 10px 0" markdown="1">
![](img/yougotthis.jpg){width=200px}
</div>


What I want to know is: 

  1. List 3 problems with this dataset that require data cleaning.
  1. What is the mean cost of publishing for the top 3 most popular publishers? 
  1. What is the number of publications by PLOS One in dataset?                 
  1. Convert sterling to CAD. What is the median cost of publishing with Elsevier in CAD?


The route I suggest to take in answering these question is:

* Inspect your dataset. Are the data types what you expect?
* Identify any immediate problems. (Answer Question #1)
* Clean up column names.
* Data clean the publisher column.
    - convert all entries to lowercase
    - correct typos
    - correct multiple names for a publisher to one name
    - remove newline characters and trailing whitespace
* Answer Questions #2-4



There is a [README](https://github.com/eacton/CAGEF/blob/master/Lesson_4/data/Readme_file.docx) file to go with this spreadsheet if you have questions about the data fields.  

</br>


The blogger's opinion of cleaning this dataset:

_'I now have no hair left; I’ve torn it all out.  My teeth are just stumps from excessive gnashing.  My faith in humanity has been destroyed!'_

Don't get to this point. The dataset doesn't need to be perfect. No datasets are 100% clean. Just do what you gotta do to answer these questions.  

We can talk about how this went at the beginnning of next week's lesson.

***



   
__Resources:__     
<http://stat545.com/block022_regular-expression.html>     
<http://stat545.com/block027_regular-expressions.html>     
<http://stat545.com/block028_character-data.html>     
<http://r4ds.had.co.nz/strings.html>
<http://www.gastonsanchez.com/Handling_and_Processing_Strings_in_R.pdf>     
<http://www.opiniomics.org/biologists-this-is-why-bioinformaticians-hate-you/>     
<https://figshare.com/articles/Wellcome_Trust_APC_spend_2012_13_data_file/963054>     >     
<http://emailregex.com/>     
<https://regex101.com/>     
<https://regexr.com/>     
<https://www.regular-expressions.info/backref.html>     
<https://www.regular-expressions.info/unicode.html>     
<https://www.rstudio.com/wp-content/uploads/2016/09/RegExCheatsheet.pdf>     
<https://simongoring.shinyapps.io/RegularExpressionR/>   


#Post-Lesson Assessment
***

Your feedback is essential to help the next cohort of trainees. Please take a minute to complete the following short survey:
https://www.surveymonkey.com/r/PVHDKDB

</br>

***

</br>

Thanks for coming!!!

![](img/rstudio-bomb.png){width=300px}


