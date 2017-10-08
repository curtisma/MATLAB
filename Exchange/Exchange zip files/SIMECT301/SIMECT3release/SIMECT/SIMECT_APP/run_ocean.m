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
% file : run_ocean.m
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
%   creates ocean script file ans runs ocean simulations
%
% MODULES UTILISES :
%       none
%
%---------------------------------------------------

function [good]=run_ocean(model_par, design_var, ac_an, ac_in_an, ac_out_an, dc_an, par_an, trans_an, verb, htxt)
% Performs parametric, AC and DC analyses over the current mirror design 
% and also modified AC for Z_out using Cadence Ocean utility


%Simulate entire circuit or subcircuits
%For subcircuits copy modified netlist to sim repository


dir_ntlst = model_par.netlist ;
dir_spctr = model_par.workdir ;

%Write model propr

dr = dir([dir_ntlst '/netlist']) ;
dr2 = dir([dir_ntlst(1:end-1-length(model_par.subcell)) '/netlist']) ;

if (isempty(dr) && isempty(dr2))
    msgbox('Netlist unavailable','Run Error') ;
    good=0 ;
    return ;
elseif ~isempty(dr)
    date_netlist=dr.datenum ;
else
    date_netlist=dr2.datenum ;
end

% get the number of external machines on which run processes
if isempty(model_par.machines)
    nmachines = 0 ;
else
    ppv = find(model_par.machines==';') ;
    ppv(end+1) = length(model_par.machines==';')+1 ;
    nmachines=length(ppv);
    if (nmachines>3)
        nmachines=3 ;
    end
    ppv=[0 ppv];
end

for k=1:nmachines
    machine{k}=model_par.machines(ppv(k)+1:ppv(k+1)-1);
end

for k=0:nmachines
    if ~exist([dir_ntlst num2str(k)],'dir')
      unix(['cp -r ' dir_ntlst ' '  dir_ntlst num2str(k)]) ;
    else
        dr=dir([dir_ntlst num2str(k) '/netlist']);
        if date_netlist> dr(1).datenum
            %disp ('the netlist has been updated copying the new netlist');
            unix(['rm -r ' dir_ntlst num2str(k)]) ;            
            unix(['cp -r ' dir_ntlst ' ' dir_ntlst num2str(k)]) ;
        end
    end
   
   if model_par.gen_sources==1
       if model_par.mode_diff_enabled==0;
            if model_par.in_kind=='V'
                filin= which('SrcIn_VU.txt');
            else
                filin= which('SrcIn_IU.txt');
            end
       else
            if model_par.in_kind=='V'
                filin= which('SrcIn_VD.txt');
            else
                filin= which('SrcIn_ID.txt');
            end        
       end
       
       if model_par.out_kind=='V'
            filout= which('SrcOut_V.txt');
            filout2= which('SrcOut_V2.txt');
       else
            filout= which('SrcOut_I.txt');
            filout2= which('SrcOut_I2.txt');
       end
       
      unix(['sed s/Vin1/' model_par.in_Vname{1} '/g '  filin ' > srcin.txt']); 
      if model_par.mode_diff_enabled
        unix(['sed s/Vin2/' model_par.in_Vname{2} '/g srcin.txt > srcin2.txt']); 
        unix('mv srcin2.txt  srcin.txt');
      end
      
      unix(['cp ' filout ' srcout.txt']);
      for m=1:model_par.numout
          for l=0:model_par.mode_diff_enabled_out
            unix(['sed s/Vout/' model_par.out_Vname{m*2+l-1} '/g '  filout2 ' > srcout2.txt']);
            unix(['sed s/8900/89' num2str((m-1)*2+l,'%02d') '/g srcout2.txt > srcout3.txt']); 
            unix('cat srcout.txt srcout3.txt > srcout2.txt');
            unix('mv srcout2.txt srcout.txt');
          end
      end
      unix('rm srcout3.txt');
      
      
      if (model_par.gen_supply==1)
          unix(['sed s/Valim/' model_par.alim_Vname '/g ' which('SrcAlim.txt') ' > srcalim.txt']);
          unix(['cat ' dir_ntlst '/netlist srcin.txt srcout.txt srcalim.txt > ' dir_ntlst num2str(k) '/netlist']) ;
          unix('rm srcalim.txt');
      else      
          unix(['cat ' dir_ntlst '/netlist srcin.txt srcout.txt > ' dir_ntlst num2str(k) '/netlist']) ;
      end
      
      %add gnd if needed
      if ~isempty(model_par.gnd)
          unix(['sed s/' model_par.gnd '/0/g ' dir_ntlst num2str(k) '/netlist >' dir_ntlst num2str(k) '/netlist_gnd']);
          unix(['cp ' dir_ntlst num2str(k) '/netlist_gnd ' dir_ntlst num2str(k) '/netlist']) ;
      end
      
      unix('rm srcin.txt');
      unix('rm srcout.txt');
      
   end
    
