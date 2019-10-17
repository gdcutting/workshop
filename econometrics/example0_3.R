# clean up
rm(list=ls())

# set working directory
setwd("C:/Course16/EC570/R")

# data frames
x <- data.frame(id=1:5,male=c(T,T,F,F,F),age=c(29,45,23,62,59))
x
class(x)
names(x)  # same as objects(x)
str(x)
summary(x)

# lists
beers <- c("Pils","Lager","Pale Ale","Dark Ale")
cars <- c("BMW","Mercedes","Volkswagen")
mylist <- list(beers,cars)
mylist
# data frame is a special list of elements of equal length

# logical operations

# file I/O functions
# read from / write to data files in text, csv, xls, dta, ...
# math/stat functions
# mean, sd, var, max, min, sum, cumsum, 
# runif, rnorm, rt, rchisq, (p.., d..)
# lm, glm, nls, nlm, optim
