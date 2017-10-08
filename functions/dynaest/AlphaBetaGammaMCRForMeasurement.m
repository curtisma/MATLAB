%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%AlphaBetaGammaMCRForMeasurement  alpha beta gamma Kalman filter -- Monte Carlo runs From Measurement

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
          for i =1:nxf
              for j=1:nzf
                  FilterGain(i,j,k) = W(i,j) ;
              end
          end
      end
      
      Estimation(nmc,:,k) = x;
  end % end of k
end% end of nmc

close(Hf_wait);

clear Hf_wait;

% The End
