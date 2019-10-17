# Example 2
# Cobb-Douglas Cost Function for Electricity Generation 
# Christensen and Greene (1976), JPE 84:655-676
# Test and Correct for Heteroscedasticity
#
setwd("C:/Course16/EC570/R")
cgdata<-read.csv("http://people.stern.nyu.edu/wgreene/Text/Edition7/TableF4-4.csv")
# use the first 128 observations
# cgdata<-read.csv("http://people.stern.nyu.edu/wgreene/Text/Edition7/TableF4-4.csv",nrows=128)
summary(cgdata)

lnc<-log(cgdata$COST)     # log total cost
lnq<-log(cgdata$Q)        # log total output
lnpl<-log(cgdata$PL)      # log wage rate
lnpk<-log(cgdata$PK)      # log price of capital
lnpf<-log(cgdata$PF)      # log price of fuel
lnqq<-0.5*lnq^2
lnqpl<-lnq*lnpl
lnqpk<-lnq*lnpk
lnqpf<-lnq*lnpf

# data normalized by fuel price: lnpf, lnqpf drop out
lncpf<-lnc-lnpf
lnplpf<-lnpl-lnpf
lnpkpf<-lnpk-lnpf
lnqplpf<-lnq*lnplpf
lnqpkpf<-lnq*lnpkpf

# cost function: linear homogeneity in prices
cgmodel1<-lm(lncpf~lnplpf+lnpkpf+lnq+lnqq+lnqplpf+lnqpkpf)
# cgmodel<-lm(lncpf~(lnplpf+lnpkpf)*lnq+lnqq)
summary(cgmodel1)

cgmodel<-lm(lncpf~lnplpf+lnpkpf+lnq+lnqq)
summary(cgmodel)
anova(cgmodel,cgmodel1)

# test for homoscedasticity
library("lmtest")
bptest(cgmodel)
coeftest(cgmodel)

# correct for heteroscedasticity
library("car")
vcov(cgmodel)  # assuming homoscedasticity
hccm(cgmodel)  # assuming heteroscedasticity (White-Huber estimator) - heterosckedasticity consistent covariance matrix
coeftest(cgmodel,df=Inf,vcov.=hccm(cgmodel))

library(sandwich)
coeftest(cgmodel,df=Inf,vcov.=vcovHC)

