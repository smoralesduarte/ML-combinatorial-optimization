param M;# number of observations

set features;
set features0 within features;
param A{1..M,features}; # model matrix
param y{1..M}; # response

param sum_squares=sum{i in 1..M}y[i]^2;
param norm_feature{j in features}=sum{i in 1..M}A[i,j]^2;
param K=10;
param lambda=0.01;

var x{features0}; # regression variables
var z{features0} binary;
var t{features0}>=0;

minimize error: sum{i in 1..M}(y[i]-sum{j in features0}A[i,j]*x[j])^2+lambda*sum{j in features0}norm_feature[j]*t[j];

subject to card: sum{j in features0}z[j]<=K;

subject to perspective{j in features0}:t[j]*z[j]>=x[j]^2;

subject to multicolinealidad: z['PctIlleg']+z['PctKids2Par']<=1;