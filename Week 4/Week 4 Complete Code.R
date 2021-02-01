# Week 4 Complete Code
# Objective: use RShiny to create interactive data visualizations
    # Create reactive data
    # Create categorical user input
# Data retrieved from: https://www.kaggle.com/yamaerenay/spotify-dataset-19212020-160k-tracks

library(tidyverse)
library(shiny)

spotify <- read_csv('Spotify data.csv')
spotify

# Clean and subset data
spotify$artists <- str_replace_all(spotify$artists, "['']", "")
spotify$artists <- str_replace_all(spotify$artists, "\\[|\\]", "")
artist_subset <- spotify %>%
  filter(artists == "Fiona Apple")
view(artist_subset)

# Component 1: User Interface Object
features <- c("danceability", "energy", "popularity")
ui <- fluidPage(
  titlePanel("Fiona Apple's Music Over the Years"),
  
  selectInput("feature", "Select an audio feature to display",
              list("energy", "danceability",
                   "tempo", "acousticness")),
  
  plotOutput("scatter", click = "plot_click"),
  
  verbatimTextOutput("text"),
  
  tags$head(
    tags$style(HTML("
      body {
        background-color: gray;
        color: pink;
        font-family: serif;
      }
      * {
      font-family: serif;
      }"
    ))
  )
)

# Component 2: Server Function
server <- function(input, output) {
  data <- reactive({
    if ("energy" %in% input$feature) return (artist_subset$energy)
    if ("danceability" %in% input$feature) return (artist_subset$danceability)
    if ("tempo" %in% input$feature) return (artist_subset$tempo)
    if ("acousticness" %in% input$feature) return (artist_subset$acousticness)
  })
  
  output$scatter <- renderPlot({
    ggplot() +
      geom_point(mapping = aes(x = data(), y = artist_subset$year), size = 3, color = "pink") +
      labs(x = input$feature, y = "Year") +
      theme_minimal()
  })
  
  output$text <- renderText({
    paste0("For this song, the ", input$feature, " is ", input$plot_click$x)
  })
}

# Component 3: Call shinyApp Function
shinyApp(ui = ui, server = server)