end


for k=0:nmachines
    fid = fopen(['init' num2str(k) '.ocn'], 'w');
    fprintf(fid,'simulator( ''spectre )\n');
    fprintf(fid,['design(	 "' dir_ntlst num2str(k) '/netlist")\n']);
    fprintf(fid,'modelFile(\n');

    
    
    
    dr=dir([dir_ntlst '/' '.modelFiles']);
    if (isempty(dr))     % file does not exist
        fid2=fopen([dir_ntlst '/' 'corners.scs']);    
    elseif (dr.bytes==0) % file is empty
        fid2=fopen([dir_ntlst '/' 'corners.scs']);     
    else  % file exists
        fid2=fopen([dir_ntlst '/' '.modelFiles']);   
    end

    %fid2=fopen([dir_ntlst '/.modelFiles']);
    if fid2~=(-1)
        tline = fgetl(fid2);
        while ~isempty(tline) & (tline~=-1)
            if strfind(tline,'include')
                pos=strfind(tline,'"') ;
                fprintf(fid,['    ''(' tline(pos(1):pos(2)) ]);

                pos=strfind(tline,'section') ;
                if (isempty(pos))
                    fprintf(fid,' "")\n');
                else
                    fprintf(fid,[' "' tline(pos+8:end) '")\n']);            
                end
            end
            tline = fgetl(fid2);
        end

        fclose(fid2);
    end
    fprintf(fid,')\n');
    fprintf(fid,'temp( 27 )\n');
    fclose(fid); 
    
end



    
%Write design variables
fiv = fopen('desvar.ocn', 'w');
for i=1:size(design_var,2)
    fprintf(fiv,'%s\n',['desVar( "' design_var(i).name '" ' num2str(design_var(i).value) ' )']);
end

%Transient generator enabled only on trans analysis
if trans_an.enabled
    if (isfield(trans_an,'naminmax'))
      fprintf(fiv,'%s\n',['desVar( "' trans_an.naminmax '"' ' 0 )' ]);
    end
    if (isfield(trans_an,'naminmin'))
      fprintf(fiv,'%s\n',['desVar( "' trans_an.naminmin '"' ' 0 )' ]);
    end
    if (isfield(trans_an,'nam_per_tr'))
      fprintf(fiv,'%s\n',['desVar( "' trans_an.nam_per_tr '" ' num2str(trans_an.per_tr) ' )']);
    end
end

fclose(fiv);

%Setup Analyses DC&Par
fid(1) = fopen('dc1.ocn', 'w');
fid(2) = fopen('dc2.ocn', 'w');
fid(3) = fopen('ac.ocn', 'w');
fid(4) = fopen('tr.ocn', 'w');

for k=1:4
    fprintf(fid(k),['save( ''i "' model_par.in_Iname{1},':n" )\n']);
    fprintf(fid(k),['save( ''i "' model_par.in_Iname{1},':p" )\n']);
    if (model_par.mode_diff_enabled)
        fprintf(fid(k),['save( ''i "' model_par.in_Iname{2},':n" )\n']);
        fprintf(fid(k),['save( ''i "' model_par.in_Iname{2},':p" )\n']);
    end

    for l=1:model_par.numout
        fprintf(fid(k),['save( ''i "' model_par.out_Iname{l*2-1},':n" )\n']);
        fprintf(fid(k),['save( ''i "' model_par.out_Iname{l*2-1},':p" )\n']);
        if (model_par.mode_diff_enabled_out)
            fprintf(fid(k),['save( ''i "' model_par.out_Iname{l*2},':n" )\n']);
            fprintf(fid(k),['save( ''i "' model_par.out_Iname{l*2},':p" )\n']);
        end
    end 
    
    if dc_an.enabled||par_an.enabled
        if ~((model_par.gen_sources==1)&&(model_par.gen_supply==0))
            fprintf(fid(k),['save( ''i "' model_par.alim_Iname,':n" )\n']);
            fprintf(fid(k),['save( ''i "' model_par.alim_Iname,':p" )\n']);
        end
    end

    % on se met en différentiel en entrée
    fprintf(fid(k),'%s\n',['desVar( "' model_par.mode_var_I{1} '" 1 )']);
    if model_par.mode_diff_enabled
        fprintf(fid(k),'%s\n',['desVar( "' model_par.mode_var_I{2} '" -1 )']);
    end
