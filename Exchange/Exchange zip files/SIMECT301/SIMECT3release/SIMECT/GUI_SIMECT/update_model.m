%UPDATE_MODEL Summary of this function goes here
%   Detailed explanation goes here

if (netpr)
    workdir=[handles.model_par.simrep '/' handles.model_par.celldir];
else
    workdir=[handles.model_par.simrep '/' handles.model_par.celldir '/' handles.model_par.netltype '/' handles.model_par.viewtype ];    
end
netlist_repository=[workdir '/netlist'];

%Extract tech + %%%%%%%%%%%%%%%%%%%%%
tech=extract_tech(netlist_repository);

% if no netlist available, try for spectre verilog netlist
if (isempty(tech))
    netlist_repository=[workdir '/netlist/analog'];
    tech=extract_tech(netlist_repository);
end

if (isempty(tech))
        errordlg('Not netlist available for this view');
else
    %

    %Extract design variables
    des_var=extract_des_var(netlist_repository);

    %Extract netlist measures
    [crt_meas,net_meas]=extract_netlist(netlist_repository,handles.model_par.cell);

    %Extract subcircuits
    [syst_nm,sub_syst_all_vect,sub_syst_first_vect]=extract_subckt(netlist_repository,handles.model_par.cell);

    %Save variables
    handles.model_par.subcell=handles.model_par.cell;
    handles.des_var=des_var;
    handles.net_meas=net_meas;
    handles.crt_meas=crt_meas;
    handles.syst_nm=syst_nm;
    handles.sub_syst_all_vect=sub_syst_all_vect;
    handles.sub_syst_first_vect=sub_syst_first_vect;
    handles.model_par.netlist_repository=netlist_repository;
    handles.model_par.netlist=netlist_repository;
    handles.model_par.workdir=workdir;
end