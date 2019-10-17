# Example 1
# U. S. Gasoline Market
# 
# Read Stata dataset from a file or URL
library(foreign)
# data<-read.dta("C:/Course16/EC570/data/gasoline.dta")
data<-read.dta("http://web.pdx.edu/~crkl/ec570/data/gasoline.dta")
summary(data)

attach(data)
g<-log(gasexp/(pop*gasp))  # log-per-capita gas consumption
y<-log(income)             # log-per-capita income
pg<-log(gasp)              # log price of gas
pnew<-log(pnc)             # log price of new cars
pused<-log(puc)            # log price of used cars
detach(data)

results<-lm(g~y+pg+pnew+pused)
summary(results)
anova(results)
vcov(results)
ghat<-results$fitted.values
View(cbind(g,ghat))  # ess<-sum((ghat-mean(g))^2)

# check for residual autocorrelation
Box.test(results$residuals)
# check for residual normality
qqnorm(results$residuals)
qqline(results$residuals)

# linear hypothesis testing
library(car)
q<-c(0,0)
R<-rbind(c(0,0,0,1,0),c(0,0,0,0,1))
linearHypothesis(results,R,q)              # test pnew=0 and pused=0
linearHypothesis(results,c(0,0,0,1,-1),0)  # test pnew=pused
linearHypothesis(results,c(0,0,0,1,1),0)   # test pnew+pused=0
# alternatively, 
lht(results,c("pnew","pused"))
lht(results,"pnew=pused")
lht(results,"pnew+pused")

# Durbin-Watson test
durbinWatsonTest(results)
# alternatively,
dwt(results)

# a better model?
dg<-c(NA,diff(g,1))
results1<-lm(dg~y+pg+pnew+pused)
summary(results1)
# checking ...
dwt(results1)
qqnorm(results1$residuals)
qqline(results1$residuals)
