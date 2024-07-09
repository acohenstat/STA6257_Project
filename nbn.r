# Load necessary libraries
install.packages("e1071")  # Run this line if you don't have the e1071 package installed
install.packages("bnlearn")  # For Bayesian network structure and CPT visualization
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Rgraphviz")  # For DAG visualization

library(e1071)
library(bnlearn)
library(Rgraphviz)

# Load the Iris dataset
data(iris)

# Separate features and target variable
iris_data <- iris[, -5]
iris_target <- iris[, 5]

# Discretize the data
iris_discrete <- discretize(iris_data, method = "interval", breaks = 3)  # Using 3 intervals
iris_discrete$Species <- iris_target

# Split the data into training and test sets
set.seed(123)  # For reproducibility
sample_index <- sample(1:nrow(iris_discrete), 0.7 * nrow(iris_discrete))  # 70% training data
train_data <- iris_discrete[sample_index, ]
test_data <- iris_discrete[-sample_index, ]

# Train the Naive Bayes model
nb_model <- naiveBayes(Species ~ ., data = train_data)

# Predict on the test data
predictions <- predict(nb_model, test_data)

# Evaluate the model
confusion_matrix <- table(predictions, test_data$Species)
print(confusion_matrix)

# Calculate accuracy
accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
print(paste("Accuracy:", accuracy))

# Bayesian Network Structure using bnlearn
dag <- model2network("[Sepal.Length|Species][Sepal.Width|Species][Petal.Length|Species][Petal.Width|Species][Species]")

# Visualize the DAG using Rgraphviz
graphviz.plot(dag, main = "Naive Bayes Network for Iris Dataset")

# CPT Visualization using bnlearn
fit <- bn.fit(dag, data = train_data, method = "bayes")

# Print CPTs
for (node in nodes(fit)) {
  cat("CPT for", node, ":\n")
  print(fit[[node]]$prob)
  cat("\n")
}
