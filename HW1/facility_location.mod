# AMPL mod file for facility location

## Sets
set I; # set of facilities
set J; # set of customers

## Parameters
param d {I,J} >= 0; # distance between facility i and customer j

## Variables
var x {I} binary; # x[i] = 1 if facility i is open
var y {I,J} binary; # y[i,j] = 1 if customer j is assigned to facility i

## Objective
minimize cost: sum {i in I, j in J} d[i,j] * y[i,j];

## Constraints
subject to closed_facility {i in I, j in J}: y[i,j] <= x[i];
subject to assign_customer {j in J}: sum {i in I} y[i,j] = 1;
subject to num_facilities: sum {i in I} x[i] = 3;


