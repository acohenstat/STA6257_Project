library(bnlearn)
library(Rgraphviz)  # for plotting DAG

# Load your dataset (adjust path and delimiter as needed)
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

# Define your Bayesian network structure
model <- empty.graph(nodes = c(
                               "age",
                               "workclass",
                               "capital.gain",
                               "capital.loss",
                               "hours.per.week",
                               "education",
                               #"education.num",
                               #"marital.status",
                               #"relationship",
                               #"occupation",
                               #"race",
                               #"sex",
                               #"native.country",
                               "income"))

# Define the structure and edges of your Bayesian network
model <- set.arc(model, from = "age", to = "income")
model <- set.arc(model, from = "workclass", to = "income")
model <- set.arc(model, from = "capital.gain", to = "income")
model <- set.arc(model, from = "capital.loss", to = "income")
model <- set.arc(model, from = "hours.per.week", to = "income")
model <- set.arc(model, from = "education", to = "income")
#model <- set.arc(model, from = "education.num", to = "income")
#model <- set.arc(model, from = "marital.status", to = "income")
#model <- set.arc(model, from = "relationship", to = "income")
#model <- set.arc(model, from = "occupation", to = "income")
#model <- set.arc(model, from = "race", to = "income")
#model <- set.arc(model, from = "sex", to = "income")
#model <- set.arc(model, from = "native.country", to = "income")



# Select relevant columns from your dataset
selected_columns <-  c(
                               "age",
                               "workclass",
                               "capital.gain",
                               "capital.loss",
                               "hours.per.week",
                               "education",
                               #"education.num",
                               #"marital.status",
                               #"relationship",
                               #"occupation",
                               #"race",
                               #"sex",
                               #"native.country",
                               "income")
data_subset <- dataset[selected_columns]

# Learn the parameters (fit the model)
model_fitted <- bn.fit(model, data = data_subset)

# Plot the DAG (Directed Acyclic Graph)
graphviz.plot(model_fitted)

# Print CPTs
for (node in nodes(model_fitted)) {
  cat("CPT for", node, ":\n")
  print(model_fitted[[node]]$prob)
  cat("\n")
}