end


% on se met en unipolaire sur chaque sortie
for l=1:model_par.numout
    fprintf(fid(1),'%s\n',['desVar( "' model_par.mode_var_O{2*l-1} '" 0 )']);
    fprintf(fid(2),'%s\n',['desVar( "' model_par.mode_var_O{2*l-1} '" 0 )']);
    if model_par.mode_diff_enabled_out
        fprintf(fid(1),'%s\n',['desVar( "' model_par.mode_var_O{2*l} '" 0 )']);
        fprintf(fid(2),'%s\n',['desVar( "' model_par.mode_var_O{2*l} '" 0 )']);
    end
end

if dc_an.enabled
    if (~isempty(dc_an.naminC))
      fprintf(fid(1),'%s\n',['desVar( "' dc_an.naminC '" 0 )']);
    end
    fprintf(fid(1),['resultsDir( "' dir_spctr '/dc" )\n']);
    %Symetric diff DC for diff designs
    if model_par.mode_diff_enabled
        fprintf(fid(1),['analysis(''dc ?dev ""  ?param "' dc_an.par_name '"  ?start "' num2str(-dc_an.par_diff_max) '"  ?stop "' num2str(dc_an.par_diff_max) '"  )\n']);   
    else
        fprintf(fid(1),['analysis(''dc ?dev ""  ?param "' dc_an.par_name '"  ?start "' num2str(dc_an.par_start) '"  ?stop "' num2str(dc_an.par_stop) '"  )\n']);   
    end
    fprintf(fid(1),'run()\n');
    fprintf(fid(1),'delete( ''analysis ''dc)\n');
    
    if model_par.mode_diff_enabled    
        % on se met en mode commun en entree
        fprintf(fid(1),'%s\n',['desVar( "' model_par.mode_var_I{2} '" 1 )']);
        fprintf(fid(1),['resultsDir( "' dir_spctr '/dc_com" )\n']);
        fprintf(fid(1),['analysis(''dc ?dev ""  ?param "' dc_an.par_name '"  ?start "' num2str(dc_an.par_start) '"  ?stop "' num2str(dc_an.par_stop) '"  )\n']);
        fprintf(fid(1),'run()\n');
        fprintf(fid(1),'delete( ''analysis ''dc)\n');
        % on se remet en differentiel en entree
        fprintf(fid(1),'%s\n',['desVar( "' model_par.mode_var_I{2} '" -1 )']);
    end
    if (~isempty(dc_an.naminC))
        idx=0;
        for i=1:size(design_var,2)
        if strcmp(dc_an.naminC,design_var(i).name)
            idx=i;
        end
        end
        if idx~=0
            fprintf(fid(1),'%s\n',['desVar( "' dc_an.naminC '" ' num2str(design_var(idx).value) ' )']);
        end
    end
end

