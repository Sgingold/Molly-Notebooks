## Goal: Identify main subjects and sentiments of an unknown text
# Text retrieved from https://www.theatlantic.com/health/archive/2021/02/uh-oh-spaghetti-os-pie/617949/
rm(list=ls())

library(plyr)
library(tidyverse)
library(tidytext)

setwd(getwd())
mystery_text <-  read_file("mystery_text.txt")
my_text <- tibble(text = mystery_text)
my_text

# Prepare for analysis (tokenize, remove stop words, etc)
words_df <- unnest_tokens(my_text, words, text, token = "words")
words_df <- anti_join(words_df, stop_words, by = c("words" = "word"))
unique_words <- count(words_df, "words")
view(unique_words)

# Part of speech analysis
words_pos <- left_join(unique_words, parts_of_speech, by = c("words" = "word"))
view(words_pos)

# Sentiment analysis




