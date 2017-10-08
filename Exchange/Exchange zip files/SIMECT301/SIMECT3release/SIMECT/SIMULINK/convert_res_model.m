%---------------------------------------------------
% Ce programme est la propriete exclusive de SUPELEC
% Tout  usage  non  authorise  ou reproduction de ce
% programme est strictement defendu. 
% Copyright  (c) 2010  SUPELEC  Departement SSE
% Tous droits reserves
%---------------------------------------------------
%
% fichier : convert_res_model.m
% auteur  : P.BENABES & C.TUGUI 
% Copyright (c) 2010 SUPELEC
% Revision: 2.0  Date: 29/10/2010
%
%---------------------------------------------------
%
% DESCRIPTION DU MODULE :
%   
%
% MODULES UTILISES :
%
%---------------------------------------------------

function []=convert_res_model(an_res,model_in_out)
%Convert analyses results to Simulink Model

simulink_model_par=an_res.model_par;

%Essay to identify the model
corrupt_mod_par=0;

if isfield(simulink_model_par,'in_kind')
    if strcmp(simulink_model_par.in_kind,'V') %Complementary input
        model_name='VC';
    else %Obviously 'V'
        model_name='CC';
    end
else
    corrupt_mod_par=1;
end

if isfield(simulink_model_par,'out_kind')
    if strcmp(simulink_model_par.out_kind,'I') %Actual output
        model_name=[model_name 'CS'];
    else %Obviously 'V'
        model_name=[model_name 'VS'];
    end
else
    corrupt_mod_par=1;
end

simulink_model_par.model_name=model_name;
simulink_model_par.nlin=0; %%%%TBD:Nlin model%%%%%

%Extract the model
if ~corrupt_mod_par
    gen_multiout_sim_model(simulink_model_par,model_in_out);
else
    errordlg('Corrupted Simulink model data.The model cannot be extracted!','Model Error');
end
    