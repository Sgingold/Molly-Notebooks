## Goal: Identify main subjects and sentiments of an unknown text
# Text retrieved from https://www.theatlantic.com/health/archive/2021/02/uh-oh-spaghetti-os-pie/617949/

library(tidyverse)
library(tidytext)

setwd(getwd())
mystery_text <-  read_file("mystery_text.txt")
my_text <- tibble(text = mystery_text)
my_text

# Prepare for analysis (tokenize, remove stop words, etc)
text_words <- unnest_tokens(my_text, words, text, token = "words")
text_words <- anti_join(text_words, stop_words, by = c("words" = "word"))
text_words

# Part of speech analysis

# Sentiment analysis

# Visualize results