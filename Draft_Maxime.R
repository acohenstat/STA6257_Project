
library(bnlearn)
library(Rgraphviz)

data <- read.csv('data/adult.csv')

# Define the structure of the Bayesian Network
bn_structure <- model2network("[age][education|age][occupation|education:age][hours_per_week|occupation][income|education:occupation:hours_per_week][marital_status][relationship|marital_status][sex|occupation:income][race][native_country|race][income|sex:native_country]")

# Learn the parameters of the network
bn <- bn.fit(bn_structure, data)

# Print the network
print(bn)

# Plot the network

graphviz.plot(bn)
