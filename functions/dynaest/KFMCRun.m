%%% DynaEst 3.032 01/02/2001
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%KFSimulation:  Kalman filter simulations-- Monte Carlo runs
% it's availabe only when SimulationFlag is 1,2,3
% Case 1 : No ExternalTruth, External Z : SimulationFlag = 1, 2 and no generation
% Case 2 : Exist ExternalTruth, No ExternalZ : SimulationFlag =1,2 and generation of ground truth or SimulationFlag = 3
% Case 3 : Extist ExternalTruth, ExternalZ : SimulationFlag =1,2 and generation truth and measurement or SimulationFlag =3 and generation measurement
% Case 4 : No ExternalTruth, ExternalZ : Simulation Flag = 4 <---Impossible with this file,see KFMCRUNFromMeasurement file

% True Track = Truth
% Mesurement = Mesurement
% Estimation = Estimation

% average xt(truth) = longxt
% average v(process noise) = longv
% average w(measurement noise) = longw
% average z(measurement) = longz
% average xp(predicted estimate) = longxp 
% average zp(predicted measurement) = lognzp 
% average nu(inovation) = longnu
% average x(estimate) = longx
% average xe(error) = longxe
% W = FilterGain 
% P = Covariance
% S = Svariance
% PP = Pvariance

if nmt > 1 
    if ~isempty( find ([ModeSystem{:,9}] == 3) ) ;
       nx = 5 ;   
       nv = 3 ;
   end
end

% if do not exist T, generate T
if exist('ExternalT','var') == 0
   if nmt == 1 
      ExternalT = Tmin+(Tmax-Tmin)*rand(1,nrun);
   else
      ExternalT = ones(1,nrun)*Tmulti ;
   end
end

if nmt > 1 
    nxactual = Xactual(ncoor,nx,nxf,nmt,ModeSystem);
else
    nxactual = Xactual(ncoor,nx,nxf,nmt,0);
end

longxt=zeros(nx,kmax);
longx=zeros(nxf,kmax);longxp=longx;longsqP1=longx ;
longxe=zeros(nxactual,kmax);longnee=longxe;longRMS1=longxe;
longz=zeros(nzf,kmax);longzp=longz;longnun=longz; longnu=longz;
longv=zeros(nvf,kmax);
longw=zeros(nwf,kmax);
% longmodePr=zeros(nmf,kmax);
longnees=zeros(1,kmax); longnis=longnees;
LongP=zeros(nxf*nxf,kmax);LongPP=LongP;
LongMSE=zeros(nxactual*nxactual, kmax);LongRMS2=LongMSE;LongsqP2=LongMSE;LongRMS3=LongMSE;LongsqP3=LongMSE;
LongS=zeros(nzf*nzf,kmax);
LongW=zeros(nxf*nzf,kmax);
[c,maxsize]=computer;

if nxf*nxf*nxf*kmax<=maxsize
  LLongRMS3=zeros(nxf*nxf*nxf,kmax);LLongsqP3=LLongRMS3;
else
  errordlg('RMS3 and sqP3 are truncated.','error');
  LLongRMS3=zeros(nxf*nxf*nxf,round(maxsize/(nxf^3)));LLongsqP3=LLongRMS3;
end

Ft = zeros(nx,nx); Ff = zeros(nxf,nxf);
Gt = zeros(nx,nv); Gf = zeros(nxf,nvf);
Ht = zeros(nz,nx); Hf = zeros(nzf,nxf);
It = zeros(nz,nw); If = zeros(nzf,nwf);
Qt = zeros(nv,nv); Qf = zeros(nvf,nvf);
Rt = zeros(nw,nw); Rf = zeros(nwf,nwf);

Truth = zeros(nrun,nx,kmax);
Measurement = zeros(nrun,nz,kmax);
Estimation = zeros(nrun,nxf,kmax);
FilterGain = zeros(nxf,nzf,kmax) ;
Covariance = zeros(nxf,nxf,kmax) ;
Pvariance = Covariance;
Svariance = zeros(nzf,nzf,kmax);
colordef none;

% Monte Carlo runs:
Hf_wait = waitbar(0,'Doing Monte Carlo runs. Please wait...');

existtruth = exist('ExternalTruth','var') ;
existZ = exist('ExternalZ','var') ;

