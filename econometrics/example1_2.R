# Example 1
# U. S. Gasoline Market
# 
# Read multi-line raw data, transform to matrix, and data.frame
data1<-scan("http://people.stern.nyu.edu/wgreene/Text/Edition7/TableF2-2.txt",skip=1)
data<-data.frame(matrix(data1,ncol=11,byrow=TRUE))
year<-data$X1
gasexp<-data$X2
pop<-data$X3
gasp<-data$X4
income<-data$X5
pnc<-data$X6
puc<-data$X7

g<-log(gasexp/(pop*gasp))  # log-per-capita gas consumption
y<-log(income)             # log-per-capita income
pg<-log(gasp)              # log price of gas
pnew<-log(pnc)             # log price of new cars
pused<-log(puc)            # log price of used cars

model1<-lm(g~year+y+pg)   # full regression: X1=[1 year], X2=[y pg]
summary(model1)
# check Frisch-Waugh Theorem
model1a<-lm(g~year)
model1b<-lm(y~year)
model1c<-lm(pg~year)
model2<-lm(model1a$resid~model1b$resid+model1c$resid)
summary(model2)
model3<-lm(g~year+model1b$resid+model1c$resid)
summary(model3)

model1d<-lm(pg~year+y)
summary(model1d)
e<-residuals(model1d)

model4<-lm(g~e)
summary(model4)

