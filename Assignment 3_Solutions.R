## CMTH 642 Assignment 3 
## Ashok Bhowmick, ID 500861640

setwd("C:/Data Science/Ryerson Courese CMTH 642/Assignment")
whitewine <- read.table("winequality-white.csv", header = TRUE, sep = ";")
View(whitewine)

## Question No. 1
## Data Characteristics
head(whitewine)
str(whitewine)
summary(whitewine)

## Check for missing values
sum(is.na(whitewine == TRUE))
## Clean Data ready for analysis
wine <- whitewine[, c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11)]
##

## Question No. 2
library(corrplot)
library(psych)
cor(wine)
corrplot(cor(wine))
pairs.panels(wine, ellipses = FALSE, smooth = FALSE, lm = TRUE)
##

## Question No. 3
library(ggplot2)
w <- ggplot(whitewine, aes(quality))
w + geom_freqpoly(size=1, alpha=0.5, color="red", binwidth = 0.2) + labs(x="Wine Quality", y="Frequency", title="Frequency distribution of Wine Quality") + annotate("text", x=6, y=2300, label="medium") + annotate("text", x=7, y=1000, label="high") + annotate("text", x=5, y=1600, label="low")
##

## Question No. 4
library(dplyr)
winequality <- mutate(whitewine, grade = quality)
x <- winequality[, c(12, 13)]
x[x$grade > 6, ] <- "high"
x[x$grade < 6, ] <- "low"
x[x$grade == 6, ] <- "medium"
View(x)
winequality <- cbind(whitewine, x)
winequality <- winequality[, -13]
View(winequality)
##

## Question No. 5
## package clusterSim
library(clusterSim)
winenormal <- data.Normalization(whitewine)
View(winenormal)
summary(winenormal)
##

## Question No. 6
wine_index <- sample(1:nrow(winenormal), 0.7*nrow(winenormal))
wine_train_set <- winenormal[wine_index, ]
wine_test_set <- winenormal[-wine_index, ]
str(wine_train_set)
str(wine_test_set)
##

## Question No. 7
wine_train_set_new <- wine_train_set[-12]
wine_test_set_new <- wine_test_set[-12]
nrow(wine_train_set_new)
nrow(wine_test_set_new)
##
wine_train_set_label <- wine_train_set$quality
wine_test_set_label <- wine_test_set$quality
##
library(caret)
library(class)
library(gmodels)
## knn test for k = 3
wine_knn_prediction <- knn(train = wine_train_set_new, test = wine_test_set_new, cl = wine_train_set_label, k = 3)
## knn test for k=11
wine_knn_prediction2 <- knn(train = wine_train_set_new, test = wine_test_set_new, cl = wine_train_set_label, k = 11)
##

## Question No. 8
## knn performance for k=3
CrossTable(x=wine_test_set_label, y=wine_knn_prediction, prop.chisq = FALSE)
## knn performance for k = 11
CrossTable(x=wine_test_set_label, y=wine_knn_prediction2, prop.chisq = FALSE)

## Question 8: Exploring other options
##
## By decision tree approach
library(party)
library(partykit)
wine_tree_model <- ctree(quality ~ fixed.acidity+volatile.acidity+citric.acid+residual.sugar+chlorides+free.sulfur.dioxide+total.sulfur.dioxide+density+alcohol, data = wine_train_set)
print(wine_tree_model)
plot(wine_tree_model, type = "extended")
wine_tree_prediction <- predict(wine_tree_model, wine_test_set)
head(wine_tree_prediction)
table(wine_tree_prediction, wine_test_set$quality)
##

## Stepwise regression approach
start <- lm(quality ~ 1, data = winenormal)
end <- lm(quality ~ fixed.acidity+volatile.acidity+citric.acid+residual.sugar+chlorides+free.sulfur.dioxide+total.sulfur.dioxide+density+alcohol, data = winenormal)
##
res.both <- step(start,scope=list(upper=end),direction="both",test="F")
summary(res.both)
##
## shows chlorides, fixed.acidity, total.sulfur.dioxide, citric.acid are low significant
## Regression 
summary(lm(quality ~ volatile.acidity+residual.sugar+free.sulfur.dioxide+density+alcohol, data = winenormal))

## PCA investigation for best regression
library(lattice)
winenormal.new <- winenormal[-12]
wine_pca <- princomp(winenormal.new, cor = TRUE)
screeplot(wine_pca, type = "line")
wine_pca$loadings
## from this analysis it shows that the following should provide the best regression for quality
summary(glm(quality ~ citric.acid+residual.sugar+chlorides+free.sulfur.dioxide+density+pH, data = winenormal))
##
## End of Assignment 3




