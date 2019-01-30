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

***

__Objective:__ At the end of this session you will be able to use regular expressions to 'clean' your data. 


***

####Packages Used in This Lesson

The following packages are used in this lesson:

`tidyverse` (`stringr`, `dplyr`)     
`mgsub`     

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

Let's start with a simple string. A string can be captured with single or double quotes.


```r
x <- "The quick brown fox is quick."
#is equivalent to
x <- 'The quick brown fox is quick.'
```


In order to understand regular expressions we will use 2 functions:

`writeLines()` is a function that outputs lines of text.

`str_view()` is a function that will highlight the regular expression for our string. 

For example, given our string:

```r
writeLines(text = x)
```

```
## The quick brown fox is quick.
```

```r
str_view(string = x, pattern = "quick")
```

<!--html_preserve--><div id="htmlwidget-2a84db202b1432e9fe03" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-2a84db202b1432e9fe03">{"x":{"html":"<ul>\n  <li>The <span class='match'>quick<\/span> brown fox is quick.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
str_view_all(string = x, pattern = "quick")
```

<!--html_preserve--><div id="htmlwidget-9cdfc84230b5b4c75005" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-9cdfc84230b5b4c75005">{"x":{"html":"<ul>\n  <li>The <span class='match'>quick<\/span> brown fox is <span class='match'>quick<\/span>.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
Note that the output of `writeLines()` does not contain the quotations. You can think of the quotations as a container for our string, rather than a part of the string itself. 

To match the pattern 'quick' `str_view()` will match the first instance of a match in _each_ character string. `str_view_all()` will highlight all matches. This behaviour can be seen more easily with strings:


```r
y <- c("The quick brown fox is quick.", "The quick brown fox is quick.")

writeLines(text = y)
```

```
## The quick brown fox is quick.
## The quick brown fox is quick.
```

```r
str_view(string = y, pattern = "quick")
```

<!--html_preserve--><div id="htmlwidget-738f373b127690ce4dfc" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-738f373b127690ce4dfc">{"x":{"html":"<ul>\n  <li>The <span class='match'>quick<\/span> brown fox is quick.<\/li>\n  <li>The <span class='match'>quick<\/span> brown fox is quick.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
str_view_all(string = y, pattern = "quick")
```

<!--html_preserve--><div id="htmlwidget-6aa47fd8df644199983c" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-6aa47fd8df644199983c">{"x":{"html":"<ul>\n  <li>The <span class='match'>quick<\/span> brown fox is <span class='match'>quick<\/span>.<\/li>\n  <li>The <span class='match'>quick<\/span> brown fox is <span class='match'>quick<\/span>.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
</br>


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


Examples:


```r
a <- "Joe paid $2.99 for chips."

#word characters (letters + digits)
str_view_all(a, "[[:alnum:]]")
```

<!--html_preserve--><div id="htmlwidget-ee1ddfa53ce032e4ed0f" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-ee1ddfa53ce032e4ed0f">{"x":{"html":"<ul>\n  <li><span class='match'>J<\/span><span class='match'>o<\/span><span class='match'>e<\/span> <span class='match'>p<\/span><span class='match'>a<\/span><span class='match'>i<\/span><span class='match'>d<\/span> $<span class='match'>2<\/span>.<span class='match'>9<\/span><span class='match'>9<\/span> <span class='match'>f<\/span><span class='match'>o<\/span><span class='match'>r<\/span> <span class='match'>c<\/span><span class='match'>h<\/span><span class='match'>i<\/span><span class='match'>p<\/span><span class='match'>s<\/span>.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
#digits
str_view_all(a, "\\d")
```

<!--html_preserve--><div id="htmlwidget-62405ba829c2d61d5dd9" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-62405ba829c2d61d5dd9">{"x":{"html":"<ul>\n  <li>Joe paid $<span class='match'>2<\/span>.<span class='match'>9<\/span><span class='match'>9<\/span> for chips.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
#alphabetical characters
str_view_all(a, "[A-z]")
```

<!--html_preserve--><div id="htmlwidget-dd843df19d5d298d6bde" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-dd843df19d5d298d6bde">{"x":{"html":"<ul>\n  <li><span class='match'>J<\/span><span class='match'>o<\/span><span class='match'>e<\/span> <span class='match'>p<\/span><span class='match'>a<\/span><span class='match'>i<\/span><span class='match'>d<\/span> $2.99 <span class='match'>f<\/span><span class='match'>o<\/span><span class='match'>r<\/span> <span class='match'>c<\/span><span class='match'>h<\/span><span class='match'>i<\/span><span class='match'>p<\/span><span class='match'>s<\/span>.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
#space
str_view_all(a, "\\s")
```

<!--html_preserve--><div id="htmlwidget-331dc64d7f1ef2604dab" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-331dc64d7f1ef2604dab">{"x":{"html":"<ul>\n  <li>Joe<span class='match'> <\/span>paid<span class='match'> <\/span>$2.99<span class='match'> <\/span>for<span class='match'> <\/span>chips.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
#not word characters
str_view_all(a, "[^A-z0-9]")
```

