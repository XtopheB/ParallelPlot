################## SninyParallel : SERVER   ################

library(shiny)
library(ggplot2)
library(ggthemes)
library(doBy)


load("riskSmall.RData")

# Define server logic for random distribution application
shinyServer(function(input, output) {
  
  
  output$PointPlot <- renderPlot({
    R <- input$R
    A <- input$A
    # Point Plot 
    Plot.Point <- ggplot(risk.all, aes(x=years, y= AR)) + 
      geom_point(color = "grey", alpha=A) + 
      geom_point(dat= subset(risk.all, region==R), alpha=0.50, color="pink") +
      coord_cartesian(ylim = c(-40,40)) + guides(colour=FALSE)+
      ggtitle(paste("Overplotted points (Region",R, "higlighted)")) +

      theme_classic()
    
    
    
    Plot.Point
  
  Plot.Point
  })
  
  output$JitterPlot <- renderPlot({
  R <- input$R
  A <- input$A
  # Point Plot  with Jitter 
  Plot.Jitter <- ggplot(risk.all, aes(x=years, y= AR)) + 
    geom_jitter(color = "grey",  alpha=A) + 
    geom_jitter(dat= subset(risk.all, region==R), alpha=0.50, color="pink") +
    coord_cartesian(ylim = c(-40,40)) + guides(colour=FALSE) +
    ggtitle(paste("Jittered points (Region",R, "higlighted)")) +
    theme_classic()
  
  Plot.Jitter
  })
  
  output$LinePlot <- renderPlot({
    risk.sum <- summaryBy(AR+theta+theta1+theta2+sigma+Profit+AR.N+theta.N+theta1.N+theta2.N+RP+RP.pc~years, data = risk.all, 
                          FUN = function(x) { c(med = median(x, na.rm=TRUE), mean = mean(x)) } )
    
    Plot.Line <- ggplot(risk.sum, aes(years, AR.med, group=1)) +
      geom_point(color ="black") +
      geom_line(color= "grey") +
      coord_cartesian(ylim = c(-40,40)) +
      ggtitle("Median Values") +
      theme_classic() 
    Plot.Line
    
  })
  
  output$QuantilePlot <- renderPlot({
    risk.sum <- summaryBy(AR+theta+theta1+theta2+sigma+Profit+AR.N+theta.N+theta1.N+theta2.N+RP+RP.pc~years, data = risk.all, 
                          FUN = function(x) { c(med = median(x, na.rm=TRUE), 
                                                mean = mean(x),
                                                sd= quantile(x,probs= c(0.05,0.95), names= FALSE, na.rm=TRUE)) } )
    
    Plot.Line <- ggplot(risk.sum, aes(years, AR.med, group=1)) +
      geom_point(color ="black") +
      geom_line(color= "grey") +
      coord_cartesian(ylim = c(-40,40)) +
      ggtitle("Median Values") +
      theme_classic() 
    
   Plot.quantile <- Plot.Line +
     geom_pointrange(data = risk.sum, aes(ymin=AR.sd1, ymax = AR.sd2), 
                                               color = "grey", size=1) +
    ggtitle("Median Values + quantiles") +
    theme_classic() 
  
  Plot.quantile 
  })
  
  output$BoxPlot <- renderPlot({
    R <- input$R
    Plot.Box <- ggplot(data = risk.all, aes(x=years, y= AR)) + 
      geom_boxplot(outlier.colour= "grey", color= "darkgrey", fill="grey") + 
      geom_boxplot(data = subset(risk.all, region == R), outlier.colour= "pink", color= "darkgrey", fill="pink") + 
      coord_cartesian(ylim = c(-40,40)) +
      guides(colour=FALSE, fill=FALSE)+
      ggtitle(paste("Boxplots")) +
      theme_classic() 
    
    Plot.Box
    
  })
  
  output$ParaPlot <- renderPlot({
    R <- input$R
    A <- input$A
    
    Plot.Tot <-  ggplot()  +
      geom_line(dat= risk.all, alpha=A, color="black",
                aes(x=years, y=AR, group=factor(ident) )) +
      geom_line(dat= subset(risk.all, region==R), alpha=0.05, color="pink", 
                aes(x=years, y=AR, group=factor(ident) )) +
      guides(colour=FALSE) +
      coord_cartesian(ylim = c(-40,40)) +
      ggtitle(paste("Parallel Plot (Region",R, "higlighted)")) +
      theme_classic() 
    
    Plot.Tot
    
  })
  output$ParaMulti <- renderPlot({
    A <- input$A
    Plot.Multi <-  ggplot()  +
      geom_line(dat= risk.all, alpha=A, color="black", 
                aes(x=years, y=AR, group=factor(ident) )) +
      guides(colour=FALSE) + 
      coord_cartesian(ylim = c(-40,40)) 
    
  Plot.Multi + facet_wrap(~region)  +
      ggtitle(paste("Multiple Parallel Plot")) +
      theme_classic() 
  })
  
  
  
})
  