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
% file : find_dc_par.m
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
%   extracts the DC parameters
%
% MODULES UTILISES :
%       * cds_ssr (bibliotheque CADENCE MMSIM)
%
%---------------------------------------------------


function [Vname Vval Iname Ival]=find_dc_all(sim_rep)
%Find input dc and output
%PARAMETERS:
%       sig_rep -> contains path and file name with simulation results 
%                    for output offset and gain_nlin
%       signame -> name of the signal to evaluate
%       sigkind -> kind of signal (voltage or current)
%       parname -> name of the parameter used for DC sim
%       write_to_files -> set in order to write results to txt
%       display_plots -> set in order to display plots
%       actual_val -> value of the parameter -> in order to create
%       different output files for different parameters.


%Files to write results (from Analog Simulation -> Matlab)

Vname=[] ;         % initialize data
Vval=[] ;
Iname=[] ;         % initialize data
Ival=[] ;

%Load raw data from simulation
filed=cds_srr(sim_rep,'dc-dc',[],0);    
l=1;

for k=1:size(filed.V,1)
    filedata=cds_srr(sim_rep,'dc-dc',char(filed.V(k)),0);
    name=char(filed.V(k));
    %Load input from raw data and normalize
    dsp=1 ;
    if (length(name)==8)            % remove the sources
        if name(1:5)=='net98'
            dsp=0 ;
        end
    end
    if (dsp)
        Vname{l}=name;
        %Load output currents from raw data
        Vval{l}=filedata.('V')';
        l=l+1 ;
    end
end
l=1;
for k=1:size(filed.I,1)
    filedata=cds_srr(sim_rep,'dc-dc',char(filed.I(k)),0);
    name=char(filed.I(k));
    %Load input from raw data and normalize
    dsp=1 ;
    if (length(name)==7)            % remove the sources currents
        if name(1:3)=='V89'
            dsp=0 ;
        end
    end
    if (length(name)==8)
        if name(1:4)=='V189'
            dsp=0 ;
        end
    end
    if (dsp)
        %Load input from raw data and normalize
        Iname{l}=char(filed.I(k));
        %Load output currents from raw data
        Ival{l}=filedata.('I')';
        l=l+1 ;
    end
end