<!--html_preserve--><div id="htmlwidget-dba58ebfb42bea591259" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-dba58ebfb42bea591259">{"x":{"html":"<ul>\n  <li>Joe<span class='match'> <\/span>paid<span class='match'> <\/span><span class='match'>$<\/span>2<span class='match'>.<\/span>99<span class='match'> <\/span>for<span class='match'> <\/span>chips<span class='match'>.<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
#not spaces
str_view_all(a, "\\S")
```

<!--html_preserve--><div id="htmlwidget-d2315b3846fb810c5e4c" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-d2315b3846fb810c5e4c">{"x":{"html":"<ul>\n  <li><span class='match'>J<\/span><span class='match'>o<\/span><span class='match'>e<\/span> <span class='match'>p<\/span><span class='match'>a<\/span><span class='match'>i<\/span><span class='match'>d<\/span> <span class='match'>$<\/span><span class='match'>2<\/span><span class='match'>.<\/span><span class='match'>9<\/span><span class='match'>9<\/span> <span class='match'>f<\/span><span class='match'>o<\/span><span class='match'>r<\/span> <span class='match'>c<\/span><span class='match'>h<\/span><span class='match'>i<\/span><span class='match'>p<\/span><span class='match'>s<\/span><span class='match'>.<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->





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

Examples:


```r
#0 or 1
str_view_all(a, "9?")
```

<!--html_preserve--><div id="htmlwidget-bb0dd680901c369c0e2c" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-bb0dd680901c369c0e2c">{"x":{"html":"<ul>\n  <li><span class='match'><\/span>J<span class='match'><\/span>o<span class='match'><\/span>e<span class='match'><\/span> <span class='match'><\/span>p<span class='match'><\/span>a<span class='match'><\/span>i<span class='match'><\/span>d<span class='match'><\/span> <span class='match'><\/span>$<span class='match'><\/span>2<span class='match'><\/span>.<span class='match'>9<\/span><span class='match'>9<\/span><span class='match'><\/span> <span class='match'><\/span>f<span class='match'><\/span>o<span class='match'><\/span>r<span class='match'><\/span> <span class='match'><\/span>c<span class='match'><\/span>h<span class='match'><\/span>i<span class='match'><\/span>p<span class='match'><\/span>s<span class='match'><\/span>.<span class='match'><\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
#0 or more
str_view_all(a, "9*")
```

<!--html_preserve--><div id="htmlwidget-1e0809edf2f09f8e291e" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-1e0809edf2f09f8e291e">{"x":{"html":"<ul>\n  <li><span class='match'><\/span>J<span class='match'><\/span>o<span class='match'><\/span>e<span class='match'><\/span> <span class='match'><\/span>p<span class='match'><\/span>a<span class='match'><\/span>i<span class='match'><\/span>d<span class='match'><\/span> <span class='match'><\/span>$<span class='match'><\/span>2<span class='match'><\/span>.<span class='match'>99<\/span><span class='match'><\/span> <span class='match'><\/span>f<span class='match'><\/span>o<span class='match'><\/span>r<span class='match'><\/span> <span class='match'><\/span>c<span class='match'><\/span>h<span class='match'><\/span>i<span class='match'><\/span>p<span class='match'><\/span>s<span class='match'><\/span>.<span class='match'><\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
#1 or more
str_view_all(a, "9+")
```

<!--html_preserve--><div id="htmlwidget-0e503b810fe9abe6064f" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-0e503b810fe9abe6064f">{"x":{"html":"<ul>\n  <li>Joe paid $2.<span class='match'>99<\/span> for chips.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
#exactly n
str_view(a, "9{1}")
```

<!--html_preserve--><div id="htmlwidget-c543e3e3c2fad34c5c8e" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-c543e3e3c2fad34c5c8e">{"x":{"html":"<ul>\n  <li>Joe paid $2.<span class='match'>9<\/span>9 for chips.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
#at least 
str_view(a, "9{1,}")
```

<!--html_preserve--><div id="htmlwidget-5d535c40ff4fd2a6e8c4" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-5d535c40ff4fd2a6e8c4">{"x":{"html":"<ul>\n  <li>Joe paid $2.<span class='match'>99<\/span> for chips.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->


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
   <td style="text-align:left;width: 40em; font-style: italic;"> grouping - used for [backreferencing](https://www.regular-expressions.info/backref.html) or [look arounds](https://stringr.tidyverse.org/articles/regular-expressions.html) </td>
  </tr>
</tbody>
</table>


Examples:


```r
#or
str_view_all(a, "(o|i)")
```

<!--html_preserve--><div id="htmlwidget-02acf3f65d087bd9ad32" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-02acf3f65d087bd9ad32">{"x":{"html":"<ul>\n  <li>J<span class='match'>o<\/span>e pa<span class='match'>i<\/span>d $2.99 f<span class='match'>o<\/span>r ch<span class='match'>i<\/span>ps.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
#any single character
str_view_all(a, "f.r")
```