if par_an.enabled 
    
    if (~isempty(dc_an.naminC))
      fprintf(fid(1),'%s\n',['desVar( "' dc_an.naminC '" 0 )']);
      fprintf(fid(2),'%s\n',['desVar( "' dc_an.naminC '" 0 )']);
    end
    
    if model_par.rev_trfunction
        for k=1:model_par.numout
          for l=0:model_par.mode_diff_enabled_out
                            
            fprintf(fid(1+l),'%s\n',['desVar( "' model_par.mode_var_O{2*k-1+l} '" 1 )']);
            fprintf(fid(1+l),['resultsDir( "' dir_spctr '/par' num2str(2*k+l-1) '" )\n']);
            %Symetric diff DC for diff designs
            if model_par.mode_diff_enabled
                fprintf(fid(1+l),['analysis(''dc ?dev ""  ?param "' dc_an.par_name '"  ?start "' num2str(-dc_an.par_diff_max) '"  ?stop "' num2str(dc_an.par_diff_max) '"  )\n']);   
            else
                fprintf(fid(1+l),['analysis(''dc ?dev ""  ?param "' dc_an.par_name '"  ?start "' num2str(dc_an.par_start) '"  ?stop "' num2str(dc_an.par_stop) '"  )\n']);   
            end
            fprintf(fid(1+l),'%s\n',['ana1 = paramAnalysis( "' par_an.var_name '" ?start ' num2str(par_an.start,'%g') ' ?stop ' num2str(par_an.stop,'%g') ' ?step ' num2str(par_an.step,'%g') ' )']);
            fprintf(fid(1+l),'paramRun(''ana1)\n');
            fprintf(fid(1+l),'%s\n',['desVar( "' model_par.mode_var_O{2*k-1+l} '" 0 )']);
          end 
        end
    else
         for k=1:model_par.numout
              for l=0:model_par.mode_diff_enabled_out
                fprintf(fid(1),'%s\n',['desVar( "' model_par.mode_var_O{2*k-1+l} '" 1 )']);
              end
         end
        fprintf(fid(1),['resultsDir( "' dir_spctr '/par" )\n']);
        %Symetric diff DC for diff designs
        if model_par.mode_diff_enabled
            fprintf(fid(1),['analysis(''dc ?dev ""  ?param "' dc_an.par_name '"  ?start "' num2str(-dc_an.par_diff_max) '"  ?stop "' num2str(dc_an.par_diff_max) '"  )\n']);   
        else
            fprintf(fid(1),['analysis(''dc ?dev ""  ?param "' dc_an.par_name '"  ?start "' num2str(dc_an.par_start) '"  ?stop "' num2str(dc_an.par_stop) '"  )\n']);   
        end
        fprintf(fid(1),'%s\n',['ana1 = paramAnalysis( "' par_an.var_name '" ?start ' num2str(par_an.start,'%g') ' ?stop ' num2str(par_an.stop,'%g') ' ?step ' num2str(par_an.step,'%g') ' )']);
        fprintf(fid(1),'paramRun(''ana1)\n');
         for k=1:model_par.numout
              for l=0:model_par.mode_diff_enabled_out
                fprintf(fid(1),'%s\n',['desVar( "' model_par.mode_var_O{2*k-1+l} '" 0 )']);
              end
         end
    end
    
    if model_par.mode_diff_enabled
        
      fprintf(fid(2),'%s\n',['desVar( "' model_par.mode_var_I{1} '" 1 )']);
      fprintf(fid(2),'%s\n',['desVar( "' model_par.mode_var_I{2} '" 1 )']);
      % on se met en mode commun en sortie
      for k=1:model_par.numout
        fprintf(fid(2),'%s\n',['desVar( "' model_par.mode_var_O{2*k-1} '" 1 )']);
        if model_par.mode_diff_enabled_out
            fprintf(fid(2),'%s\n',['desVar( "' model_par.mode_var_O{2*k} '" 1 )']);
        end
      end
         
      fprintf(fid(2),['resultsDir( "' dir_spctr '/par_com" )\n']);
      fprintf(fid(2),['analysis(''dc ?dev ""  ?param "' dc_an.par_name '"  ?start "' num2str(dc_an.par_start) '"  ?stop "' num2str(dc_an.par_stop) '"  )\n']);
      fprintf(fid(2),'%s\n',['ana1 = paramAnalysis( "' par_an.var_name '" ?start ' num2str(par_an.start,'%g') ' ?stop ' num2str(par_an.stop,'%g') ' ?step ' num2str(par_an.step,'%g') ' )']);
      fprintf(fid(2),'paramRun(''ana1)\n');
      
      fprintf(fid(2),'%s\n',['desVar( "' model_par.mode_var_I{2} '" 1 )']);
    end
    
    if (~isempty(dc_an.naminC))
        idx=0;
        for i=1:size(design_var,2)
        if strcmp(dc_an.naminC,design_var(i).name)
            idx=i;
        end
        end
        if idx~=0
            fprintf(fid(1),'%s\n',['desVar( "' dc_an.naminC '" ' num2str(design_var(idx).value) ' )']);
            fprintf(fid(2),'%s\n',['desVar( "' dc_an.naminC '" ' num2str(design_var(idx).value) ' )']);
        end
    end

