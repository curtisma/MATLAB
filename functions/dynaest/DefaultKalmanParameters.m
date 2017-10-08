%%% DynaEst 3.032 01/02/2001
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% DefaultKalmanParameters, Set the default paramenter for Kalman Filter

clear Ffstr Gfstr Hfstr Ifstr Qfstr Rfstr vmf wmf x0 P0;
if FilterModelFlag == 3 
   nxf = 5 ;
   nvf = 3 ;
end

[Ffstr,Gfstr,Qfstr,vmf] = GenerateProcessModel(FilterModelFlag, nxf,nvf,ncoor) ;
[Hfstr,Ifstr,Rfstr,wmf] = GenerateObservationModel(FilterModelFlag, nxf,nzf,nwf,ncoor) ;
x0 = InitialX(FilterModelFlag,nxf,omegaf) ;
P0 = 0.2*eye(nxf);  % Initial covariance for the filter



