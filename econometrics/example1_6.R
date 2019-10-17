# Example 1
# U. S. Gasoline Market
# Structural Change: dummy variable approach
# Read Stata dataset from a file or URL
library(foreign)
# data<-read.dta("C:/Course15/EC570/data/gasoline.dta")
data<-read.dta("http://web.pdx.edu/~crkl/ec570/data/gasoline.dta")
summary(data)
attach(data)

g<-log(gasexp/(pop*gasp))  # log-per-capita gas consumption
y<-log(income)             # log-per-capita income
pg<-log(gasp)              # log price of gas
pnew<-log(pnc)             # log price of new cars
pused<-log(puc)            # log price of used cars

results1<-lm(g~y+pg+pnew+pused)  # restricted model
summary(results1)
RSSr<-sum(results1$residuals^2)
DFr<-results1$df.residual

break_year<-factor(year<1978)                 # dummy variable
results2<-lm(g~y+pg+pnew+pused+break_year)    # model with additive dummy variable
summary(results2)

results3<-lm(g~(y+pg+pnew+pused)*break_year)  # unrestricted model
summary(results3)
RSSur<-sum(results3$residuals^2)
DFur<-results3$df.residual

Ftest<-((RSSr-RSSur)/(DFr-DFur))/(RSSur/DFur)
Ftest

# alternatively, do ANOVA
anova(results1,results3)
