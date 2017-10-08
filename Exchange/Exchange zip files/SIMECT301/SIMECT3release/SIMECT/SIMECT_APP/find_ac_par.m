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
% file : find_ac_par.m
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
%   extracts the AC parameters
%
% MODULES UTILISES :
%       * cds_ssr (bibliotheque CADENCE MMSIM)
%       * extract_smod
%
%---------------------------------------------------


function [B_Trans_Fct A_Trans_Fct fr cu]=find_ac_par(sim_rep, signame, sigkind, extract_tf, f0, fmax, ord_max, rempoles, err_param, extract_pz, extr_adm, en_norm)
%Find transfer function, input impedance and output impedance for a mirror
%PARAMETERS:
%       sim_rep -> contains path and file name with simulation results 
%                    for transfer function and input impedance
%       signame -> name of the signal to evaluate
%       sigkind -> kind of signal (voltage or current)
%       f0 -> normalizing frequency
%       ord_num_max -> maximum order for the numerator of fitting filter
%       ord_den_max -> maximum order for the denominator of fitting filter
%       display_plots -> set in order to display plots
%       err_param -> structure containing the parameters for error
%       shapping: err_param.max = maximum value for square relative error
%                 err_param.w = value that weights the modulus relative err
%                (TOTAL_ERR = PERCENT*MODULUS_ERR + (1-PERCENT)*PHASE_ERR)
%       actual_val -> value of the parameter -> in order to create
%       different output files for different parameters.


%Check for parameters
if ((nargin<4)||(nargin>14)) 
    error('Parameters for the function must be from 4 to 14..');
else
    if (nargin==4) 
        ord_max_local=3;
    else
        ord_max_local=ord_max;
    end
end;

%Extract Cadence AC

filedata=cds_srr(sim_rep,'ac-ac',signame,0);

%Load frequencies from raw data and normalize if enabled
if en_norm
    fr=filedata.freq' /f0;
else
    fr=filedata.freq';
end
    
%Load output from raw data
if (extract_tf)
    cu=filedata.(sigkind)';
else
    if (sigkind=='V')
        cu=filedata.(sigkind)';
    else
        cu=1./filedata.(sigkind)';
    end
end

%Extract poles and zeros
if extract_pz

    [B_Trans A_Trans]=extract_smod(cu, fr, ord_max_local, err_param, extr_adm);
    
    %%%TO ADD Command on GUI
    
    if rempoles
        [B_Trans_Fct,A_Trans_Fct] =sup_pzmax(B_Trans, A_Trans, fmax, rempoles);
    else
        B_Trans_Fct = B_Trans;
        A_Trans_Fct = A_Trans;
    end
   
else
    
    B_Trans_Fct=[];
    A_Trans_Fct=[];
    
end;

return;