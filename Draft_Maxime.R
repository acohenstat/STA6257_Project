
library(bnlearn)
library(Rgraphviz)
library(tidyverse)
library(gRain)

#data adjustments
dataset <- read.csv("data/adult.csv")
dataset[dataset == "?"] <- NA
# TCP process becomes to large for limits of R(12.5gb) need to prunce some nodes atm

dataset <- na.omit(dataset)
dataset <- subset(dataset, select = -fnlwgt)
dataset <- subset(dataset, select = -education.num)


#dataset$fnlwgt <- as.factor(dataset$fnlwgt)

#dataset$education.num <- as.factor(dataset$education.num)


breaks <- c(18, 40, 65, 100)  # Adjust as needed
labels <- c("Young", "Middle", "Retired")
dataset$age <- cut(dataset$age, breaks = breaks, labels = labels, include.lowest = TRUE)

breaks <- c(0, 5000, 10000, 20000, 100000)  # Adjust as needed
labels <- c("Low", "Medium", "High", "Rich")
dataset$capital.gain  <- cut(dataset$capital.gain, breaks = breaks, labels = labels, include.lowest = TRUE)


breaks <- c(0, 35, 40, 200)  # Adjust as needed
labels <- c("Partime", "FullTIme", "Overtime")
dataset$hours.per.week <- cut(dataset$hours.per.week, breaks = breaks, labels = labels, include.lowest = TRUE)

dataset$race <- as.factor(dataset$race)
dataset$native.country <- as.factor(dataset$native.country)
dataset$workclass <- as.factor(dataset$workclass)
dataset$education <- as.factor(dataset$education)
dataset$marital.status <- as.factor(dataset$marital.status)
dataset$occupation <- as.factor(dataset$occupation)
dataset$relationship <- as.factor(dataset$relationship)
dataset$sex <- as.factor(dataset$workclass)
dataset$income <- as.factor(dataset$income)


features = c("age","workclass","capital.gain",  
             "hours.per.week", "education","marital.status","relationship",  
             "occupation","sex", "native.country","race",          
             "income")

dag = empty.graph(features)
dag = set.arc(dag, from = "native.country", to = "income")
dag = set.arc(dag, from = "race", to = "income")

dag = set.arc(dag, from = "age", to = "education")
dag = set.arc(dag, from = "age", to = "occupation")
dag = set.arc(dag, from = "education", to = "occupation")
dag = set.arc(dag, from = "education", to = "income")
dag = set.arc(dag, from = "capital.gain", to = "income")
dag = set.arc(dag, from = "age", to = "capital.gain")
dag = set.arc(dag, from = "workclass", to = "capital.gain")
dag = set.arc(dag, from = "education", to = "workclass")
dag = set.arc(dag, from = "occupation", to = "hours.per.week")
dag = set.arc(dag, from = "occupation", to = "income")
dag = set.arc(dag, from = "marital.status", to = "relationship")
dag = set.arc(dag, from = "relationship", to = "income")
dag = set.arc(dag, from = "sex", to = "occupation")
dag = set.arc(dag, from = "sex", to = "income")
dag = set.arc(dag, from = "hours.per.week", to = "income")




graphviz.plot(dag, layout = "fdp")

fit <- bn.fit(dag, data = dataset, method = "bayes")

graphviz.chart(fit, type="barchart")