<!--html_preserve--><div id="htmlwidget-72bc52d7aa1136fe4207" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-72bc52d7aa1136fe4207">{"x":{"html":"<ul>\n  <li>Joe paid $2.99 <span class='match'>for<\/span> chips.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
#any characters inside the brackets
str_view_all(a, "[aps]")
```

<!--html_preserve--><div id="htmlwidget-47e929bbc9f5b882d901" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-47e929bbc9f5b882d901">{"x":{"html":"<ul>\n  <li>Joe <span class='match'>p<\/span><span class='match'>a<\/span>id $2.99 for chi<span class='match'>p<\/span><span class='match'>s<\/span>.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
#any characters that are not found inside the brackets
str_view_all(a, "[^a-e]")
```

<!--html_preserve--><div id="htmlwidget-798bd61574a653c1ddf5" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-798bd61574a653c1ddf5">{"x":{"html":"<ul>\n  <li><span class='match'>J<\/span><span class='match'>o<\/span>e<span class='match'> <\/span><span class='match'>p<\/span>a<span class='match'>i<\/span>d<span class='match'> <\/span><span class='match'>$<\/span><span class='match'>2<\/span><span class='match'>.<\/span><span class='match'>9<\/span><span class='match'>9<\/span><span class='match'> <\/span><span class='match'>f<\/span><span class='match'>o<\/span><span class='match'>r<\/span><span class='match'> <\/span>c<span class='match'>h<\/span><span class='match'>i<\/span><span class='match'>p<\/span><span class='match'>s<\/span><span class='match'>.<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
#grouping for a 'positive look-ahead'
str_view_all(a, "\\d(?=\\.)")
```

<!--html_preserve--><div id="htmlwidget-ffbb010bcae26d69b255" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-ffbb010bcae26d69b255">{"x":{"html":"<ul>\n  <li>Joe paid $<span class='match'>2<\/span>.99 for chips.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
#grouping for a 'positive look-behind'
str_view_all(a, "(?<=\\$)\\d")
```

<!--html_preserve--><div id="htmlwidget-ef9f356e80c1bc2a950e" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-ef9f356e80c1bc2a950e">{"x":{"html":"<ul>\n  <li>Joe paid $<span class='match'>2<\/span>.99 for chips.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->



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

Examples:


```r
#empty string at either edge of a word boundary
str_view_all(y, "\\b")
```

<!--html_preserve--><div id="htmlwidget-2291aeb5fa985cc01493" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-2291aeb5fa985cc01493">{"x":{"html":"<ul>\n  <li><span class='match'><\/span>The<span class='match'><\/span> <span class='match'><\/span>quick<span class='match'><\/span> <span class='match'><\/span>brown<span class='match'><\/span> <span class='match'><\/span>fox<span class='match'><\/span> <span class='match'><\/span>is<span class='match'><\/span> <span class='match'><\/span>quick<span class='match'><\/span>.<\/li>\n  <li><span class='match'><\/span>The<span class='match'><\/span> <span class='match'><\/span>quick<span class='match'><\/span> <span class='match'><\/span>brown<span class='match'><\/span> <span class='match'><\/span>fox<span class='match'><\/span> <span class='match'><\/span>is<span class='match'><\/span> <span class='match'><\/span>quick<span class='match'><\/span>.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
#start of string
str_view_all(y, "^\\w+\\b")
```

<!--html_preserve--><div id="htmlwidget-56caad8c7ea9555e8cf9" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-56caad8c7ea9555e8cf9">{"x":{"html":"<ul>\n  <li><span class='match'>The<\/span> quick brown fox is quick.<\/li>\n  <li><span class='match'>The<\/span> quick brown fox is quick.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
#end of string
str_view_all(y, "\\b\\w+[[:punct:]]$")
```

<!--html_preserve--><div id="htmlwidget-4319a7029a82cc5d5c36" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-4319a7029a82cc5d5c36">{"x":{"html":"<ul>\n  <li>The quick brown fox is <span class='match'>quick.<\/span><\/li>\n  <li>The quick brown fox is <span class='match'>quick.<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->


###Escape characters

Sometimes a meta-character is just a character. _Escaping_ allows you to use a character 'as is' rather than its special function. In R, y gets evaluated as a string before a regular expression, and a backslash is used to escape the string - so you really need 2 backslashes to escape, say, a '$' sign (`"\\\$"`). 

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

Examples:


```r
#escaping meta characters
str_view_all(a, "\\$|\\.")

b <- "'Joe paid $2.99 for chips.'"

writeLines(b)
#escaping quotations
str_view_all(b, "\'")

#escaping escape characters
c <-  "\escape this!\'"
```

