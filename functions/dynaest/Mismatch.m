%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%KFMismatch:  Kalman filter mismatch simulations-- Monte Carlo runs
% it's availabe only when SimulationFlag is 1 or 2 and nmt = 1 
% Case 1 : No ExternalTruth, External Z : SimulationFlag = 1, 2 

% if do not exist T, generate T
if exist('ExternalT','var') == 0
   if nmt == 1 
      ExternalT = Tmin+(Tmax-Tmin)*rand(1,nrun);
   else
      ExternalT = ones(1,nrun)*Tmulti ;
   end
end

longx=zeros(nx,kmax);longxt=longx;longxe=longx;longxp=longx;longnee=longx;
	             longRMS1=longx;  longsqP1=longx;
longz=zeros(nz,kmax);longzp=longz;longnun=longz; longnu=longz;
longv=zeros(nv,kmax);
longw=zeros(nw,kmax);
% longmodePr=zeros(nmf,kmax);
longnees=zeros(1,kmax); longnis=longnees;
LongP=zeros(nx*nx,kmax);LongMSE=LongP;LongPP=LongP;LongRMS2=LongP;LongsqP2=LongP;
LongS=zeros(nz*nz,kmax);
LongW=zeros(nx*nz,kmax);
LongRMS2=zeros(nx*nx,kmax);LongsqP2=LongRMS2;
LongRMS3=zeros(nx*nx,nx);LongsqP3=LongRMS3;
[c,maxsize]=computer;
if nx*nx*nx*kmax<=maxsize
  LLongRMS3=zeros(nx*nx*nx,kmax);LLongsqP3=LLongRMS3;
else
  errordlg('RMS3 and sqP3 are truncated.','error');
  LLongRMS3=zeros(nx*nx*nx,round(maxsize/(nx^3)));LLongsqP3=LLongRMS3;
end

Ft = zeros(nx,nx); Ff = zeros(nr,nr);
Gt = zeros(nx,nv); Gf = zeros(nr,nv);
Ht = zeros(nz,nx); Hf = zeros(nz,nr);
It = zeros(nz,nw); If = zeros(nz,nw);
Qt = zeros(nv,nv); Qf = zeros(nv,nv);
Rt = zeros(nw,nw); Rf = zeros(nw,nw);

Estimation = zeros(nrun,nx,kmax);
Truth = zeros(nrun,nx,kmax);
Measurement = zeros(nrun,nz,kmax);
FilterGain = zeros(nx,nz,kmax) ;

colordef none;

% Monte Carlo runs:
Hf_wait = waitbar(0,'Doing Monte Carlo runs. Please wait...');

existtruth = exist('ExternalTruth','var') ;
existZ = exist('ExternalZ','var') ;

for nmc=1:nrun,
  %disp(['run # ' num2str(nmc)])
  waitbar(nmc/nrun); 
  T = ExternalT(nmc);
  
  % Step 2
  if nmt == 1 
     if ~existtruth
        [Ft,Gt,Qt] = ProcessModel(SystemModelFlag,nx,nv,T,omega,xt0,Ftstr,Gtstr,Qtstr) ;
     end
     [Ht,It,Rt] = ObservationModel(nz,nw,Htstr,Itstr,Rtstr) ;
  else
     mode = 1 ;    
  end
   % End of Step 2
   
   [Ff,Gf,Qf] = ProcessModel(FilterModelFlag,nr,nv,T,omega,x0,Ffstr,Gfstr,Qfstr) ;
   [Hf,If,Rf] = ObservationModel(nz,nw,Hfstr,Ifstr,Rfstr) ;  
   
   % initial condition
   clear xt x P Ck_1k_1 Pr Xk_1;
   xt = zeros(nx,1) ;
   if ~existtruth 
      xt=xt0; 
   end
   x=x0; P=P0; z=zeros(nz,1);
   Ck_1k_1 = P0; Pf = P0;  Xk_1 = (Tx'*x0)*(Tx'*x0)'+P0;   
   
   for k=1:kmax,
      % Step 3
      if ~existtruth | ~existZ
         if nmt > 1 
            if k*T > FromTime(mode)
               [Ftstr, Gtstr,Htstr,Itstr,Qtstr,Rtstr] = FindMultiModel(k,T,FromTime,ToTime,ModeSystem,nmt) ;
               mode = mode + 1 ;
               if ~existtruth
                  [Ft,Gt,Qt] = ProcessModel(SystemModelFlag,nx,nv,T,omega,xt0,Ftstr,Gtstr,Qtstr) ;
               end
               if ~existZ
                  [Ht,It,Rt] = ObservationModel(nz,nw,Htstr,Itstr,Rtstr) ;
               end
            end
         end
      end
      % End of Step 3
      % generate true state and measurement at k
      if existtruth
         xt(:) = ExternalTruth(nmc,:,k);
         if exist('ExternalZ','var')
            z(:) = ExternalZ(nmc,:,k) ;
         else
            % generate z
            w = Normal(wmt,Rt);
            z = Ht*xt + It*w ;
         end
      else 
         [xt,z,v,w] = Xzgen(xt,Ft,Gt,Ht,It,Qt,Rt,vmt,wmt);
      end
      
      % store Truth and measurement
      for i=1:nx
         Truth(nmc,i,k) = xt(i);
      end
      for i=1:nz
         Measurement(nmc,i,k) = z(i);
      end
      
    clear x;
    x = Tx*xt;    
    % estimation using Kalman filter
    [x,Pf,xp,PP,S,W,zp,nu,P,Ck_1k_1,Xk_1]=...
       MismatchKalman(x,Pf,z,Qf,Rf,vmf,wmf,Ff,Gf,Hf,If,P,Ck_1k_1,Ft,Gt,Ht,Qt,Rt,Xk_1,Tx);
    
    if nmc == 1 
       for i =1:nx
          for j=1:nz
             FilterGain(i,j,k) = W(i,j) ;
          end
       end
    end

    
    for i=1:nr
       Estimation(nmc,i,k) = x(i);
    end
    for i=nr+1:nx
       Estimation(nmc,i,k) = 0;
    end

