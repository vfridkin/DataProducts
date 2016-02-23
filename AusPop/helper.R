library(openxlsx)
library(dplyr)
library(tidyr)
library(ggplot2)

abs <- read.xlsx("abs.xlsx", sheet = "reformatted") # data.frame