```
## Error: '\e' is an unrecognized escape in character string starting ""\e"
```



```r
c <-  "\\escape this!\\"

writeLines(c)
```

```
## \escape this!\
```

```r
#remember to escape the string as well
str_view_all(c, "\\\\")
```

<!--html_preserve--><div id="htmlwidget-68b5c7775c5d5644603c" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-68b5c7775c5d5644603c">{"x":{"html":"<ul>\n  <li><span class='match'>\\<\/span>escape this!<span class='match'>\\<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->


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

To replace one pattern or multiple patterns with one replacement, `str_replace_all` can be used.

However, to replace multiple patterns at once with multiple replacements, we need another package. `str_replace_all` works iteratively, which means a replacement can be replaced. `mgsub` from the `mgsub` package averts this behaviour by performing simultaneous replacement.


```r
#all G replaced with C - one pattern, one replacement
str_replace_all(dna, pattern = "G", replacement = "C")
```

```
## [1] "CCCTTCCTCCCCTTTTTCCATACCCTCCCCCCCCCTCACCACCATCACAAAAATCCACCCCCTCCCCAAACCCCACACCACTATAAACATACCACCCCTTTCCCCCTCCAACCTCCCTCCTCTTCCCACCCTCCCCCTTACCCCATACCTCTCCCCCTTTCTCCCTTCCCCAACCCTCCCTCCTCACCCTCTACCTATCTCACTTCCCTCTACCTCCTTCCCTCCAACCTCCCCTCTCTCCCCTTCACCCCCACCCCTCCCCCTTATCCCCTAACTATCCTCTTCACTCCAACCCCCTAAACTACCACACCTCCCCCCACCCCTCTCCCTCATTTTCCCCCACCACCCCTTTCCCTCCACATCCCCCTCTCCCTTCCCCTATTCCCAATCTTCCACCCCCTCCCTCAACCCTTCCTCACTCCAAACCTTTCCCCCACAACCACCCCATTATCCCCCCCATCCCCCCCCACCCCCTCCCCTCCCCTTCCCCACCCCACCCTCCATCCCCTTCCCCATTATCATTCTTCTCCCTTCCCCCCCCCCCCCTTCCACCCCATCCTCTCCACCCACCTACATCACCACCATCACCCACACCTTCAACCCCTCTTACCACCCTAACTTCCATCACTCCACCCCTCATCCTCACCCCCATTTATCCCCCACATCCACCCCTTCCTCCCCTTTTTCCATACCCTCCCCCCCCCTCACCACCATCACAAACAACTCACACCTCCCCAAACCCCACACCACTATAAACATACCACCCCTTTCCCCCTCCAACCCCTCTCCTCTTCCCACCCTCCCCCTTACCCCATACCTCTCCCCCTTTCTCCCTTCCCCCTTTCTCAATCCTCACCCTCTACCTATCTCACTTCCCTCTACCTCCTTCCCTCCAACCTCACCAACCCCCCCTTCACCCCCACCCCTCCCCCTTATCCCCTAACTATCCTCTTCACTCCAACACCACTTAACCCCTTCCCATCCATTCTACCCCCCCCCCTATACCTTCTCTCCCTCCCCCCCCTCCATCCACCCCCCCCACCTCCACCTCAATCCAACCCCCCCCCACCTCCCTAACCCCCAACAATTCCACCCAATCAATTCTTCCCCACAACTCTCAATCCCCAAACCAACCCTTCCCCATCCCCTCCCCCATCTCCACCACCCCCACCCCCCCCATCTCCCCCACCCTTCCCTCCT"
```

```r
#all AGT replaced with C - multiple patterns, one replacement
str_replace_all(dna, pattern = "[AGT]", replacement = "C")
```

```
## [1] "CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC"
```

```r
#multiple patterns with multiple replacement works iteratively, G is replaced with C, but then ALL C get replaced with G, as such, our replacement was replaced
str_replace_all(dna, c("G" = "C", "C" = "G", "A" = "U", "T" = "A"))
```

