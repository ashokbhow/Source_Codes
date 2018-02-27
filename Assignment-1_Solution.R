## CIND 642 Assignment 1

## Setting Directory
getwd()
setwd("C:/Data Science/Ryerson Courese CMTH 642/Assignment")
getwd()

## Question No. 1
## Reading Data files
Macro <- read.csv("USDA_Macronutrients.csv", header = TRUE)
Micro <- read.csv("USDA_Micronutrients.csv", header = TRUE)
str(Macro)
str(Micro)

## Question No. 2
## Merging Data files
USDA <- merge(Macro, Micro, by = "ID")
str(USDA)

## Question No. 3
View(USDA)
USDA$Sodium <- as.numeric(gsub(",", "", USDA$Sodium))
USDA$Potassium <- as.numeric(gsub(",", "", USDA$Potassium))
nrow(USDA)
View(USDA)

## Question No. 4
Cal <- sum(is.na(USDA$Calories) == TRUE)
Pro <- sum(is.na(USDA$Protein) == TRUE)
Fat <- sum(is.na(USDA$TotalFat) == TRUE)
Carb <- sum(is.na(USDA$Carbohydrate) == TRUE)
Na <- sum(is.na(USDA$Sodium) == TRUE)
Chol <- sum(is.na(USDA$Cholesterol) == TRUE)
Sug <- sum(is.na(USDA$Sugar) == TRUE)
Ca <- sum(is.na(USDA$Calcium) == TRUE)
Fe <- sum(is.na(USDA$Iron) == TRUE)
K <- sum(is.na(USDA$Potassium) == TRUE)
C <- sum(is.na(USDA$VitaminC) == TRUE)
E <- sum(is.na(USDA$VitaminE) == TRUE)
D <- sum(is.na(USDA$VitaminD) == TRUE)
## Missing values in variables
c(Cal, Pro, Fat, Carb, Na, Chol, Sug, Ca, Fe, K, C, E, D)
##

## Question No. 5
## Leaving Sugar, Vitamin E and Vitamin D, maximum NA are in Vitamin C = 408

USDA_Clean1 <- USDA[!is.na(USDA$Sodium), ]
USDA_Clean2 <- USDA[!is.na(USDA_Clean1$Iron), ]
USDA_Clean3 <- USDA[!is.na(USDA_Clean2$Calcium), ]
USDA_Clean4 <- USDA[!is.na(USDA_Clean3$Cholesterol), ]
USDA_Clean5 <- USDA[!is.na(USDA_Clean4$Potassium), ]
USDA_Clean6 <- USDA[!is.na(USDA_Clean5$VitaminC), ]
nrow(USDA_Clean6)
View(USDA_Clean6)
## Reduced NA in Sugar, VitaminE, VitaminD
sum(is.na(USDA_Clean6$Sugar))
length(USDA_Clean6$Sugar)
sum(is.na(USDA_Clean6$VitaminE))
length(USDA_Clean6$VitaminE)
sum(is.na(USDA_Clean6$VitaminD))
length(USDA_Clean6$VitaminD)
## 
## Question No. 6
## mean of Sugar, Vitamin E, Vitamin D
mean.Sugar <- mean(USDA_Clean6$Sugar, na.rm = TRUE)
mean.VitaminE <- mean(USDA_Clean6$VitaminE, na.rm = TRUE)
mean.VitaminD <- mean(USDA_Clean6$VitaminD, na.rm = TRUE)
c(mean.Sugar, mean.VitaminE, mean.VitaminD)
##
## Replacement of mean value
USDA_Clean6$Sugar[is.na(USDA_Clean6$Sugar)]=mean.Sugar
sum(is.na(USDA_Clean6$Sugar))
##
USDA_Clean6$VitaminE[is.na(USDA_Clean6$VitaminE)]=mean.VitaminE
sum(is.na(USDA_Clean6$VitaminE))
##
USDA_Clean6$VitaminD[is.na(USDA_Clean6$VitaminD)]=mean.VitaminD
sum(is.na(USDA_Clean6$VitaminD))
##
## Question No. 7
USDAclean <- na.omit(USDA_Clean6)
View(USDAclean)
rm(USDA_Clean1, USDA_Clean2, USDA_Clean3, USDA_Clean4, USDA_Clean5, USDA_Clean6)

## Question No. 8
nrow(USDAclean)
##
mean.Sugar.final <- mean(USDAclean$Sugar)
mean.VitaminE.final <- mean(USDAclean$VitaminE)
mean.VitaminD.final <- mean(USDAclean$VitaminD)
c(mean.Sugar.final, mean.VitaminE.final, mean.VitaminD.final)

## Question No. 9
x <- USDAclean[, c(2, 7)]
Answer <- which(x$Sodium == max(x$Sodium))
x[Answer, ]

## Question No. 10
## Data Visualization (Fat vs Protein)
library(ggplot2)
g <- ggplot(USDAclean, aes(TotalFat, Protein))
g + geom_point(size=1, alpha=0.25, color="red") + labs(x="Fat", y="Protein", title="Fat vs Protein")
##
## Question No. 11
ggplot(USDAclean, aes(VitaminC)) + geom_histogram(binwidth = 1, color="red", fill="blue") + scale_x_continuous(limits = c(1, 100)) + labs(title="USDAclean: Vitamin C record")

## Question No. 12 and 13 together : they are similar (16 points)
##
library(dplyr)
USDA_New <- mutate(USDAclean, HighSodium = Sodium, HighCalorie = Sodium, HighProtein = Sodium, HighSugar = Sodium, HighFat = Sodium)
View(USDA_New)
##
X_data <- USDA_New[, c(16, 17, 18, 19, 20)]
View(X_data)
nrow(X_data)
##
mean.Sodium <- mean(USDAclean$Sodium)
##
X_data[X_data$HighSodium & X_data$HighCalorie & X_data$HighProtein & X_data$HighSugar & X_data$HighFat <= mean.Sodium, ] <- 0
X_data[X_data$HighSodium & X_data$HighCalorie & X_data$HighProtein & X_data$HighSugar & X_data$HighFat > mean.Sodium, ] <- 1
##
USDA_Final <- cbind(USDAclean, X_data)
rm(USDA_New, X_data)
View(USDA_Final)

## Question No. 14
##
F <- which(USDA_Final$HighSodium & USDA_Final$HighFat == '1')
length(F)

## Question No. 15
##
Y_data <- USDA_Final[, c(11, 18)]
View(Y_data)
I <- Y_data$Iron[which(Y_data$HighProtein == '1')]
c(length(I), mean(I))
L <- Y_data$Iron[which(Y_data$HighProtein == '0')]
c(length(L), mean(L))
##
rm(Y_data)
##
## The End































