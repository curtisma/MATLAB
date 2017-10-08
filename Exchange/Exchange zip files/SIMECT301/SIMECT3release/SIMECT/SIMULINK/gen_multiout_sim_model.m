%---------------------------------------------------
% Ce programme est la propriete exclusive de SUPELEC
% Tout  usage  non  authorise  ou reproduction de ce
% programme est strictement defendu.
% Copyright  (c) 2010  SUPELEC  Departement SSE
% Tous droits reserves
%---------------------------------------------------
%
% fichier : gen_multiout_mod.m
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

function []=gen_multiout_sim_model(simulink_model_par,model_in_out)
%Create Simulink model starting from extracted characteristics

%subcell
subcell=simulink_model_par.subcell;

%Create new system with parameters

%new system
nm=find_system;
ex=0 ;
for i=1:length(nm)
    if strcmp(char(nm(i)),subcell)
        ex=1 ;
    end
end
if (ex==1)
    save_system(subcell);
    close_system(subcell);
end

%open
open_system(new_system(subcell));
% set default screen color
set_param(subcell, 'ScreenColor', 'green');
% set default solver
set_param(subcell, 'Solver', 'ode45');
% set default toolbar visibility
set_param(subcell, 'Toolbar', 'on');
% save the model
save_system(subcell);

%Number of outputs
no=simulink_model_par.numout;

%Initial coordinates of blocks
x1 = 250;
y1 = 30;
w1 = 100;
h1 = 80;
offset1 = 0;

pos = [x1 (y1+offset1*2) x1+w1 (y1+offset1*2)+h1];

%For multiple outputs insert new subsystem
if no>1
    add_block('built-in/Subsystem',[subcell '/' subcell],'Position',pos);
    sub_string=['/' subcell '/'];
else
    sub_string='/';
end

%Add subcells for all the outputs
for i=1:no
    
    %Recalculate position
    pos = [x1 (y1+offset1*2) x1+w1 (y1+offset1*2)+h1];
    
    %Open source type
    open_system([simulink_model_par.model_name comp_nlin_diff(simulink_model_par)]);
    %Copy block
    add_block([simulink_model_par.model_name comp_nlin_diff(simulink_model_par) '/' simulink_model_par.model_name]', [subcell sub_string subcell num2str(i)],'Position',pos);
    %close source
    close_system([simulink_model_par.model_name comp_nlin_diff(simulink_model_par)]);
    
    
    %Insert parameters for the blocks
    create_analog_model(subcell,sub_string,i,model_in_out{i})
    
    %Move offset for the next block
    offset1=offset1+50;
    
end

%For multiple outputs new subsystem structure
if no>1
    
    %Number of signs
    inputs_adder='';
    
    for i=1:no
        inputs_adder=[inputs_adder '+'];
    end
    
    %Position of adders
    x2 = 50;
    y2 = 100;
    w2 = 30;
    h2 = 15*no;
    offset2 = 0;
    offsetg = 60;
    wp = 15;
    hp = 15;
    
    %Inputs are unipolar/diff
    if simulink_model_par.mode_diff_enabled
        nadd=2;
    else
        nadd=1;
    end
    
    for l=1:nadd
        
        %Adders
        pos = [x2 (y2+offset2*2) x2+w2 (y2+offset2*2)+h2];
        
        add_block('built-in/Sum',[subcell sub_string 'Add_in' num2str(l)],'Position',pos);
        
        set_param([subcell sub_string 'Add_in' num2str(l)],'Inputs',inputs_adder);
        
        %Gains
        pos = [x2+offsetg (y2+offset2*2) x2+offsetg+w2 (y2+offset2*2)+h2];
        
        add_block('built-in/Gain',[subcell sub_string 'Gain_in' num2str(l)],'Position',pos);
        
        set_param([subcell sub_string 'Gain_in' num2str(l)],'Gain',num2str(1/no));
  
        %Lines
        for i=1:no
            add_line([subcell sub_string(1:end-1)],[subcell num2str(i) '/' num2str(l)],['Add_in' num2str(l) '/' num2str(i)],'autorouting','on');
        end
        
        add_line([subcell sub_string(1:end-1)],['Add_in' num2str(l) '/1'], ['Gain_in' num2str(l) '/1'],'autorouting','on');
        
        %I/O ports for input 
 
        pos = [x2 offset2 x2+wp offset2+hp];
        
        add_block('built-in/Inport',[subcell sub_string strrep(simulink_model_par.model_name(1),'C','I') 'in' num2str(l)],'Position',pos);
        
        %Lines
        for i=1:no
            add_line([subcell sub_string(1:end-1)],[strrep(simulink_model_par.model_name(1),'C','I') 'in' num2str(l) '/1'],[subcell num2str(i) '/' num2str(l)],'autorouting','on');
        end
        
        pos = [x2+offsetg*2 (y2+offset2*2) x2+offsetg*2+wp (y2+offset2*2)+hp];
        
        add_block('built-in/Outport',[subcell sub_string strrep(strrep(simulink_model_par.model_name(1),'V','I'),'C','V') 'in' num2str(l)],'Position',pos);
        
        add_line([subcell sub_string(1:end-1)], ['Gain_in' num2str(l) '/1'], [strrep(strrep(simulink_model_par.model_name(1),'V','I'),'C','V') 'in' num2str(l) '/1'],'autorouting','on');
        
        offset2=offset2+30+10*no;
    end
    
    %I/O ports for output
    
    %Outputs are unipolar/diff
    if simulink_model_par.mode_diff_enabled_out
        nado=2;
    else
        nado=1;
    end
    
    offsetop=220;
    offsetop1=160;
    offset1 =0;
    
    for i=1:no
    
        for l=1:nado
        
         %Recalculate position and add inport
         pos = [x1+offsetop (y1+offset1*2) x1+offsetop+wp (y1+offset1*2)+hp]; 
         
         add_block('built-in/Inport',[subcell sub_string strrep(strrep(simulink_model_par.model_name(3),'V','I'),'C','V') 'out' num2str(i) '_'  num2str(l)],'Position',pos);
        
         add_line([subcell sub_string(1:end-1)],[strrep(strrep(simulink_model_par.model_name(3),'V','I'),'C','V') 'out' num2str(i) '_'  num2str(l) '/1'],[subcell num2str(i) '/' num2str(nadd+l)],'autorouting','on');
         
         %Recalculate position and add outport
         pos = [x1+offsetop1 (y1+offset1*2) x1+offsetop1+wp (y1+offset1*2)+hp];
         
         add_block('built-in/Outport',[subcell sub_string strrep(simulink_model_par.model_name(3),'C','I') 'out' num2str(i) '_'  num2str(l)],'Position',pos);
        
         add_line([subcell sub_string(1:end-1)],[subcell num2str(i) '/' num2str(nadd+l)],[strrep(simulink_model_par.model_name(3),'C','I') 'out' num2str(i) '_'  num2str(l) '/1'],'autorouting','on');

         offset1=offset1+25;   
        end
    end
    
end

% save the model
save_system(subcell,[],'OverwriteIfChangedOnDisk',true);

% subfunctions used in the generator
function [txt]=comp_nlin_diff(simulink_model_par)

if simulink_model_par.nlin
    lin='_nlin';
else
    lin='_lin';
end

if simulink_model_par.mode_diff_enabled
    indiff='_in_diff';
else
    indiff='_in_comm';
end

if simulink_model_par.mode_diff_enabled_out
    outdiff='_out_diff';
else
    outdiff='_out_comm';
end

txt=[lin indiff outdiff];

return