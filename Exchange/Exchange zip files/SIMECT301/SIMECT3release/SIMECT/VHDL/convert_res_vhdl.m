%---------------------------------------------------
% Ce programme est la propriete exclusive de SUPELEC
% Tout  usage  non  authorise  ou reproduction de ce
% programme est strictement defendu. 
% Copyright  (c) 2010  SUPELEC  Departement SSE
% Tous droits reserves
%---------------------------------------------------
%
% fichier : convert_res_vhdl.m
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
function filname=convert_res_vhdl(vhdl_model_par,dc_an,ac_an,model_in_out,multi_in_out,model_type,filname,edt)
%Convert analyses results to vhdl Model

%vhdl_model_par=model_par;

%Essay to identify the model
corrupt_mod_par=0;

if isfield(vhdl_model_par,'in_kind')
    if strcmp(vhdl_model_par.in_kind,'V') %Normal input-ATTENTION
        model_name='VC';
    else %Obviously 'V'
        model_name='CC';
    end
else
    corrupt_mod_par=1;
end

if isfield(vhdl_model_par,'out_kind')
    if strcmp(vhdl_model_par.out_kind,'I') %Actual output
        model_name=[model_name 'CS'];
    else %Obviously 'V'
        model_name=[model_name 'VS'];
    end
else
    corrupt_mod_par=1;
end

vhdl_model_par.model_name=model_name;
vhdl_model_par.dc_an=dc_an;
vhdl_model_par.ac_an=ac_an;
vhdl_model_par.nlin=0; %%%%TBD:Nlin model%%%%%

%Extract the model
if ~corrupt_mod_par
    if model_type==1
        filname=create_vhdl_model_smash(vhdl_model_par,model_in_out,multi_in_out,filname);
    elseif model_type==2
        filname=create_vhdl_model_cdn(vhdl_model_par,model_in_out,multi_in_out,filname);
    elseif model_type==3
        filname=create_verilog_model(vhdl_model_par,model_in_out,multi_in_out,filname);
    end
    if (edt)
      edit(filname);
    end
else
    errordlg('Corrupted vhdl model data.The model cannot be extracted!','Model Error');
end
    