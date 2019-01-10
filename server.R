#written by David Ashbrook 21st November 2018
#
library(shiny)
library(datasets)
library(ggplot2)# load ggplot
library(RColorBrewer)
library(data.table)
library(dplyr)
library(DT)
## import data
dataimported = read.csv(url("http://individual.utoronto.ca/D_Ashbrook/Effect_size_analysis_heritability_28th_Nov_2018_recalc.csv"), header = TRUE)
abc <- dataimported
# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
  Significant_lines_table <- reactive({(subset(abc,effect.size.locus==input$a&Heritability==input$b&Power>=input$c&NumberOfReplicates>=input$slider2[1]&NumberOfReplicates<=input$slider2[2])[,c(1,3,4,7)])%>% 
      group_by(numberoflines) %>% 
      slice(which.min(NumberOfReplicates))
  })
  
  output$powerplot <- renderPlot({
    
    ahhhh <- ggplot(data=abc, aes(x=numberoflines, y=Power, group=factor(NumberOfReplicates), colour=factor(NumberOfReplicates))) + 
      geom_line(data=subset(abc,effect.size.locus==input$a&Heritability==input$b&NumberOfReplicates>=input$slider2[1]&NumberOfReplicates<=input$slider2[2])) +
      geom_hline(yintercept = input$c) +
      #      geom_point(data=subset(dataimported,NumberOfReplicates==input$a&Heritability==input$b&Power<=0.95))+ 
      scale_y_continuous(breaks=seq(0,1,0.05), limits = c(0, 1), expand=c(0,0)) + 
      scale_x_continuous(breaks=seq(0,150,10), limits = c(0,150), expand=c(0,0)) +
      theme(legend.position="top", axis.text=element_text(size=14),
            axis.title=element_text(size=18,face="bold")) + 
      guides(colour = guide_legend(override.aes = list(size=3))) +
      xlab("Number of BXD lines") + 
      ylab("Power") + 
      labs(color = "Number of biological replicates\n")
    print(ahhhh)
  })
  output$summary <- renderPrint({
    Significant_lines_table()
  })
  output$view <- renderTable({
    (Significant_lines_table())
  })
  
  output$mytable = DT::renderDataTable({
    Significant_lines_table
  })
  output$tbl2 <- DT::renderDataTable({
    DT::datatable(Significant_lines_table(),options = list(pageLength = 10), colnames = c('Power', 'Number of lines', 'Number of biological replicates', 'Total animals needed'))%>%
      formatRound(columns=c('Power'), digits=2)
  })
  output$effectplot <- renderPlot({
    
    n<-input$slider2[1]            ## Sample n individuals at a time
    effect <- input$a
    p_mean_1<- -((input$a)/2)        ## Population mean
    p_mean_2<- (input$a)/2        ## Population mean
    p_sd<-1            ## Population standard deviation
    vc <-  curve(((dnorm(x,p_mean_2,p_sd/sqrt(n)))+((dnorm(x,p_mean_1,p_sd/sqrt(n))))), xlim=c(-5,5), ylim=c(0,3.5), ylab = "Density", xlab = "")
    title(main="Standard error density around the mean of the two homozoygotes
            using effect size and minimum number of replicates inputs")
    va <-  curve(dnorm(x,p_mean_1,(p_sd/sqrt(n))), xlim=c(-5,5), ylim=c(0,3.5),add=TRUE) 
    vb <-  curve(dnorm(x,p_mean_2,(p_sd/sqrt(n))), xlim=c(-5,5), ylim=c(0,3.5),add=TRUE)
    text(3,3, labels = ("Locus effect size:"))
    text(3,3, labels = (input$a), offset	= 3.5, pos = 4)
    text(3,2.5, labels = ("Number of replicates:"))
    text(3,2.5, labels = (input$slider2[1] ), offset	= 4, pos = 4)
    
  })
  ## Need to get H2RIX for the selected H2, and selected number of strains
  ## prob need to do some subsetting, then output, rather than just output. 
  ## Should be able to use the significant lines table
  output$selected_var_1 <- renderText({    paste("H2RI using minimum biological replicates value:", (signif((min(subset(abc,effect.size.locus==input$a&Heritability==input$b&NumberOfReplicates==input$slider2[1])$H2RI)),3)))})
  output$selected_var_2 <- renderText({    paste("H2RI using maximum biological replicates value:", (signif((min(subset(abc,effect.size.locus==input$a&Heritability==input$b&NumberOfReplicates==input$slider2[2])$H2RI)),3)))})
})