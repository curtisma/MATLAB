%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%FixedGainKalman, Fixed Gain KALMAN Filter


%Fixed Gain KALMAN Filter  standard discrete-time Kalman filter for the following system:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         plant equation:      x(k) = F(k-1)*x(k-1) + G(k-1)*v(k-1)          %
%         measurment equation: z(k) = H(k)*x(k)     + I(k)*w(k)              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This is one cycle of the algorithm.  F, G, H, and I need not be constant.  
% For example, they can be time varying and state dependent.

function [xkk,Pkk,xkk_1,Pkk_1,Sk,Wk,zkk_1,nuk]=FixedGainKalman(xk_1k_1,Pk_1k_1,...
zk,Qk_1,Rk,vmk_1,wmk,Fk_1,Gk_1,Hk,Ik,Wk)
   xkk_1 = Fk_1*xk_1k_1       + Gk_1*vmk_1;
   Pkk_1 = Fk_1*Pk_1k_1*Fk_1' + Gk_1*Qk_1*Gk_1';
   zkk_1 = Hk*xkk_1 + Ik*wmk;
   nuk   = zk - zkk_1;
   Sk    = Hk*Pkk_1*Hk' + Ik*Rk*Ik';
   % now ,Wk is fixed
   % Wk    = Pkk_1*Hk'*inv(Sk);
   xkk   = xkk_1 + Wk*nuk;
   Pkk   = (eye(length(Wk*Hk))-Wk*Hk)*Pkk_1*(eye(length(Wk*Hk))-Wk*Hk)'+Wk*Rk*Wk';
return
