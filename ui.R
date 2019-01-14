#written by David Ashbrook 21st November 2018
#
library(shiny)

## Load UI
shinyUI(fluidPage(tags$style(type = "text/css", ".irs-grid-pol.small {height: 0px;}"),
                  fluidRow(
                    # Create title, link to help page, etc, across whole of top
                    column(12, offset = 0.2,
                           h1("Power Calculator for a two parent recombinant inbred family"),h2("Probability (beta) of detecting a QTL as a function of heritability, strains, and replicates within strain", offset = 3),tags$div(class="header", checked=NA, tags$a(href="https://davidashbrook.wordpress.com/bxd-power-app-help-page/", "     (Help Page)")),h3("     Beta 0.7; 10th January 2019"),h4("     David Ashbrook and colleagues")),
                    # Create inputs, half width of title
                    column(6,
                           # Heritability input, with link to help page
                           tags$a(href="https://davidashbrook.wordpress.com/bxd-power-app-help-page#Heritability", "Heritability"),
                           # Input for heritability, slider between 0 and 1.
                           sliderInput("b", label = NULL, 
                                       min=0, max=1, value=0.1, step = 0.05, ticks = TRUE, width = '90%'),
                           # Locus effect size input, and link to help file
                           tags$a(href="https://davidashbrook.wordpress.com/bxd-power-app-help-page#Standardized-locus-effect-size", "Standardized locus effect size"),
                           # Input for locus effect size, slider between 0 and 1
                           sliderInput("a", label = NULL, 
                                       min = 0, max = 1, value = 1, step = 0.05, ticks = TRUE, width = '90%'),
                           # Number of biological replicates (within-strain replicates), and link to help file
                           tags$a(href="https://davidashbrook.wordpress.com/bxd-power-app-help-page#Within-strain replicates", "Biological replicates"),
                           # Input for number of biological replicates, between 1 and 10. 
                           sliderInput("slider2", label = NULL, min = 1, 
                                       max = 20, value = c(2, 10), ticks = TRUE, width = '90%'),
                           # H2RIX, help file
                           tags$a(href="https://davidashbrook.wordpress.com/bxd-power-app-help-page#H2RIX", "H2RI"),
                           # Minimum H2RIX (using the smallest number of biological replicates selected)
                           textOutput("selected_var_1"),
                           # Maximum H2RIX (using the largest number of biological replicates selected)
                           textOutput("selected_var_2"),
                           # Power input, with link to help file
                           tags$a(href="https://davidashbrook.wordpress.com/bxd-power-app-help-page#Power", "Power threshold"),
                           # Input for power (i.e. the cut off value the user wants), between 0.1 and 1 (power of 0 is meaningless)
                           sliderInput("c", label = NULL, 
                                       min = 0.1, max = 1, value = 0.8, step = 0.05, ticks = TRUE, width = '90%')),
                    # Create space for the effect plot, the other half of the page next to inputs
                    column(6,
                           plotOutput("effectplot"))
                  ),
                  # Move to next row, create plot for power vs locus effect size, the main plot. Just less than full size (11.5) to allow some white space
                  fluidRow(
                    column(11.5, offset = 0.2, textOutput("Power vs Locus Effect Size"),
                           plotOutput("powerplot", height = 600))),
                  # Move to next row, create table to find strain combinations (i.e. number of strains and number of biological replicates) sufficient to get above the selected power cut-off
                  fluidRow(
                    column(3, offset = 0.2, 
                           verbatimTextOutput("Strain combinations with sufficient power"),
                           DT::dataTableOutput('tbl2'))))
)
