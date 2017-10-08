%---------------------------------------------------
% Ce programme est la propriete exclusive de SUPELEC
% Tout  usage  non  authorise  ou reproduction de ce
% programme est strictement defendu. 
% Copyright  (c) 2010  SUPELEC  Departement SSE
% Tous droits reserves
%---------------------------------------------------
%
% fichier : verif_par_run.m
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


%run_status -> control successful execution
run_status=0;


%Sim repository, tech, cell, variant
if isempty(handles.model_par.simrep)
    errordlg('No SIM repository selected!','SIMECT Error');
    return;
end

if isempty(handles.model_par.cell)
    errordlg('No cell selected!','SIMECT Error');
    return;
end

%Subcircuits
if isempty(handles.model_par.sim_subckt)
    errordlg('Subckt or circuit simulation not selected!','SIMECT Error');
    return;
end


%Run OCEAN, Ord_num/denum max, Extract AC p/z
% if ~isfield(handles.model_par,'rnocn')
%     errordlg('Not specified if run OCEAN or not!','SIMECT Error');
%     return;
% end


%Analyses
if isempty(handles.trans_an.enabled)
    errordlg('Not specified if TRANS enabled/disabled!','SIMECT Error');
    return;
end

if isempty(handles.dc_an.enabled)
    errordlg('Not specified if DC enabled/disabled!','SIMECT Error');
    return;
end

if isempty(handles.par_an.enabled)
    errordlg('Not specified if PAR enabled/disabled!','SIMECT Error');
    return;
end

if isempty(handles.ac_in_an.enabled)
    errordlg('Not specified if AC IN enabled/disabled!','SIMECT Error');
    return;
end

if isempty(handles.ac_out_an.enabled)
    errordlg('Not specified if AC OUT enabled/disabled!','SIMECT Error');
    return;
end

%Schematic simulation parameters

%In, out, alim, mode diff
if isempty(handles.model_par.in_kind)
    errordlg('Primary Input name/kind not specified!','SIMECT Error');
    return;
end

if isempty(handles.model_par.out_kind)
    errordlg('Primary Output kind not specified!','SIMECT Error');    
    return;
end

if isempty(handles.model_par.alim_kind)
    errordlg('Supply name/kind not specified!','SIMECT Error');
    return;
end




if (handles.model_par.gen_sources==1)
    if isempty(handles.model_par.inoffset)
        errordlg('DC In not specified!','SIMECT Error');
        return;
    end
    
    if isempty(handles.model_par.outoffset)
        errordlg('DC Out not specified!','SIMECT Error');
        return;
    end
    if length(handles.model_par.outoffset)>1 && length(handles.model_par.outoffset)~=handles.numout
        errordlg('DC Out length sould be equal to the number of outputs','SIMECT Error');
        return;
    end
    

    if handles.model_par.gen_supply
        if isempty(handles.model_par.supply_value)
            errordlg('Supply value not specified!','SIMECT Error');
            return;
        end
    end
       
end


%Design variables
if ~isempty(handles.des_var)
    for i=1:size(handles.des_var,2)
        if isempty(handles.des_var(i).name)
            errordlg(['Name not set for design variable: ' num2str(i)],'SIMECT Error');
            return;
        end
        if isnan(handles.des_var(i).value)
            errordlg(['NaN value for design variable: ' handles.des_var(i).name '. Please re-edit.'],'SIMECT Error');
            return;
        end
        if isempty(handles.des_var(i).value)
            errordlg(['No value for design variable: ' handles.des_var(i).name '. Please re-edit.'],'SIMECT Error');
            return;
        end
    end
end




%DC
if handles.dc_an.enabled
    if handles.gen_sources==0
        if isempty(handles.dc_an.par_name)
                errordlg('Name not set for DC variable','SIMECT Error');
                return;
        end
    end
    
    if isempty(handles.dc_an.par_start) || isnan(handles.dc_an.par_start)
            errordlg('Start value not set for DC variable','SIMECT Error');
            return;
    end
    
    if isempty(handles.dc_an.par_stop) || isnan(handles.dc_an.par_stop)
            errordlg('Stop value not set for DC variable','SIMECT Error');
            return;
    end
    
    if handles.dc_an.par_stop <= handles.dc_an.par_start
            errordlg('DC stop must be higher than DC start','SIMECT Error');
            return;
    end
    
    if handles.model_par.mode_diff_enabled
        if isempty(handles.dc_an.par_diff_max) || isnan(handles.dc_an.par_diff_max)
            errordlg('DIFF max value not set for DC variable','SIMECT Error');
            return;
        end
    end
    
    if isempty(handles.dc_an.par_gain)
            errordlg('Desired gain value not set for DC analysis','SIMECT Error');
            return;
    end
end

