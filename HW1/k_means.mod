# AMPL mod file for k-means with continuous centroids

# Sets
set observations; # index for observations
set centroids; # index for centroids

# Data
param observations_x {i in observations}; # x-coordinates of observations and cluster 1
param observations_y {i in observations}; # y-coordinates of observations and cluster 1

# Variables
var z {i in observations, j in centroids} binary; # assignment of observations to centroids
var t_x {i in observations, j in centroids}; # auxiliary variable for x-distances of observations to centroids
var t_y {i in observations, j in centroids}; # auxiliary variable for y-distances of observations to centroids
var p {i in observations, j in centroids}; # auxiliary variable for the objective function
var centroids_x {j in centroids}; # x-coordinates of centroids
var centroids_y {j in centroids}; # y-coordinates of centroids


# Objective
minimize cost: sum {i in observations, j in centroids} p[i, j];

# Constraints
subject to a1 {i in observations, j in centroids}: observations_x[i] - centroids_x[j] = t_x[i, j]; # auxiliary variable for x-distances of observations to centroids
subject to a2 {i in observations, j in centroids}: observations_y[i] - centroids_y[j] = t_y[i, j]; # auxiliary variable for y-distances of observations to centroids
subject to c1 {i in observations}: sum {j in centroids} z[i,j] = 1; # each observation is assigned to exactly one centroid
subject to tx_lims {i in observations, j in centroids}: -1000 <= t_x[i, j] <= 1000; # bound the x-distances of observations to centroids
subject to ty_lims {i in observations, j in centroids}: -1000 <= t_y[i, j] <= 1000; # bound the y-distances of observations to centroids
subject to p_lims {i in observations, j in centroids}: 0 <= p[i, j] <= 3200; # bound the auxiliary variable for the objective function
subject to c2 {i in observations, j in centroids}: t_x[i, j] * t_x[i, j] + t_y[i, j] * t_y[i, j]  <=  p[i, j] + 3200 * (1 - z[i, j]); # OR restrictions 

