## software carpentry 2016
# set working directory
setwd("~/Desktop/software-carpentry-2016/data-files/r-lesson/data/")
list.files()
read.csv("inflammation-01.csv", header = FALSE)

#assign names to values
weight_kg <- 55
weight_kg

#convert kg to lbs
weight_lbs = weight_kg*2.2

weight_kg <- 100
weight_lbs

#assign name to data
dat <- read.csv("inflammation-01.csv", header = FALSE)
dat

#what kind of variable
class(dat)
#data.frame
#dimensions
dim(dat)
# 60 rows, 40 columns
#find values
dat[1,1]
#rows, columns
dat[1:4,1:10]
#c is combine
dat[c(3,8,37,56), c(10,14,29)]
#all columns in row 5
dat[5,]

raptor_1 <- dat[1,]
max(raptor_1)
min(raptor_1)
max(dat[2,])

mean(dat[,7])
median(dat[,7])
sd(dat[,7])
mean(raptor_1)
class(raptor_1)
as.numeric(raptor_1)
mean(raptor_1)
#still didn't work

?apply
#average inflammation of each raptor over whole time period
avg_raptor_inflammation <- apply(dat, 1, mean)

avg_day_inflammation <- apply(dat, 2, mean)
avg_day_inflammation

#challenge question
animal <- c("m", "o", "n", "k", "e", "y")
animal[1:3]
animal[4:6]
animal[3:1]
animal[-1]
animal[-4]
animal[-1:-4]
animal[c(5, 2, 3)]

max(dat[5, 3:7])

#plotting 
plot(avg_day_inflammation)
max_day_inflammation <- apply(dat, 2, max)
plot(max_day_inflammation)
min_day_inflammation <- apply(dat, 2, min)
plot(min_day_inflammation)
sd_day_inflammation <- apply(dat, 2, sd)
plot(sd_day_inflammation)