```
## [1] "GGGAAGGAGGGGAAAAAGGUAUGGGAGGGGGGGGGAGUGGUGGUAGUGUUUUUAGGUGGGGGAGGGGUUUGGGGUGUGGUGAUAUUUGUAUGGUGGGGAAAGGGGGAGGUUGGAGGGAGGAGAAGGGUGGGAGGGGGAAUGGGGUAUGGAGAGGGGGAAAGAGGGAAGGGGUUGGGAGGGAGGAGUGGGAGAUGGAUAGAGUGAAGGGAGAUGGAGGAAGGGAGGUUGGAGGGGAGAGAGGGGAAGUGGGGGUGGGGAGGGGGAAUAGGGGAUUGAUAGGAGAAGUGAGGUUGGGGGAUUUGAUGGUGUGGAGGGGGGUGGGGAGAGGGAGUAAAAGGGGGUGGUGGGGAAAGGGAGGUGUAGGGGGAGAGGGAAGGGGAUAAGGGUUAGAAGGUGGGGGAGGGAGUUGGGAAGGAGUGAGGUUUGGAAAGGGGGUGUUGGUGGGGUAAUAGGGGGGGUAGGGGGGGGUGGGGGAGGGGAGGGGAAGGGGUGGGGUGGGAGGUAGGGGAAGGGGUAAUAGUAAGAAGAGGGAAGGGGGGGGGGGGGAAGGUGGGGUAGGAGAGGUGGGUGGAUGUAGUGGUGGUAGUGGGUGUGGAAGUUGGGGAGAAUGGUGGGAUUGAAGGUAGUGAGGUGGGGAGUAGGAGUGGGGGUAAAUAGGGGGUGUAGGUGGGGAAGGAGGGGAAAAAGGUAUGGGAGGGGGGGGGAGUGGUGGUAGUGUUUGUUGAGUGUGGAGGGGUUUGGGGUGUGGUGAUAUUUGUAUGGUGGGGAAAGGGGGAGGUUGGGGAGAGGAGAAGGGUGGGAGGGGGAAUGGGGUAUGGAGAGGGGGAAAGAGGGAAGGGGGAAAGAGUUAGGAGUGGGAGAUGGAUAGAGUGAAGGGAGAUGGAGGAAGGGAGGUUGGAGUGGUUGGGGGGGAAGUGGGGGUGGGGAGGGGGAAUAGGGGAUUGAUAGGAGAAGUGAGGUUGUGGUGAAUUGGGGAAGGGUAGGUAAGAUGGGGGGGGGGAUAUGGAAGAGAGGGAGGGGGGGGAGGUAGGUGGGGGGGGUGGAGGUGGAGUUAGGUUGGGGGGGGGUGGAGGGAUUGGGGGUUGUUAAGGUGGGUUAGUUAAGAAGGGGUGUUGAGAGUUAGGGGUUUGGUUGGGAAGGGGUAGGGGAGGGGGUAGAGGUGGUGGGGGUGGGGGGGGUAGAGGGGGUGGGAAGGGAGGA"
```

```r
library(mgsub)
#multiple patterns with multiple replacements working simultaneously - safe!
mrna <- mgsub::mgsub(dna, pattern = c("G", "C", "A", "T"), replacement = c("C", "G", "U", "A"))

mrna
```

```
## [1] "CGCAACGACCGCAAAAAGGUAUCCGAGGCGGGGGGACUGCUCGUAGUGUUUUUAGCUGCGCCACCGCUUUGGGCUGUCCUGAUAUUUCUAUGGUCCGCAAAGGGGGACCUUCGAGGGAGCACAAGGCUGGGACGGCGAAUGGCCUAUGGACAGGCGGAAAGAGGGAAGCCCUUCGCACCGACGAGUGCGACAUGGAUAGAGUCAAGCCACAUCCAGCAAGCGAGGUUCGACCCGACACACGGCAAGUCGGGCUGGCGACGCGGAAUAGGCCAUUGAUAGCAGAACUCAGGUUGGGCCAUUUCAUCCUGUCCACGGCCGUCGCGAGACCCAGUAAAAGCCGCUCCUGGCGAAAGCGACCUCUAGCCGGACAGCGAACGCCAUAAGCCUUAGAACGUGCGGGAGCGAGUUCGGAAGCAGUGAGGUUUGCAAAGCCGCUCUUCGUCCGGUAAUAGCGGCCGUACCGCCGGCUGCGCGACCCGACCGCAAGCGCUGCGCUCCGACCUACCGGAAGGGGUAAUACUAAGAAGAGCGAAGGCCGCCGGGCGCAACGUCCGGUACGACAGGUCCGUCCAUCUACUGCUGGUAGUCCCUGUCGAAGUUGCCGAGAAUGGUCGGAUUGAAGCUAGUGACCUGGCGACUAGCAGUGCCGCUAAAUACGGCGUGUACCUGCGCAACGACCGCAAAAAGGUAUCCGAGGCGGGGGGACUGCUCGUAGUGUUUGUUCAGUCUCCACCGCUUUGGGCUGUCCUGAUAUUUCUAUGGUCCGCAAAGGGGGACCUUCGCGAGAGGACAAGGCUGGGACGGCGAAUGGCCUAUGGACAGGCGGAAAGAGGGAAGCCCGAAAGAGUUACGAGUGCGACAUCCAUAGAGUCAAGCCACAUCCAGCAAGCGAGGUUCGACUGCUUGGGGGGCAAGUCGGGCUGGCGACGCGGAAUAGGCCAUUGAUAGCAGAACUCAGGUUGUGCUGAAUUGCCCAACCGUACCUAACAUCCGCGGCGGGAUAUGGAACAGACGGAGGGGCGCCACGUACCUCGGCCCGGUGGAGCUGGACUUACCUUCGGCCGCCGUGGAGCGAUUGCCGGUUCUUAACCUCGGUUAGUUAAGAACGCCUCUUGACACUUACGCGUUUGGUUGGGAACCGGUAGCGCAGGCGGUAGAGGUCGUCGGCGUGCGCCGCGUAGAGCCCGUCGCAACCCAGGA"
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
## [1] 9
```



