import pandas as pd
import networkx as nx
import matplotlib.pyplot as plt
from pgmpy.models import BayesianNetwork
from pgmpy.estimators import MaximumLikelihoodEstimator
from pgmpy.inference import VariableElimination

# Load the Adult Income dataset
# Adjust the path accordingly
data = pd.read_csv('data/adult.csv', delimiter=',', engine='python')
column_names = data.columns
print(column_names)

# For simplicity, let's select a subset of relevant variables
selected_columns = ["age", "education", "occupation", "income"]

# Restrict data to selected columns
data_subset = data[selected_columns]

# Create a Bayesian network model
model = BayesianNetwork()

# Define the structure of the Bayesian network
model.add_nodes_from(['age', 'education', 'occupation', 'income'])
model.add_edges_from([('age', 'income'), ('education', 'income'), ('occupation', 'income')])

# Learn the parameters (conditional probabilities) from data using Maximum Likelihood Estimation (MLE)
estimator = MaximumLikelihoodEstimator(model, data_subset)
model.fit(data_subset, estimator=estimator)

# Visualize the Bayesian network
plt.figure(figsize=(12, 8))
pos = nx.spring_layout(model, seed=42)  # Specifying the seed ensures consistent layout
nx.draw(model, pos, with_labels=True, node_size=3000, node_color="skyblue", font_size=12, font_weight="bold", arrows=True)
edge_labels = {(edge[0], edge[1]): f"P({edge[1]}|{edge[0]})" for edge in model.edges()}
nx.draw_networkx_edge_labels(model, pos, edge_labels=edge_labels, font_color='red')

plt.title("Bayesian Network - Adult Income Dataset")
plt.show()