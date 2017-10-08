%---------------------------------------------------
% Ce programme est la propriete exclusive de SUPELEC
% Tout  usage  non  authorise  ou reproduction de ce
% programme est strictement defendu. 
% Copyright  (c) 2010  SUPELEC  Departement SSE
% Tous droits reserves
%---------------------------------------------------
%
% fichier : write_variant_to_file.m
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

%Create variant file

run_status=0;

variant_file=[path '/' file];

fid_sch = fopen(variant_file, 'w');

if ~isempty(handles.model_par.machines)
    fprintf(fid_sch,['model_par.machines=''' handles.model_par.machines ''';\n']);
else
    fprintf(fid_sch,'model_par.machines=[] ;\n');    
end

if ~isempty(handles.model_par.rev_trfunction)
    fprintf(fid_sch,['model_par.rev_trfunction=' '0'+handles.model_par.rev_trfunction ';\n']);
else
    fprintf(fid_sch,'model_par.rev_trfunction=[] ;\n');    
end

%%In, out, alim, mode diff
fprintf(fid_sch,['model_par.in_kind=''' handles.model_par.in_kind ''';\n']);
fprintf(fid_sch,['model_par.in_Vname{1}=''' handles.model_par.in_Vname{1} ''';\n']);
if (handles.model_par.gen_sources==0)
    fprintf(fid_sch,['model_par.in_Iname{1}=''' handles.model_par.in_Iname{1} ''';\n']);
end


%In2 if diff on input
if handles.model_par.mode_diff_enabled
        fprintf(fid_sch,['model_par.in_Vname{2}=''' handles.model_par.in_Vname{2} ''';\n']);
        if (handles.model_par.gen_sources==0)
            fprintf(fid_sch,['model_par.in_Iname{2}=''' handles.model_par.in_Iname{2} ''';\n']);
        end
end

fprintf(fid_sch,['model_par.numout=' num2str(handles.model_par.numout) ';\n']);

fprintf(fid_sch,['model_par.out_kind=''' handles.model_par.out_kind ''';\n']);
for k=1:handles.model_par.numout
    fprintf(fid_sch,['model_par.out_Vname{' num2str(2*k-1) '}=''' handles.model_par.out_Vname{2*k-1} ''';\n']);
    if (handles.model_par.gen_sources==0)
        fprintf(fid_sch,['model_par.out_Iname{' num2str(2*k-1) '}=''' handles.model_par.out_Iname{2*k-1} ''';\n']);
    end
end


%Out2 if diff on output
if handles.model_par.mode_diff_enabled_out
    for k=1:handles.model_par.numout
        fprintf(fid_sch,['model_par.out_Vname{' num2str(2*k) '}=''' handles.model_par.out_Vname{2*k} ''';\n']);
        if (handles.model_par.gen_sources==0)
            fprintf(fid_sch,['model_par.out_Iname{' num2str(2*k) '}=''' handles.model_par.out_Iname{2*k} ''';\n']); 
        end
    end
end

fprintf(fid_sch,['model_par.alim_Vname=''' handles.model_par.alim_Vname ''';\n']);
if (handles.model_par.gen_sources==0)
    fprintf(fid_sch,['model_par.alim_Iname=''' handles.model_par.alim_Iname ''';\n']);
end
fprintf(fid_sch,['model_par.alim_kind=''' handles.model_par.alim_kind ''';\n']);

%Sources
fprintf(fid_sch,['model_par.gen_sources=' num2str(handles.model_par.gen_sources) ';\n']);
if (handles.model_par.gen_sources==1)
    fprintf(fid_sch,['model_par.inoffset=''' num2str(handles.model_par.inoffset) ''';\n']) ;      
    fprintf(fid_sch,['model_par.outoffset=''' num2str(handles.model_par.outoffset) ''';\n']);      
    fprintf(fid_sch,['model_par.gen_supply=' num2str(handles.model_par.gen_supply) ';\n']);

    if isfield(handles.model_par,'supply_value')
        fprintf(fid_sch,['model_par.supply_value=' num2str(handles.model_par.supply_value) ';\n']) ;
    end
end

%Gnd
if isfield(handles.model_par,'gnd')    
    fprintf(fid_sch,['model_par.gnd=''' handles.model_par.gnd ''';\n']) ;    
end

%Mode comm/diff on input
fprintf(fid_sch,['model_par.mode_diff_enabled=' num2str(handles.model_par.mode_diff_enabled) ';\n']);
%Mode comm/diff on output
fprintf(fid_sch,['model_par.mode_diff_enabled_out=' num2str(handles.model_par.mode_diff_enabled_out) ';\n']);

if (handles.model_par.gen_sources==0)
    fprintf(fid_sch,['model_par.mode_var_I{1}=''' handles.model_par.mode_var_I{1} ''';\n']);
    if handles.model_par.mode_diff_enabled
        fprintf(fid_sch,['model_par.mode_var_I{2}=''' handles.model_par.mode_var_I{2} ''';\n']);
    else
        fprintf(fid_sch,'model_par.mode_var_I{2}='''';\n');
    end

    for k=1:handles.model_par.numout
      fprintf(fid_sch,['model_par.mode_var_O{' num2str(2*k-1) '}=''' handles.model_par.mode_var_O{2*k-1} ''';\n']);
    end

    if handles.model_par.mode_diff_enabled_out
        for k=1:handles.model_par.numout
          fprintf(fid_sch,['model_par.mode_var_O{' num2str(2*k) '}=''' handles.model_par.mode_var_O{2*k} ''';\n']);
        end
    else
        fprintf(fid_sch,'model_par.mode_var_O{2}='''';\n');
    end
end

if isfield(handles.model_par,'vhdl_filename')
    fprintf(fid_sch,['model_par.vhdl_filename=''' handles.model_par.vhdl_filename ''';\n']);
else
    fprintf(fid_sch,'model_par.vhdl_filename='''';\n');
end

    

fprintf(fid_sch,'\n');

%Design variables
if ~isempty(handles.des_var)
    for i=1:size(handles.des_var,2)
            fprintf(fid_sch,['des_var(' num2str(i) ').name=''' handles.des_var(i).name ''';\n']);
            fprintf(fid_sch,['des_var(' num2str(i) ').value=' num2str(handles.des_var(i).value) ';\n']);
    end
end

fprintf(fid_sch,'\n');

%DC
if handles.dc_an.enabled
    if (handles.model_par.gen_sources==0)
          fprintf(fid_sch,['dc_an.par_name=''' handles.dc_an.par_name ''';\n']);
    end
    fprintf(fid_sch,['dc_an.par_start=' num2str(handles.dc_an.par_start) ';\n']);
    fprintf(fid_sch,['dc_an.par_stop=' num2str(handles.dc_an.par_stop) ';\n']);
    if handles.model_par.mode_diff_enabled
          fprintf(fid_sch,['dc_an.par_diff_max=' num2str(handles.dc_an.par_diff_max) ';\n']);
    end
    fprintf(fid_sch,['dc_an.par_gain=' num2str(handles.dc_an.par_gain) ';\n']);
    fprintf(fid_sch,['dc_an.naminC=''' handles.dc_an.naminC ''';\n']);
end

fprintf(fid_sch,'\n');

%Par
if handles.par_an.enabled
    if (handles.model_par.gen_sources==0)
            fprintf(fid_sch,['par_an.var_name=''' handles.par_an.var_name ''';\n']);
    end
    fprintf(fid_sch,['par_an.start=' num2str(handles.par_an.start) ';\n']);
    fprintf(fid_sch,['par_an.stop=' num2str(handles.par_an.stop) ';\n']);
    fprintf(fid_sch,['par_an.npt=' num2str(handles.par_an.npt) ';\n']);
end

fprintf(fid_sch,'\n');

%Trans
if handles.trans_an.enabled
    if (handles.model_par.gen_sources==0)
        fprintf(fid_sch,['trans_an.naminmax=''' handles.trans_an.naminmax ''';\n']);
        fprintf(fid_sch,['trans_an.naminmin=''' handles.trans_an.naminmin ''';\n']);
        fprintf(fid_sch,['trans_an.nam_per_tr=''' handles.trans_an.nam_per_tr ''';\n']);
    else
        if ~isempty(handles.trans_an.type)
            fprintf(fid_sch,['trans_an.type=''' handles.trans_an.type ''';\n']);
        end
    end
    fprintf(fid_sch,['trans_an.valinmax=' num2str(handles.trans_an.valinmax) ';\n']);
    fprintf(fid_sch,['trans_an.valinmin=' num2str(handles.trans_an.valinmin) ';\n']);
    fprintf(fid_sch,['trans_an.per_tr=' num2str(handles.trans_an.per_tr) ';\n']);
    fprintf(fid_sch,['trans_an.start=' num2str(handles.trans_an.start) ';\n']);
    fprintf(fid_sch,['trans_an.stop=' num2str(handles.trans_an.stop) ';\n']);
    fprintf(fid_sch,['trans_an.step=' num2str(handles.trans_an.step) ';\n']);
end

fprintf(fid_sch,'\n');

%AC
if handles.ac_in_an.enabled||handles.ac_out_an.enabled
    all_ac_vars_set=0;
    fprintf(fid_sch,['ac_an.start=' num2str(handles.ac_an.start) ';\n']);
    fprintf(fid_sch,['ac_an.stop=' num2str(handles.ac_an.stop) ';\n']);
    fprintf(fid_sch,['ac_an.points=' num2str(handles.ac_an.points) ';\n']);
    fprintf(fid_sch,['ac_an.f0=' num2str(handles.ac_an.f0) ';\n']);
    fprintf(fid_sch,['ac_an.enable_ac_norm=' num2str(handles.enable_ac_norm) ';\n']);
        
                
    if handles.ac_in_an.enabled
        fprintf(fid_sch,['ac_in_an.naminC=''' handles.ac_in_an.naminC ''';\n']);
        if (handles.extract_ac_in_pz)
          fprintf(fid_sch,['ac_in_an.ord_Zin=' num2str(get(handles.popupmenu85,'value')-1) ';\n']);
          fprintf(fid_sch,['ac_in_an.ord_trf=' num2str(get(handles.popupmenu107,'value')-1) ';\n']);
        end
    end
      
           
    if handles.ac_out_an.enabled
        
        fprintf(fid_sch,['ac_out_an.namoutC=''' handles.ac_out_an.namoutC ''';\n']);
        if (handles.extract_ac_out_pz)
          fprintf(fid_sch,['ac_out_an.ord_Zout=' num2str(get(handles.popupmenu94,'value')-1) ';\n']);
          fprintf(fid_sch,['ac_out_an.ord_invf=' num2str(get(handles.popupmenu108,'value')-1) ';\n']);
        end
    end
    
    all_ac_vars_set=1;
    
end

fclose(fid_sch);

run_status=1;