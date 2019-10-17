# Example 1
# U. S. Gasoline Market
#
setwd("C:/Course16/EC570/R")
gasoline<-read.csv("http://people.stern.nyu.edu/wgreene/Text/Edition7/TableF2-2.csv")
# reading TableF2-2.txt file may cause problem due to unbalanced lines

g<-log(gasoline$GASEXP/(gasoline$POP*gasoline$GASP))  # log-per-capita gas consumption
y<-log(gasoline$INCOME)             # log-per-capita income
pg<-log(gasoline$GASP)              # log price of gas
pnew<-log(gasoline$PNC)             # log price of new cars
pused<-log(gasoline$PUC)            # log price of used cars

# Using matrix algebra to do OLS
nobs<-length(g)
Y<-g
X<-cbind(1,y,pg)
XX<-t(X)%*%X
XY<-t(X)%*%Y
invXX<-solve(XX)
b<-invXX%*%XY
e<-Y-X%*%b
M<-diag(1,nobs,nobs)-X%*%invXX%*%t(X)
# check M%*%X=0, t(X)%*%e=0, ...

results<-lm(g~y+pg)
summary(results)
anova(results)
vcov(results)

results$model
results$fitted.values
results$residuals
results$coefficients
results$rank
results$df.residual

resultx<-lm(g~y*pg)
summary(resultx)
# F test
anova(results,resultx)

# residuals plot
par(mfrow = c(2, 2), pty = "s")       
plot(results)
plot(resultx)

# interpretation of resultx: price elasticity
resultx$coefficients[3]+resultx$coefficients[4]*y
# price elasticity at the mean
resultx$coefficients[3]+resultx$coefficients[4]*mean(y)
