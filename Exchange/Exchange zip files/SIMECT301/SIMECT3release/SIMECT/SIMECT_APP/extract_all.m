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
% file : extract_param.m
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
%   extraction du macro-modele complet (AC & DC) d'une fonction analogique
%
% MODULES UTILISES :
%       * extract_dc
%       * extract_ac
%       * extract_smod
%
%---------------------------------------------------


function [multi_in_out model_in_out]=extract_all(model_par, ac_an, ac_in_an, ac_out_an, dc_an, par_an, trans_an, extract_ac_in_pz, extract_ac_out_pz, err_param)
%Function extract_param() -> Extracts AC, DC and transient response for a schematic    

    % extract dc
    for k=1:model_par.numout
      for l=0:model_par.mode_diff_enabled_out
        multi_in_out(k*2+l+1).simple_dc=get_dc(model_par,dc_an,k*2+l-1);
        [multi_in_out(k*2+l+1).dir_dc multi_in_out(k*2+l+1).inv_dc multi_in_out(k*2+l+1).imp_dc]=extract_param(model_par, dc_an, par_an, k*2+l-1, err_param);
      end
    end

    % extract AC from IN
    if (ac_in_an.enabled) 
        for l=1:model_par.mode_diff_enabled+1
            [multi_in_out(l).mod_ac multi_in_out(l).rep_ac]=get_ac_in(ac_an,ac_in_an.ord_Zin,  ac_in_an.ord_trf, ac_in_an.extract_pz, model_par, ['ac_in' '0'+l],l,err_param);
            for k=1:model_par.numout
                if model_par.mode_diff_enabled_out
                  multi_in_out(l).par_rlc_fc{k*2+l-2} = find_rlc_fc(multi_in_out(l).rep_ac, multi_in_out(l).imp_dc, 1, k*2+l-2, ac_an, err_param);
                else
                   multi_in_out(l).par_rlc_fc{k*2+l-2} = find_rlc_fc(multi_in_out(l).rep_ac, multi_in_out(l).imp_dc, 1, k*2-1, ac_an, err_param);                 
                end
            end
        end

        %if model_par.mode_diff_enabled %from in diff     
        %    [multi_in_out(2).mod_ac multi_in_out(2).rep_ac]=get_ac_in(ac_an,ac_in_an.ord_Zin,  ac_in_an.ord_trf, ac_in_an.extract_pz, model_par, 'ac_in2',2,0,verb,err_param);
        %    for k=1:model_par.numout
        %        multi_in_out(2).par_rlc_fc{k*2} = find_rlc_fc(multi_in_out(2).rep_ac, multi_in_out(2).imp_dc, 2, k*2, ac_an, err_param);    
        %    end
        %end
    end

    % extract AC from out
    for k=1:model_par.numout
      for l=0:model_par.mode_diff_enabled_out
        if (ac_out_an.enabled)    
            [multi_in_out(k*2+l+1).mod_ac multi_in_out(k*2+l+1).rep_ac]=get_ac_out(ac_an,ac_out_an.ord_Zout,ac_out_an.ord_invf,ac_out_an.extract_pz,model_par,['ac_out' num2str(k*2+l-1)],'ac_out0',k*2+l-1,err_param);
            for m=0:model_par.mode_diff_enabled
                multi_in_out(k*2+l+1).par_rlc_fc{m+1} = find_rlc_fc(multi_in_out(k*2+l+1).rep_ac, multi_in_out(1).imp_dc, k*2+l-1, m+1, ac_an, err_param);
            end
        end  
      end
    end


    % extract tran
    for k=1:model_par.numout
      for l=0:model_par.mode_diff_enabled_out
        multi_in_out(k*2+l+1).par_rep_trans=extract_tran(model_par, trans_an, k*2+l-1 );
      end
    end


    for k=1:model_par.numout
        %Export data for display diff/comm in AC mode
        model_in_out{k}.mode_diff_enabled=model_par.mode_diff_enabled;
        model_in_out{k}.mode_diff_enabled_out=model_par.mode_diff_enabled_out;
        
        if ac_in_an.enabled                                                         % get the transfer functions
            model_in_out{k}=get_trf(model_par,multi_in_out,model_in_out{k},k,ac_in_an,extract_ac_in_pz,err_param);
        end

        %Export data for model extraction
        if ac_in_an.enabled && ac_out_an.enabled && extract_ac_in_pz && extract_ac_out_pz
            model_in_out{k}=get_model(model_par,multi_in_out,model_in_out{k},k);
        end

        if dc_an.enabled
            model_in_out{k}=get_gains(model_par,multi_in_out,model_in_out{k},k);
        else
            %Input 1 offset
            model_in_out{k}.OffIn11=[];  model_in_out{k}.OffIn12=[];
            %Input 2 offset
            model_in_out{k}.OffIn21=[];  model_in_out{k}.OffIn22=[];
            %Output 1 offset
            model_in_out{k}.OffOut11=[]; model_in_out{k}.OffOut12=[];
            %Output 2 offset
            model_in_out{k}.OffOut21=[]; model_in_out{k}.OffOut22=[];
        end
           
    end
    
end

    
