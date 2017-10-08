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
% file : get_params.m
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
%   extracts the non-linearities from parametric simulation
%
% MODULES UTILISES :
%       * find_dc_par
%
%---------------------------------------------------



function [idc out in idc_comm out_comm inalim out_avg out_avg_comm]=get_dcparam(model_par,dc_an,par_an,numout,actual_val,err_param)

%Delete previous simulation files
delete exp_*.txt;

if par_an.enabled
    
    if model_par.rev_trfunction
        d=dir([model_par.workdir '/par' num2str(numout)]);
    else
        d=dir([model_par.workdir '/par']);
    end
        
    s=size(d);
    directory_name='';
    for i=1:s(1)
        value=str2double(strrep(strrep(d(i).name,par_an.var_name,''),'=',''));
        err=abs(actual_val-value);
        if ((err<=err_param.res)||(actual_val==value)||((abs(value)<=err_param.res*1e-4)&&(actual_val==0)))
        directory_name=strcat(d(i).name,'/');
        end
    end
    if strcmp(directory_name,'')==1
        error('The function was unable to find the corresponding simulation directory for %s = %f',par_an.var_name,actual_val);
    end
    
    %Extract DC parameters
    
    if model_par.rev_trfunction
      s2=[model_par.workdir '/par' num2str(numout) '/' directory_name 'psf'];
    else
      s2=[model_par.workdir '/par/' directory_name 'psf'];
    end
        
    if (model_par.out_kind=='V')
        [idc out]=find_dc_par(s2,model_par.out_Vname{numout},model_par.out_kind,dc_an.par_name);
    else
        [idc out]=find_dc_par(s2,[model_par.out_Iname{numout} ':n'],model_par.out_kind,dc_an.par_name);
    end
    
    for k=1:model_par.mode_diff_enabled+1
        if (model_par.in_kind=='V')
            [idc in{k}]=find_dc_par(s2,[model_par.in_Iname{k} ':n'],invIV(model_par.in_kind),dc_an.par_name);
        else
            [idc in{k}]=find_dc_par(s2,model_par.in_Vname{k},invIV(model_par.in_kind),dc_an.par_name);
        end
    end
    
    %Extract input alimentation
    if (~isempty(model_par.alim_Iname))&& (~((model_par.gen_sources==1)&&(model_par.gen_supply==0)))
    [idc inalim]=find_dc_par(s2,[model_par.alim_Iname ':n'],model_par.alim_kind,dc_an.par_name);
    else
    inalim=[];
    end
    
    %Extract offset for the complementary schematic output (V->I / I->V)
    if (model_par.out_kind=='V')
        [idc out_comp]         =find_dc_par(s2,[model_par.out_Iname{numout} ':n'],invIV(model_par.out_kind),dc_an.par_name);
    else
         [idc out_comp]         =find_dc_par(s2,model_par.out_Vname{numout},invIV(model_par.out_kind),dc_an.par_name);
   end
    val=out_comp;
    out_avg=(max(val)+min(val))/2;
        
    %Extract DC parametrs for common mode if design supports both common and differential
    if model_par.mode_diff_enabled
         
        s2=[model_par.workdir '/par_com/' directory_name 'psf'];
            
        if (model_par.out_kind=='V')
            [idc_comm out_comm]=find_dc_par(s2,model_par.out_Vname{numout},model_par.out_kind,dc_an.par_name);
        else
            [idc_comm out_comm]=find_dc_par(s2,[model_par.out_Iname{numout} ':n'],model_par.out_kind,dc_an.par_name);
        end
        
        %Extract COMM offset for the complementary schematic output (V->I / I->V)
        if (model_par.out_kind=='V')
            [idc_comm out_comp_comm]         =find_dc_par(s2,[model_par.in_Iname{2} ':n'],invIV(model_par.out_kind),dc_an.par_name);
        else
            [idc_comm out_comp_comm]         =find_dc_par(s2,model_par.out_Vname{numout},invIV(model_par.out_kind),dc_an.par_name);
        end
        val=out_comp_comm;
        out_avg_comm=(max(val)+min(val))/2;
   
    else
        idc_comm=[];
        out_comm=[];
        out_avg_comm=[];
    end
        
else
    idc=[];
    out=[];
    in=[];
    inalim=[];
    out_avg=[];
end

return;