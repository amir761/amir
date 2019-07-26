
library(data.table)
library(dplyr)
library(forecast)
library(keras)
library(tensorflow)

#reading data
data <- read.csv("train.csv")

#converting columns to approprite data type
#train
data[, c(2, 3)] <- lapply(data[, c(2,3)], as.factor)

#checking for na and inf in both train and test
apply(data, 2, function(x) any(is.na(x) | is.infinite(x)))

s1i1 <- data %>% filter(store == 1, item == 1)

Series <- (s1i1$sales)
plot(Series)
s_train <- Series[1:1500]
s_test  <- Series[1501:1826]

model <- nnetar(s_train)
fc <- forecast(model, h = 326)
plot(fc)
lines(s_train, col = "red")