%    longxt(:,k) = longxt(:,k) + xt/nrun;
%    longz(:,k)  = longz(:,k)  + z/nrun;
%    longv(:,k)  = longv(:,k)  + v/nrun;
%    longw(:,k)  = longw(:,k)  + w/nrun;
%    longx(:,k)  = longx(:,k)  + x/nrun;
%    LongP(:,k)  = LongP(:,k)  + P(:)/nrun;
%    longmodePr(:,k)  = longmodePr(:,k) + modePr/nrun;
    xe          = xt-Tx'*x;
    longxe(:,k) = longxe(:,k) + xe/nrun;
    dummy       = xe*xe';
    LongMSE(:,k)= LongMSE(:,k) + dummy(:)/nrun;
    LongPP(:,k) = LongPP(:,k) + PP(:)/nrun;
    LongS(:,k)  = LongS(:,k) + S(:)/nrun;
    LongW(:,k)  = LongW(:,k) + W(:)/nrun;
    longRMS1(:,k)= longRMS1(:,k) + xe.*xe/nrun;
    dummy=[]; for i=1:nx, dummy(i) = P(i,i); end
    longsqP1(:,k)= longsqP1(:,k) + dummy'/nrun;
    
    clear RMS2 sqP2;
    for i=1:nx, for j=1:nx, 
       RMS2(i,j) = xe(i)^2+xe(j)^2; 
       sqP2(i,j) = P(i,j);
    end, end

    LongRMS2(:,k)= LongRMS2(:,k) + RMS2(:)/nrun;
    LongsqP2(:,k)= LongsqP2(:,k) + sqP2(:)/nrun;
    
    clear RMS3 sqP3;
    for l=1:nx, 
      for i=1:nx, for j=1:nx,
        RMS3(i,j) = xe(i)^2+xe(j)^2+xe(l)^2;
        sqP3(i,j) = P(i,i)+P(j,j)+P(l,l);
      end, end
      LongRMS3(:,l) = RMS3(:);
      LongsqP3(:,l) = sqP3(:);
    end
    if k<=maxsize/(nx^3)
      LLongRMS3(:,k)=LLongRMS3(:,k) + LongRMS3(:)/nrun;
      LLongsqP3(:,k)=LLongsqP3(:,k) + LongsqP3(:)/nrun;
    end

    longxp(:,k) = longxp(:,k) + xp/nrun;
    longzp(:,k) = longzp(:,k) + zp/nrun;
    longnu(:,k) = longnu(:,k) + nu/nrun;
    nees        = xe'*inv(P)*xe;
    longnees(k) = longnees(k) + nees/nrun;
    for i=1:nx, longnee(i,k) = longnee(i,k) + xe(i)/sqrt(P(i,i))/nrun; end
    nis         = nu'*inv(S)*nu;
    longnis(k)  = longnis(k) + nis/nrun;
    for i=1:nz, longnun(i,k) = longnun(i,k) + nu(i)/sqrt(S(i,i))/nrun; end
  end
end
longRMS1=sqrt(longRMS1);
longsqP1=sqrt(longsqP1);
LongRMS2 = sqrt(LongRMS2);
LongsqP2 = sqrt(LongsqP2);
LLongRMS3 = sqrt(LLongRMS3);
LLongsqP3 = sqrt(LLongsqP3);

clear longxt longz longx longRMS1 longsqP1;
clear existtruth existZ  mode ;
close(Hf_wait);

% The End
