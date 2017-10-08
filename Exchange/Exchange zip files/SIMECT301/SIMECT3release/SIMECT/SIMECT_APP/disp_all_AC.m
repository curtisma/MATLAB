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
% file : disp_all_ac.m
% authors  : P.BENABES & C.TUGUI 
% Copyright (c) 2011 SUPELEC
% Revision: 3.0  Date: 24/03/2011
%
%---------------------------------------------------
% Modifications history
% 24 JAN 2010 	: version 1.0
% 24 MAR 2011 	: version 3.0
%---------------------------------------------------
%
% DESCRIPTION DU MODULE :
%   affiche les simulations AC pour toutes les sorties
%
% MODULES UTILISES :
%       * disp_ac
%
%---------------------------------------------------

function disp_all_AC(model_par,multi_in_out,model_in_out,ac_an,ac_in_an,ac_out_an,outdisp,disprlc)

if outdisp
    if model_par.mode_diff_enabled %diff input
        if model_par.mode_diff_enabled_out %if out diff
            disp_AC(multi_in_out,model_in_out{outdisp},ac_an,ac_in_an,ac_out_an,model_par,outdisp,disprlc,'AC: In Comm/Diff Out Comm/Diff');
        else
            disp_AC(multi_in_out,model_in_out{outdisp},ac_an,ac_in_an,ac_out_an,model_par,outdisp,disprlc,'AC: In Comm/Diff Out Unipol');
        end
    else
        if model_par.mode_diff_enabled_out %if out diff
            disp_AC(multi_in_out,model_in_out{outdisp},ac_an,ac_in_an,ac_out_an,model_par,outdisp,disprlc,'AC: In Unipol Out Comm/Diff');
        else
            disp_AC(multi_in_out,model_in_out{outdisp},ac_an,ac_in_an,ac_out_an,model_par,outdisp,disprlc,'AC: In Unipol Out Unipol');
        end
    end
else
  for k=1:model_par.numout
    if model_par.mode_diff_enabled %diff input
        if model_par.mode_diff_enabled_out %if out diff
            disp_AC(multi_in_out,model_in_out{k},ac_an,ac_in_an,ac_out_an,model_par,k,disprlc,'AC: In Comm/Diff Out Comm/Diff');
        else
            disp_AC(multi_in_out,model_in_out{k},ac_an,ac_in_an,ac_out_an,model_par,k,disprlc,'AC: In Comm/Diff Out Unipol');
        end
    else
        if model_par.mode_diff_enabled_out %if out diff
            disp_AC(multi_in_out,model_in_out{k},ac_an,ac_in_an,ac_out_an,model_par,k,disprlc,'AC: In Unipol Out Comm/Diff');
        else
            disp_AC(multi_in_out,model_in_out{k},ac_an,ac_in_an,ac_out_an,model_par,k,disprlc,'AC: In Unipol Out Unipol');
        end
    end
  end
end


end