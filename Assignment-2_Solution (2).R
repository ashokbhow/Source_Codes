## CMTH 642
## Assignment 2  Ashok Bhowmick

getwd()
setwd("C:/Data Science/Ryerson Courese CMTH 642/Assignment")
## Writing the final file from Assignment 1 
## Fiename USDB_Final (Please see end of Q.no. 13 in Assignment-1)

USDB <- read.csv("USDA-Bhowmick.csv", header = TRUE)
View(USDB)
nrow(USDB)
##
library(dplyr)
USDB_New <- mutate(USDB, HighCalories = Calories, HighSodium = Sodium, HighSugar = Sugar, HighFat = TotalFat, HID = ID)
View(USDB_New)
##
mean.Calories <- mean(USDB$Calories)
mean.Sodium <- mean(USDB_New$Sodium)
mean.Sugar <- mean(USDB_New$Sugar)
mean.Fat <- mean(USDB_New$TotalFat)
c(mean.Calories, mean.Sodium, mean.Sugar, mean.Fat)
##
x1 <- USDB_New[, c(17, 21)]
x2 <- USDB_New[, c(18, 21)]
x3 <- USDB_New[, c(19, 21)]
x4 <- USDB_New[, c(20, 21)]
##
x1[x1$HighCalories <= mean.Calories, ] <- 0
x1[x1$HighCalories > mean.Calories, ] <- 1
##
x2[x2$HighSodium <= mean.Sodium, ] <- 0
x2[x2$HighSodium > mean.Sodium, ] <- 1
##
x3[x3$HighSugar <= mean.Sugar, ] <- 0
x3[x3$HighSugar > mean.Sugar, ] <- 1
##
x4[x4$HighFat <= mean.Fat, ] <- 0
x4[x4$HighFat > mean.Fat, ] <- 1
##
x <- cbind(x1, x2, x3, x4)
View(x)
x_edit <- drop(x[, c(1, 3, 5, 7)])
View(x_edit)
##
## Final working file for Assignment 2
USDF <- cbind(USDB, x_edit)
View(USDF)
rm(USDB_New, x1, x2, x3, x4, x, x_edit)
##
## Assignment 2 Questions

## Question No. 1
## Data Visualization and illustration of distribution
library(ggplot2)
a <- ggplot(USDF, aes(TotalFat))
b <- ggplot(USDF, aes(Protein))
c <- ggplot(USDF, aes(Carbohydrate))
## Density distribution
a + geom_density(kernel = "gaussian", color = "red", fill = "light blue") + labs(x = "Total Fat", y = "Density of Fat", title = "Density distribution of Fat in Food")
b + geom_density(kernel = "gaussian", color = "green", fill = "light yellow") + labs(x = "Protein", y = "Density of Protein", title = "Density distribution of Protein in Food")
c + geom_density(kernel = "gaussian", color = "blue", fill = "light grey") + labs(x = "Carbohydrate", y = "Density of Carb", title = "Density distribution of Carbohydrate in Food")
## Frequency Histogram
a + geom_histogram(binwidth = 1, color = "red", fill = "light blue") + labs(x = "Total Fat", y = "Freq. count of Fat", title = "Histogram of Fat in Food")
b + geom_histogram(binwidth = 1, color = "green", fill = "light yellow") + labs(x = "Protein", y = "Freq. count of Protein", title = "Histogram of Protein in Food")
a + geom_histogram(binwidth = 1, color = "blue", fill = "light grey") + labs(x = "Carbohydrate", y = "Freq. count of Carb", title = "Histogram of Carbohydrate in Food")
##

## Question No. 2
d <- ggplot(USDF, aes(TotalFat, Calories))
d + geom_point(size=1, alpha=0.5, color="red") + labs(x="Fat content in food", y="Energy in Calories", title="Energy conten of Fat in food") + geom_smooth(method="lm", se=TRUE, size=1, color="blue") + geom_line(y=mean(USDB$Calories)) + annotate("text", x=50, y= 260, label="mean Calories line")
##

## Question No. 3
## Examining linearity
## The question says, High Calories. It is the added nominal variable in Assignment 1 which
## is created by assigning 1 to high Sodium and 0 to low Sodium. So it has only 0 and 1 as values
## and ideally, a Multiple Logistic Regression has to be done in such case.
## 
## formula : ln(p/(1-p))= a + b1x1 + b2x2 + b3x3 + ... and the result is given
## by Maximum Likelihood Method. 
## 

## Regression 
summary(glm(HighCalories ~ Carbohydrate + Protein + TotalFat + Sodium, data = USDF, family = binomial))
##
P1 <- (1-pchisq(8157.2, 6019))
P1

