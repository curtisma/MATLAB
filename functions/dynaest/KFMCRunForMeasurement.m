%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% KalmanFilter, Kalman Filter Algorithm when from measurement
% it's availabe only when SimulationFlag is 4
% Case 4 : No ExternalTruth, ExternalZ : Simulation Flag = 4 

Ff = zeros(nxf,nxf);
Gf = zeros(nxf,nvf);
Hf = zeros(nzf,nxf);
If = zeros(nzf,nwf);
Qf = zeros(nvf,nvf);
Rf = zeros(nwf,nwf);

colordef none;

% Monte Carlo runs:
Hf_wait = waitbar(0,'Doing Monte Carlo runs. Please wait...');

Estimation = zeros(nrun,nxf,kmax);
Measurement = ExternalZ;
FilterGain = zeros(nxf,nzf,kmax) ;

for nmc=1:nrun,
  waitbar(nmc/nrun); 
  
  T = ExternalT(nmc);
  
  [Ff,Gf,Qf] = ProcessModel(FilterModelFlag,nxf,nvf,T,omegaf,x0,Ffstr,Gfstr,Qfstr) ;
  [Hf,If,Rf] = ObservationModel(nzf,nwf,Hfstr,Ifstr,Rfstr) ;
    
  % initial condition
  clear x P;
  x=x0; P=P0; z=zeros(nz,1);
  for k=1:kmax
     z(:) = ExternalZ(nmc,:,k);
     % estimation using Kalman filter
     [x,P,xp,PP,S,W,zp,nu]=Kalman(x,P,z,Qf,Rf,vmf,wmf,Ff,Gf,Hf,If);
     if SystemModelFlag == 3
         temp = x(5) ;
         Ff = [ 1 ( sin(temp*T) )/temp 0 -(1-cos(temp*T))/temp 0 ;
             0 cos(temp*T) 0 -sin(temp*T) 0 ;
             0 (1-cos(temp*T))/temp 1 ( sin(temp*T) )/temp 0 ;
             0 sin(temp*T) 0 cos(temp*T) 0 ;
             0 0 0 0 1] ;        
     end
     if nmc == 1 
         for i =1:nxf
             for j=1:nzf
                 FilterGain(i,j,k) = W(i,j) ;
             end
         end
     end
     Estimation(nmc,:,k) = x(:);
 end% end of k
end% end of nmc

close(Hf_wait);
clear Hf_wait;

% The End
