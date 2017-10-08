%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
    function [xrkk,Pfkk,xkk_1,Pfkk_1,Sk,Wk,zkk_1,nuk,Pkk,Ckk,Xk]=MismatchKalman(xrk_1k_1,Pfk_1k_1,...
zk,Qk_1,Rk,vmk_1,wmk,Frk_1,Grk_1,Hrk,Irk,Pk_1k_1,Ck_1k_1,Ftk_1,Gtk_1,Htk,Qtk_1,Rtk,Xk_1,Tx)

   % Ffk_1(nx,nx); Gfk_1(nx,nv)
   Ffk_1 = Tx'*Frk_1*Tx;
   Gfk_1 = Tx'*Grk_1;
   % Hfk(nz,nr)
   Hfk = Hrk*Tx;
   Ifk = Irk;
   
   xfk_1k_1 = Tx'*xrk_1k_1;
   
   xkk_1 = Ffk_1*xfk_1k_1 + Gfk_1*vmk_1;
   Pfkk_1 = Ffk_1*Pfk_1k_1*Ffk_1' + Gfk_1*Qk_1*Gfk_1';
   zkk_1 = Hfk*xkk_1 + Ifk*wmk;
   nuk   = zk - zkk_1;
   Sk    = Hfk*Pfkk_1*Hfk' + Ifk*Rk*Ifk';
   Wk    = Pfkk_1*Hfk'*inv(Sk);
   xkk   = xkk_1 + Wk*nuk;
   xrkk = Tx*xkk;
   Pfkk   = (eye(size(Wk*Hfk))-Wk*Hfk)*Pfkk_1*(eye(size(Wk*Hfk))-Wk*Hfk)'+ Wk*Rtk*Wk';
   
   nuF = Ftk_1 - Ffk_1;
   nuH = Htk - Hfk;
   Xk = Ftk_1*Xk_1*Ftk_1'+Gtk_1*Qtk_1*Gtk_1';
   Ck_k_1 = nuF*Xk_1*Ftk_1'+Ffk_1*Ck_1k_1*Ftk_1'+ Gtk_1*Qtk_1*Gtk_1';
   Pkk_1 = Ffk_1*Pk_1k_1*Ffk_1' + Gtk_1*Qtk_1*Gtk_1' + nuF*Xk_1*nuF'+...
      Ffk_1*Ck_1k_1*nuF'+nuF*Ck_1k_1'*Ffk_1';
   Pkk   = (eye(size(Wk*Hfk))-Wk*Hfk)*Pkk_1*(eye(size(Wk*Hfk))-Wk*Hfk)'+ ...
      Wk*Rtk*Wk'+Wk*nuH*Xk*nuH'*Wk'-(eye(size(Wk*Hfk))-Wk*Hfk)*Ck_k_1*nuH'*Wk'- ...
      Wk*nuH*Ck_k_1'*(eye(size(Wk*Hfk))-Wk*Hfk);
   Ckk = (eye(size(Wk*Hfk))-Wk*Hfk)*Ck_k_1-Wk*nuH*Xk;
   return
