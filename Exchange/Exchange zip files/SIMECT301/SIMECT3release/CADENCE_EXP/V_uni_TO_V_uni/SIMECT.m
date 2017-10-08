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
% file : SIMECT.m
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
%   extraction du macro-modele d'une fonction analogique
%
% MODULES UTILISES :
%       * copy_subckt_netlist
%       * addinfogene
%       * run_ocean
%       * extract_all
%       * disp_all_DC
%       * disp_all_AC
%
%---------------------------------------------------



%model_par.simrep='/home/benabes/cadence/projets/lamb/ams35/Sim/';  % simulation directory
model_par.simrep='/home/benabes/cadence/outils/SIMECT/CADENCE_EXP/V_uni_TO_V_uni/Sim';  % simulation directory
model_par.netltype='spectre' ;
model_par.viewtype='schematic' ;
model_par.cell='test_v_uni_v_uni';       % name of schematic
model_par.cellrep=[];       % name of schematic
model_par.sim_subckt=0;
model_par.subcell=[] ;       % name of schematic
model_par.variant='_v1';                             % name of variant   

model_par.rnocn=1;                             % executer ocean
model_par.disp_res=1;                          % afficher 
model_par.disp_res_diffcomm=0;                 % display DC in differential mode
model_par.enable_cdn_model=1;
model_par.extr_vhdl=0;                         % extract vhdl model
model_par.rempoles=0;                          % do not remove poles

%DC Analysis Parameters
dc_an.enabled=1;

%Parametric Analysis
par_an.enabled=1;

%Trasient Analysis
trans_an.enabled=1;

%AC Analysis Parameters
ac_an.enable_ac_norm=0;
ac_in_an.enabled=1;
ac_in_an.extract_pz = 1;
ac_out_an.enabled=1;
ac_out_an.extract_pz = 1;

%Verbosity parameters
verb.warning=0;         % display warnings or not
verb.ocn_msg=0;         % display ocean messages
verb.txt=0;             % display debug informations in a text file
verb.plot=0;            % plot DC results
verb.mesh=0;            % plot parametric results

%Error Parameters 
err_param.max=1e20;  %Maximum step to start computing error for numerator/denominator/fc
err_param.w=0.5; %Weight of Modulus in approximation of TF,Z_in,Z_out -> Phase=1-w
err_param.freq_w=[]; %Array of weights for frequency-distributed fitting of invfreqs. If =[],same weights for all freq
err_param.iter=100; %MAX Number of iterations for invfreqs
err_param.tol=0.01; %Tolerance of fitting for invfreqs
err_param.trace=1; %Use complex extracting alg and show textual progress of invfreqs
err_param.w_rlc=0.8; %Weight of Modulus in approximation of TF,Z_in,Z_out -> Phase=1-w
err_param.perc_rlc=1.1; %percentage of the + variation of impedance curve in order to declare that is RLC
err_param.var_min=1e-20; %MIN variance of a curve to be considered constant function

if isfield(model_par,'cellrep')
  if ~isempty(model_par.cellrep)
    model_par.workdir=[model_par.simrep '/' model_par.cellrep ];
  else
    model_par.workdir=[model_par.simrep '/' model_par.cell '/' model_par.netltype '/' model_par.viewtype ];
  end
else
    model_par.workdir=[model_par.simrep '/' model_par.cell '/' model_par.netltype '/' model_par.viewtype ];
end

tpwd=pwd ;
cd(model_par.simrep) ;
model_par.netlist_repository=[model_par.workdir '/netlist'];
model_par.netlist=model_par.netlist_repository;

if exist('subcell','var')
    lg=length(subcell) ; if(lg==0), lg=1 ; end
else
    lg=1; subcell=[] ;
end

for subc=1:lg
    
    if (~isempty(subcell))
        model_par.subcell=char(subcell(subc)) ;
    else
        model_par.subcell='' ;
    end
    
    cd('variables');
    if isempty(model_par.subcell)
      clear(['var_' model_par.cell model_par.variant])
      eval(['var_' model_par.cell model_par.variant]) ;         % charge les variables correspondant au schema
    else
      clear(['var_' model_par.cell '_'  model_par.subcell model_par.variant])
      eval(['var_' model_par.cell '_'  model_par.subcell model_par.variant]) ;         % charge les variables correspondant au schema
    end
    cd('..');

    if (par_an.enabled)
        par_an.step=(par_an.stop-par_an.start)/(par_an.npt-1) ;
        err_param.res=(par_an.step)*1e-2; %Resolution of searching for the simulation directory -> ATTENTION: For small values of the step, could have error due to simulator
    end;

    %Input and output impedances/admitances selection for Simulink model
    if strcmp(model_par.in_kind,'I')
        %Extract input admitance model
        model_par.extr_in_adm=0;
    else
        %Extract input impedance model
        model_par.extr_in_adm=1;
    end

    if strcmp(model_par.out_kind,'V')
        %Extract output impedance model
        model_par.extr_out_adm=0;
    else
        %Extract output admitance model
        model_par.extr_out_adm=1;
    end

    if verb.warning
        warning on all;
    else
        warning off all;
    end;

    if (model_par.sim_subckt==1)
      [ind,subckt_net_meas,model_par.netlist]=copy_subckt_netlist(model_par.subcell,model_par);
    end

    if (model_par.gen_sources==1)       % if sources must be added
        [ model_par,trans_an, dc_an, par_an, des_var ] = addinfogene( model_par, trans_an, dc_an, par_an, des_var);
    end  

    if model_par.rnocn
        figure(11);
        set(11,'position',[400,400,80,80]);
        h1=uicontrol('style','text','units','normalized','position',[0.0 0.0 1 1],'string','Running');
        r=run_ocean(model_par, des_var, ac_an, ac_in_an, ac_out_an, dc_an, par_an, trans_an, verb, h1 );
        close(11);
        if (r==0)
           msgbox('Error during OCEAN run. Please check schematic!','Run Error')
        end
    end

    %Extract parameters
    [rep model]=extract_all(model_par, ac_an, ac_in_an, ac_out_an, dc_an, par_an,trans_an,ac_in_an.extract_pz,ac_out_an.extract_pz,verb,err_param);

    if (model_par.disp_res)
        if  ~isdir(['figures/' model_par.cell model_par.variant])  
            mkdir(['figures/' model_par.cell model_par.variant]) ; 
        end

        disp_all_DC(model_par,rep,model_par.disp_res_diffcomm,0) ;
        
        for k=1:model_par.numout
             saveas(19+2*k,['figures/' model_par.cell model_par.variant '/fig' num2str(19+2*k)],'fig');
             if model_par.mode_diff_enabled_out %if out diff
                saveas(20+2*k,['figures/' model_par.cell model_par.variant '/fig' num2str(20+2*k)],'fig');
             end
        end

        disp_all_AC(model_par,rep,model,ac_an,ac_in_an,ac_out_an,0,1)

        for k=1:model_par.numout
             saveas(39+2*k,['figures/' model_par.cell model_par.variant '/fig' num2str(39+2*k)],'fig');
        end
            
    end

    if (model_par.extr_vhdl==1)
        convert_res_vhdl(model_par,dc_an,ac_an,model,rep,model_par.enable_cdn_model,model_par.vhdl_filename,0);
    end

end
cd(tpwd);

