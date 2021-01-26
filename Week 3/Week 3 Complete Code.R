### Spatial Plotting ###
# COVID case data retrieved from https://github.com/nytimes/covid-19-data
# COVID reopening rank data retrieved from https://www.multistate.us/issues/covid-19-state-reopening-guide

## Load libraries
library(tidyverse)
library(sf)
library(spData)
library(ggthemes) # https://yutannihilation.github.io/allYourFigureAreBelongToUs/ggthemes/
library(RColorBrewer)

## Read and merge data
covid_cases <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")
covid_cases <- filter(covid_cases, date == as.Date("2021-1-22")) # reopening rank data was last updated on Jan 22, 2021
reopening_ranks <- read_csv("covid reopening rank.csv")

us_covid <- inner_join(covid_cases, reopening_ranks, by = c("state" = "STATE"))
us_covid <- inner_join(us_covid, us_states, by = c("state" = "NAME"))
us_covid_geo <- st_sf(us_covid)
view(us_covid_geo)

## Create variable
us_covid_geo$cases_pc <- round(us_covid_geo$cases / us_covid_geo$total_pop_15, 2)

## Plot reopening score
# a score of 0 indicates full lockdown; a score of 100 indicates no restrictions
ggplot(us_covid_geo) +
  geom_sf(aes(fill = SCORE)) +
  labs(title = "COVID-19 Reopening Scores",
       caption = "0 indicates full lockdown; 100 indicates no restrictions") +
  theme_void() +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_color_continuous(name = "Reopening Score")

ggplot(us_covid_geo) +
  geom_sf(aes(fill = SCORE)) +
  labs(title = "COVID-19 Reopening Scores",
       caption = "0 indicates full lockdown; 100 indicates no restrictions") +
  theme_void() +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_brewer(palette = "YlGn") # What happens if we want to specify a color scale?

## Plot cases per capita
cases_deciles <- us_covid_geo %>%
  mutate(decile = as.factor(ntile(cases_pc, 10)))
view(cases_deciles)

ggplot(cases_deciles) +
  geom_sf(aes(fill = (decile))) +
  labs(title = "COVID-19 Cases per Capita") +
  theme_void() +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_brewer(palette = "YlOrRd")

mycolors <- colorRampPalette(brewer.pal(8, "Set2"))(10)
pinks <- c("#fff7f3", "#fde0dd", "#fcc5c0", "#fa9fb5", "#f768a1", "#dd3497", "#ae017e",
           "#7a0177", "#49006a", "#000000")
    # helpful tool for creating palettes: https://colorbrewer2.org/#type=sequential&scheme=Greys&n=9

ggplot(cases_deciles) +
  geom_sf(aes(fill = (decile))) +
  labs(title = "COVID-19 Cases per Capita") +
  theme_void() +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(values = pinks)
