%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%Xzgen    generate the true state and the measurement at time k
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         plant equation:      x(k) = F(k-1)*x(k-1) + G(k-1)*v(k-1)           %
%         measurment equation: z(k) = H(k)*x(k)     + I(k)*w(k)               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x,z,v,w] = Xzgen(xk_1,Fk_1,Gk_1,Hk,Ik,Qk_1,Rk,vmk_1,wmk)
   v = Normal(vmk_1,Qk_1);
   w = Normal(wmk,Rk);
   x = Fk_1*xk_1 + Gk_1*v;
   z = Hk*x + Ik*w;
   return ;
   

