%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% DefaultIMMParameters  : Generate default parameters for Linear, CT, NCT IMM algorithm 

%   IMM MARKOV CHAIN PARAMETERS:

clear TransPr modePr0 ;

switch nmf     % number of models used in the IMM 
case 2
   TransPr=[ % transition probability matrix: TransPr(i,j)=p_ij=P{m_j(k)|m_i(k-1)}
    0.9    0.1;   0.1    0.9 ];

case 3
   TransPr = [0.8 0.1 0.1; 0.1 0.8 0.1; 0.1 0.1 0.8]; 
   
case 4
   TransPr = [0.7 0.1 0.1 0.1; 
      0.1 0.7 0.1 0.1; 
      0.1 0.1 0.7 0.1;
      0.1 0.1 0.1 0.7];
end

modePr0= 1/nmf*ones(nmf,1); % initial mode probability vector
   
DefaultKalmanParameters ; 

clear modeFfstr modeGfstr modeHfstr modeIfstr modeQfstr modeRfstr modevmf modewmf;
clear modex0 modeP0;
for i = 1:nmf
   %       ipwcfghif(i)=0;          % index for piecewise constant Ff, Gf, Hf, and If
   %      itvfghif(i)=0;           % index for timie-varying Ff, Gf, Hf, and If
   %     ipwcqrvwf(i)=0;           % index for Qf, Rf, vmf, and wmf input
   %   itvqrvwf(i)=0;            % index for time-varying Qf, Rf, vmf, and wmf
   modeFfstr{i}=Ffstr;
   modeGfstr{i}=Gfstr;
   modeHfstr{i}=Hfstr;
   modeIfstr{i}=Ifstr;
   modeQfstr{i}=Qfstr;
   modeRfstr{i}=Rfstr;
   modevmf(:,i)=vmf;
   modewmf(:,i)=wmf;
   modex0(:,i)=x0; 
   modeP0(:,i)=P0(:);
end

%% For what ???? %%   
% INITIAL CONDITIONS:
%irandomx0p0=0;    % index for initial conditions
%same_modex0='y'; %index for same x0 for all models
%same_x0mean='y'; %index for same x0mean for all models
%%%%%%%%%%%%%%