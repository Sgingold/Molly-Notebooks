# OBJECTIVE 1: Review relative file paths
# OBJECTIVE 2: Create generalizable code for NLP, analyze multiple waves of text data, 
#              perform topic modeling

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
library(topicmodels)
library(igraph)
library(ggraph)
library(ggplot2)

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

# Topic modeling - on nouns
# https://cran.r-project.org/web/packages/udpipe/vignettes/udpipe-usecase-topicmodelling.html
# Prepare model
ud_model <- udpipe_download_model(language = "english")
ud_model <- udpipe_load_model(ud_model$file_model)

# Prepare our parsed data by adding a topic modeling id
parsed16$topic_model_id <- unique_identifier(parsed16, fields = c("doc_id", "paragraph_id", "sentence_id"))
nouns16 <- parsed16 %>%
  filter(upos == "NOUN") %>%
  document_term_frequencies(document = "topic_model_id", term = "lemma")
view(nouns16)

# Create document/term/matrix
dtm16 <- document_term_matrix(x = nouns16)
dtm16_freq <- dtm_remove_lowfreq(dtm, minfreq = 2)
head(dtm_colsums(dtm16_freq))

# Create topic model
model <- LDA(dtm16_freq, k = 4, method = "Gibbs", 
             control = list(nstart = 5, burnin = 2000, best = TRUE, seed = 1:5))

# Visualize model
terms <- predict(model, type = "terms", min_posterior = 0.05, min_terms = 4)
scores <- predict(model, newdata = dtm, type = "topics", 
                  labels = c("topic1", "topic2", "topic3", "topic4"))
topics <- merge(parsed16, scores, by.x = "topic_model_id", by.y = "doc_id")

wordnetwork <- subset(topics, topic %in% 1 & lemma %in% terms[[1]]$term)
wordnetwork <- cooccurrence(wordnetwork, group = c("topic_model_id"), term = "lemma")
wordnetwork <- graph_from_data_frame(wordnetwork)

ggraph(wordnetwork, layout = "fr") +
  geom_edge_link(aes(width = cooc, edge_alpha = cooc), edge_colour = "pink")  +
  geom_node_text(aes(label = name), col = "darkgreen", size = 4) +
  labs(title = "Cooccurrence of Nouns in Topic 1") +
  theme_void()





