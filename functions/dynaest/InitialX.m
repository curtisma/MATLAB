%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% InitalX
function y = InitialX(SystemModelFlag,nx,omega)

if nx == 4
   xt0=[ 25  0  120  4 ]';  % initial true state vector
else
   xt0 = 100*rand(nx,1);
end

if SystemModelFlag == 3
    xt0 = [ 25  0  120  4 omega]' ;        
end

y=xt0 ;