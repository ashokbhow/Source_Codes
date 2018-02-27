## CIND 642 : Lab-2
## Question No. 1
set.seed(0)
lumber <- rnorm(75, 36500, 2000)
c(mean(lumber), sd(lumber))
t.test(lumber, mu = 39000, alternative = "two.sided", conf.level = 0.95)
alpha <- (1-0.95)
t.half.alpha <- qt(1-(alpha/2), df = 74)
t.table.value <- c(-t.half.alpha, t.half.alpha)
t.table.value
p.value <- 2 * pt(-12.228, df = 74)
p.value
## conclusion : Null rejected

## Question No. 2
IT <- c(65, 78, 88, 55, 48, 95, 66, 57, 79, 81)
c(mean(IT), sd(IT))
t.test(IT, mu = 75, alternative = "two.sided", conf.level = 0.95)
alpha <- (1-0.95)
IT.half.alpha <- qt(1-(alpha/2), df = 9)
IT.table.value <- c(-IT.half.alpha, IT.half.alpha)
IT.table.value
p.value <- 2 * pt(-0.78303, df = 9)
p.value
## conclusion : Null Accepted

## Question No. 3
bottles <- c(484.11,459.49,471.38,512.01,494.48,528.63,493.64,485.03,473.88,501.59,502.85,538.08,465.68,495.03,475.32,529.41,518.13,464.32,449.08,489.27)
c(mean(bottles), sd(bottles))
t.test(bottles, mu = 500, alternative = "less", conf.level = 0.99)
alpha <- 0.01
bottle.alpha <- qt(1-(alpha), df = 19)
bottle.table.value <- c(-bottle.alpha, bottle.alpha)
bottle.table.value
p.value <- pt(-1.5205, df = 19)
p.value
## conclusion : Null Rejected, Alternate accepted

## Question No. 4
x <- c(0.593, 0.142, 0.329, 0.691, 0.231, 0.793, 0.519, 0.392, 0.418)
c(mean(x), sd(x))
t.test(x, mu = 0.3, alternative = "greater", conf.level = 0.95)
alpha <- (1-0.95)
x.alpha <- qt(1-(alpha), df = 8)
x.value <- c(-x.alpha, x.alpha)
x.value
## conclusion : NULL rejected

##Question No. 5
head(mtcars)
automatic = mtcars$am == 0
mpg.auto = mtcars[automatic, ]$mpg
mpg.auto
mpg.manual = mtcars[!automatic, ]$mpg
mpg.manual
t.test(mpg.auto, mpg.manual, var.equal = TRUE, conf.level = 0.95)
## conclusion : Not equal to zero

## Question No. 6
High_P <- c(134, 146, 104, 119, 124, 161, 107, 83, 113, 129, 97, 12)
Low_P <- c(70, 118, 101, 85, 107, 132, 94)
t.test(High_P, Low_P, var.equal = TRUE, conf.level = 0.95)
## conclusion : there is non zero difference and Null hypothesis rejected





