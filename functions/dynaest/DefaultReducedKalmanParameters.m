%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% DefaultReducedKalmanParameters, Set the default paramenter for reduced Kalman Filter

%ipwcfghif(1)=0;          % index for piecewise constant Ff, Gf, Hf, and If
%itvfghif(1)=0;           % index for timie-varying Ff, Gf, Hf, and If

clear Ffstr Gfstr Hfstr Ifstr Qfstr Rfstr;

str = num2str(eye(nr));
for i = 1:nr 
   Ffstr{i} = str(i,:);
end

str = num2str(eye(nr,nv));
for i = 1:nr 
   Gfstr{i} = str(i,:);
end

str = num2str(eye(nz,nr));
for i = 1:nz 
   Hfstr{i} = str(i,:);
end

if (nr == 3) & (nx == 4) & (nz == 2) & (nv == 2)
   Ffstr{1} = ' 1 T 0 ';
   Ffstr{2} = ' 0 1 0 ';
   Ffstr{3} = ' 0 0 1 ';
   Gfstr{1} = ' T^2/2 0 ';
   Gfstr{2} = ' T     0 ';
   Gfstr{3} = ' 0 T^2/2 ';
   Hfstr{1} = ' 1 0 0 ';
   Hfstr{2} = ' 0 0 1 ';
end   


str = num2str(eye(nz,nw));
for i = 1:nz 
   Ifstr{i} = str(i,:);
end

% NOISE STATISTICS used in the FILTER:
%ipwcqrvwf(1)=0;           % index for Qf, Rf, vmf, and wmf input
%itvqrvwf(1)=0;            % index for time-varying Qf, Rf, vmf, and wmf

% Qf(nv,nv)                    % covariance matrix of process noise
str = num2str(0.01* eye(nv));
for i = 1:nv 
   Qfstr{i} = str(i,:);
end

% Rf (nw,nw)
str = num2str(1* eye(nw));
for i = 1:nw 
   Rfstr{i} = str(i,:);
end

vmf=zeros(nv,1);            % bias of     process noise 
wmf=zeros(nw,1);;            % bias of measurement noise 
 
% INITIAL CONDITIONS:
%irandomx0p0=0;           % index for initial conditions
if nr == 3
   x0 =[ 25  0  120]';  % initial estimate vector   
else
   x0 = Tx*xt0;
end
     
P0 = 0.2*eye(nr);
      
