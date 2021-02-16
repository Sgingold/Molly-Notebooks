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
library(udpipe)

# Create function to read text files
fnames <- list("fr2016.txt", "fr2015.txt", "fr2014.txt")
obj_names <- list("parsed16", "parsed15", "parsed14")
parse_text <- function(fname, parsed_name) {
  text <- read_file(paste0(path, fname))
  parsed <- udpipe(text, "english") %>%
    anti_join(stop_words, by = c("token" = "word"))
  assign(x = parsed_name, value = parsed, envir = globalenv())
  return(parsed_name)
}

for (index in 1:length(fnames)) {
  parse_text(fnames[[index]], obj_names[[index]])
}

# Sentiment analysis of particular token
token_sa <- function(token, sa_df, parsed_text, new_df_name) {
  df <- parsed_text %>%
    filter(token == token) %>%
    select("token_id", "token", "lemma", "upos", "head_token_id", "dep_rel") %>%
    inner_join(sa_df, by = c("token" = "word"))
  assign(x = new_df_name, value = df, envir = globalenv())
  return(new_df_name)
}
sentiment_bing <- get_sentiments("bing")
parsed_dfs <- list(parsed16, parsed15, parsed14)
sa_names <- list("ob16", "ob15", "ob14")
for (index in 1:length(obj_names)) {
  token_sa("Obama", sentiment_bing, parsed_dfs[[index]], sa_names[[index]])
}










