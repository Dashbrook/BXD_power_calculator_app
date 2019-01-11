---
title: 'Simple graphical interface for calculating power to detect a QTL in a two parent recombinent inbred population, such as the BXD'
tags:
  - R
  - Genetics
  - BXD recombinant inbred
  - Mouse
  - QTL studies
authors:
  - name: David G. Ashbrook
    orcid: 0000-0002-7397-8910
    affiliation: "1" # (Multiple affiliations must be quoted)
  - name: Danny Arends ## Check if middle name?
    orcid: 0000-0001-8738-0162 
    affiliation: 2
affiliations:
 - name: Department of Genetics, Genomics and Informatics, University of Tennessee Health Science Center, USA
   index: 1
 - name: Humboldt University, Berlin, Germany
   index: 2
date: 10 January 2019
bibliography: paper.bib
---

# Summary

Quantitative trait loci (QTL) studies are often carried out in two parent recombinant inbred (RI) populations
such as the BXD mouse family [@Taylor1973;@Andreux2012c;@Williams2016;@Williams2017a;@Li2018]. Although calculations
have been available for many years to calculate power to detect effects in these populations [REFS], there is 
not currently a quick, easy, way for bench scientists to visualise the power to detect a loci under different 
experimental conditions. The power to detect a loci depends on several parameters including; the heritability 
of the trait, the locus effect size, the number of  strain being used, and the number of within strain biological 
replicates. The first two of these (heritability and locus effect size) are features of the trait, which have to
be estimated beforehand, whereas number of strains and number of biological replicates are decided by the 
experimenter. This app seeks to help an experimenter decide how many strains and biological replicates are 
necessary to have sufficient power to detect a QTL for a trait of interest.

Our app queries a dataframe build using a highly cited and commonly used method to calculate QTL power 
[REFs, R/QTL, R/QTL design], the results of which are then presented to the user graphically. This allows the
user to compare their power to detect a loci of a given size, given other common conditions. It is presented 
through a ShinyApp web interface (https://dashbrook1.shinyapps.io/bxd_power_calculator_app/). We provide two
outputs for this. The first is a figure showing the users power to detect a loci with different numbers of 
strains, given an input heritability, effect size, and range of biological replicates (Figure 1). The second is a table,
allowing the user to determine e.g. the minimum number of animals needed to achieve a certain power to detect
a QTL (Figure 2). 

We also provide a graphic of the standard error density around the mean trait value for the two homzygotes 
at a locus of interest. This gives a visual representation of what the overall distribution of trait values
is expected to look like, given the locus effect size and the number of biological replicates. 

This app will be useful at several stages. Firstly, when applying for grants to use RI strains, the
user will be able to determine how many animals should be used, and provide a simple figure which can
be presented to reviewers. Secondly, it can be used post-hoc, after an experiment has been carried out
to determine what the probability was to detect a loci, given the actual values known after the fact 
(e.g. heritability of the trait, and locus effect size). 

Early prototypes of the app have been used within the department for grant applications, and is being
used in several current projects which will result in publications. 


# Mathematics

Single dollars ($) are required for inline mathematics e.g. $f(x) = e^{\pi/x}$

Double dollars make self-standing equations:

$$\Theta(x) = \left\{\begin{array}{l}
0\textrm{ if } x < 0\cr
1\textrm{ else}
\end{array}\right.$$


# Citations

Citations to entries in paper.bib should be in
[rMarkdown](http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html)
format.

# Figures

-![Figure 1](Figure_1.png)
-![Figure 2](Figure_2.JPG)
-![Figure 3](Figure_3.png)

# Acknowledgements

We acknowledge contributions from Brigitta Sipocz, Syrtis Major, and Semyeong
Oh, and support from Kathryn Johnston during the genesis of this project.

# References
