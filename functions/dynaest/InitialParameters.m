%%% DynaEst 3.032 12/29/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% InitialParameters

omega = 1 ; %Constant/Initial angular rate 
kmax = 20;  % maximum number of time steps       
Tmin = 1;  % minimum sampling interval                  
Tmax = 1;	% maximum sampling interval
nrun = 10;  % number of Monte Carlo runs         
nseed= 6.265e+004;  % seed for random number generator   
nmt  = 1;  % number of system modes             

nx   = 4;  % dimension of state vector          
nv   = 2;  % dimension of process noise vector  
nz   = 2;  % dimension of measurement vector    
nw   = 2;  % dimension of measurement noise vector
ncoor= 2;  % number of coordinates              