%Par
if handles.par_an.enabled
    if handles.gen_sources==0
        if isempty(handles.par_an.var_name)
                errordlg('Name not set for PAR variable','SIMECT Error');
                return;
        end
    end
        
    if isempty(handles.par_an.start) || isnan(handles.par_an.start)
            errordlg('Start value not set for PAR variable','SIMECT Error');
            return;
    end
    if isempty(handles.par_an.stop) || isnan(handles.par_an.start)
            errordlg('Stop value not set for PAR variable','SIMECT Error');
            return;
    end
    if isempty(handles.par_an.npt) || isnan(handles.par_an.npt)
            errordlg('Number of points not set for PAR analysis','SIMECT Error');
            return;
    end
end

%Trans
if handles.trans_an.enabled
    if handles.gen_sources==0
        if isempty(handles.trans_an.naminmax)
                errordlg('Name not set for MAX TRANS variable','SIMECT Error');
                return;
        end
        if isempty(handles.trans_an.naminmin)
                errordlg('Name not set for MIN TRANS variable','SIMECT Error');
                return;
        end
        if isempty(handles.trans_an.nam_per_tr)
                errordlg('Name not set for period TRANS variable','SIMECT Error');
                return;
        end
    else
        if isempty(handles.trans_an.type)
                errordlg('Name not set for TYPE TRANS variable','SIMECT Error');
                return;
        end
    end
    
    if isempty(handles.trans_an.valinmax)
            errordlg('Value not set for MAX TRANS variable','SIMECT Error');
            return;
    end
    
    
    if isempty(handles.trans_an.valinmin)
            errordlg('Value not set for MIN TRANS variable','SIMECT Error');
            return;
    end
    
    
    if isempty(handles.trans_an.per_tr)
            errordlg('Value not set for period TRANS variable','SIMECT Error');
            return;
    end   
    
    if isempty(handles.trans_an.start)
            errordlg('Start value not set for trans variable','SIMECT Error');
            return;
    end
    if isempty(handles.trans_an.stop)
            errordlg('Stop value not set for trans variable','SIMECT Error');
            return;
    end
    if isempty(handles.trans_an.step)
            errordlg('Step not set for trans analysis','SIMECT Error');
            return;
    end
end

%AC
if handles.ac_in_an.enabled||handles.ac_out_an.enabled
    all_ac_vars_set=0;
    
    if isempty(handles.ac_an.start) || isnan(handles.ac_an.start)
        errordlg('Start value not set for AC variable','SIMECT Error');
        return;
    end
    if isempty(handles.ac_an.stop) || isnan(handles.ac_an.stop)
        errordlg('Stop value not set for AC variable','SIMECT Error');
        return;
    end
    if isempty(handles.ac_an.points) || isnan(handles.ac_an.points)
        errordlg('Number of points not set for AC analysis','SIMECT Error');
        return;
    end
    if isempty(handles.ac_an.f0) || isnan(handles.ac_an.f0)
        errordlg('F0 not set for AC analysis','SIMECT Error');
        return;
    end
    if (handles.ac_an.f0<handles.ac_an.start) || (handles.ac_an.f0>handles.ac_an.stop)
        errordlg('F0 must be between start and stop','SIMECT Error');
        return;
    end    
    if isempty(handles.enable_ac_norm)
        errordlg('Enable AC in norm not set for AC analysis','SIMECT Error');
        return;
    end
   
    if handles.ac_in_an.enabled
        if isempty(handles.extract_ac_in_pz)
            errordlg('extraction not set for AC analysis in','SIMECT Error'); 
            return; 
        end
    end
    if handles.ac_out_an.enabled
        if isempty(handles.extract_ac_out_pz)
            errordlg('extraction not set for AC analysis out','SIMECT Error'); 
            return; 
        end
    end
    
%     if handles.ac_in_an.enabled
%         if isempty(handles.ac_in_an.naminC)
%             errordlg('Illegal name for AC in canceled component','SIMECT Error');
%             return;
%         end
%     end
%     
%     if handles.ac_out_an.enabled
%         if isempty(handles.ac_out_an.namoutC)
%             errordlg('Illegal name for AC out canceled component','SIMECT Error');
%             return;
%         end
%     end
    all_ac_vars_set=1;
end

%If Parametric enabled and DC disabled
if handles.par_an.enabled&&(~handles.dc_an.enabled)
    warndlg('Parametric DC Analysis can be run only when DC analysis is enabled!','SIMECT Analyses');
    return;
end

%If all analyses disabled
if ~(handles.trans_an.enabled||handles.dc_an.enabled||handles.par_an.enabled||handles.ac_in_an.enabled||handles.ac_out_an.enabled)
    warndlg('All analyses disabled.Please set at least one analysis to run!','SIMECT Analyses');
    return;
end

run_status=1;