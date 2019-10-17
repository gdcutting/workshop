# clean up
rm(list=ls())

# set working directory
setwd("C:/Course16/EC570/R")

# matrices
x1<-1:3; x2<-4:6; x3<-7:9
x <- cbind(x1,x2,x3)
x
x <- rbind(x1,x2,x3)
x
dim(x)
length(x)

y <- matrix(1:8,nrow=2,ncol=4)
y
t(y)

a<-c(1,10,100)
a
x
# recycling
x+a
x-a
x*a
x/a

z <- matrix(1:9,3,3)
z
x+z
x*z
x%*%z

x/z
x+y[,1:3]
x*t(y[,1:3])
x%*%t(y[,1:3])

x%*%a
a%*%x

# factors
x <- c("yes","yes","no","yes","no")
class(x)
x <- as.factor(x)
class(x)
x
table(x)

# pre-ordered factors
x <- factor(c("agree","agree","neutral","disagree"),levels=c("disagree","neutral","agree"))
x
class(x)
unclass(x)

# save scrips
# save/load data
# save/load workspace

# clean up
ls()  # same as objects()
rm(list=ls())

# quit
q()
