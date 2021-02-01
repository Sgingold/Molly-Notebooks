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
keep = c("Fiona Apple", "Metallica", "Taylor Swift")
artist_subset <- spotify %>%
  filter(artists %in% keep)
view(artist_subset)


