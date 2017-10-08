%%% DynaEst 3.032 02/18/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%AlphaBetaGammaMonteCarloRun  alpha beta gamma Kalman filter -- Monte Carlo runs
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

% if do not exist T, generate T
if exist('ExternalT','var') == 0
    if nmt == 1 
        ExternalT = Tmin+(Tmax-Tmin)*rand(1,nrun);
    else
        ExternalT = ones(1,nrun)*Tmulti ;
    end
end
% End of Step 1
nxactual = nx ;

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

if nx*nx*nx*kmax<=maxsize
  LLongRMS3=zeros(nx*nx*nx,kmax);LLongsqP3=LLongRMS3;
else
  errordlg('RMS3 and sqP3 are truncated.','error');
  LLongRMS3=zeros(nx*nx*nx,round(maxsize/(nx^3)));LLongsqP3=LLongRMS3;
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

for nmc=1:nrun,
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
    
    for k=1:kmax,
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
                xt = ModeChanging(PrevSystemModelFlag,SystemModelFlag,xt,omega)
            end
        end
        
        % End of Step 3
        
        % generate true state and measurement at k
        if existtruth
            %       v = Normal(vmt,Qt);
            w = Normal(wmt,Rt);
            xt(:) = ExternalTruth(nmc,:,k);
            if exist('ExternalZ','var')
                z(:) = ExternalZ(nmc,:,k) ;
            else
                % generate z
                z = Ht*xt + It*w ;
            end
        else 
            [xt,z,v,w] = Xzgen(xt,Ft,Gt,Ht,It,Qt,Rt,vmt,wmt);
        end
        
        % store truth and measurement
        Truth(nmc,:,k) = xt;
        Measurement(nmc,:,k) = z;
        % lemda = vmf/wmf*T^2; 
        clear W OmigaV OmigaW lemda beta alpha gama;
        W = zeros(3*ncoor,ncoor);
        OmigaV = sqrt(Qf*ones(ncoor,1));
        OmigaW = sqrt(Rf*ones(ncoor,1));
        lemda = OmigaV./OmigaW*T*T;
        alpha = zeros(ncoor,1);
        beta = zeros(ncoor,1);
        gamma = zeros(ncoor,1);
        for j=1:ncoor
            sroots = roots([1, 0.5*lemda(j)-3, 0.5*lemda(j)+3, -1]);
            for  i = 1:length(sroots)  
                if isreal( sroots(i)) 
                    s = sroots(i); 
                    break; 
                end
            end
            beta(j) = 2*(1-s)*(1-s);
            alpha(j) = 1 - s*s;
            gamma(j) = 2*lemda(j)*s;
        end
        for i = 1: ncoor
            W((i-1)*3+1,i) = alpha(i);
            W((i-1)*3+2,i) = beta(i)/T;
            W((i-1)*3+3,i) = 0.5*gamma(i)/(T*T);
        end
        
        P11 = alpha.*OmigaW.*OmigaW;
        P12 = beta.*OmigaW.*OmigaW/T;
        P13 = gamma.*OmigaW.*OmigaW.*0.5./(T*T);
        P22 = (8.*alpha.*beta+gamma.*(beta-2.*alpha-4.*ones(ncoor,1))).*OmigaW.*OmigaW./ ...
            (8*T*T.*(ones(ncoor,1)-alpha));
        P23 = beta.*(2.*beta-gamma).*OmigaW.*OmigaW./((4*T*T*T).*(ones(ncoor,1)-alpha));
        P33 = gamma.*OmigaW.*OmigaW.*(2.*beta-alpha)./((4*T*T*T*T).*(ones(ncoor,1)-alpha));
        
        P = zeros(3*ncoor,3*ncoor);
        for i = 1: ncoor
            P((i-1)*3+1,(i-1)*3+1) = P11(i);
            P((i-1)*3+1,(i-1)*3+2) = P12(i);
            P((i-1)*3+1,(i-1)*3+3) = P13(i);
            P((i-1)*3+2,(i-1)*3+1) = P12(i);
            P((i-1)*3+2,(i-1)*3+2) = P22(i);
            P((i-1)*3+2,(i-1)*3+3) = P23(i);
            P((i-1)*3+3,(i-1)*3+1) = P13(i);
            P((i-1)*3+3,(i-1)*3+2) = P23(i);
            P((i-1)*3+3,(i-1)*3+3) = P33(i);
        end
        
        [x,xp,zp,nu]=AlphaBetaKalman(x,W,z,vmf,wmf,Ff,Gf,Hf,If);   
        
        if nmc == 1 
            FilterGain(:,:,k) = W ;
            Covariance(:,:,k) = P ;
        end
        
        Estimation(nmc,:,k) = x;
        
        longxt(:,k) = longxt(:,k) + xt/nrun;
        longz(:,k)  = longz(:,k)  + z/nrun;
        longv(:,k)  = longv(:,k)  + v/nrun;
        longw(:,k)  = longw(:,k)  + w/nrun;
        longx(:,k)  = longx(:,k)  + x/nrun;
        LongP(:,k)  = LongP(:,k)  + P(:)/nrun;
        %    longmodePr(:,k)  = longmodePr(:,k) + modePr/nrun;
        clear xe;
        xe = xt-x;
        longxe(:,k) = longxe(:,k) + xe/nrun;
        
        %%% will be deleted
        %dummy       = xe*xe';
        %LongMSE(:,k)= LongMSE(:,k) + dummy(:)/nrun;
        % LongPP(:,k) = LongPP(:,k) + PP(:)/nrun; 
        % LongS(:,k)  = LongS(:,k) + S(:)/nrun;   
        %LongW(:,k)  = LongW(:,k) + W(:)/nrun;
        %longRMS1(:,k)= longRMS1(:,k) + xe.*xe/nrun;
        %dummy=[]; for i=1:nx, dummy(i) = P(i,i); end
        %longsqP1(:,k)= longsqP1(:,k) + dummy'/nrun;
        %%%
        clear RMS2 sqP2;
        %% debug 04-01-01
        if ncoor ~= 1       
            for i=1:nx
                for j=1:nx 
                    RMS2(i,j) = xe(i)^2+xe(j)^2; 
                    sqP2(i,j) = P(i,i)+P(j,j);
                end
            end      
        else
            for i=1:nx
                for j=1:nx 
                    RMS2(i,j) = xe(i)^2 ; 
                    sqP2(i,j) = P(i,j);
                end
            end      
        end

        %xe, P, RMS2, sqP2, pause
        LongRMS2(:,k)= LongRMS2(:,k) + RMS2(:)/nrun;
        LongsqP2(:,k)= LongsqP2(:,k) + sqP2(:)/nrun;
        
        %    clear RMS3 sqP3;
        %   for l=1:nx, 
        %    RMS3 = zeros(nx,nx);
        %   sqP3 = zeros(nx,nx);
        %  for i=1:nx, for j=1:nx,
        %   RMS3(i,j) = xe(i)^2+xe(j)^2+xe(l)^2;
        %  sqP3(i,j) = P(i,i)+P(j,j)+P(l,l);
        %      end, end
        %LongRMS3(:,l) = RMS3(:);
        %      LongsqP3(:,l) = sqP3(:);
        %   end
        %    if k<=maxsize/(nx^3)
        %     LLongRMS3(:,k)=LLongRMS3(:,k) + LongRMS3(:)/nrun;
        %    LLongsqP3(:,k)=LLongsqP3(:,k) + LongsqP3(:)/nrun;
        % end
        
        longxp(:,k) = longxp(:,k) + xp/nrun;
        longzp(:,k) = longzp(:,k) + zp/nrun;
        longnu(:,k) = longnu(:,k) + nu/nrun;
        nees        = xe'*inv(P)*xe;
        longnees(k) = longnees(k) + nees/nrun;
        for i=1:nx, longnee(i,k) = longnee(i,k) + xe(i)/sqrt(P(i,i))/nrun;
        end    
        %nis         = nu'*inv(S)*nu;
        %longnis(k)  = longnis(k) + nis/nrun;
        %for i=1:nzf, longnun(i,k) = longnun(i,k) + nu(i)/sqrt(S(i,i))/nrun; end    
        %nis         = nu'*inv(S)*nu;
        %longnis(k)  = longnis(k) + nis/nrun;
        %for i=1:nz, longnun(i,k) = longnun(i,k) + nu(i)/sqrt(S(i,i))/nrun; end
    end
end

longRMS1=sqrt(longRMS1);
longsqP1=sqrt(longsqP1);
LongRMS2 = sqrt(LongRMS2);
LongsqP2 = sqrt(LongsqP2);
LLongRMS3 = sqrt(LLongRMS3);
LLongsqP3 = sqrt(LLongsqP3);

clear existtruth existZ mode ;

close(Hf_wait);

% The End



