#written by David Ashbrook 21st November 2018
#
library(shiny)
library(datasets)
library(ggplot2)
library(RColorBrewer)
library(data.table)
library(dplyr)
library(DT)

## import data from website, pre-calculated so once its loaded changing inputs rapidly changes the plots. Takes a little time for initial loading though. 
dataimported = read.csv(url("http://individual.utoronto.ca/D_Ashbrook/Effect_size_analysis_heritability_28th_Nov_2018_recalc.csv"), header = TRUE)

# Define server logic required to plot various variables
shinyServer(function(input, output) {
  ## Create a table of values, using the user defined inputs to subset the full table. This will be pulled in later to provide the user with a table of values.
  Significant_lines_table <- reactive({(subset(dataimported,effect.size.locus==input$a&Heritability==input$b&Power>=input$c&NumberOfReplicates>=input$slider2[1]&NumberOfReplicates<=input$slider2[2])[,c(1,3,4,7)])%>% 
      group_by(numberoflines) %>% 
      slice(which.min(NumberOfReplicates))
  })
  ## The main plot
  output$powerplot <- renderPlot({
    ## ggplot, using the user inputs
    ahhhh <- ggplot(data=dataimported, aes(x=numberoflines, y=Power, group=factor(NumberOfReplicates), colour=factor(NumberOfReplicates))) + 
      # Subset the data based on user inputs
      geom_line(data=subset(dataimported,effect.size.locus==input$a&Heritability==input$b&NumberOfReplicates>=input$slider2[1]&NumberOfReplicates<=input$slider2[2])) +
      # Put horizontal line, at the users chosen poser
      geom_hline(yintercept = input$c) +
      # Define y axis (so all plots look the same, and can be compared)
      scale_y_continuous(breaks=seq(0,1,0.05), limits = c(0, 1), expand=c(0,0)) + 
      # Define x axis (so all plots look the same, and can be compared)
      scale_x_continuous(breaks=seq(0,150,10), limits = c(0,150), expand=c(0,0)) +
      # Define theme, e.g. size of axis labels
      theme(legend.position="top", axis.text=element_text(size=14),
            axis.title=element_text(size=18,face="bold")) + 
      guides(colour = guide_legend(override.aes = list(size=3))) +
      # Label axis
      xlab("Number of RI strains") + 
      ylab("Power") + 
      labs(color = "Number of biological replicates\n")
    print(ahhhh)
  })
  ## Output table, showing the combinations of number of lines and number of biological replicates sufficient to reach the user selected power 
  output$tbl2 <- DT::renderDataTable({
    DT::datatable(Significant_lines_table(),options = list(pageLength = 10), colnames = c('Power', 'Number of strains', 'Number of biological replicates', 'Total animals needed'))%>%
      formatRound(columns=c('Power'), digits=2)
  })
  ## Output effect size plot, showing the theoretical distribution of values, given the selected locus effect size and number of bioloigcal replicates
  output$effectplot <- renderPlot({
    n<-input$slider2[1]            ## Sample n individuals at a time - taken from selected minimum number of biological replicates
    effect <- input$a ## Locus effect size, as selected by user
    p_mean_1<- -((input$a)/2)        ## Population mean of the homozygote with low values (negative, half of the total locus effect size)
    p_mean_2<- (input$a)/2        ## Population mean of the homozygote with high values (positive, half of the total locus effect size)
    p_sd<-1            ## Population standard deviation - define the standard deviation as 1
    ## Plot the whole population curve, i.e. by adding the values for both homozygote populations. Define size of the plot, so all three curves will fit on same axis
    vc <-  curve(((dnorm(x,p_mean_2,p_sd/sqrt(n)))+((dnorm(x,p_mean_1,p_sd/sqrt(n))))), xlim=c(-5,5), ylim=c(0,3.5), ylab = "Density", xlab = "")
    title(main="Standard error density around the mean of the two homozoygotes
            using effect size and minimum number of replicates inputs")
    ## Plot curve for the low value homozygote
    va <-  curve(dnorm(x,p_mean_1,(p_sd/sqrt(n))), xlim=c(-5,5), ylim=c(0,3.5),add=TRUE) 
    ## Plot curve for the high value homozygote
    vb <-  curve(dnorm(x,p_mean_2,(p_sd/sqrt(n))), xlim=c(-5,5), ylim=c(0,3.5),add=TRUE)
    ## Write the two values used to calculate the plot (already selected by user, but here to remind them)
    text(3,3, labels = ("Locus effect size:"))
    text(3,3, labels = (input$a), offset	= 3.5, pos = 4)
    text(3,2.5, labels = ("Number of replicates:"))
    text(3,2.5, labels = (input$slider2[1] ), offset	= 4, pos = 4)
    
  })
  ## Calculate the H2RIX using the smallest and largest of the selected number of bioloigcal replicates. 
  output$selected_var_1 <- renderText({    paste("H2RI using minimum biological replicates value:", (signif((min(subset(dataimported, effect.size.locus==input$a&Heritability==input$b&NumberOfReplicates==input$slider2[1])$H2RI)),3)))})
  output$selected_var_2 <- renderText({    paste("H2RI using maximum biological replicates value:", (signif((min(subset(dataimported, effect.size.locus==input$a&Heritability==input$b&NumberOfReplicates==input$slider2[2])$H2RI)),3)))})
})