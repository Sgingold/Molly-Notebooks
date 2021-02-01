# Week 4 Complete Code
# Objective: use RShiny to create interactive data visualizations
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
                   "tempo", "acousticness")
              ),
  textOutput("result"),
  
  plotOutput("scatter", click = "plot_click"),
  
  verbatimTextOutput("text")
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
    plot(x = data(), y = artist_subset$year,
    xlab = input$feature,
    ylab = "Year")
  })
  
  output$text <- renderText({
    paste0("This song is titled ", input$plot_click$x)
  })
}

# Component 3: Call shinyApp Function
shinyApp(ui = ui, server = server)
