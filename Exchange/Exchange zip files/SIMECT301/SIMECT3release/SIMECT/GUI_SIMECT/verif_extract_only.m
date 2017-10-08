%---------------------------------------------------
% Ce programme est la propriete exclusive de SUPELEC
% Tout  usage  non  authorise  ou reproduction de ce
% programme est strictement defendu. 
% Copyright  (c) 2010  SUPELEC  Departement SSE
% Tous droits reserves
%---------------------------------------------------
%
% fichier : verif_extract_only.m
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


function indication=verif_extract_only(model_par, res)

indication=1;

a='/';

workdir=model_par.workdir ;
cell_repository=[model_par.simrep a model_par.cell];

if res.dc_an.enabled
    if ~exist([workdir a 'dc' a 'psf' a 'dc.dc'],'file')
        indication=0;
        errordlg('DC Cadence results cannot be found. Cannot extract only. Use RUN OCEAN.','Extract only error');
    end
end

if res.ac_in_an.enabled
    if ~exist([workdir a 'ac_in1' a 'psf' a 'ac.ac'],'file')
        indication=0;
        errordlg('AC in Cadence results cannot be found. Cannot extract only. Use RUN OCEAN.','Extract only error');
    end
end

if res.ac_out_an.enabled
    if ~exist([workdir a 'ac_out1' a 'psf' a 'ac.ac'],'file')
        indication=0;
        errordlg('AC out Cadence results cannot be found. Cannot extract only. Use RUN OCEAN.','Extract only error');
    end
end

if res.trans_an.enabled
    if ~exist([workdir a 'trans' a 'trans1.txt'],'file')
        indication=0;
        errordlg('TRANS Cadence results cannot be found. Cannot extract only. Use RUN OCEAN.','Extract only error');
    end
end

if res.par_an.enabled
    if ~exist([workdir a 'par'],'dir') && ( ~exist([workdir a 'par1'],'dir'))%too weak
        indication=0;
        errordlg('PARAM Cadence results cannot be found. Cannot extract only. Use RUN OCEAN.','Extract only error');
    end
end    

%Check common mode on input
if res.model_par.mode_diff_enabled
    
    if res.dc_an.enabled
        if ~exist([workdir a 'dc_com' a 'psf' a 'dc.dc'],'file')
            indication=0;
            errordlg('DC COMM Cadence results cannot be found. Cannot extract only. Use RUN OCEAN.','Extract only error');
        end
    end

    if res.ac_in_an.enabled
        if ~exist([workdir a 'ac_in2' a 'psf' a 'ac.ac'],'file')
            indication=0;
            errordlg('AC IN 2 Cadence results cannot be found. Cannot extract only. Use RUN OCEAN.','Extract only error');
        end
    end

    if res.par_an.enabled
        if ~exist([workdir a 'par_com' ],'dir') %too weak
            indication=0;
            errordlg('PARAM COMM Cadence results cannot be found. Cannot extract only. Use RUN OCEAN.','Extract only error');
        end
    end
    
end

%Check diff mode on output
if res.model_par.mode_diff_enabled_out
    
    if res.ac_out_an.enabled
        if ~exist([workdir a 'ac_out2' a 'psf' a 'ac.ac'],'file')
            indication=0;
            errordlg('AC out 2 Cadence results cannot be found. Cannot extract only. Use RUN OCEAN.','Extract only error');
        end
    end

    if res.par_an.enabled
        if ~exist([workdir a 'par2'],'dir') && ~exist([workdir a 'par'],'dir') %too weak
            indication=0;
            errordlg('PARAM 2 Cadence results cannot be found. Cannot extract only. Use RUN OCEAN.','Extract only error');
        end
    end
    
end


return;