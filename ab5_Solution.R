#####Q1####
x <- c(6, 8, 2, 4, 4, 5)
y <- c(7, 10, 4, 3, 5, 6)


boxplot(x, y)

hist(x, xlim=c(1,12), ylim= c(1,3), breaks = seq(from=1, to=12, by=2), col='red')
par(new=TRUE)
hist(y, xlim=c(1,12), ylim= c(1,3), breaks = seq(from=1, to=12, by=2), col='blue')
dev.off()

xrank <- rank(x)
yrank <- rank(y)
plot(xrank, col='red', ylim=c(1,7), ylab='x(red), y(blue)')
points(yrank, col='blue')

test_result <- wilcox.test(x,y, correct = F, exact=F)
summary(test_result)
test_result$statistic
test_result$parameter
test_result$p.value
test_result$method

wilcox.test(y,x, exact=F)

wilcox.test(x,y, correct=FALSE)

#data:  x and y
#W = 14, p-value = 0.5174
#The p-value is greater than 0.05, 
#then we can accept the hypothesis H0 of statistical 
#equality of the means of two groups.

#####Q2####

#A) Are these two groups of sampling paired or independent?
#   It is clear that the two groups are paired, 
#   because there is a bond between the readings, 
#   consisting in the fact that we are considering the same lake 
#   albeit in two different days.
a <- c(214, 159, 169, 202, 103, 119, 200, 109, 132, 142, 194, 104, 219, 119, 234)
b <- c(159, 135, 141, 101, 102, 168, 62, 167, 174, 159, 66, 118, 181, 171, 112)
plot(a, col='red', ylim=c(60,240), ylab='With Rental (red),  Without Rental(blue)')
points(b, col='blue')
#B)

wilcox.test(a,b, paired=TRUE, alternative = "less")


# [1] V = 80, p-value = 0.873

#Since the p-value is greater than 0.05, 
#we conclude that the means have remained essentially unchanged 
#(we accept the null hypothesis H0), 
#then banning the boat rental for a single day did not lead to any improvements 
#in terms of pollution of the lake.

#The value V = 80 corresponds to the sum of ranks assigned to the differences with positive sign.
#We can calculate the sum of ranks assigned to the differences with positive sign,
#and the sum of ranks assigned to the differences with negative sign,
#to compare this interval with the interval tabulated on the tables of Wilcoxon for paired samples,
#and confirm our statistic decision. Here’s how to calculate the two sums.

#C)
diff <- c(a - b) #Calculating the vector containing the differences
diff <- diff[ diff!=0 ] #delete all differences equal to zero
diff.rank <- rank(abs(diff)) #check the ranks of the differences, taken in absolute
diff.rank.sign <- diff.rank * sign(diff) #check the sign to the ranks, recalling the signs of the values of the differences
ranks.pos <- sum(diff.rank.sign[diff.rank.sign > 0]) #calculating the sum of ranks assigned to the differences as a positive, ie greater than zero
ranks.neg <- -sum(diff.rank.sign[diff.rank.sign < 0]) #calculating the sum of ranks assigned to the differences as a negative, ie less than zero
ranks.pos #it is the value V of the wilcoxon signed rank test
ranks.neg

#We accept the null hypothesis H0 of equality of the means. 
#As predicted by the p-value, banning bout rental 
#did not bring any improvements in terms of rate of pollution.


#Q3

zip <- c(10, 44, 65, 77, 43, 44, 22, 66, 50, 100, 55, 99, 44, 23, 100, 88, 200, 220, 110, 551)
tar <- c(20, 55, 75, 60, 55, 88, 35, 33, 35, 80, 65, 82, 47, 35, 97, 110, 250, 190, 111, 600)

#Q3-A: Paired, as the runtime is calculated based on archiving the same files.
#Q3-B
plot(density(zip)) #not normal
hist.default(zip)
plot(density(tar)) #not normal
hist.default(tar)

#Q3-C
wilcox.test(zip,tar, paired=TRUE)

# V = 85.5, p-value = 0.4779
# p-value > 0.05
# We accept the null hypothesis H0 of equality of the means. 


#Q4
boxplot(Ozone ~ Month, data = airquality, ylab='Ozone', xlab='Month')
wilcox.test(Ozone ~ Month, data = airquality,
            subset = Month %in% c(5, 8), exact = F)


#Q5
a = c(6, 8, 2, 4, 4, 5)
b = c(7, 10, 4, 3, 5, 6)
wilcox.test(b,a, correct=FALSE)
wilcox.test(a,b, correct=FALSE)

#Q6
women_weight <- c(38.9, 61.2, 73.3, 21.8, 63.4, 64.6, 48.4, 48.8, 48.5)
men_weight <- c(67.8, 60, 63.4, 76, 89.4, 73.3, 67.3, 61.3, 62.4) 
wilcox.test(men_weight, women_weight,alternative = "two.sided")

wilcox.test(men_weight, women_weight,alternative = "greater")

wilcox.test(women_weight, men_weight,alternative = "less")

wilcox.test(men_weight, women_weight,alternative = "less")
my_data <- data.frame( 
  group = rep(c("Woman", "Man"), each = 9),
  weight = c(women_weight,  men_weight)
)

wilcox.test(weight~group, data= my_data, alternative = "two.sided")
wilcox.test(weight~group, data= my_data, alternative = "greater")
wilcox.test(weight~group, data= my_data, alternative = "less")
