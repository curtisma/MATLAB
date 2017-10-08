%---------------------------------------------------
% Ce programme est la propriete exclusive de SUPELEC
% Tout  usage  non  authorise  ou reproduction de ce
% programme est strictement defendu. 
% Copyright  (c) 2010  SUPELEC  Departement SSE
% Tous droits reserves
%---------------------------------------------------
%
% fichier : read_user_input.m
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
%Read user input

%hv=[handles.popupmenu59 handles.popupmenu97 handles.popupmenu119 handles.popupmenu118 handles.popupmenu125 handles.popupmenu124];
%hi=[handles.popupmenu103 handles.popupmenu102 handles.popupmenu121 handles.popupmenu120 handles.popupmenu127 handles.popupmenu126];
%hd=[handles.popupmenu105 handles.popupmenu106 handles.popupmenu117 handles.popupmenu116 handles.popupmenu123 handles.popupmenu122];
handpopmenu ;

%%General
handles.model_par.simrep=get(handles.edit1,'String');
handles.model_par.variant=get(handles.edit3,'String');


cell=get(handles.popupmenu2,'String');
handles.model_par.celldir=cell{get(handles.popupmenu2,'Value')};
pos=findstr(handles.model_par.celldir,':');
if (length(pos)>=2)
    handles.model_par.cell=handles.model_par.celldir(pos(1)+1:pos(2)-1) ;
else
    handles.model_par.cell=handles.model_par.celldir;
end

%Subcircuits
handles.model_par.sim_subckt=handles.sim_subckt;

if (handles.model_par.sim_subckt==0)
  handles.model_par.subcell=handles.model_par.cell;
end
netlist_repository=handles.model_par.netlist_repository ;

% extract machines
handles.model_par.machines=get(handles.edit38,'String');


%In name and kind
handles.model_par.in_kind=handles.in_kind;

if ~isempty(handles.model_par.in_kind)
    contents_in_name_a = get(handles.popupmenu58,'String');
    selected_in_name_a = contents_in_name_a{get(handles.popupmenu58,'Value')};
    handles.model_par.in_Vname{1}=selected_in_name_a;

    if handles.gen_sources==0
        contents_in_name_b = get(handles.popupmenu101,'String');
        selected_in_name_b = contents_in_name_b{get(handles.popupmenu101,'Value')};   
        handles.model_par.in_Iname{1}=selected_in_name_b;
    else
        handles.model_par.in_Iname{1}=[];
    end 
else
    handles.model_par.in_Vname=[];
    handles.model_par.in_Iname=[];
end


%Out name and kind
handles.model_par.out_kind=handles.out_kind;

if ~isempty(handles.model_par.out_kind)   
    for k=1:handles.numout
        contents_out_name_a = get(hv(k*2-1),'String');
        selected_out_name_a = contents_out_name_a{get(hv(k*2-1),'Value')};
        handles.model_par.out_Vname{k*2-1}=selected_out_name_a;

        if handles.gen_sources==0
            contents_out_name_b = get(hi(k*2-1),'String');
            selected_out_name_b = contents_out_name_b{get(hi(k*2-1),'Value')};
            handles.model_par.out_Iname{k*2-1}=selected_out_name_b;
        else
            handles.model_par.out_Iname{k*2-1}=[];        
        end
    end
else    
    handles.model_par.out_Vname=[];
    handles.model_par.out_Iname=[];   
end

%Diff_mode IN
handles.model_par.mode_diff_enabled=handles.mode_diff_enabled;

if handles.gen_sources==0
    diffI1_var_name = get(handles.popupmenu61,'String');
    selected_diffI1_var_name = diffI1_var_name{get(handles.popupmenu61,'Value')};
    handles.model_par.mode_var_I{1} = selected_diffI1_var_name;
else
    handles.model_par.mode_var_I{1} = [];
end

if handles.model_par.mode_diff_enabled

    %Differential variable on input
    
    %Differential variable on input
    if handles.gen_sources==0
        diffI2_var_name = get(handles.popupmenu104,'String');
        selected_diffI2_var_name = diffI2_var_name{get(handles.popupmenu104,'Value')};
        handles.model_par.mode_var_I{2} = selected_diffI2_var_name;
    else
        handles.model_par.mode_var_I{2}=[];
    end
    
    %Input 2

    if ~isempty(handles.model_par.in_kind)
    
        contents_in_name_a = get(handles.popupmenu96,'String');
        selected_in_name_a = contents_in_name_a{get(handles.popupmenu96,'Value')};
        handles.model_par.in_Vname{2}=selected_in_name_a;

        if handles.gen_sources==0
            contents_in_name_b = get(handles.popupmenu100,'String');
            selected_in_name_b = contents_in_name_b{get(handles.popupmenu100,'Value')};
            handles.model_par.in_Iname{2}=selected_in_name_b;
        else
            handles.model_par.in_Iname{2}=[];
        end
        
    end
    
