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
% file : find_rlc_fc.m
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
%   gets the RLC model of an impedance
%   gets the cutoff frequency of an impedance
%
% MODULES UTILISES :
%       * find_fc
%       * find_rlc
%
%---------------------------------------------------


function [par_rlc_fc] = find_rlc_fc(rep_ac,imp_dc,numin,numout,ac_an,err_param)
%Function find_rlc_fc extracts the cut-off frequency of the transfer
%function and the RLC components of the Zin and Zout for a given circuit

%Get raw data for TF, Zin and Zout + respective freq

if (isfield(rep_ac,'Z'))
    if isfield(rep_ac,'TF')
        [par_rlc_fc.fc par_rlc_fc.phase_at_f0  par_rlc_fc.Q ]=find_fc(rep_ac,ac_an,numout,err_param) ;
    end
    if (numin<3)
        if isfield(imp_dc,'Zin')
            Rs = imp_dc.Zin;
        else
            Rs = rep_ac.Z0;
        end
    else
        if isfield(imp_dc,'Zout')
            Rs = imp_dc.Zout{1};
        else
            Rs = rep_ac.Z0;
        end
    end
    
    par_rlc_fc.Rs = Rs;
    if (ac_an.enable_ac_norm==1)
        freq_real_Z=rep_ac.f*ac_an.f0;
    else
        freq_real_Z=rep_ac.f;
    end
    [par_rlc_fc.R par_rlc_fc.L par_rlc_fc.C]=find_rlc(Rs,rep_ac.Z{1},freq_real_Z,err_param);  
    
    if (isfield(rep_ac,'Z2'))
        if (numin<3)
            if isfield(imp_dc,'Zin')
                Rs2 = imp_dc.Zin;
            else
                Rs2 = rep_ac.Z0;
            end
        else
            if isfield(imp_dc,'Zout')
                Rs2 = imp_dc.Zout{2};
            else
                Rs2 = rep_ac.Z0;
            end
        end
        par_rlc_fc.Rs2 = Rs2;
        [par_rlc_fc.R2 par_rlc_fc.L2 par_rlc_fc.C2]=find_rlc(Rs2,rep_ac.Z{2},freq_real_Z,err_param);  
    end
end



return;