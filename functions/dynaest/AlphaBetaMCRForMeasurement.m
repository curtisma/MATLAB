%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%AlphaBetaMCRForMeasurement  alpha beta Kalman filter -- Monte Carlo runs from Measurement

Ff = zeros(nxf,nxf);
Gf = zeros(nxf,nvf);
Hf = zeros(nzf,nxf);
If = zeros(nzf,nwf);
Qf = zeros(nvf,nvf);
Rf = zeros(nwf,nwf);

colordef none;

% Monte Carlo runs:
Hf_wait = waitbar(0,'Doing Monte Carlo runs. Please wait...');

Estimation = zeros(nrun,nxf,kmax);
Measurement = ExternalZ;
FilterGain = zeros(nxf,nzf,kmax) ;

for nmc=1:nrun,
  waitbar(nmc/nrun); 
  T = ExternalT(nmc);
  
  [Ff,Gf,Qf] = ProcessModel(FilterModelFlag,nxf,nvf,T,omegaf,x0,Ffstr,Gfstr,Qfstr) ;
  [Hf,If,Rf] = ObservationModel(nzf,nwf,Hfstr,Ifstr,Rfstr) ;
    
  % initial condition
  clear x P;
  x=x0; P=P0; z=zeros(nz,1);
  
  for k=1:kmax
      
      z(:) = ExternalZ(nmc,:,k);

    % estimation using alpha_beta Kalman filter
    
    % lemda = vmf/wmf*T^2;   
    clear W OmigaV OmigaW lemda beta alpha;
   W = zeros(2*ncoor,ncoor);
   OmigaV = sqrt(Qf*ones(ncoor,1));
   OmigaW = sqrt(Rf*ones(ncoor,1));
   lemda = OmigaV./OmigaW*T*T;
   beta = 0.25*(lemda.*lemda+4*lemda-lemda.*sqrt(lemda.*lemda+8*lemda));
   alpha = -0.125*(lemda.*lemda+8*lemda-(lemda+4).*sqrt(lemda.*lemda+8*lemda));
   for i = 1: ncoor
      W((i-1)*2+1,i) = alpha(i);
      W((i-1)*2+2,i) = beta(i)/T;
   end
   
   clear P11 P12 P22;
   P11 = alpha.*OmigaW;
   P12 = beta.*OmigaW/T;
   P22 = beta./(T*T).*(alpha-beta/2).*OmigaW./(ones(ncoor,1)-alpha);
   
   P = zeros(2*ncoor,2*ncoor);
   for i = 1: ncoor
      P((i-1)*2+1,(i-1)*2+1) = P11(i);
      P((i-1)*2+2,(i-1)*2+1) = P12(i);
      P((i-1)*2+1,(i-1)*2+2) = P12(i);
      P((i-1)*2+2,(i-1)*2+2) = P22(i);
   end
   
   [x,xp,zp,nu]=AlphaBetaKalman(x,W,z,vmf,wmf,Ff,Gf,Hf,If);
   
    if nmc == 1 
       for i =1:nxf
          for j=1:nzf
             FilterGain(i,j,k) = W(i,j) ;
          end
       end
    end
    
    Estimation(nmc,:,k) = x(:);

   
  end % end of k
end% end of nmc

close(Hf_wait);

clear Hf_wait;
% The End
