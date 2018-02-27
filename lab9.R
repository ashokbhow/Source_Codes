#Q1
data(USArrests) 
head(USArrests) 
pairs(USArrests)
##
out1=princomp(USArrests, cor=T)
summary(out1)
out1$loadings 
out1$scores 
screeplot(out1, type = "line")
## 
eigen(cor(USArrests))
eigen(cor(USArrests))$values/4
library(lattice)
biplot(out1)

#Q2
ab=read.csv("Climate.csv") 
attach(ab)
ab <- na.omit(ab)
head(ab) 
str(ab)

data.frame(names(ab)) 

tcol=colorRampPalette(c("blue","lightblue","yellow","red"))(100) 

levelplot(MAT~X*Y, aspect="iso", cuts=99, col.regions=tcol)

pcol=colorRampPalette(c("brown","yellow","darkgreen", "darkblue"))(100)


levelplot(log(MAP)~X*Y, aspect="iso", cuts=99, col.regions=pcol)

levelplot(ECOSYS~X*Y, aspect="iso", cuts=20, col.regions=rainbow(21))



#Q3
data.frame(names(ab))
out2=princomp(ab[,6:18], cor=T)
##
library(vegan) 
vectors=envfit(out2$score[,1:2], ab[,c(7,9,18)], permutations=0) 
##
plot(out2$score[,1:2],cex=0.3,asp=1,col=rainbow(21)[ab$ECOSYS])
plot(vectors, col="black")
##
legend(9~-12.5, cex=0.8, bty="n", pch=c(16), col=rainbow(21), legend=sort(unique(ab$ECOSYS)))



