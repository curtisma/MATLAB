%---------------------------------------------------
% This software is the exclusive property of SUPELEC
%
% It is distributed as a MATLAB toolbox
% No part of this software can be distributed or
% modified without reference to the authors
%
% Copyright  (c) 2011  SUPELEC SSE Departement
% All rights reserved
%
% http://www.supelec.fr/361_p_10063/philippe-benabes.html
%
%---------------------------------------------------
%
% file : simect_run.m
% authors  : P.BENABES & C.TUGUI 
% Copyright (c) 2011 SUPELEC
% Revision: 3.0  Date: 24/03/2011
%
%---------------------------------------------------
% Modifications history
% 24 JAN 2010 	: version 1.0
% 28 OCT 2010   : version 2.0
% 24 MAR 2011 	: version 3.0
%---------------------------------------------------
%
% DESCRIPTION DU MODULE :
%   extraction du macro-modele d'une fonction analogiaue
%
% MODULES UTILISES :
%       * addinfogene
%       * run_ocean
%
%---------------------------------------------------

%%Internal debugging and functional parameters

%Verbosity parameters
verb.warning=0;         % display warnings or not
verb.ocn_msg=0;         % display ocean messages

%Error Parameters 
err_param.max=1e20;  %Maximum step to start computing error for numerator/denominator/fc
err_param.w=0.5; %Weight of Modulus in approximation of TF,Z_in,Z_out -> Phase=1-w
err_param.freq_w=[]; %Array of weights for frequency-distributed fitting of invfreqs. If =[],same weights for all freq
err_param.iter=100; %MAX Number of iterations for invfreqs
err_param.tol=0.01; %Tolerance of fitting for invfreqs
err_param.trace=1; %Use complex extracting alg and show textual progress of invfreqs
err_param.w_rlc=0.8; %Weight of Modulus in approximation of TF,Z_in,Z_out -> Phase=1-w
err_param.perc_rlc=1.1; %percentage of the + variation of impedance curve in order to declare that is RLC
err_param.var_min=1e-20; %MIN variance of a curve to be considered constant function
if (handles.par_an.enabled)
    handles.par_an.step=(handles.par_an.stop-handles.par_an.start)/(handles.par_an.npt-1) ;
    err_param.res=(handles.par_an.step)*1e-2; %Resolution of searching for the simulation directory -> ATTENTION: For small values of the step, could have error due to simulator
end;

%Input and output impedances/admitances selection for Simulink model
if strcmp(handles.model_par.in_kind,'I')
    %Extract input admitance model
    handles.model_par.extr_in_adm=0;
else
    %Extract input impedance model
    handles.model_par.extr_in_adm=1;
end

if strcmp(handles.model_par.out_kind,'V')
    %Extract output impedance model
    handles.model_par.extr_out_adm=0;
else
    %Extract output admitance model
    handles.model_par.extr_out_adm=1;
end

%%-------------------------------------------------------------------------
%Run Simulation and extract results according to design type

if verb.warning
    warning on all;
else
    warning off all;
end;

multi_in_out=[];

%Run OCEAN
if (handles.model_par.gen_sources==1)       % if sources must be added
    [ handles.model_par,handles.trans_an, handles.dc_an, handles.par_an, handles.design_var ] = addinfogene( handles.model_par,handles.trans_an, handles.dc_an, handles.par_an, handles.des_var);
else
    handles.design_var=handles.des_var ;
end  

if handles.model_par.rnocn
    run_good=run_ocean(handles.model_par, handles.design_var, handles.ac_an, handles.ac_in_an, handles.ac_out_an, handles.dc_an, handles.par_an, handles.trans_an, verb, handles.text126);
    if (run_good==0)
        msgbox('Error during OCEAN run. Please check the logs!','Run Error')
        return ;
    end
end;

set(handles.pushbutton16,'Enable','on');

%Extract DATA
set(handles.text126,'String',[char(10) char(10) 'EXTRACTING' char(10) 'DATA']);
pause(0.01);

[multi_in_out model_in_out] = extract_all(handles.model_par, handles.ac_an, handles.ac_in_an, handles.ac_out_an, handles.dc_an, handles.par_an, handles.trans_an, handles.extract_ac_in_pz, handles.extract_ac_out_pz, err_param) ;


        
        
    