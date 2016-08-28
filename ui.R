#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    tags$style("body {background-color: #f0f0ff;}"),
    tags$style(".nav-tabs {background-color: #e0e0ff;}"),
    tags$style(".well {background-color:#e0e0ff;}"),
    tags$style(".tab-content {background-color:#ffffff;outer-sep:0 pt; inner-sep=10pt;}"),
    titlePanel("Motor Trend Data Set"),
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
    sidebarPanel(
        h4("Variable selection"),
        selectInput(inputId = 'x',
            label = "X variable",
            choices = varlist,
            selected = varlist[2]),
            selectInput(inputId = 'y',
                label = "Y variable",
                choices = varlist,
                selected = varlist[1]),
            selectInput(inputId = 'sizev',
                label = "Point size variable",
                choices = varlist,
                selected = varlist[3]),
            selectInput(inputId = 'colf',
                label = "Color variable",
                choice = faclist,
                selected = faclist[1]),
            h4("Linear Model"),
            checkboxInput(inputId="usecross",label="Multiple slope"),
            checkboxInput(inputId="usesize",label="use"),
            sliderInput(inputId = 'sval',post="%",
                label = setlab(varlist[3]),
                min = 5,max =95,value = 50,step = 2.5)
    ,width=3),
    mainPanel(
        tabsetPanel(
            # First tabPanel, interface and figure
            tabPanel("Visualization",
                h4("Data and linear model"),
                # Show a plot of the generated distribution
                ggvisOutput("plot1"),
                h4("Residuals"),
                # Show the residual plot
                ggvisOutput("plot2")
            ),
            # Second tabPanel, model and statistics
            tabPanel("Modelization",
                h4("Current Linear Model"),
                h5("Formula"),
                # show formula
                textOutput("curformula"),
                h5("Coefficients"),
                # Show coefficient table
                tableOutput("modcoef"),
                h4("List of possible models"),
                h5("Formulas"),
                textOutput("formula0"),
                textOutput("formula1"),
                textOutput("formula2"),
                textOutput("formula3"),
                h5("Comparison"),
                # Show anova test and R squared
                tableOutput("allmod")
            )
    ),width=9)
)))