%else
%    handles.model_par.mode_var_I2=[];
end


%Diff_mode OUT
handles.model_par.mode_diff_enabled_out=handles.mode_diff_enabled_out;
handles.model_par.numout=handles.numout;

if handles.gen_sources==0
    for k=1:handles.numout
        diffO_var_name = get(hd(k*2-1),'String');
        selected_diffO_var_name = diffO_var_name{get(hd(k*2-1),'Value')};
        handles.model_par.mode_var_O{2*k-1} = selected_diffO_var_name;
        
    end    
else
    handles.model_par.mode_var_O{1} = [];
end

if handles.model_par.mode_diff_enabled_out  
    if handles.gen_sources==0
     for k=1:handles.numout
        diffO_var_name = get(hd(k*2),'String');
        selected_diffO_var_name = diffO_var_name{get(hd(k*2),'Value')};
        handles.model_par.mode_var_O{2*k} = selected_diffO_var_name;
        
     end 
    else
      handles.model_par.mode_var_O{2} = [];        
    end

    if ~isempty(handles.out_kind)
    
        for k=1:handles.numout
            contents_out_name_a = get(hv(k*2),'String');
            selected_out_name_a = contents_out_name_a{get(hv(k*2),'Value')};
            handles.model_par.out_Vname{k*2}=selected_out_name_a;

            if handles.gen_sources==0
                contents_out_name_b = get(hi(k*2),'String');
                selected_out_name_b = contents_out_name_b{get(hi(k*2),'Value')};
                handles.model_par.out_Iname{k*2}=selected_out_name_b;
            else
                handles.model_par.out_Iname{k*2}=[];        
            end
        end
    
    end
    
else
    handles.model_par.mode_var_O{2}=[];
end

handles.model_par.rev_trfunction=get(handles.checkbox40,'Value');

% generate sources
if isfield(handles,'gen_sources')
    handles.model_par.gen_sources=handles.gen_sources ;
    if (handles.gen_sources==1)
        handles.model_par.inoffset=str2double(get(handles.edit39,'String'));
        handles.model_par.outoffset=str2num(get(handles.edit40,'String'));
        if isfield(handles,'gen_supply')
            handles.model_par.gen_supply=handles.gen_supply ;
            if (handles.gen_supply==1)
                handles.model_par.supply_value=str2double(get(handles.edit41,'String'));
            end
        else
            handles.model_par.gen_supply=0 ;    
        end
    end
else
    handles.model_par.gen_sources=0 ;    
end

% GND
if isfield(handles,'gen_sources')
    
    % GND is generated only when generating sources
    if (handles.gen_sources==1)    
        contents_gnd = get(handles.popupmenu112,'String');
        selected_gnd = contents_gnd{get(handles.popupmenu112,'Value')};    
        if ~strcmp(selected_gnd,'<None>')
            handles.model_par.gnd = selected_gnd;
        else
            handles.model_par.gnd = '';
        end 
    else
        handles.model_par.gnd = '';  
    end
end     


%Supply name and kind
contents_supply_name = get(handles.popupmenu110,'String');
selected_supply_name = contents_supply_name{get(handles.popupmenu110,'Value')};
handles.model_par.alim_Vname=selected_supply_name;

if (handles.gen_sources)&&(~handles.gen_supply)
    handles.model_par.alim_Iname=[];  
elseif (~handles.gen_sources)
    contents_supply_name = get(handles.popupmenu60,'String');
    selected_supply_name = contents_supply_name{get(handles.popupmenu60,'Value')};
    handles.model_par.alim_Iname=selected_supply_name;
end

handles.model_par.alim_kind='I'; %Supply is a current


%%Transient

handles.trans_an.enabled=handles.trans_enabled;

