# Question 1

group1 = c(18.2, 20.1, 17.6, 16.8, 18.8, 19.7, 19.1) 
group2 = c(17.4, 18.7, 19.1, 16.4, 15.9, 18.4, 17.7) 
group3 = c(15.2, 18.8, 17.7, 16.5, 15.9, 17.1, 16.7)

observations = c(group1, group2, group3)
group_numbers = rep(1:3, rep(7, 3)) 

# checking how group_numbers looks like:
group_numbers

group_numbers = as.factor(group_numbers)
data = data.frame(observation=observations, group_number=group_numbers)

fit = lm(observation ~ group_number, data=data)
anova(fit)


# Question 2

# > oneway.test(folate~ventilation)
# One-way analysis of means (not assuming equal variances)


library(ISwR)
fit = lm(folate ~ ventilation, data=red.cell.folate)
anova(fit)


# Question 3

# Check tanner column, it seems tanner has numeric values.
summary(juul$tanner)

# converting tanner to factor
modified_juul <- juul
modified_juul$tanner <-factor(modified_juul$tanner,labels=c("I","II","III","IV","V"))

# check how new tanner column looks like
summary(modified_juul$tanner)

fit = lm(igf1~tanner, data=modified_juul)
anova(fit)

# Question 4:

fit = lm(hr~subj+time, data=heart.rate)
anova(fit)


      