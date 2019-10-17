# Example 1
# U. S. Gasoline Market
# Structural Change: Sample Separation
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

results<-lm(g~y+pg+pnew+pused)
summary(results)
# test of homoscedasticity in groups
bartlett.test(results$residuals,year<1978)

results1<-lm(g~y+pg+pnew+pused,subset=year<1978)
summary(results1)
results2<-lm(g~y+pg+pnew+pused,subset=year>1977)
summary(results2)

## Calculate RSS and DF for restricted and unrestricted models
RSSr<-sum(results$residuals^2)
DFr<-results$df.residual
RSSur<-sum(results1$residuals^2)+sum(results2$residuals^2)
DFur<-results1$df.residual+results2$df.residual

## Computing the Chow test statistic (F-test)
Ftest<-((RSSr-RSSur)/(DFr-DFur))/(RSSur/DFur)
Ftest

## Calculate P-value
1-pf(Ftest, DFr-DFur, DFur)