for nmc=1:nrun
%    disp(['run # ' num2str(nmc)])
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
   
   [Ff,Gf,Qf] = ProcessModel(FilterModelFlag,nxf,nvf,T,omegaf,x0,Ffstr,Gfstr,Qfstr) ;
   [Hf,If,Rf] = ObservationModel(nzf,nwf,Hfstr,Ifstr,Rfstr) ;  
   
   % initial condition
   clear  x P;
   xt = zeros(nx,1) ;
   if ~existtruth 
      xt=xt0; 
   end
   x=x0; P=P0; z=zeros(nz,1);
   if nmt > 1
      SystemModelFlag = ModeSystem{1,9} ;
   end
   for k=1:kmax
      % Step 3
      if nmt > 1 
          if k*T > FromTime(mode)
              PrevSystemModelFlag = SystemModelFlag ;
              [Ftstr, Gtstr,Htstr,Itstr,Qtstr,Rtstr vmt wmt SystemModelFlag omega] = FindMultiModel(k,T,FromTime,ToTime,ModeSystem,nmt) ;
              mode = mode + 1 ;
              if ~existtruth
                  [Ft,Gt,Qt] = ProcessModel(SystemModelFlag,nx,nv,T,omega,xt0,Ftstr,Gtstr,Qtstr) ;
              end
              if ~existZ
                  [Ht,It,Rt] = ObservationModel(nz,nw,Htstr,Itstr,Rtstr) ;
              end
              xt = ModeChanging(PrevSystemModelFlag,SystemModelFlag,xt,omega);
          end
      end
      % End of Step 3
      % generate true state and measurement at k
      if existtruth
          %         v = Normal(vmt,Qt);
          w = Normal(wmt,Rt);
          if nx==5 & SystemModelFlag ~= 3 ;
             xt(:) = ExternalTruth(nmc,1:4,k) ;                          
          else
              xt(:) = ExternalTruth(nmc,:,k);
          end
          if exist('ExternalZ','var')
              z(:) = ExternalZ(nmc,:,k) ;
          else
              % generate z
              z = Ht*xt + It*w ;
          end
      else 
          [xt,z,v,w] = Xzgen(xt,Ft,Gt,Ht,It,Qt,Rt,vmt,wmt);
          if SystemModelFlag == 3
              temp = xt(5) ;
              Ft = [ 1 ( sin(temp*T) )/temp 0 -(1-cos(temp*T))/temp 0 ;
                  0 cos(temp*T) 0 -sin(temp*T) 0 ;
                  0 (1-cos(temp*T))/temp 1 ( sin(temp*T) )/temp 0 ;
                  0 sin(temp*T) 0 cos(temp*T) 0 ;
                  0 0 0 0 1] ;        
          end
      end
      % store truth and measurement
      if nx == 5 & SystemModelFlag ~=3 
          xttemp = [ xt' 0]' ;
      else
          xttemp = xt ;
      end
      
      Truth(nmc,:,k) = xttemp;
      Measurement(nmc,:,k) = z;
      
      % estimation using Kalman filter
      if SensitivityFlag == 4 % fixed gain Kalman Filter 
         [x,P,xp,PP,S,W,zp,nu]=FixedGainKalman(x,P,z,Qf,Rf,vmf,wmf,Ff,Gf,Hf,If,Wf);
         W = Wf;
         if find(P < 0)
            P = zeros(nx,nx);
         end       
      else
         [x,P,xp,PP,S,W,zp,nu]= Kalman(x,P,z,Qf,Rf,vmf,wmf,Ff,Gf,Hf,If);       
      end
      
      if FilterModelFlag == 3
         temp = x(5) ;
         Ff = [ 1 ( sin(temp*T) )/temp 0 -(1-cos(temp*T))/temp 0 ;
            0 cos(temp*T) 0 -sin(temp*T) 0 ;
            0 (1-cos(temp*T))/temp 1 ( sin(temp*T) )/temp 0 ;
            0 sin(temp*T) 0 cos(temp*T) 0 ;
            0 0 0 0 1] ;        
      end
      if nmc == 1 
          FilterGain(:,:,k) = W ;
          Covariance(:,:,k) = P ;
          Pvariance(:,:,k) = PP;
          Svariance(:,:,k) = S ;
      end
      
      Estimation(nmc,:,k) = x;
      
      longxt(:,k) = longxt(:,k) + xttemp/nrun;
      longz(:,k)  = longz(:,k)  + z/nrun;
      longv(:,k)  = longv(:,k)  + v/nrun; 
      longw(:,k)  = longw(:,k)  + w/nrun;
      longx(:,k)  = longx(:,k)  + x/nrun;
      LongP(:,k)  = LongP(:,k)  + P(:)/nrun;
      %    longmodePr(:,k)  = longmodePr(:,k) + modePr/nrun;
      clear xe;
      xe = Xerror(nxactual,nx,xt,nxf,x) ;
      longxe(:,k) = longxe(:,k) + xe/nrun;
      
      %%% will be deleted(don't be used)      
      %dummy       = xe*xe';
      %LongMSE(:,k)= LongMSE(:,k) + dummy(:)/nrun;
      %LongPP(:,k) = LongPP(:,k) + PP(:)/nrun;
      %LongS(:,k)  = LongS(:,k) + S(:)/nrun;
      %LongW(:,k)  = LongW(:,k) + W(:)/nrun;
      %longRMS1(:,k)= longRMS1(:,k) + xe.*xe/nrun;
      %dummy=[]; for i=1:nxf, dummy(i) = P(i,i); end
      %longsqP1(:,k)= longsqP1(:,k) + dummy'/nrun;
      %%%%  
            
      clear RMS2 sqP2;
      %% debug 04-01-01
      if ncoor ~= 1       
          for i=1:nxactual
              for j=1:nxactual 
                  RMS2(i,j) = xe(i)^2+xe(j)^2; 
                  sqP2(i,j) = P(i,i)+P(j,j);
              end
          end      
      else
          for i=1:nxactual
              for j=1:nxactual 
                  RMS2(i,j) = xe(i)^2 ; 
                  sqP2(i,j) = P(i,j);
              end
          end      
      end
      LongRMS2(:,k)= LongRMS2(:,k) + RMS2(:)/nrun;
      LongsqP2(:,k)= LongsqP2(:,k) + sqP2(:)/nrun;
      % do not need RMS3 ================================= 
      %for l=1:nx, 
      %  for i=1:nx, for j=1:nx,
      %    RMS3(i,j) = xe(i)^2+xe(j)^2+xe(l)^2;
      %    sqP3(i,j) = P(i,i)+P(j,j)+P(l,l);
      %  end, end
      %  LongRMS3(:,l) = RMS3(:);
      %  LongsqP3(:,l) = sqP3(:);
      %end
      %if k<=maxsize/(nx^3)
      %  LLongRMS3(:,k)=LLongRMS3(:,k) + LongRMS3(:)/nrun;
      %  LLongsqP3(:,k)=LLongsqP3(:,k) + LongsqP3(:)/nrun;
      %end
      % ==========================================================================
      longxp(:,k) = longxp(:,k) + xp/nrun;
      longzp(:,k) = longzp(:,k) + zp/nrun;
      longnu(:,k) = longnu(:,k) + nu/nrun;
      if nxactual == 4 ;
         Ptemp = P(1:4,1:4) ;
         nees = xe'*inv(Ptemp)*xe;
      else
         nees = xe'*inv(P)*xe;
      end
            
      longnees(k) = longnees(k) + nees/nrun;
      for i=1:nxactual, longnee(i,k) = longnee(i,k) + xe(i)/sqrt(P(i,i))/nrun; end
      nis         = nu'*inv(S)*nu;
      longnis(k)  = longnis(k) + nis/nrun;
      for i=1:nzf, longnun(i,k) = longnun(i,k) + nu(i)/sqrt(S(i,i))/nrun; end
  end
end
longRMS1=sqrt(longRMS1);
longsqP1=sqrt(longsqP1);
LongRMS2 = sqrt(LongRMS2);
LongsqP2 = sqrt(LongsqP2);

%LLongRMS3 = sqrt(LLongRMS3);
%LLongsqP3 = sqrt(LLongsqP3);

clear existtruth existZ  mode xttemp temp;
clear PrevSystemModelFlag ;
close(Hf_wait);

% The End
