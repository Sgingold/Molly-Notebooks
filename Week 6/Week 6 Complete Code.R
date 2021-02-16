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

# Create function to read pdf files
fnames <- list("Fiscal Report 2016.pdf", "Fiscal Report 2015.pdf", "Fiscal Report 2014.pdf")
df_names <- list("df16", "df15", "df14")
pdf_to_tokens <- function(fname, df_name) {
  temp_text <- pdf_text(paste0(path, fname)) %>%
    readr::read_lines()
  df <- tibble(text = temp_text)
  df <- unnest_tokens(df, words, text, token = "words")
  assign(x = df_name, value = df, envir = globalenv())
  return(df_name)
}

for (index in 1:length(fnames)) {
  pdf_to_text(fnames[[index]], df_names[[index]])
}
df15


# Sentiment analysis

# Call functions in loop







