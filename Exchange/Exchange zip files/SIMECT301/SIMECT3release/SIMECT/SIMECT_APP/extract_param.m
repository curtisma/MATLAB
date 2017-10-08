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
% file : extract_dc.m
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
%   extraction du macro-modele DC d'une fonction analogiaue
%
% MODULES UTILISES :
%       * get_dc
%       * get_params
%       * ls_estimate
%
%---------------------------------------------------




function [dir_dc inv_dc imp_dc]=extract_param(model_par, dc_an, par_an, numout, err_param)
%Function extract_param() -> Extracts AC, DC and transient response for a schematic    

%Get simulations
idc{1}=[];
out{1}=[];
idc{2}=[];
out{2}=[];
in{1}=[];
in{2}=[];
par=[];
inalim=[];
out_avg{1}=[];
out_avg{2}=[];

%Index after parametric simulation
idx_par=1;

%%Extract AC parameters or simple DC response

dir_dc{1}=[];
dir_dc{2}=[];

%%Extract DC parameters from parametric analysis
if (par_an.enabled)
    for k=par_an.start:par_an.step:par_an.stop
        [idc_t out_t in_t idc_comm_t out_comm_t inalim_t out_avg_t out_avg_comm_t]=get_dcparam(model_par,dc_an,par_an,numout,k,err_param);
        for l=1:model_par.mode_diff_enabled+1
            in{l}=[in{l};in_t{l}];
        end
        par=[par;k];
        
        idc{1}=[idc{1};idc_t];
        out{1}=[out{1};out_t];
        out_avg{1}=[out_avg{1};out_avg_t];
        
        
        idc{2}=[idc{2};idc_comm_t];
        out{2}=[out{2};out_comm_t];
        out_avg{2}=[out_avg{2};out_avg_comm_t];
        
        inalim=[inalim;inalim_t];      
        idx_par=idx_par+1;
    end

        
    %fit by the least-square aproximation and extract non-linearities
    
    for k=1:model_par.mode_diff_enabled+1                   % 1 = differentiel 2 = mode commun
    %Direct
    %fit by the least-square aproximation for common mode if design supports both common and differential
        dir_dc{k}.nl  = ls_estimate(idc{k}(1,:),par,out{k},dc_an.par_gain) ;
        dir_dc{k}.idc=idc{k}(1,:) ;
        dir_dc{k}.par=par ;
        dir_dc{k}.out=out{k} ;
        %Output offset - if not same value with dc, take from dc
        %if ~(dir_dc{k}.nl.c0==simple_dc{k}.out_offset)
            %warndlg('Parametric Analysis central point misaligned with the DC! Output offset will be extracted from simple DC.','Parametric DC Warning');
        %    dir_dc{k}.nl.c0=simple_dc{k}.out_offset;  
        %end
        dir_dc{k}.compl_out_offset=(max(out_avg{k})+min(out_avg{k}))/2;      
        dir_dc{k}.Gn_dir = dir_dc{k}.nl.cx1;

        %Complementary Output offset
    end
        
    
    for k=1:model_par.mode_diff_enabled+1  
        if model_par.rev_trfunction
            %Inverse
    %       [inv_dc.c0 inv_dc.cx1 inv_dc.cy1 inv_dc.cx2 inv_dc.cy2 inv_dc.cxy inv_dc.cx3 inv_dc.cy3 inv_dc.cx1n inv_dc.cy1n inv_dc.cxyn inv_dc.cx2n inv_dc.cy2n inv_dc.cx3n inv_dc.cy3n inv_dc.ct]  = ls_estimate(idc{1}(1,:),par,in1,dc_an.par_gain) ;
            inv_dc{k}.idc=idc{k}(1,:) ;
            inv_dc{k}.par=par ;
                
            for l=1:model_par.mode_diff_enabled+1  
                inv_dc{k}.nl{l} = ls_estimate(idc{k}(1,:),par,in{1},dc_an.par_gain) ;
                inv_dc{k}.in{l} = in{l} ;
            end
        else
            inv_dc{k}=[] ;
        end
    end
    
    if (model_par.out_kind=='V')
        imp_dc.Zout{1} = abs(dir_dc{1}.nl.cy1);
        if (~isempty(dir_dc{2}))
            imp_dc.Zout{2} = abs(dir_dc{2}.nl.cy1);
        end
    else
        imp_dc.Zout{1} = 1/abs(dir_dc{1}.nl.cy1);
        if (~isempty(dir_dc{2}))
          imp_dc.Zout{2} = 1/abs(dir_dc{2}.nl.cy1);
        end
    end
  
    if ~isempty(inv_dc{1})
        for l=1:model_par.mode_diff_enabled+1  
            imp_dc.Gn_inv{l} = inv_dc{1}.nl{l}.cy1;
            if (model_par.in_kind=='I')
                imp_dc.Zin{l} = abs(inv_dc{1}.nl{l}.cx1);
            else
                imp_dc.Zin{l} = 1/abs(inv_dc{1}.nl{l}.cx1);
            end
        end
    end
    
    %Find mean of input alim and transfer it to dir_dc
    dir_dc{1}.inalim=mean(mean(inalim));
    
else
    dir_dc{1}=[] ;
    inv_dc{1}=[] ;
    dir_dc{2}=[];
    inv_dc{2}=[] ;
    imp_dc=[];    
end
    

