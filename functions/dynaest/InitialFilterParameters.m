%%% DynaEst 3.032 02/15/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% InitialFilter Parameters

if nx == 5 
   nxf   = 4;  % dimension of state vector          
   nvf   = 2;  % dimension of process noise vector  
else
   nxf = nx ;
   nvf = nv ;
end

nzf   = nz;  % dimension of measurement vector    
nwf   = nw;  % dimension of measurement noise vector
omegaf = omega ;
    


