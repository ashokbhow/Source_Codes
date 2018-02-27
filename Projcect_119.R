setwd("C:/Data Science/Ryerson Courese CMTH 642/Assignment")
getwd()

## CIND 119 Project work: Dataset churn.csv
## Read Data file
churn <- read.csv("churn.csv", header = TRUE, sep = ",")

## 
head(churn)
str(churn)
summary(churn)

## View Data
View(churn)

## Data Types

## State: Char, Account.Length: Int, Area.Code: Int, Phone: Char, Int.I.Plan: Char
## VMail.Plan: Char, VMail.Message: Int, Day.Mins: Double, Day.Calls: Int, Day.Charge: Double
## Eve.Mins: Double, Eve.Calls: Int, Eve.Charge: Double, Night.Mins: Double, Night.Calls: Int
## Night.Charge: Double, Intl.Mins: Double, Intl.Calls: Int, Intl.Charge: double
## CustSer.Calls: Int, Churn?: Char

# Part I : Data Visualization

## Missing value check
St <- sum(is.na(churn$State) == TRUE)
Length <- sum(is.na(churn$Account.Length) == TRUE)
Code <- sum(is.na(churn$Area.Code) == TRUE)
Ph <- sum(is.na(churn$Phone) == TRUE)
Iplan <- sum(is.na(churn$Int.I.Plan) == TRUE)
Vmail <- sum(is.na(churn$VMail.Plan) == TRUE)
Vmsg <- sum(is.na(churn$VMail.Message) == TRUE)
Dmins <- sum(is.na(churn$Day.Mins) == TRUE)
Dcalls <- sum(is.na(churn$Day.Calls) == TRUE)
Dchg <- sum(is.na(churn$Day.Charge) == TRUE)
Emins <- sum(is.na(churn$Eve.Mins) == TRUE)
Ecalls <- sum(is.na(churn$Eve.Calls) == TRUE)
Echg <- sum(is.na(churn$Eve.Charge) == TRUE)
Nmins <- sum(is.na(churn$Night.Mins) == TRUE)
Ncalls <- sum(is.na(churn$Night.Calls) == TRUE)
Nchg <- sum(is.na(churn$Night.Charge) == TRUE)
Imins <- sum(is.na(churn$Intl.Mins) == TRUE)
Icalls <- sum(is.na(churn$Intl.Calls) == TRUE)
Ichg <- sum(is.na(churn$Intl.Charge) == TRUE)
Custserv <- sum(is.na(churn$CustServ.Calls) == TRUE)
Chrn <- sum(is.na(churn$Churn) == TRUE)

## Result 
c(St, Length, Code, Ph, Iplan, Vmail, Vmsg, Dmins, Dcalls, Dchg, Emins, Ecalls, Echg, Nmins, Ncalls, Nchg, Imins, Icalls, Ichg, Custserv, Chrn)
## Conclusion: No missing value in any column

## Histograms
library(lattice)
histogram(~ Account.Length + Area.Code + VMail.Message + Day.Mins + Day.Calls + Day.Charge + Eve.Mins + Eve.Calls + Eve.Charge, data = churn)
histogram(~ Night.Mins + Night.Calls + Night.Charge + Intl.Mins + Intl.Calls + Intl.Charge + CustServ.Calls, data = churn)
##

