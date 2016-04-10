library(ggvis)
library(dplyr)
library(data.table)
library(ggplot2)

filtered_extrema = read.csv("filtered_extrema.csv")
female = filtered_extrema %>%
  filter(Gender == 'F', ROC > 0, Count >= 500)
ggplot(female, aes(x = Year,y = ROC,col = Name))+geom_point()

male = filtered_extrema %>%
  filter(Gender == 'M', ROC > 0, Count >= 500)
ggplot(male, aes(x = Year,y = ROC,col = Name))+geom_point()

both = filtered_extrema %>%
  filter(ROC > 0, Count >= 500)
ggplot(both, aes(x = Year,y = ROC,col = Name))+geom_point()

female_neg = filtered_extrema %>%
  filter(Gender == 'F', ROC < 0, Count >= 100)
ggplot(female_neg, aes(x = Year,y = ROC,col = Name))+geom_point()

male_neg = filtered_extrema %>%
  filter(Gender == 'M', ROC < 0, Count >= 100)
ggplot(male_neg, aes(x = Year,y = ROC,col = Name))+geom_point()

both_neg = filtered_extrema %>%
  filter(ROC < 0, Count >=100)
ggplot(both_neg, aes(x = Year,y = ROC,col = Name))+geom_point()