end

%Setup Analyses AC
if ac_in_an.enabled
    
    if (~isempty(ac_in_an.naminC))
      fprintf(fid(3),'%s\n',['desVar( "' ac_in_an.naminC '" 0 )']);
    end
    
    fprintf(fid(3),'%s\n',['desVar( "' model_par.mode_var_I{1} '" 1 )']);
    for l=1:model_par.numout
        fprintf(fid(3),'%s\n',['desVar( "' model_par.mode_var_O{2*l-1} '" 0 )']);
    end
    if model_par.mode_diff_enabled
        fprintf(fid(3),'%s\n',['desVar( "' model_par.mode_var_I{2} '" 0 )']);
    end
    if model_par.mode_diff_enabled_out
    for l=1:model_par.numout
            fprintf(fid(3),'%s\n',['desVar( "' model_par.mode_var_O{2*l} '" 0 )']);
    end
    end

    fprintf(fid(3),['resultsDir( "' dir_spctr '/ac_in1" )\n']);
    fprintf(fid(3),['analysis(''ac ?start "' num2str(ac_an.start) '"  ?stop "' num2str(ac_an.stop) '"  ?dec "' num2str(ac_an.points) '"  )\n']);
    fprintf(fid(3),'run()\n');
    fprintf(fid(3),'delete( ''analysis ''ac)\n');
    

%Perform Par DC and AC for common mode if design supports both common and diff
    if model_par.mode_diff_enabled
    
        fprintf(fid(3),'%s\n',['desVar( "' model_par.mode_var_I{1} '" 0 )']);
        fprintf(fid(3),'%s\n',['desVar( "' model_par.mode_var_I{2} '" 1 )']);
            
        fprintf(fid(3),['resultsDir( "' dir_spctr '/ac_in2" )\n']);
        fprintf(fid(3),['analysis(''ac ?start "' num2str(ac_an.start) '"  ?stop "' num2str(ac_an.stop) '"  ?dec "' num2str(ac_an.points) '"  )\n']);
        fprintf(fid(3),'run()\n');
        fprintf(fid(3),'delete( ''analysis ''ac)\n');
        
        
        
        fprintf(fid(3),'%s\n',['desVar( "' model_par.mode_var_I{2} '" 0 )']);

    end
    fprintf(fid(3),'%s\n',['desVar( "' model_par.mode_var_I{1} '" 0 )']);
    
    if (~isempty(ac_in_an.naminC))

        idx=0;
        for i=1:size(design_var,2)
        if strcmp(ac_in_an.naminC,design_var(i).name)
            idx=i;
        end
        end
        if idx~=0
            fprintf(fid(3),'%s\n',['desVar( "' ac_in_an.naminC '" ' num2str(design_var(idx).value) ' )']);
        end
    end
   
end

