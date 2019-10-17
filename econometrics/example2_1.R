# Example 2
# Cobb-Douglas Cost Function for Electricity Generation 
# Christensen and Greene (1976), JPE 84:655-676 (using first 128 obs.)
#
setwd("C:/Course16/EC570/R")
cgdata<-read.csv("http://people.stern.nyu.edu/wgreene/Text/Edition7/TableF4-4.csv")
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
obs<-seq_along(lnc)

# general model
cgmodel.1<-lm(lnc~lnpl+lnpk+lnpf+lnq+lnqq+lnqpl+lnqpk+lnqpf,subset=(obs<=128))
# cgmodel.1<-lm(lnc~(lnpl+lnpk+lnpf)*lnq+lnqq)
summary(cgmodel.1)

# linear hypothesis testing: linear homogeneity in prices
library(car)
lht(cgmodel.1,c("lnpl+lnpk+lnpf=1","lnqpl+lnqpk+lnqpf=0"))
# test lnpl+lnpk+lnpf=1,lnqpl+lnqpk+lnqpf=0
# R<-rbind(c(0,1,1,1,0,0,0,0,0),c(0,0,0,0,0,0,1,1,1))
# linearHypothesis(cgmodel.1,R,c(1,0))  

# data normalized by fuel price: lnpf, lnqpf drop out
lncpf<-lnc-lnpf
lnplpf<-lnpl-lnpf
lnpkpf<-lnpk-lnpf
lnqplpf<-lnq*lnplpf
lnqpkpf<-lnq*lnpkpf

# restricted model
cgmodel.2<-lm(lncpf~lnplpf+lnpkpf+lnq+lnqq+lnqplpf+lnqpkpf,subset=(obs<=128))
# cgmodel.2<-lm(lncpf~(lnplpf+lnpkpf)*lnq+lnqq)
summary(cgmodel.2)

# restricted model
cgmodel.0<-lm(lnc~lnpl+lnpk+lnpf+lnq,subset=(obs<=128))
summary(cgmodel.0)

# model comparison
cgmodel.3<-lm(lnc~lnplpf+lnpkpf+lnq+lnqq+lnqplpf+lnqpkpf,offset=lnpf,subset=(obs<=128))
summary(cgmodel.3)
anova(cgmodel.3,cgmodel.1)

