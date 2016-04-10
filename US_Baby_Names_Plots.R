library(ggvis)
library(dplyr)
library(data.table)
library(ggplot2)

filtered_extrema = read.csv("filtered_extrema.csv")

# plots female names with the largest increases in baby name counts
female = filtered_extrema %>%
  filter(Gender == 'F', ROC > 0, Count >= 500)
ggplot(female, aes(x = Year,y = ROC,col = Name))+geom_point()

# plots male names with the largest increases in baby name counts
male = filtered_extrema %>%
  filter(Gender == 'M', ROC > 0, Count >= 500)
ggplot(male, aes(x = Year,y = ROC,col = Name))+geom_point()

# plots female and male names with the largest increases in baby name counts
both = filtered_extrema %>%
  filter(ROC > 0, Count >= 500)
ggplot(both, aes(x = Year,y = ROC,col = Name))+geom_point()

# plots female names with the largest decreases in baby name counts
female_neg = filtered_extrema %>%
  filter(Gender == 'F', ROC < 0, Count >= 100)
ggplot(female_neg, aes(x = Year,y = ROC,col = Name))+geom_point()

# plots male names with the largest decreases in baby name counts
male_neg = filtered_extrema %>%
  filter(Gender == 'M', ROC < 0, Count >= 100)
ggplot(male_neg, aes(x = Year,y = ROC,col = Name))+geom_point()

# plots female and male names with the largest decreases in baby name counts
both_neg = filtered_extrema %>%
  filter(ROC < 0, Count >=100)
ggplot(both_neg, aes(x = Year,y = ROC,col = Name))+geom_point()