%AC for Zout
if ac_out_an.enabled
   
    if (~isempty(ac_out_an.namoutC))
        fprintf(fid(3),'%s\n',['desVar( "' ac_out_an.namoutC '" 0 )']);
    end
    
    fprintf(fid(3),'%s\n',['desVar( "' model_par.mode_var_I{1} '" 0 )']);
    if model_par.mode_diff_enabled
        fprintf(fid(3),'%s\n',['desVar( "' model_par.mode_var_I{2} '" 0 )']);
    end
    
    
    for k=1:model_par.numout
      for l=0:model_par.mode_diff_enabled_out
    
        for m=1:model_par.numout
            for n=0:model_par.mode_diff_enabled_out          
                fprintf(fid(3),'%s\n',['desVar( "' model_par.mode_var_O{m*2-1+n} '" ' num2str(m*2+n==k*2+l) ' )']);
            end
        end

        fprintf(fid(3),['resultsDir( "' dir_spctr '/ac_out' num2str(k*2+l-1) '" )\n']);
        fprintf(fid(3),['analysis(''ac ?start "' num2str(ac_an.start) '"  ?stop "' num2str(ac_an.stop) '"  ?dec "' num2str(ac_an.points) '"  )\n']);
        fprintf(fid(3),'run()\n');
        fprintf(fid(3),'delete( ''analysis ''ac)\n');
      end
    end    
      
    for m=1:model_par.numout
        for n=0:model_par.mode_diff_enabled_out          
            fprintf(fid(3),'%s\n',['desVar( "' model_par.mode_var_O{m*2-1+n} '" 1)']);
        end
    end

    fprintf(fid(3),['resultsDir( "' dir_spctr '/ac_out0" )\n']);
    fprintf(fid(3),['analysis(''ac ?start "' num2str(ac_an.start) '"  ?stop "' num2str(ac_an.stop) '"  ?dec "' num2str(ac_an.points) '"  )\n']);
    fprintf(fid(3),'run()\n');
    fprintf(fid(3),'delete( ''analysis ''ac)\n');
    
    
    
    
    if (~isempty(ac_out_an.namoutC))     
        idx=0;
        for i=1:size(design_var,2)
            if strcmp(ac_out_an.namoutC,design_var(i).name)
                idx=i;
            end
        end
        if idx~=0
            fprintf(fid(3),'%s\n',['desVar( "' ac_out_an.namoutC '" ' num2str(design_var(idx).value) ' )']);
        end

    end

end

%Transient analysis
if trans_an.enabled

    fprintf(fid(4),'%s\n',['desVar( "' model_par.mode_var_I{1} '" 1 )']);
    fprintf(fid(4),'%s\n',['desVar( "' model_par.mode_var_O{1} '" 1 )']);
    if model_par.mode_diff_enabled
        fprintf(fid(4),'%s\n',['desVar( "' model_par.mode_var_I{2} '" -1 )']);
    end
    if model_par.mode_diff_enabled_out
        fprintf(fid(4),'%s\n',['desVar( "' model_par.mode_var_O{2} '" -1 )']);
    end
    
    %The transient stimulus should start only for trans analysis!
    if (isfield(trans_an,'naminmax'))
        fprintf(fid(4),'%s\n',['desVar( "' trans_an.naminmax '" ' num2str(trans_an.valinmax) ' )']);
    end
    if (isfield(trans_an,'naminmin'))
        fprintf(fid(4),'%s\n',['desVar( "' trans_an.naminmin '" ' num2str(trans_an.valinmin) ' )']);
    end
    if (isfield(trans_an,'nam_per_tr'))
        fprintf(fid(4),'%s\n',['desVar( "' trans_an.nam_per_tr '" ' num2str(trans_an.per_tr) ' )']);
    end
    
    %fprintf(fid,'saveOption( ''format "psfbin" )\n');
    fprintf(fid(4),['resultsDir( "' dir_spctr '/trans" )\n']);
    fprintf(fid(4),['analysis( ''tran ?start "' num2str(trans_an.start) '" ?stop "' num2str(trans_an.stop) '" ?step "' num2str(trans_an.step) '" )\n']);
    fprintf(fid(4),'run()\n');
    fprintf(fid(4),'selectResult( ''tran )\n'); 
    %fprintf(fid,'plot( i("V1:p"))\n');
    for l=0:model_par.mode_diff_enabled_out
        for m=1:model_par.numout
            if (model_par.out_kind=='V')
                str_out=['v("' model_par.out_Vname{m*2+l-1}, '")' ];
            else        
                str_out=['i("' model_par.out_Iname{m*2+l-1}, ':n")' ];
            end
            fprintf(fid(4),['ocnPrint( ?output "' dir_spctr '/trans/trans' num2str(m*2+l-1) '.txt" ?numberNotation ''scientific ?numSpaces 1 ' str_out ' )\n']);
        end
    end
    %fprintf(fid,'run()\n');
end

%fprintf(fid,'exit\n');
for k=1:4
    fclose(fid(k));
end

for k=0:nmachines
    fid(k+1) = fopen(['sim' num2str(k) '.cmd'], 'w');
    fprintf(fid(k+1),'%s\n',['load( "init' num2str(k) '.ocn" )']);
    fprintf(fid(k+1),'%s\n','load( "desvar.ocn" )');
end

