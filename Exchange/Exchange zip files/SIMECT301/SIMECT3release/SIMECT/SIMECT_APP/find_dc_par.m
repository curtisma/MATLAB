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


function [idc out1]=find_dc_par(sim_rep, signame, sigkind, parname)
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

idc=0 ;         % initialize data
out1=0 ;

%Load raw data from simulation
filed=cds_srr(sim_rep,'dc-dc',[],0);
if strcmp(signame(end-1:end),':n')      % signal is current
     for k=1:size(filed.I,1)
        if strcmp(char(filed.I(k)),signame)
            filedata=cds_srr(sim_rep,'dc-dc',signame,0);
            %Load input from raw data and normalize
            idc=filedata.(parname)';
            %Load output currents from raw data
            out1=-filedata.(sigkind)';
            break;
        end
     end  
     if (idc==0)            % if no current was found try to get the inverse
         signame(end)='p' ;
         for k=1:size(filed.I,1)
            if strcmp(char(filed.I(k)),signame)
                filedata=cds_srr(sim_rep,'dc-dc',signame,0);
                %Load input from raw data and normalize
                idc=filedata.(parname)';
                %Load output currents from raw data
                out1=filedata.(sigkind)';
                break;
            end
         end  
         if (idc==0)
            disp(['warning : could not extract signal ' signame]); 
         end
    end
elseif strcmp(signame(end-1:end),':p')       % signal is current
     for k=1:size(filed.I,1)
        if strcmp(char(filed.I(k)),signame)
            filedata=cds_srr(sim_rep,'dc-dc',signame,0);
            %Load input from raw data and normalize
            idc=filedata.(parname)';
            %Load output currents from raw data
            out1=filedata.(sigkind)';
            break;
        end
     end 
     if (idc==0)            % if no current was found try to get the inverse
         signame(end)='n' ;
         for k=1:size(filed.I,1)
            if strcmp(char(filed.I(k)),signame)
                filedata=cds_srr(sim_rep,'dc-dc',signame,0);
                %Load input from raw data and normalize
                idc=filedata.(parname)';
                %Load output currents from raw data
                out1=-filedata.(sigkind)';
                break;
            end
         end  
         if (idc==0)
            disp(['warning : could not extract signal ' signame]); 
         end
     end
else        % signal is voltage
    for k=1:size(filed.V,1)
        if strcmp(char(filed.V(k)),signame)
            filedata=cds_srr(sim_rep,'dc-dc',signame,0);
            %Load input from raw data and normalize
            idc=filedata.(parname)';
            %Load output currents from raw data
            out1=filedata.(sigkind)';
            break;
        end
    end
end


out_offset = mean(out1);
%Derivative of output current -> gain
gain1=gradient(out1,idc);

gain_nlin=(max(gain1)-min(gain1))/mean(gain1);

return;