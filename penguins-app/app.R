# app.R
library(shiny)
library(palmerpenguins)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Palmer Penguins Explorer"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("species", "Choose species:",
                  choices = unique(na.omit(penguins$species)),
                  selected = "Adelie"),
      selectInput("xvar", "X-axis:",
                  choices = c("bill_length_mm", "bill_depth_mm", 
                              "flipper_length_mm", "body_mass_g"),
                  selected = "bill_length_mm"),
      selectInput("yvar", "Y-axis:",
                  choices = c("bill_length_mm", "bill_depth_mm", 
                              "flipper_length_mm", "body_mass_g"),
                  selected = "flipper_length_mm")
    ),
    
    mainPanel(
      plotOutput("scatterPlot")
    )
  )
)

server <- function(input, output) {
  output$scatterPlot <- renderPlot({
    data <- penguins[!is.na(penguins$species) & penguins$species == input$species, ]
    
    ggplot(data, aes_string(x = input$xvar, y = input$yvar, color = "species")) +
      geom_point(size = 3) +
      labs(title = paste("Scatterplot for", input$species),
           x = input$xvar,
           y = input$yvar) +
      theme_minimal()
  })
}

shinyApp(ui = ui, server = server)