if (nmachines==0)
    fprintf(fid(1),'%s\n','load( "dc1.ocn" )');
    fprintf(fid(1),'%s\n','load( "dc2.ocn" )');
    fprintf(fid(1),'%s\n','load( "ac.ocn" )');
    fprintf(fid(1),'%s\n','load( "tr.ocn" )');
elseif (nmachines==1)
    fprintf(fid(1),'%s\n','load( "dc1.ocn" )');
    fprintf(fid(1),'%s\n','load( "dc2.ocn" )');
    fprintf(fid(2),'%s\n','load( "ac.ocn" )');
    fprintf(fid(2),'%s\n','load( "tr.ocn" )');
elseif (nmachines==2)
    fprintf(fid(1),'%s\n','load( "dc1.ocn" )');
    fprintf(fid(2),'%s\n','load( "dc2.ocn" )');
    fprintf(fid(3),'%s\n','load( "ac.ocn" )');
    fprintf(fid(3),'%s\n','load( "tr.ocn" )');
elseif (nmachines==3)
    fprintf(fid(1),'%s\n','load( "dc1.ocn" )');
    fprintf(fid(2),'%s\n','load( "dc2.ocn" )');
    fprintf(fid(3),'%s\n','load( "ac.ocn" )');
    fprintf(fid(4),'%s\n','load( "tr.ocn" )');
end

for k=0:nmachines
    fprintf(fid(k+1),'%s\n','exit');
    fclose(fid(k+1));
end

for k=0:nmachines
    fid = fopen(['sim' num2str(k) '.bat'], 'w');
    %fprintf(fid,'%s\n',['touch sim' num2str(k) '.run']);
    fprintf(fid,'%s\n',['ocean < sim' num2str(k) '.cmd > ocean' num2str(k) '.log']);
    fprintf(fid,'%s\n',['rm sim' num2str(k)  '.run']);
    fclose(fid);
    unix (['chmod 744 sim' num2str(k) '.bat']) ;
end


if unix('which ocean > txtxtxtx')  % ocean is not in the profile
   good=0 ;
   unix('rm txtxtxtx');
   disp('Ocean software is not in your path') ;
else
    unix('rm txtxtxtx');
    %Run OCEAN
    disp('Ocean started') ;
    pause(0.01);
    [s,hst]=unix('hostname');

    if ~verb.ocn_msg
        delete('sim*.run')
        delete('ocean*.log')

        unix (['touch sim0.run']);
        unix './sim0.bat &' ;
        for k=1:nmachines
            unix(['xhost ' machine{k} '> txtxtxtx ; rm txtxtxtx']);
            unix (['touch sim' num2str(k) '.run']);
            unix(['ssh ' machine{k} ' ". ./.rprofile ; export DISPLAY=' hst(1:end-1) ':0.0 ; cd ' pwd ' ; ./sim' num2str(k) '.bat " & ']);
        end

        ex=1 ;

        while (ex==1)

            if (nargin>9)
              str=[char(10) 'RUNNING' char(10) 'OCEAN '];
            else
              str=['RUNNING OCEAN '];
            end

             for k=0:nmachines

                [s,w] = unix(['ls -l ocean' num2str(k) '.log']);
                a1=strread(w,'%s');
                str=[str char(a1(5)) ' '] ;
             end
           if (nargin>9)
             set(htxt,'String',str);
           else
             fprintf('%s \n',str);
           end
           pause(1);

           ex=0 ;
           a=dir ;
           for k=1:size(a,1)
               for l=0:nmachines
                   if (strcmp(a(k).name,['sim' num2str(l) '.run'])) 
                        ex=1 ;
                   end
               end
           end

        end
        [s,w] = unix('cat ocean*.log');
        if (~isempty(findstr(w,'Error found')) || ~isempty(findstr(w,'Fatal error')))
            good=0 ;
        else
            good = 1;
        end
    else
        unix 'ocean < sim0.cmd' ;    
        for k=1:nmachines
            unix(['ssh ' machine{k} ' ". ./.rprofile ; export DISPLAY=' hst(1:end-1) ':0.0 ; cd ' pwd ' ; ./sim' num2str(k) '.bat " ']);
        end

        good = 1 ;
    end;
end

if (good==1)
   disp('Ocean ended') ;
   delete('*.ocn');
   delete('*.cmd');
   delete('sim*.bat');
   delete('ocean*.log');
end

return;