# https://shiny.rstudio.com/articles/build.html

library(shiny)
mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

ui <- pageWithSidebar(
  
  headerPanel("Miles Per Gallon"),
  
  sidebarPanel(
    selectInput("variable",
                "Variable",
                c("Cylinders" = "cyl",
                  "Transmission" = "am",
                  "Gears" = 'gear')),
    checkboxInput("outliers", "Show outliers", TRUE)
  ),
  
  mainPanel(
    
    h3(textOutput("caption")),
    
    plotOutput("mpgPlot")
    
  )
  
)

server <- function(input, output) {
 
  formulaText <- reactive({
    paste("mpg ~", input$variable)
  })
  
  output$caption <- renderText({
    formulaText()
  })
  
  output$mpgPlot <- renderPlot({
    boxplot(as.formula(formulaText()),
            data = mpgData,
            outline = input$outliers,
            col = "#007bc2", pch = 19)
  })
   
}

shinyApp(ui, server)