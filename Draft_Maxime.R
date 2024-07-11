
library(bnlearn)
library(Rgraphviz)
library(tidyverse)

#data adjustments
dataset <- read.csv('data/adult.csv')
dataset[dataset == "?"] <- NA
dataset <- na.omit(dataset)
dataset <- subset(dataset, select = -fnlwgt)
breaks <- c(18, 30, 40, 50, 60, 70, 80, 90, 100)  # Adjust as needed
labels <- c("19-29", "30-39", "40-49", "50-59", "60-69", "70-79", "80-89", "90-100")
dataset$age <- cut(dataset$age, breaks = breaks, labels = labels, include.lowest = TRUE)
breaks <- c(0, 5000, 10000, 20000, 100000)  # Adjust as needed
labels <- c("Low", "Medium", "High", "Rich")
dataset$capital.gain  <- cut(dataset$capital.gain, breaks = breaks, labels = labels, include.lowest = TRUE)
dataset$capital.loss  <- cut(dataset$capital.loss, breaks = breaks, labels = labels, include.lowest = TRUE)
breaks <- c(0, 35, 40, 200)  # Adjust as needed
labels <- c("Partime", "FullTIme", "Overtime")
dataset$hours.per.week <- cut(dataset$hours.per.week, breaks = breaks, labels = labels, include.lowest = TRUE)
dataset$workclass <- as.factor(dataset$workclass)
dataset$education <- as.factor(dataset$education)
dataset$education.num <- as.factor(dataset$education.num)
dataset$marital.status <- as.factor(dataset$marital.status)
dataset$occupation <- as.factor(dataset$occupation)
dataset$relationship <- as.factor(dataset$relationship)
dataset$race <- as.factor(dataset$race)
dataset$sex <- as.factor(dataset$workclass)
dataset$native.country <- as.factor(dataset$native.country)
dataset$income <- as.factor(dataset$income)

features = c("age","workclass","capital_gain",
             "capital_loss","hours_per_week",
             "education","marital_status",
             "relationship","occupation",
             "sex","income")

model = empty.graph(features)

model = set.arc(model, from = "age", to = "education")
model = set.arc(model, from = "age", to = "occupation")
model = set.arc(model, from = "education", to = "occupation")
model = set.arc(model, from = "education", to = "income")
model = set.arc(model, from = "capital_gain", to = "income")
model = set.arc(model, from = "age", to = "capital_gain")
model = set.arc(model, from = "workclass", to = "capital_gain")
model = set.arc(model, from = "education", to = "workclass")
model = set.arc(model, from = "capital_loss", to = "income")
model = set.arc(model, from = "occupation", to = "hours_per_week")
model = set.arc(model, from = "occupation", to = "income")
model = set.arc(model, from = "marital_status", to = "relationship")
model = set.arc(model, from = "relationship", to = "income")
model = set.arc(model, from = "sex", to = "occupation")
model = set.arc(model, from = "sex", to = "income")
model = set.arc(model, from = "hours_per_week", to = "income")


graphviz.plot(model, layout = "fdp")
#evidence node : age, education, occupation, sex, workclass, marital_status
#query node : income
fitted_model <- bn.fit(model, data = dataset)


print(fitted_model)

# Plot the Bayesian Network with probabilities
graphviz.chart(fitted_model, grid = TRUE, scale = c(1, 1))

