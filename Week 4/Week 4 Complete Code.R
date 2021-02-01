# Week 4 Complete Code
# Objective: use RShiny to create interactive data visualizations
# Data retrieved from: https://www.kaggle.com/yamaerenay/spotify-dataset-19212020-160k-tracks

library(tidyverse)
library(shiny)

spotify <- read_csv('Spotify data.csv')