if handles.trans_an.enabled
    if handles.gen_sources==0
        %Trans in max
        contents_trans_in_max = get(handles.popupmenu62,'String');
        selected_trans_in_max = contents_trans_in_max{get(handles.popupmenu62,'Value')};
        handles.trans_an.naminmax=selected_trans_in_max;

         %Trans in min
        contents_trans_in_min = get(handles.popupmenu63,'String');
        selected_trans_in_min = contents_trans_in_min{get(handles.popupmenu63,'Value')};
        handles.trans_an.naminmin=selected_trans_in_min;

        %Trans period
        contents_trans_period = get(handles.popupmenu68,'String');
        selected_trans_period = contents_trans_period{get(handles.popupmenu68,'Value')};
        handles.trans_an.nam_per_tr=selected_trans_period;
    else
        handles.trans_an.naminmax=[];
        handles.trans_an.naminmin=[];
        handles.trans_an.nam_per_tr=[];
    end
    
    if handles.gen_sources==1
        contents_type_tr_a = get(handles.popupmenu109,'String');
        selected_type_tr_a = contents_type_tr_a{get(handles.popupmenu109,'Value')};
        handles.trans_an.type = selected_type_tr_a;
    else
        handles.trans_an.type = [];
    end
    
    trans_in_max_val=str2double(get(handles.edit5,'String'));
    handles.trans_an.valinmax=trans_in_max_val;
    
    trans_in_min_val=str2double(get(handles.edit4,'String'));
    handles.trans_an.valinmin=trans_in_min_val;
 
    trans_period_val=str2double(get(handles.edit8,'String'));
    handles.trans_an.per_tr=trans_period_val;
    
    %Trans start/stop/step
    trans_start_val=str2double(get(handles.edit9,'String'));
    handles.trans_an.start=trans_start_val;
    
    trans_stop_val=str2double(get(handles.edit12,'String'));
    handles.trans_an.stop=trans_stop_val;
    
    trans_step_val=str2double(get(handles.edit11,'String'));
    handles.trans_an.step=trans_step_val;
    
else
    handles.trans_an.naminmax=[];
    handles.trans_an.valinmax=[];
    handles.trans_an.naminmin=[];
    handles.trans_an.type = [];
    handles.trans_an.valinmin=[];
    handles.trans_an.nam_per_tr=[];
    handles.trans_an.per_tr=[];
    handles.trans_an.start=[];
    handles.trans_an.stop=[];
    handles.trans_an.step=[];
end

%%DC

handles.dc_an.enabled=handles.dc_enabled;
handles.ac_an.enable_ac_norm=handles.enable_ac_norm;


if handles.dc_an.enabled
    %DC var name
    contents_dc_in_comp = get(handles.popupmenu132,'String');
    selected_dc_in_comp = contents_dc_in_comp{get(handles.popupmenu132,'Value')};
    handles.dc_an.naminC=selected_dc_in_comp;
    if strcmp(handles.dc_an.naminC,'<None>')
         handles.dc_an.naminC='';
    end
    
    if handles.gen_sources==0
        contents_dc_var = get(handles.popupmenu34,'String');
        selected_dc_var = contents_dc_var{get(handles.popupmenu34,'Value')};
        handles.dc_an.par_name=selected_dc_var;
    else
        handles.dc_an.par_name=[];
    end
    
    %DC start
    dc_start_val=str2double(get(handles.edit13,'String'));
    handles.dc_an.par_start=dc_start_val;
    
    %DC stop
    dc_stop_val=str2double(get(handles.edit14,'String'));
    handles.dc_an.par_stop=dc_stop_val;
    
    %DC max for diff mode
    if handles.model_par.mode_diff_enabled
        dc_diff_max_val=str2double(get(handles.edit37,'String'));
        handles.dc_an.par_diff_max=dc_diff_max_val;
    else
        handles.dc_an.par_diff_max=[];
    end
            
    %DC Desired gain
    dc_gain_val=str2double(get(handles.edit15,'String'));
    if (isnan(dc_gain_val))
      handles.dc_an.par_gain=1;         % if no gain entered supposed to be equal to 1
    else
      handles.dc_an.par_gain=dc_gain_val;
    end
    
else
    handles.dc_an.par_name=[];
    handles.dc_an.par_start=[];
    handles.dc_an.par_stop=[];
    handles.dc_an.par_gain=[];
end

%%Param

handles.par_an.enabled=handles.par_enabled;

