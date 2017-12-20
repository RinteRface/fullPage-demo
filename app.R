library(shiny)

options <- list(
  sectionsColor = c('#f2f2f2', '#4BBFC3', '#7BAABE'),
  parallax = TRUE
)

ui <- fullPage(
  menu = c("Full Page" = "link1",
           "Sections" = "link2",
           "Slides" = "section3",
           "backgrounds" = "section4",
           "Background Slides" = "section5"),
  opts = options,
  fullSection(
    center = TRUE,
    menu = "link1",
    tags$h1("fullPage.js meets Shiny")
  ),
  fullSection(
    menu = "link2",
    fullRow(
      h2("Milligram's grid"),
      fullColumn(
        h3("Input column"),
        selectInput(
          "dd",
          "data points",
          choices = c(10, 20, 30)
        )
      ),
      fullColumn(
        plotOutput("hist")
      ),
      fullColumn(
        plotOutput("plot")
      )
    )
  ),
  fullSection(
    menu = "section3",
    fullSlide(
      fullContainer(
        center = TRUE,
        h3("With container"),
        plotOutput("slideplot2"),
        shiny::verbatimTextOutput("containerCode")
      )
    ),
    fullSlide(
      center = TRUE,
      h3("Without container"),
      plotOutput("slideplot1")
    )
  ),
  fullSectionPlot(
    menu = "section4",
    center = TRUE,
    "fp",
    h3("Background plots"),
    fullContainer(
      sliderInput(
        "fpInput",
        label = "Input",
        min = 10,
        max = 100,
        value = 74
      )
    )
  ),
  fullSection(
    menu = "section5",
    fullSlidePlot(
      "slideSectionPlot1",
      center = TRUE,
      h1("Slide background plot")
    ),
    fullSlidePlot(
      "slideSectionPlot2"
    )
  )
)

server <- function(input, output){
  
  output$plot <- renderPlot({
    hist(rnorm(input$dd, 1, 10))
  })
  
  output$hist <- renderPlot({
    hist(rnorm(input$dd, 1, 10))
  })
  
  output$slideplot1 <- renderPlot({
    plot(mtcars$mpg, mtcars$drat)
  })
  
  output$slideplot2 <- renderPlot({
    plot(mtcars$wt, mtcars$mpg)
  })
  
  output$fp <- renderPlot({
    par(bg = "lightgray")
    hist(rnorm(input$fpInput, 1, 10))
  })
  
  output$containerCode <- renderText({
    "fullSlide(
      fullContainer(...)
    )"
  })
  
  output$slideSectionPlot1 <- renderPlot({
    par(bg = "lightblue")
    hist(rnorm(50, 1, 20))
  })
  
  output$slideSectionPlot2 <- renderPlot({
    par(bg = "gray50")
    hist(rnorm(50, 1, 25))
  })
}

shinyApp(ui, server)