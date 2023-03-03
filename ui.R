################## SninyParallel :UI   ################
library(shiny)

# Define UI for random distribution application 
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Visualizing Many Over Time "),
  tags$h5("Christophe Bontemps (SIAP)"),
  tags$h5("Version 2.1 - 3 March, 2023 "),
  
  # Sidebar with controls to select the random distribution type
  # and number of observations to generate. Note the use of the br()
  # element to introduce extra vertical spacing
  sidebarPanel(   
    
    HTML("<h4><font color='#2874A6'> Select a Region to Highlight  </font></h3>"),
    selectInput("Region", "Select Region to highlight ",
                choices = c("A", "B", "C", "D", "Select..."),
                selected = "Select..."), 
    
    
    HTML("<h4><font color='#2874A6'> Transparent lines adjustment </font></h3>"),
    
    sliderInput("A", 
                "Select the transparancy level (Brushing)", 
                value = 1,  
                min = 0, 
                max = 1,
                step = 0.01)
    
  ),
  
  # Show a tabset that includes a plot, summary, and table view
  # of the generated distribution
  mainPanel(
    tabsetPanel(
      tabPanel("Summary Statistics", tableOutput("SumTable")),
      tabPanel("Median Values", plotOutput("LinePlot")),
      tabPanel("Quantile Values", plotOutput("QuantilePlot")),
      tabPanel("Point Plot", plotOutput("PointPlot")),
      tabPanel("Jitter Plot", plotOutput("JitterPlot")),
     #tabPanel("Box Plot", plotOutput("BoxPlot")),
      tabPanel("Box Plot", plotOutput("BoxPlot2")),
      tabPanel("Parallel Plot", plotOutput("ParaPlot")),
      tabPanel("Small Multiple", plotOutput("ParaMulti"))
      
    )
  )
))