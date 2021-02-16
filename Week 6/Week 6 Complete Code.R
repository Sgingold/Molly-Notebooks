# OBJECTIVE 1: Review relative file paths
# OBJECTIVE 2: Create generalizable code for NLP, analyze multiple waves of text data, 
#              perform sentiment analysis on specific tokens 

# Data downloaded from: https://fiscal.treasury.gov/reports-statements/financial-report/previous-reports.html

# File paths
# Option 1
path <- "/Users/mollybair/Documents/GitHub/Molly-Notebooks/Week 6/"
paste0(path, filename)
# Option 2
path <- "./Week 6/"
paste0(path, filename)

# Load libraries
library(tidyverse)
library(tidytext)
library(pdftools)
library(readr)
library(udpipe)
library(SnowballC)

# Create function to read text files
fnames <- list("fr2016.txt", "fr2015.txt", "fr2014.txt")
obj_names <- list("parsed16", "parsed15", "parsed14")
parse_text <- function(fname, parsed_name) {
  text <- read_file(paste0(path, fname))
  parsed <- udpipe(text, "english")
  assign(x = parsed_name, value = parsed, envir = globalenv())
  return(parsed_name)
}

for (index in 1:length(fnames)) {
  parse_text(fnames[[index]], obj_names[[index]])
}

view(parsed16)

# Sentiment analysis

# Call functions in loop