To get the position of a possible start codon we can use `str_locate` which will return the indices of where the start and end of our substring occurs (`str_locate_all` can be used to find the all possible locations).



```r
str_locate(mrna, "AUG")
```

```
##      start end
## [1,]    90  92
```


__Splitting:__

Let's split this string into substrings of codons, starting at the position of our start codon. We have the position of our start codon from `str_locate`. We can use `str_sub` to subset the string by position (we will just go to the end of the string for now).


```r
str_sub(mrna, 90, 1200)
```

```
## [1] "AUGGUCCGCAAAGGGGGACCUUCGAGGGAGCACAAGGCUGGGACGGCGAAUGGCCUAUGGACAGGCGGAAAGAGGGAAGCCCUUCGCACCGACGAGUGCGACAUGGAUAGAGUCAAGCCACAUCCAGCAAGCGAGGUUCGACCCGACACACGGCAAGUCGGGCUGGCGACGCGGAAUAGGCCAUUGAUAGCAGAACUCAGGUUGGGCCAUUUCAUCCUGUCCACGGCCGUCGCGAGACCCAGUAAAAGCCGCUCCUGGCGAAAGCGACCUCUAGCCGGACAGCGAACGCCAUAAGCCUUAGAACGUGCGGGAGCGAGUUCGGAAGCAGUGAGGUUUGCAAAGCCGCUCUUCGUCCGGUAAUAGCGGCCGUACCGCCGGCUGCGCGACCCGACCGCAAGCGCUGCGCUCCGACCUACCGGAAGGGGUAAUACUAAGAAGAGCGAAGGCCGCCGGGCGCAACGUCCGGUACGACAGGUCCGUCCAUCUACUGCUGGUAGUCCCUGUCGAAGUUGCCGAGAAUGGUCGGAUUGAAGCUAGUGACCUGGCGACUAGCAGUGCCGCUAAAUACGGCGUGUACCUGCGCAACGACCGCAAAAAGGUAUCCGAGGCGGGGGGACUGCUCGUAGUGUUUGUUCAGUCUCCACCGCUUUGGGCUGUCCUGAUAUUUCUAUGGUCCGCAAAGGGGGACCUUCGCGAGAGGACAAGGCUGGGACGGCGAAUGGCCUAUGGACAGGCGGAAAGAGGGAAGCCCGAAAGAGUUACGAGUGCGACAUCCAUAGAGUCAAGCCACAUCCAGCAAGCGAGGUUCGACUGCUUGGGGGGCAAGUCGGGCUGGCGACGCGGAAUAGGCCAUUGAUAGCAGAACUCAGGUUGUGCUGAAUUGCCCAACCGUACCUAACAUCCGCGGCGGGAUAUGGAACAGACGGAGGGGCGCCACGUACCUCGGCCCGGUGGAGCUGGACUUACCUUCGGCCGCCGUGGAGCGAUUGCCGGUUCUUAACCUCGGUUAGUUAAGAACGCCUCUUGACACUUACGCGUUUGGUUGGGAACCGGUAGCGCAGGCGGUAGAGGUCGUCGGCGUGCGCCGCGUAGAGCCCGUCGCAACCCAGGA"
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
##   [1] "AUG" "GUC" "CGC" "AAA" "GGG" "GGA" "CCU" "UCG" "AGG" "GAG" "CAC"
##  [12] "AAG" "GCU" "GGG" "ACG" "GCG" "AAU" "GGC" "CUA" "UGG" "ACA" "GGC"
##  [23] "GGA" "AAG" "AGG" "GAA" "GCC" "CUU" "CGC" "ACC" "GAC" "GAG" "UGC"
##  [34] "GAC" "AUG" "GAU" "AGA" "GUC" "AAG" "CCA" "CAU" "CCA" "GCA" "AGC"
##  [45] "GAG" "GUU" "CGA" "CCC" "GAC" "ACA" "CGG" "CAA" "GUC" "GGG" "CUG"
##  [56] "GCG" "ACG" "CGG" "AAU" "AGG" "CCA" "UUG" "AUA" "GCA" "GAA" "CUC"
##  [67] "AGG" "UUG" "GGC" "CAU" "UUC" "AUC" "CUG" "UCC" "ACG" "GCC" "GUC"
##  [78] "GCG" "AGA" "CCC" "AGU" "AAA" "AGC" "CGC" "UCC" "UGG" "CGA" "AAG"
##  [89] "CGA" "CCU" "CUA" "GCC" "GGA" "CAG" "CGA" "ACG" "CCA" "UAA" "GCC"
## [100] "UUA" "GAA" "CGU" "GCG" "GGA" "GCG" "AGU" "UCG" "GAA" "GCA" "GUG"
## [111] "AGG" "UUU" "GCA" "AAG" "CCG" "CUC" "UUC" "GUC" "CGG" "UAA" "UAG"
## [122] "CGG" "CCG" "UAC" "CGC" "CGG" "CUG" "CGC" "GAC" "CCG" "ACC" "GCA"
## [133] "AGC" "GCU" "GCG" "CUC" "CGA" "CCU" "ACC" "GGA" "AGG" "GGU" "AAU"
## [144] "ACU" "AAG" "AAG" "AGC" "GAA" "GGC" "CGC" "CGG" "GCG" "CAA" "CGU"
## [155] "CCG" "GUA" "CGA" "CAG" "GUC" "CGU" "CCA" "UCU" "ACU" "GCU" "GGU"
## [166] "AGU" "CCC" "UGU" "CGA" "AGU" "UGC" "CGA" "GAA" "UGG" "UCG" "GAU"
## [177] "UGA" "AGC" "UAG" "UGA" "CCU" "GGC" "GAC" "UAG" "CAG" "UGC" "CGC"
## [188] "UAA" "AUA" "CGG" "CGU" "GUA" "CCU" "GCG" "CAA" "CGA" "CCG" "CAA"
## [199] "AAA" "GGU" "AUC" "CGA" "GGC" "GGG" "GGG" "ACU" "GCU" "CGU" "AGU"
## [210] "GUU" "UGU" "UCA" "GUC" "UCC" "ACC" "GCU" "UUG" "GGC" "UGU" "CCU"
## [221] "GAU" "AUU" "UCU" "AUG" "GUC" "CGC" "AAA" "GGG" "GGA" "CCU" "UCG"
## [232] "CGA" "GAG" "GAC" "AAG" "GCU" "GGG" "ACG" "GCG" "AAU" "GGC" "CUA"
## [243] "UGG" "ACA" "GGC" "GGA" "AAG" "AGG" "GAA" "GCC" "CGA" "AAG" "AGU"
## [254] "UAC" "GAG" "UGC" "GAC" "AUC" "CAU" "AGA" "GUC" "AAG" "CCA" "CAU"
## [265] "CCA" "GCA" "AGC" "GAG" "GUU" "CGA" "CUG" "CUU" "GGG" "GGG" "CAA"
## [276] "GUC" "GGG" "CUG" "GCG" "ACG" "CGG" "AAU" "AGG" "CCA" "UUG" "AUA"
## [287] "GCA" "GAA" "CUC" "AGG" "UUG" "UGC" "UGA" "AUU" "GCC" "CAA" "CCG"
## [298] "UAC" "CUA" "ACA" "UCC" "GCG" "GCG" "GGA" "UAU" "GGA" "ACA" "GAC"
## [309] "GGA" "GGG" "GCG" "CCA" "CGU" "ACC" "UCG" "GCC" "CGG" "UGG" "AGC"
## [320] "UGG" "ACU" "UAC" "CUU" "CGG" "CCG" "CCG" "UGG" "AGC" "GAU" "UGC"
## [331] "CGG" "UUC" "UUA" "ACC" "UCG" "GUU" "AGU" "UAA" "GAA" "CGC" "CUC"
## [342] "UUG" "ACA" "CUU" "ACG" "CGU" "UUG" "GUU" "GGG" "AAC" "CGG" "UAG"
## [353] "CGC" "AGG" "CGG" "UAG" "AGG" "UCG" "UCG" "GCG" "UGC" "GCC" "GCG"
## [364] "UAG" "AGC" "CCG" "UCG" "CAA" "CCC" "AGG"
```
The codons are extracted into a list, but we can get our character substrings using `unlist`. 


