# get/set working directory
getwd()
setwd("C:/Course16/EC570/R")

# a few peculiar syntax: <-, ~, #
# get help
str(help)
help()
help(lm)
help.search("regression")

# install and use packages
# AER, Ecdat, car, ...
library(help="datasets")

# let's begin
1+1
a <- 1; b <- 2
a + b

c <- a-b
class(c)
c
c <- 1+2i
class(c)
c
c <- TRUE
class(c)
c
c <- "Hello!"
class(c)
c

# vectors
a <- c(1,2)
class(a)
b <- c(3,4)
c <- a + b
class(c)
c
c <- c("Hello","World!")
class(c)
c
c <- c("Hello","World!",2015)
class(c)
c

x <- 1:10
mean(x)
sd(x)
var(x)
length(x)
sum(x)

a <- 1:10
b <- 11:20
a + b
a * b
b / a

# recycling
c <- c(-1,-2)
a * c
b / c

# save scrips
# save/load data
# save/load workspace

# clean up
ls()  # same as objects()
rm(list=ls())

# quit
q()

