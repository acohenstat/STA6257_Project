
library(rmarkdown)
library(tidyverse)
library(knitr)
library(ggthemes)
library(ggrepel)
library(dslabs)
library(datasets)
library(ggplot2)
library(cluster)
library(bnlearn)
# Subset iris dataset
iris_data <- iris[, -5]  # Exclude the 5th column (Species)

head(iris_data)

# Scale the data
# iris_scaled <- scale(iris_data)

# Set a random seed for reproducibility
# set.seed(123)

# Apply k-means clustering with 3 clusters
# kmeans_result <- kmeans(iris_scaled, centers = 3, nstart = 20)

# Add cluster assignment to the original data
# iris$Sepal.Length.Cluster <- as.factor(kmeans_result$cluster)
# iris$Sepal.Width.Cluster <- as.factor(kmeans_result$cluster)
# iris$Petal.Length.Cluster <- as.factor(kmeans_result$cluster)
# iris$Petal.Width.Cluster <- as.factor(kmeans_result$cluster)

# Map cluster numbers to categories
# cluster_map <- c("Small", "Medium", "Large")
# iris$Sepal.Length.Category <- cluster_map[as.numeric(iris$Sepal.Length.Cluster)]
# iris$Sepal.Width.Category <- cluster_map[as.numeric(iris$Sepal.Width.Cluster)]
# iris$Petal.Length.Category <- cluster_map[as.numeric(iris$Petal.Length.Cluster)]
# iris$Petal.Width.Category <- cluster_map[as.numeric(iris$Petal.Width.Cluster)]

# Define Bayesian network structure
network_structure <- "Species ~ Sepal.Length.Category + Sepal.Width.Category + Petal.Length.Category + Petal.Width.Category"

# Learn CPTs using Hill-Climbing algorithm
#bn_iris <- bn.fit(network_structure, data = iris, method = "hc", max.ite = 100)

# Display head of the modified iris dataset
# table_md <- knitr::kable(head(iris), format = "markdown")
# print(table_md)