```r
codons <- unlist(str_extract_all(mrna, "..."))
```

We now have a vector with 370 codons.

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
##  [89] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
## [100] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [111] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE
## [122] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [133] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [144] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [155] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [166] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [177]  TRUE FALSE  TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
## [188]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [199] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [210] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [221] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [232] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [243] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [254] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [265] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [276] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [287] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
## [298] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [309] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [320] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [331] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
## [342] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
## [353] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [364]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
```
Looks like we have many matches. We can subset the codons using `str_detect` (instances where the presence of a stop codon is equal to TRUE) to see which stop codons are represented. We can use the `which` function to find the which indices the stop codons are positioned at.


```r
which(str_detect(codons, "(UAG)|(UGA)|(UAA)") == TRUE)
```

```
##  [1]  98 120 121 177 179 180 184 188 293 338 352 356 364
```

Let's subset our codon strings to end at the first stop codon. 


```r
translation <- codons[1:98]

#equivalent to 
translation <- codons[1:which(str_detect(codons, "(UAG)|(UGA)|(UAA)") == TRUE)[1]]
```



__More Replacing:__

After finding our unique codons, we can translate codons into their respective proteins by using `mgsub` using multiple patterns and replacements as before.



```r
unique(translation)
```

```
##  [1] "AUG" "GUC" "CGC" "AAA" "GGG" "GGA" "CCU" "UCG" "AGG" "GAG" "CAC"
## [12] "AAG" "GCU" "ACG" "GCG" "AAU" "GGC" "CUA" "UGG" "ACA" "GAA" "GCC"
## [23] "CUU" "ACC" "GAC" "UGC" "GAU" "AGA" "CCA" "CAU" "GCA" "AGC" "GUU"
## [34] "CGA" "CCC" "CGG" "CAA" "CUG" "UUG" "AUA" "CUC" "UUC" "AUC" "UCC"
## [45] "AGU" "CAG" "UAA"
```

```r
translation <- mgsub::mgsub(translation, pattern = c("AUG", "GUC", "CGC", "AAA", "GGG", "GGA", "CCU", "UCG", "AGG", "GAG", "CAC", "AAG", "GCU", "ACG", "GCG", "AAU", "GGC", "CUA", "UGG", "ACA", "GAA", "GCC", "CUU", "ACC", "GAC", "UGC", "GAU", "AGA", "CCA", "CAU", "GCA", "AGC", "GUU", "CGA", "CCC", "CGG", "CAA", "CUG", "UUG", "AUA", "CUC", "UUC", "AUC", "UCC", "AGU", "CAG", "UAA"), replacement = c("M", "V", "R", "K", "G", "G", "P", "S", "R", "E", "H", "K", "A", "T", "A", "N", "G", "L", "W", "T", "E", "A", "L", "T", "D", "C", "D", "R", "P", "H", "A", "S", "V", "R", "P", "R", "Q", "L", "L", "I", "L", "F", "I", "S", "S", "Q", ""))

