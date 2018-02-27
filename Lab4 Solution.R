############## CMTH 642 LAB4 #####################

#Multiple Linear Regression###########
# lm(y ~ x1+x2+x3...,data)

## Question 1 Read the "mtcars" data 

mtcars
View(mtcars)
summary(mtcars)
str(mtcars)

attach(mtcars) #Attach is used to avoid using referring to the dataset every time. 
  #When you're done use "detach". 
  
  #####################################################

#Question 2 

input <- cbind(mpg,disp, hp, wt)
View(input)
head(input)
  
#OR this way

  #get the inputs 
  input <- mtcars[,c("mpg","disp","hp","wt")]   
print(head(input))

##An alternative code for Question 2 would be as follows: 
######################################################
#my_variables = c("mpg" , "disp" , "hp" , "wt")
#cars = mtcars[my_variables]
#cars
#print(head(cars)) 
######################################################

# Question 3

cor(input)# Correlation matrix
  
plot(input)

# Question 4 

results = lm (mpg ~ disp + hp , data = mtcars ) 
results

vif(results)# Variance Inflation Factor to check for correlation between variables.
#The lower the value the better.


# y_head = 30.73590 - 0.03035x1 - 0.02484 is the fitted value 


#Try this code for a 3d graph. It will give your the best fit. In this case it's a plane.
disp <- hp <- seq(-10, 10, length= 30)
f <- function(disp,hp){ mpg <-mpg = 30.73590 - 0.03035x1 - 0.02484  }
mpg <- outer(disp,hp,f)
persp(disp, hp, mpg, theta = 30, phi = 30, expand = 0.5, col = "lightblue")


# Question 5 

summary(results)

# The output shows that F-statistic: 43.09 with p-value: 2.062e-09,
# indicating that we should reject the null hypothesis.  The null hypothesis was that all of the ??j's are 
# equal to zero against the alternative that allows them to take any values. If we reject this null hypothesis
# (which we do because the p-value is small), then this is the same as saying there
# is enough evidence to conclude that at least one of the variables has predictive
# power in our linear model, i.e. that using a regression is predictively 'better' than
# just guessing the average. 

# Question 6 

reduced = lm (mpg ~ disp + hp , data = mtcars ) 
reduced 

full = lm ( mpg ~ disp + hp + wt , data = mtcars ) 

anova(reduced, full) 

# The output shows the results of the partial F-test. Since
# F=12.709 with p-value: 0.0013, we reject the null hypothesis.
# We say that the variable wt contribute to mpg once the 
# variables disp and hp have been taken into consideration. 

# Question 7 

results = lm (mpg ~ disp + hp , data = mtcars ) 

predict (results, data.frame ( hp = 100 , disp = 300) , interval = "confidence" )

# Question 8 

results = lm (mpg ~ disp + hp , data = mtcars ) 

predict (results , data.frame (hp = 100, disp = 300 ) , interval = "prediction" ) 


