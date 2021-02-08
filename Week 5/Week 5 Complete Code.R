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
nouns <- words_pos %>%
  filter(pos == "Noun")
view(nouns)

# Sentiment analysis
sentiment_bing <- get_sentiments("bing")
sentiment_nrc <- get_sentiments("nrc") 
join_sentiment <- function(text_df, sentiment_df) {
  return(inner_join(text_df, sentiment_df, by = c("words" = "word")))
}
words_bing <- join_sentiment(unique_words, sentiment_bing)
words_nrc <- join_sentiment(unique_words, sentiment_nrc)
# Compare sentiment libraries 
nrow(words_bing)
nrow(words_nrc)
# Visualize sentiment analysis
ggplot(words_bing) +
  geom_histogram(aes(sentiment), stat = "count")
ggplot(words_nrc) +
  geom_histogram(aes(sentiment), stat = "count") +
  theme(axis.text.x = element_text(angle = 45))

