# U.S. Consumption-Income Relationship
setwd("C:/Course16/EC570/R")
usdata <- read.csv("http://people.stern.nyu.edu/wgreene/Text/Edition7/TableF5-2.csv")
summary(usdata)

c <- usdata$REALCONS
y <- usdata$REALGDP
logc <- log(c)
logy <- log(y)

# comparing the following 3 non-nested models:
# (1) c = a0 + a1 y + e, e ~ Normal => c ~ Normal(E(c),Var(c))
# (2) log(c) = b0 + b1 y + e, e ~ Normal => log(c) ~ Normal(E(log(c)),Var(log(c)))
# (3) log(c) = c0 + c1 log(y) + e        
# from (2) or (3) => c ~ log-Normal(E*(c),Var*(c)), where
# E*(c) = exp[E(log(c))+0.5*Var(log(c))]
# Var*(c) = exp[2*E(log(c))+Var(log(c))]*exp[Var(log(c))-1]
m1 <- lm(c~y)
m2 <- lm(logc~y)
m3 <- lm(logc~logy)
# do not use AIC or BIC
AIC(m1,m2,m3)
BIC(m1,m2,m3)

# model 2 vs. model 3 => model 3
library(lmtest)
jtest(m2,m3)
encomptest(m2,m3)

# model 1 vs. model 3 
# compare the encompassed versions first
m1a <- lm(c~logy+y)
m3a <- lm(logc~logy+y)

logc.fit<-m3a$fitted
logc.rss<-sum(m3a$resid^2)
logc.v<-logc.rss/m3a$df.resid
c.fit<-exp(logc.fit+0.5*logc.v)
cor(c,c.fit)^2  # compare with model 1a's R^2 (0.9993)
summary(m1a)

# compute geometric mean of c
gmc<-exp(mean(logc))
(gmc^2)*logc.rss  # compare with model 1a's RSS
sum(m1a$resid^2)

# model 1 vs. model 2
logc.fit<-m2$fitted
logc.rss<-sum(m2$resid^2)
logc.v<-logc.rss/m2$df.resid
c.fit<-exp(logc.fit+0.5*logc.v)
cor(c,c.fit)^2  # compare with model 1's R^2 

# compute geometric mean of c
gmc<-exp(mean(logc))
(gmc^2)*logc.rss  # compare with model 1's RSS
sum(m1$resid^2)

# using graphs: based on model 1
plot(y,c)
abline(m1)
lines(y,c.fit,col="red")

# using graphs: based on model 2
plot(y,logc)
abline(m2)
lines(y,log(m1$fitted),col="red")

