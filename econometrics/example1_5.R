# Example 1
# U. S. Gasoline Market
# Structural Change: Sample Separation
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

results<-lm(g~y+pg+pnew+pused)  # restricted model
RSSr<-sum(results$residuals^2)
DFr<-results$df.residual

Ftest=NULL
for (t in 1960:1996){
    results1<-lm(g~y+pg+pnew+pused,subset=year<t)
    RSS1<-sum(results1$residuals^2)
    DF1<-results1$df.residual
    results2<-lm(g~y+pg+pnew+pused,subset=year>=t)
    RSS2<-sum(results2$residuals^2)
    DF2<-results2$df.residual
    RSSur<-RSS1+RSS2
    DFur<-DF1+DF2
    Ftest1<-((RSSr-RSSur)/(DFr-DFur))/(RSSur/DFur)
    PFtest1<-1-pf(Ftest1, DFr-DFur, DFur)
    Ftest<-rbind(Ftest,c(t,Ftest1,PFtest1))
}
plot(Ftest[,1],Ftest[,2],type="b",main="Chow Test of Structural Change",xlab="Break Year",ylab="F Test Statistic")
Ftest[Ftest[,2]==max(Ftest[,2]),]
