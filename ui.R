################## SninyParallel :UI   ################
library(shiny)

# Define UI for random distribution application 
shinyUI(fluidPage(
  
  # Application title
 # headerPanel("Visualizing Many"),
  # Application title
  titlePanel("Visualizing Many "),
  tags$h5("Christophe Bontemps (SIAP)"),
  tags$h5("Version 0.1, February 26th, 2023 "),
  
  # Sidebar with controls to select the random distribution type
  # and number of observations to generate. Note the use of the br()
  # element to introduce extra vertical spacing
  sidebarPanel(   
    HTML("<h4><font color='#2874A6'> Highlight a Region </font></h3>"),
    sliderInput("R", 
                "Select Region to highlight", 
                value = 0.50,  #  0 = no region highlighted !
                min = 0, 
                max = 6,
                step = 1),
    HTML("<h4><font color='#2874A6'> Transparent lines adjustment </font></h3>"),
    
    sliderInput("A", 
                "Select the transparancy level (Brushing)", 
                value = 1,  #  0 = no region highlighted !
                min = 0, 
                max = 1,
                step = 0.01)
    
  ),
  
  # Show a tabset that includes a plot, summary, and table view
  # of the generated distribution
  mainPanel(
    tabsetPanel(
      tabPanel("Point Plot", plotOutput("PointPlot")),
      tabPanel("Jitter Plot", plotOutput("JitterPlot")),
      tabPanel("Line Plot", plotOutput("LinePlot")),
      tabPanel("Quantile Plot", plotOutput("QuantilePlot")),
      tabPanel("Box Plot", plotOutput("BoxPlot")),
      tabPanel("Spaghetti Plot", plotOutput("ParaPlot")),
      tabPanel("Multiple Spaghetti", plotOutput("ParaMulti"))
      
    )
  )
))