## Question No. 4
## From the answer of question No. 3
## Significance level of Sodium is found to be the lowest
## To visualize
model1 <- glm(HighCalories ~ Sodium, data = USDF, family = binomial("logit"))
summary(model1)
range(USDF$Sodium)
x <- seq(min(USDF$Sodium), max(USDF$Sodium), 5000)
y <- predict(model1, list(Sodium=x), type = "response")
plot(HighCalories ~ Sodium, data = USDF)
lines(x, y)


## Question No. 5
## From the answer of Question 3, all Carbohydrate, Protein and TotalFat have 
## comparable significance where TotalFat has highest z-score
## Choosing TotalFat as the most significant one
model2 <- glm(HighCalories ~ TotalFat, data = USDF, family = binomial("logit"))
summary(model2)
range(USDF$TotalFat)
x <- seq(min(USDF$TotalFat), max(USDF$TotalFat), 10)
y <- predict(model2, list(TotalFat=x), type = "response")
plot(HighCalories ~ TotalFat, data = USDF)
lines(x, y)

##
library(ggplot2)
gl <- ggplot(USDF, aes(Carbohydrate, TotalFat))
gl + geom_point(size=1, alpha=0.5, aes(color=HighCalories)) + facet_grid(HighSodium~HighSugar) + labs(title = "Low and High Sodium ~ Sugar")
##

## Question No. 6
## Comment:
## As a function call, individual food name or their ID has to be called each time
## Thereby separating all healthy foods together is an issue and could be a lengthy routine
## so the following has been done as the question does not specify whether
## a complete separation or individual merit is to be explored ! 

USDF_Check <- USDF[, c(2, 3, 18, 19, 20)]
View(USDF_Check)
nrow(USDF_Check)
##
attach(USDF_Check)
## Separating Safe Foods 
Pass1 <- USDF_Check[which(USDF_Check$HighSodium == '0'), ]
nrow(Pass1)
##
Pass2 <- Pass1[which(Pass1$HighSugar == '0'), ]
nrow(Pass2)
##
SafeFoods <- Pass2[which(Pass2$HighFat == '0'), ]
nrow(SafeFoods)
View(SafeFoods)
##

## Unsafe Foods
Fail1 <- USDF_Check[which(USDF_Check$HighSodium == '1'), ]
nrow(Fail1)
##
Fail2 <- Fail1[which(Fail1$HighSugar == '1'), ]
nrow(Fail2)
##
UnsafeFoods <- Fail2[which(Fail2$HighFat == '1'), ]
nrow(UnsafeFoods)
View(UnsafeFoods)
##

## Note:
## Notice, Safe + Unsafe does not sum up to total food because these are totally
## safe and totally unsafe food by criteria. However, there will be intermediates who has one 
## 2 parameters either '0' or '1'. They can also be counted out by cross selecting
## by doing Pass on Fail or Fail on Pass. Not asked in question though!
## For example
## Sodium & Sugar safe
Int1 <- USDF_Check[which(USDF_Check$HighSodium == '0' & USDF_Check$HighSugar == '0'), ]
nrow(Int1)

##
## Sodium & Fat safe
Int2 <- USDF_Check[which(USDF_Check$HighSodium == '0' & USDF_Check$HighFat == '0'), ]
nrow(Int2)

##
## Sugar and Fat safe
Int3 <- USDF_Check[which(USDF_Check$HighSugar == '0' & USDF_Check$HighFat == '0'), ]
nrow(Int3)

## etc.
detach(USDF_Check)
##
source("SFood.R")
##
## Question No. 7

View(USDF)
nrow(USDF)
library(dplyr)
FoodSafety <- mutate(USDF, HealthCheck = ID)
FoodSafety$HealthCheck[which(FoodSafety$HighSodium == '0' & FoodSafety$HighSugar == '0' & FoodSafety$HighFat == '0')] <- "Safe Food"
FoodSafety$HealthCheck[which(FoodSafety$HighSodium == '1' | FoodSafety$HighSugar == '1' | FoodSafety$HighFat == '1')] <- "Unsafe Food"
nrow(FoodSafety)
View(FoodSafety)
##
write.csv(FoodSafety, "Food-Final_Bhowmick.csv")
##
## Question No. 8
## Foods that fail HealthCheck which has either one value high
(nrow(USDF)-nrow(SafeFoods))
length(which(FoodSafety$HealthCheck == "Unsafe Food"))
##
rm(USDF_Check)
## End Assignment 2




         