%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% KalmanDef, user defined Kalman Filter parameters


% Filter Algorithm Type
FilterAlgorithmFlag = 1;
% 1 stand for ALGORITHM_KALMAN; % default value
% 2 for ALGORITHM_IMM
% 3 for ALGORITHM_alphabeta
% 4 for ALGORITHM_alphabetagamma

ipwcfghif(1)=0;          % index for piecewise constant Ff, Gf, Hf, and If
itvfghif(1)=0;           % index for timie-varying Ff, Gf, Hf, and If

% define F(t) matrix for filter
Ffstr{1} ='1     T     0     0';
Ffstr{2}=' 0     1     0     0';
Ffstr{3}=' 0     0     1     T';
Ffstr{4}=' 0     0     0     1';

Gfstr{1} ='T^2/2  0';
Gfstr{2}=' T      0';
Gfstr{3}=' 0      T^2/2';
Gfstr{4}=' 0      T';

Hfstr{1} = '1     0     0     0';
Hfstr{2} = '0     0     1     0';


Ifstr{1} = '1 0';
Ifstr{2} = '0 1';

% NOISE STATISTICS used in the FILTER:
ipwcqrvwf(1)=0;           % index for Qf, Rf, vmf, and wmf input
itvqrvwf(1)=0;            % index for time-varying Qf, Rf, vmf, and wmf

Qfstr{1} =' 0.01 0';          % covariance matrix of process noise    
Qfstr{2} =' 0   0.01';        

Rfstr{1} = '1 0 ';        % covariance matrix of measurement noise
Rfstr{2} =' 0  1';

vmf=[ 0  0 ]';            % bias of process noise 
wmf=[ 0  0 ]';            % bias of measurement noise 
 
% INITIAL CONDITIONS:
irandomx0p0=0;           % index for initial conditions
xt0=[ 25  0  120  4 ]';  % initial true state vector
x0 =[ 25  0  120  4 ]';  % initial estimate vector   
P0 = [                   % covariance matrix associated with x0
    0.2000         0         0         0
         0    0.2000         0         0
         0         0    0.2000         0
         0         0         0    0.2000
      ];
save Kalmandef;      

