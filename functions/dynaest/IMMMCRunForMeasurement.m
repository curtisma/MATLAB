%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%IMMMCRUNFormeasurement:  IMM algorithm Monte Carlo runs when from measurement

Ff = zeros(nxf,nxf);
Gf = zeros(nxf,nvf);
Hf = zeros(nzf,nxf);
If = zeros(nzf,nwf);
Qf = zeros(nvf,nvf);
Rf = zeros(nwf,nwf);

longmodePr=zeros(nmf,kmax);

colordef none;

% Monte Carlo runs:
Hf_wait = waitbar(0,'Doing Monte Carlo runs. Please wait...');

Estimation = zeros(nrun,nxf,kmax);
Measurement = ExternalZ;

% Monte Carlo runs:
for nmc=1:nrun,
  waitbar(nmc/nrun);
  
  T = ExternalT(nmc);
  
  for immmode=1:nmf
     Ffstr = modeFfstr{immmode}; 
     Gfstr = modeGfstr{immmode};
     Hfstr = modeHfstr{immmode}; 
     Ifstr = modeIfstr{immmode};
     Qfstr = modeQfstr{immmode}; 
     Rfstr = modeRfstr{immmode};
     x0 = modex0(: ,immmode) ;

     [Ff,Gf,Qf] = ProcessModel(FilterModelFlag,nxf,nvf,T,omegaf,x0,Ffstr,Gfstr,Qfstr) ;
     [Hf,If,Rf] = ObservationModel(nzf,nwf,Hfstr,Ifstr,Rfstr) ;  
      
      modeFf(:,immmode)=Ff(:); modeGf(:,immmode)=Gf(:);
      modeHf(:,immmode)=Hf(:); modeIf(:,immmode)=If(:);
      modeQf(:,immmode)=Qf(:); modeRf(:,immmode)=Rf(:);
  end
  
  % get TranPr
  if TransitionProbabilityFlag == 2
     TranPr = zeros(nmf,nmf);
     for i=1:nmf
        TranPr(i,i) = min(UpperLimit(i),max( LowerLimit(i), 1-T/SojournTime(i) ));                
        for j= 1:nmf
           if i ~= j
              TranPr(i,j) = TranProEdit(i,j)*(1-TranPr(i,i));                
           end
        end        
     end       
  end
    
  clear x P modex modeP modePr;
  z=zeros(nz,1);

  x=modex0*modePr0; modex=modex0; modeP=modeP0; modePr=modePr0;
    
  for k=1:kmax
      z(:) = ExternalZ(nmc,:,k);
      [x,P,modex,modeP,modePr,modexp,modePP,modeS,modeW,modezp,modenu,...
              likelihood]=ImmKf(modex,modeP,z,...
          modeQf,modeRf,modevmf,modewmf,modeFf,modeGf,modeHf,modeIf,TransPr,modePr);
      if FilterModelFlag == 3
          temp = x(5) ;
          Ff = [ 1 ( sin(temp*T) )/temp 0 -(1-cos(temp*T))/temp 0 ;
              0 cos(temp*T) 0 -sin(temp*T) 0 ;
              0 (1-cos(temp*T))/temp 1 ( sin(temp*T) )/temp 0 ;
              0 sin(temp*T) 0 cos(temp*T) 0 ;
              0 0 0 0 1] ;        
          for mode=1:nmf
              modeFf(:,mode)=Ff(:); 
          end  
      end
      Estimation(nmc,:,k) = x(:);
      longmodePr(:,k)  = longmodePr(:,k) + modePr/nrun;
  end %end of k
end % end of nmc

close(Hf_wait);
clear Hf_wait ;

clear modeFf modeGf modeHf modeIf modeQf modeRf;
% The End
% estimation using IMM
   
