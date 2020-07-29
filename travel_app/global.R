library(shiny)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(RColorBrewer)


travel <- read.csv(file = "./travel.csv")

travel$arrival_date_month <- sort(factor(travel$arrival_date_month, levels = month.name))

