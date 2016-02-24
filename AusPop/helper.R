library(ggplot2)
library(openxlsx)
library(dplyr)
library(tidyr)
library(scales)

# Read data.frame from XL worksheet
abs <- read.xlsx("data/abs.xlsx", sheet = "reformatted")

# Non-numeric rows are summary of existing data, except for age>100
abs$Age[abs$Age == "100 and over"] <- "100" # 100 now represents >100

# Convert Age to numeric and remove non-numeric rows to remove duplicate summary data
abs$Age <- as.numeric(abs$Age)
abs <- abs[!is.na(abs$Age),]

# Gather seperate gender counts
abs <- abs %>% gather("gender", "count", Males, Females)



