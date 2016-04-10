library(ggvis)
library(dplyr)
library(data.table)
library(ggplot2)

fex = read.csv("filtered_extrema.csv")
female = fex %>%
  filter(Gender == 'F', ROC > 0, Count >= 500)
ggplot(female, aes(x = Year,y = ROC,col = Name))+geom_point()
male = fex %>%
  filter(Gender == 'M', ROC > 0, Count >= 500)
ggplot(male, aes(x = Year,y = ROC,col = Name))+geom_point()
