%%% DynaEst 3.032 11/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%GenerateMeasurement,  generate measurement from External Truth

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

ExternalZ = zeros(nrun,nz,kmax);

Hf_wait = waitbar(0,'Generating Measurement. Please Wait...');

% Check exist External Truth
existtruth =  exist('ExternalTruth','var') ;

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
   xt = zeros(nx,1) ;
   if ~existtruth    
      xt=xt0;
   end
   z=zeros(nz,1);
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
            [Ht,It,Rt] = ObservationModel(nz,nw,Htstr,Itstr,Rtstr) ;
            xt = ModeChanging(PrevSystemModelFlag,SystemModelFlag,xt,omega);
        end
      end
      % End of Step 3

      % generate truth and measurement at k
      % generate truth
      if existtruth 
          if nx==5 & SystemModelFlag ~= 3 ;
              xt(:) = ExternalTruth(nmc,1:4,k) ;
          else
              xt(:) = ExternalTruth(nmc,:,k);
          end
      else
        v = Normal(vmt,Qt);
        xt = Ft*xt + Gt*v;
        
        if SystemModelFlag == 3
           temp = xt(5) ;
           Ft = [ 1 ( sin(temp*T) )/temp 0 -(1-cos(temp*T))/temp 0 ;
              0 cos(temp*T) 0 -sin(temp*T) 0 ;
              0 (1-cos(temp*T))/temp 1 ( sin(temp*T) )/temp 0 ;
              0 sin(temp*T) 0 cos(temp*T) 0 ;
              0 0 0 0 1] ;        
        end
     end
     
     %generate measurment
     w = Normal(wmt,Rt);
     z = Ht*xt+It*w;
     ExternalZ(nmc,:,k) = z;
 end
  
end
clear mode T ; % Step 4 

clear existtruth ;
clear xttemp PrevSystemModelFlag ;
close(Hf_wait);

% The End
