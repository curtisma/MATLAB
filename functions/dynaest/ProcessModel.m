%%% DynaEst 3.032 01/02/2001
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% Subfunction ProcessModel : generate process model for ground truth and measurement

function [Ft,Gt,Qt] = ProcessModel(SystemModelFlag,nx,nv,T,omega,xt0,Ftstr,Gtstr,Qtstr)

if ( SystemModelFlag == 1 | SystemModelFlag == 2 ) & nx == 5 
   nx = 4 ;
   nv = 2 ;
end

switch SystemModelFlag     
case 1 
   for i=1:nx
      Ft(i,:) = eval(['[',Ftstr{i},']']);  
   end
case 2
   Ft = [ 1 ( sin(omega*T) )/omega 0 -(1-cos(omega*T))/omega ;
      0 cos(omega*T) 0 -sin(omega*T) ;
      0 (1-cos(omega*T))/omega 1 ( sin(omega*T) )/omega ;
      0 sin(omega*T) 0 cos(omega*T) ; ] ;
case 3
   Ft = [ 1 ( sin(omega*T) )/omega 0 -(1-cos(omega*T))/omega 0 ;
      0 cos(omega*T) 0 -sin(omega*T) 0 ;
      0 (1-cos(omega*T))/omega 1 ( sin(omega*T) )/omega 0 ;
      0 sin(omega*T) 0 cos(omega*T) 0 ;
      0 0 0 0 1] ;
end

for i=1:nx
   Gt(i,:) = eval(['[',Gtstr{i},']']);  
end
for i=1:nv
   Qt(i,:) = eval(['[',Qtstr{i},']']);  
end