## Outliers
## 1. Account Length by Area Code
boxplot(Account.Length ~ Area.Code, data = churn, xlab = "Area.Code", ylab="Account.Length", main = "Account.Length outliers")
## 2. Day Pattern
boxplot(churn$Day.Mins, churn$Day.Calls, churn$Day.Charge, main = "Day: Mins/Calls/Charge")
## Evening Pattern
boxplot(churn$Eve.Mins, churn$Eve.Calls, churn$Eve.Charge, main = "Evening: Mins/Calls/Charge")
## Night Pattern
boxplot(churn$Night.Mins, churn$Night.Calls, churn$Night.Charge, main = "Night: Mins/Calls/Charge")
## International Pattern
boxplot(churn$Intl.Mins, churn$Intl.Calls, churn$Intl.Charge, main = "Intl: Mins/Calls/Charge")
##
## Customer Service Calls
boxplot(churn$CustServ.Calls, main = "Customer Service Calls")
##
## Attribute Relations and Dependency
library(corrplot)
Ch <- churn[, c(2,3,7,8,9,10,11,12,13,14,15,16,17,18,19)]
corrplot(cor(Ch))
##
library(psych)
## Day Evening Night Intl relations
Day <- churn[, c(8,9,10)]
Eve <- churn[, c(11,12,13)]
Night <- churn[, c(14,15,16)]
Intl <- churn[, c(17,18,19)]
pairs(Day)
pairs(Eve)
pairs(Night)
pairs(Intl)
## Some other on Calls
library(ggplot2)
## Day Calls Analysis
a <- ggplot(churn, aes(Day.Calls, Day.Mins))
a1 <- ggplot(churn, aes(Day.Calls))
a1 + geom_density(size = 1, alpha = 0.5, color = "red")
a + geom_point(size = 1, alpha = 0.5, color = "red") + facet_grid(.~ Area.Code)
##
## Evening Calls Analysis
e <- ggplot(churn, aes(Eve.Calls, Eve.Mins))
e1 <- ggplot(churn, aes(Eve.Calls))
e1 + geom_density(size = 1, alpha = 0.5, color = "blue")
e + geom_point(size = 1, alpha = 0.5, color = "blue") + facet_grid(.~ Area.Code)
##
## Night Calls Analysis
n <- ggplot(churn, aes(Night.Calls, Night.Mins))
n1 <- ggplot(churn, aes(Night.Calls))
n1 + geom_density(size = 1, alpha = 0.5, color = "black")
e + geom_point(size = 1, alpha = 0.5, color = "black") + facet_grid(.~ Area.Code)
##
## International Calls Analysis
i <- ggplot(churn, aes(Intl.Calls, Intl.Mins))
i1 <- ggplot(churn, aes(Intl.Calls))
i1 + geom_density(size = 1, alpha = 0.5, color = "green")
i + geom_point(size = 1, alpha = 0.5, color = "green") + facet_grid(.~ Area.Code)
##
## Distribution of attributes
attach(churn)
d1 <- density(Account.Length)
d2 <- density(Area.Code)
d3 <- density(VMail.Message)
d4 <- density(CustServ.Calls)
par(mfrow=c(2,2))
plot(d1)
plot(d2)
plot(d3)
plot(d4)
##
## Calls attributes
c1 <- density(Day.Calls)
c2 <- density(Day.Mins)
c3 <- density(Day.Charge)
c4 <- density(Eve.Calls)
c5 <- density(Eve.Mins)
c6 <- density(Eve.Charge)
c7 <- density(Night.Calls)
c8 <- density(Night.Mins)
c9 <- density(Night.Charge)
c10 <- density(Intl.Calls)
c11 <- density(Intl.Mins)
c12 <- density(Intl.Charge)
##
attach(churn)
par(mfrow=c(3,4))
plot(c1)
plot(c2)
plot(c3)
plot(c4)
plot(c5)
plot(c6)
plot(c7)
plot(c8)
plot(c9)
plot(c10)
plot(c11)
plot(c12)
##
## Distribution check to Normal function
x <- churn$Account.Length 
h<-hist(x, breaks=20, col="red", xlab="Account Length", 
        main="Histogram with Normal Curve") 
xfit<-seq(min(x),max(x),length=40) 
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
yfit <- yfit*diff(h$mids[1:2])*length(x) 
lines(xfit, yfit, col="blue", lwd=2)
## 
## Distribution check to Normal function
x <- churn$Day.Calls 
h<-hist(x, breaks=20, col="magenta", xlab="Day.Calls", 
        main="Histogram with Normal Curve") 
xfit<-seq(min(x),max(x),length=40) 
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
yfit <- yfit*diff(h$mids[1:2])*length(x) 
lines(xfit, yfit, col="red", lwd=2)
##
## Others can be checked followsuit
## End Part I: Data Visualization

## Part II : Classification Algorithms (knn & ctree)

## Remove categorical variables except churn to label

churn_m <- churn[, -c(1,4,5,6)]
View(churn_m)
write.csv(churn_m, file = "churn_m.csv")
## Data Sampling for Classification
train_index <- sample(1:nrow(churn_m), 0.7 * nrow(churn_m))
churn_train.set <- churn_m[train_index,]
churn_test.set  <- churn_m[-train_index,]
##
churn_train.set_new <- churn_train.set[-17]
churn_test.set_new <- churn_test.set[-17]
## Create Label data
churn_train_labels <- churn_train.set$Churn. 
churn_test_labels <- churn_test.set$Churn.
## 
library(clusterSim)
library(caret)
library(class)
library(gmodels)
## k-Nearest neighbor Classification on 70% train 30% test set; k = 3
churn_knn_prediction <- knn(train = churn_train.set_new, test = churn_test.set_new, cl= churn_train_labels, k = 3) 
## Result: k=3
CrossTable(x=churn_test_labels, y=churn_knn_prediction, prop.chisq=FALSE)
##
## k-Nearest neighbor Classification on 70% train 30% test set; k = 10
churn_knn_prediction_2 <- knn(train = churn_train.set_new, test = churn_test.set_new, cl= churn_train_labels, k = 10) 
## Result: k=10
CrossTable(x=churn_test_labels, y=churn_knn_prediction_2, prop.chisq=FALSE)
##
## Decision Tree Classification 
library(party)
library(partykit)
##
churn_tree_model <- ctree(Churn. ~ Account.Length + Area.Code + VMail.Message + Day.Mins + Day.Calls + Day.Charge + Eve.Mins + Eve.Calls + Eve.Charge + Night.Mins + Night.Calls + Night.Charge + Intl.Mins + Intl.Calls + Intl.Charge + CustServ.Calls, data = churn)
print(churn_tree_model)
plot(churn_tree_model, type = "extended")
## Prediction
churn_tree_prediction <- predict(churn_tree_model, churn_test.set)
head(churn_tree_prediction)
table(churn_tree_prediction, churn_test.set$Churn.)
## End of Decision Tree Analysis
##






