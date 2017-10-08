%%% DynaEst 3.032 01/02/2001
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%GenerateTruth,  generate ground truth

% Check whether NCT will be used during multi model system
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

ExternalTruth= zeros(nrun,nx,kmax);

Hf_wait = waitbar(0,'Generating Ground Truth. Please Wait...');
existZ = exist('ExternalZ','var') ;
if existZ 
   ExternalZ= zeros(nrun,nz,kmax);
end

for nmc=1:nrun
   waitbar(nmc/nrun); 
   T = ExternalT(nmc);
   xt=xt0; 
   %z=zeros(nz,1);
   
   % Step 2
   if nmt == 1 
      [Ft,Gt,Qt] = ProcessModel(SystemModelFlag,nx,nv,T,omega,xt0,Ftstr,Gtstr,Qtstr) ;
      [Ht,It,Rt] = ObservationModel(nz,nw,Htstr,Itstr,Rtstr) ;
   else
      mode = 1 ;    
   end
   % End of Step 2
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
            [Ft,Gt,Qt] = ProcessModel(SystemModelFlag,nx,nv,T,omega,xt0,Ftstr,Gtstr,Qtstr) ;
            [Ht,It,Rt] = ObservationModel(nz,nw,Htstr,Itstr,Rtstr) ;
            xt = ModeChanging(PrevSystemModelFlag,SystemModelFlag,xt,omega);
        end
      end
      % End of Step 3            
            
      [xt,z,v,w] = Xzgen(xt,Ft,Gt,Ht,It,Qt,Rt,vmt,wmt);
      
      if SystemModelFlag == 3
         temp = xt(5) ;
         Ft = [ 1 ( sin(temp*T) )/temp 0 -(1-cos(temp*T))/temp 0 ;
            0 cos(temp*T) 0 -sin(temp*T) 0 ;
            0 (1-cos(temp*T))/temp 1 ( sin(temp*T) )/temp 0 ;
            0 sin(temp*T) 0 cos(temp*T) 0 ;
            0 0 0 0 1] ;        
      end
      %  z = Ht*xt+It*w;
      if nx == 5 & SystemModelFlag ~=3 
          xttemp = [xt' 0]' ;
      else
          xttemp = xt ;
      end
          
      ExternalTruth(nmc,:,k) = xttemp;
      
      if existZ
          ExternalZ(nmc,:,k) = z;
      end
      
   end
end

clear temp mode T  ; % Step 4 
clear xttemp ;
close(Hf_wait);

% The End