if handles.par_an.enabled
    %Parameter name
    if handles.gen_sources==0
        contents_par_var = get(handles.popupmenu77,'String');
        selected_par_var = contents_par_var{get(handles.popupmenu77,'Value')};
        handles.par_an.var_name=selected_par_var;
    else
        handles.par_an.var_name=[];
    end
        
    %par start
    par_start_val=str2double(get(handles.edit19,'String'));
    handles.par_an.start=par_start_val;
    
    %par stop
    par_stop_val=str2double(get(handles.edit21,'String'));
    handles.par_an.stop=par_stop_val;
    
    %par points
    par_npt_val=str2double(get(handles.edit20,'String'));
    handles.par_an.npt=par_npt_val;
    
else
    handles.par_an.var_name=[];
    handles.par_an.start=[];
    handles.par_an.stop=[];
    handles.par_an.npt=[];
end

%%AC in
handles.ac_in_an.enabled=handles.ac_in_enabled;
handles.ac_out_an.enabled=handles.ac_out_enabled;

if handles.ac_in_an.enabled || handles.ac_out_an.enabled

    %AC in f0
    ac_f0_val=str2double(get(handles.edit25,'String'));
    handles.ac_an.f0=ac_f0_val;
    
    %AC in start
    ac_start_val=str2double(get(handles.edit22,'String'));
    handles.ac_an.start=ac_start_val;
    
    %AC in stop
    ac_stop_val=str2double(get(handles.edit24,'String'));
    handles.ac_an.stop=ac_stop_val;
    
    %AC in points
    ac_npt_val=str2double(get(handles.edit23,'String'));
    handles.ac_an.points=ac_npt_val;
    
else
    handles.ac_an.f0=[];
    handles.ac_an.start=[];
    handles.ac_an.stop=[];
    handles.ac_an.points=[];
end

if handles.ac_in_an.enabled
    
    %AC in cancel component
    contents_ac_in_comp = get(handles.popupmenu40,'String');
    selected_ac_in_comp = contents_ac_in_comp{get(handles.popupmenu40,'Value')};
    handles.ac_in_an.naminC=selected_ac_in_comp;
    if strcmp(handles.ac_in_an.naminC,'<None>')
         handles.ac_in_an.naminC='';
    end

    
    handles.ac_in_an.extract_pz=handles.extract_ac_in_pz;
    
    if handles.ac_in_an.extract_pz
        %General AC in numerator max order
        contents = get(handles.popupmenu85,'String');
        selected = contents{get(handles.popupmenu85,'Value')};
        handles.ac_in_an.ord_Zin=str2double(selected);
        
        %General AC in denominator max order
        contents = get(handles.popupmenu107,'String');
        selected = contents{get(handles.popupmenu107,'Value')};
        handles.ac_in_an.ord_trf=str2double(selected);
    else
        handles.ac_in_an.ord_Zin=[];
        handles.ac_in_an.ord_trf=[];
    end

else
    handles.ac_in_an.naminC=[];
    handles.ac_in_an.extract_pz=0;
    handles.ac_in_an.ord_Zin=[];
    handles.ac_in_an.ord_trf=[];
end

%%AC out

if handles.ac_out_an.enabled
        
    %AC out cancel component
    contents_ac_out_comp = get(handles.popupmenu93,'String');
    selected_ac_out_comp = contents_ac_out_comp{get(handles.popupmenu93,'Value')};
    handles.ac_out_an.namoutC=selected_ac_out_comp;
    if strcmp(handles.ac_out_an.namoutC,'<None>')
       handles.ac_out_an.namoutC='';
    end
    
    handles.ac_out_an.extract_pz=handles.extract_ac_out_pz;
    
    if handles.ac_out_an.extract_pz
        %General AC out numerator max order
        contents = get(handles.popupmenu94,'String');
        selected = contents{get(handles.popupmenu94,'Value')};
        handles.ac_out_an.ord_Zout=str2double(selected);
        
        %General AC out denominator max order
        contents = get(handles.popupmenu108,'String');
        selected = contents{get(handles.popupmenu108,'Value')};
        handles.ac_out_an.ord_invf=str2double(selected);
    else
        handles.ac_out_an.ord_Zout=[];
        handles.ac_out_an.ord_invf=[];
    end

else
    handles.ac_out_an.namoutC=[];
    handles.ac_out_an.extract_pz=0;
    handles.ac_out_an.ord_Zout=[];
    handles.ac_out_an.ord_invf=[];
end

handles.model_par.disp_res_diffcomm=handles.disp_res_diffcomm ;

handles.model_par.vhdl_filename=get(handles.edit42,'String');

handles.model_par.rempoles= get(handles.popupmenu131,'Value')-1;
