### OBJECTIVE ###
# Wrangle dataset with hierarchical index and inconsistent missing values
# Data retrieved from https://data.unicef.org/topic/child-migration-and-displacement/displacement/

### LOAD LIBRARIES ### 
library(tidyverse)
library(readxl)

### LOAD DATA ###
var_names <- c("iso_code", "country", "tot_immigrants_19", "pct_immigrants_19", "pct_child_immigrants_19", 
               "tot_emigrants_19", "pct_emigrants_19", "tot_ref_to_18", "pct_child_ref_to_18", 
               "tot_ref_from_18", "pct_child_ref_from_18", "tot_as_to_18", "tot_as_from_18", 
               "tot_in_displace_18", "hr_instruments")
child_displacement_v1 <- read_excel("Child-migrants-and-refugees_Dec2019.xlsx",
                                 sheet = "country",
                                 range = cell_rows(12:208),
                                 col_names = var_names) 
view(child_displacement_v1)

### ADDRESS MISSING VALUES ###
is.na(child_displacement$hr_instruments)

# Method 1 #
ctypes <- c("text", "text", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric",
            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
child_displacement_v2 <- read_excel("Child-migrants-and-refugees_Dec2019.xlsx",
                                 sheet = "country",
                                 range = cell_rows(12:208),
                                 col_names = var_names,
                                 col_types = ctypes)
view(child_displacement_v2)  # What information do we lose using this method?

# Method 2 #
ctypes_new <- c("text", "text", "guess", "guess", "numeric", "guess", "guess", "guess", "guess", "guess", 
             "guess", "guess", "guess", "guess", "guess")
child_displacement_v3 <- read_excel("Child-migrants-and-refugees_Dec2019.xlsx",
                                 sheet = "country",
                                 range = cell_rows(12:208),
                                 col_names = var_names,
                                 col_types = ctypes_new)
view(child_displacement_v3)
child_displacement_v3[child_displacement_v3 == "-" | child_displacement_v3 == "a"] <- NA