translation
```

```
##  [1] "M" "V" "R" "K" "G" "G" "P" "S" "R" "E" "H" "K" "A" "G" "T" "A" "N"
## [18] "G" "L" "W" "T" "G" "G" "K" "R" "E" "A" "L" "R" "T" "D" "E" "C" "D"
## [35] "M" "D" "R" "V" "K" "P" "H" "P" "A" "S" "E" "V" "R" "P" "D" "T" "R"
## [52] "Q" "V" "G" "L" "A" "T" "R" "N" "R" "P" "L" "I" "A" "E" "L" "R" "L"
## [69] "G" "H" "F" "I" "L" "S" "T" "A" "V" "A" "R" "P" "S" "K" "S" "R" "S"
## [86] "W" "R" "K" "R" "P" "L" "A" "G" "Q" "R" "T" "P" ""
```


__Combining:__

What is our final protein string? `str_flatten` allows us to collapse our individual protein strings into one long string.


```r
translation <- str_flatten(translation)
translation
```

```
## [1] "MVRKGGPSREHKAGTANGLWTGGKREALRTDECDMDRVKPHPASEVRPDTRQVGLATRNRPLIAELRLGHFILSTAVARPSKSRSWRKRPLAGQRTP"
```

We can add our header back using `str_c`, which allows us to combine strings. We can use a space to separate our original strings.


```r
str_c(header, translation, sep = " ")
```

```
## [1] ">DinoDNA from Crichton JURASSIC PARK  p. 103 nt 1-1200 MVRKGGPSREHKAGTANGLWTGGKREALRTDECDMDRVKPHPASEVRPDTRQVGLATRNRPLIAELRLGHFILSTAVARPSKSRSWRKRPLAGQRTP"
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
  1. What is the number of publications by PLOS One in dataset?                 
  1. What is the median cost of publishing with Elsevier?


The route I suggest to take in answering these question is:

* Inspect your dataset. Are the data types what you expect?
* Identify any immediate problems. (Answer Question #1)
* Clean up column names.
* Data clean the publisher column for publications from Elsevier and PLOS One by:
    - converting all entries to lowercase
    - correcting typos
    - correcting multiple names for a publisher to one name
    - removing newline characters and trailing whitespace
* Answer Questions #2-3



There is a [README](https://github.com/eacton/CAGEF/blob/master/Lesson_4/data/Readme_file.docx) file to go with this spreadsheet if you have questions about the data fields.  

</br>

The dataset doesn't need to be perfect. No datasets are 100% clean. Just do what you gotta do to answer these questions.  

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
<https://github.com/bmewing/mgsub>     



***

</br>

Thanks for coming!!!

![](img/rstudio-bomb.png){width=300px}


