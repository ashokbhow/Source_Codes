# Anscombes Quartlet
data("anscombe")

par(mfrow= c(2,2))
for (i in 1:4){
  plot(anscombe[,i], anscombe[,i+4], xlab='x', ylab='y') 
}
summary(anscombe)
par(mfrow= c(2,2))
for (i in 1:4){
  fit <- lm(anscombe[,i+4]~ anscombe[,i])
  plot(anscombe[,i], anscombe[,i+4], xlab='x', ylab='y', 
       main= paste0('cor ', round(cor(anscombe[,i], anscombe[,i+4]),2), 
                    ' slope ', round(fit$coefficients[2],2),
                    ' mean', )
  )
  abline(fit)
}

# DatasauRus
# https://cran.r-project.org/web/packages/datasauRus/vignettes/Datasaurus.html

install.packages("datasauRus")
if(require(ggplot2)){
  library(ggplot2)
  library(datasauRus)
  ggplot(datasaurus_dozen, aes(x=x, y=y, colour=dataset))+
    geom_point()+
    theme_void()+
    theme(legend.position = "none")+
    facet_wrap(~dataset, ncol=3)
}

# http://rstudio-pubs-static.s3.amazonaws.com/155188_cc8b400f7d134a3e9de6cbfb8320e1e0.html
# Simpsons Paradox
z = c("hardcover","hardcover", "hardcover","hardcover", "paperback", "paperback","paperback", 
      "paperback")

x1 = c( 150, 225, 342, 185)
y1 = c( 27.43, 48.76, 50.25, 32.01 )

x2 = c( 475, 834, 1020, 790)
y2 = c( 10.00, 15.73, 20.00, 17.89 )

x = c(x1, x2)
y = c(y1, y2)

plot(x,y)

cor(y, x)   #-0.5949366
cor(y1, x1) #0.8481439
cor(y2,x2)  #0.9559518

lm(y ~ x)
lm(y1 ~ x1)
lm(y2 ~ x2)


plot(x,y, type="n")
text(x,y,z, cex=0.8)


plot(x,y)

text(200,40,"hardcover")
model1 <- lm(y1 ~ x1)
abline(model1)

text(600,15,"paperback")
model2 <- lm(y2 ~ x2)
abline(model2)
