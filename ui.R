#written by David Ashbrook 21st November 2018
#
library(shiny)
library(datasets)
library(ggplot2)# load ggplot
library(RColorBrewer)
library(data.table)
library(dplyr)
library(DT)

#dataimported <- read.csv(file = "E:/Effect_size_analysis_heritability_27th_Nov_2018_recalc.csv", header = TRUE)
dataimported = read.csv(url("http://individual.utoronto.ca/D_Ashbrook/Effect_size_analysis_heritability_28th_Nov_2018_recalc.csv"), header = TRUE)
abc <- dataimported


shinyUI(fluidPage(tags$style(type = "text/css", ".irs-grid-pol.small {height: 0px;}"),
                  fluidRow(
                    column(12, offset = 0.2,
                           h1("Power Calculator for BXD Family"),h2("Probability (beta) of detecting a QTL as a function of heritability, strains, and replicates within strain", offset = 3),tags$div(class="header", checked=NA, tags$a(href="https://davidashbrook.wordpress.com/bxd-power-app-help-page/", "     (Help Page)")),h3("     Beta 0.691; 29th November 2018"),h4("     David Ashbrook and colleagues")),
                    column(6,
                           tags$a(href="https://davidashbrook.wordpress.com/bxd-power-app-help-page#Heritability", "Heritability"),
                           sliderInput("b", label = NULL, 
                                       min=0, max=1, value=0.1, step = 0.05, ticks = TRUE, width = '90%'),
                           #           
                           #           # Allele effect,size.allele
                           tags$a(href="https://davidashbrook.wordpress.com/bxd-power-app-help-page#Standardized-locus-effect-size", "Standardized locus effect size"),
                           sliderInput("a", label = NULL, 
                                       min = 0, max = 1, value = 1, step = 0.05, ticks = TRUE, width = '90%'),
                           tags$a(href="https://davidashbrook.wordpress.com/bxd-power-app-help-page#Within-strain replicates", "Biological replicates"),
                           sliderInput("slider2", label = NULL, min = 1, 
                                       max = 20, value = c(2, 10), ticks = TRUE, width = '90%'),
                           tags$a(href="https://davidashbrook.wordpress.com/bxd-power-app-help-page#H2RIX", "H2RI"),
                           textOutput("selected_var_1"),
                           textOutput("selected_var_2"),
                           
                           
                           #           # Power
                           tags$a(href="https://davidashbrook.wordpress.com/bxd-power-app-help-page#Power", "Power threshold"),
                           sliderInput("c", label = NULL, 
                                       min = 0.1, max = 1, value = 0.8, step = 0.05, ticks = TRUE, width = '90%')),
                    
                    column(6,
                           plotOutput("effectplot"))
                  ),
                  fluidRow(
                    column(11.5, offset = 0.2, textOutput("Power vs Locus Effect Size"),
                           plotOutput("powerplot", height = 600))),
                  fluidRow(
                    column(3, offset = 0.2, 
                           verbatimTextOutput("Strain combinations with sufficient power"),
                           DT::dataTableOutput('tbl2'))))
)
