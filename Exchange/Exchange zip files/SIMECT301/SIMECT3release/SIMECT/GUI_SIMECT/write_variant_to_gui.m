%---------------------------------------------------
% Ce programme est la propriete exclusive de SUPELEC
% Tout  usage  non  authorise  ou reproduction de ce
% programme est strictement defendu. 
% Copyright  (c) 2010  SUPELEC  Departement SSE
% Tous droits reserves
%---------------------------------------------------
%
% fichier : write_variant_to_gui.m
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

%Write variant parameters to gui

corrupt_var=0;

%hv=[handles.popupmenu59 handles.popupmenu97 handles.popupmenu119 handles.popupmenu118 handles.popupmenu125 handles.popupmenu124];
%hi=[handles.popupmenu103 handles.popupmenu102 handles.popupmenu121 handles.popupmenu120 handles.popupmenu127 handles.popupmenu126];
%hd=[handles.popupmenu105 handles.popupmenu106 handles.popupmenu117 handles.popupmenu116 handles.popupmenu123 handles.popupmenu122];
handpopmenu ;

%%General

if isfield(model_par,'machines')
    set(handles.edit38,'String',model_par.machines);
else
    set(handles.edit38,'String',[]);    
end

if ~isfield(model_par,'gen_sources')
    model_par.gen_sources=0 ;
end
if ~isfield(model_par,'gen_supply')
    model_par.gen_supply=0 ;
end
if ~isfield(model_par,'rev_trfunction')
    model_par.rev_trfunction=0 ;
end
if ~isfield(model_par,'numout')
    model_par.numout=1 ;
end

set(handles.checkbox40,'Value',model_par.rev_trfunction);


if model_par.gen_sources==1
    %Mode diff enabled on input
    handles.gen_sources=1;
    set(handles.edit39,'Enable','on');
    set(handles.edit39,'String',num2str(model_par.inoffset));
    
    set(handles.edit40,'Enable','on');
    set(handles.edit40,'String',num2str(model_par.outoffset));
    set(handles.checkbox34,'Value',1);
    
    set(handles.checkbox35,'Enable','on');
    handles.gen_supply=0;
    set(handles.popupmenu109,'Enable','on');
    set(handles.popupmenu109,'String',{'Constant','Sine','Square'});
    
    %GND
    nets_as_vect{1}='<None>';
    if size(handles.net_meas,2)>size(handles.net_meas,1)
        sz=size(handles.net_meas,2);
    else
        sz=size(handles.net_meas,1);
    end
        
    for i=1:sz
        nets_as_vect{i+1}=handles.net_meas{i};
    end
    
    if isfield(model_par,'gnd')
        
        set_popup_on(handles.popupmenu112,nets_as_vect);
        
        if ~isempty(model_par.gnd)
            corrupt_var = set_popup(handles.popupmenu112,strrep(model_par.gnd,':n',''),corrupt_var) ;
        else
            corrupt_var = set_popup(handles.popupmenu112,'<None>',corrupt_var) ;
        end
    else
        
        set_popup_on(handles.popupmenu112,nets_as_vect);
        corrupt_var = set_popup(handles.popupmenu112,'<None>',corrupt_var) ;
    end
    
    if model_par.gen_supply==1
        handles.gen_supply=1;
        set(handles.checkbox35,'Value',1);   
        set(handles.edit41,'Enable','on');
        if isfield(model_par,'supply_value')
            set(handles.edit41,'String',num2str(model_par.supply_value));
        else
            corrupt_var=1;
        end
    else
        handles.gen_supply=0;
        set(handles.checkbox35,'Value',0);   
        set(handles.edit41,'Enable','off');
    end

else
    %Disable
    handles.gen_sources=0;
    handles.gen_supply=0;
    set_edit_off(handles.edit39);
    set_edit_off(handles.edit40);
    set(handles.checkbox34,'Value',0);   
    set_check_off(handles.checkbox35);
    set_edit_off(handles.edit41);
    set_popup_off(handles.popupmenu109,'Constant');
    
end


%In name and kind
if isfield(model_par,'in_kind')
    if strcmp(model_par.in_kind,'V')
        set(handles.radiobutton57,'Value',1) %then primary input is V
        handles.in_kind='V';
    elseif strcmp(model_par.in_kind,'I')
        set(handles.radiobutton58,'Value',1) %then primary input is I
        handles.in_kind='I';
    else
        corrupt_var=1;
        handles.in_kind=[];
    end
else
    corrupt_var=1;
end


if isfield(model_par,'in_kind')
        
    if isfield(model_par,'in_Vname')
        set_popup_on(handles.popupmenu58,handles.net_meas);
        corrupt_var = set_popup(handles.popupmenu58,strrep(model_par.in_Vname{1},':n',''),corrupt_var) ;
    else
        corrupt_var=1;
    end

    if (model_par.gen_sources==0)       % sources are not generated
        if isfield(model_par,'in_Iname')
            set_popup_on(handles.popupmenu101,handles.crt_meas);
            corrupt_var = set_popup(handles.popupmenu101,model_par.in_Iname{1},corrupt_var) ;
        else
            corrupt_var=1;
        end
    else
        set_popup_off(handles.popupmenu101,'<Ii1>')
    end
        
    
else
    corrupt_var=1;
end

        
%Out name and kind
if isfield(model_par,'out_kind')
    if strcmp(model_par.out_kind,'V')
        set(handles.radiobutton59,'Value',1) %then primary input is V
        handles.out_kind='V';
    elseif strcmp(model_par.out_kind,'I')
        set(handles.radiobutton60,'Value',1) %then primary input is I
        handles.out_kind='I';
    else
        corrupt_var=1;
        handles.out_kind=[];
    end
else
    corrupt_var=1;
end

for no=0:2
    for df=1:2
        set_popup_off(hv(no*2+df),['<Vo' num2str(df) 'A'+no '>']);
        set_popup_off(hi(no*2+df),['<Io' num2str(df) 'A'+no '>']);
        set_popup_off(hd(no*2+df),['<Diff' num2str(df) 'A'+no '>']);
    end
end


if isfield(model_par,'out_kind')
  for k=1:model_par.numout     
    if isfield(model_par,'out_Vname')
        set_popup_on(hv(2*k-1),handles.net_meas);
        corrupt_var = set_popup(hv(2*k-1),strrep(model_par.out_Vname{2*k-1},':n',''),corrupt_var) ;
    else
        corrupt_var=1;
    end

    if (model_par.gen_sources==0)       % sources are not generated
        if isfield(model_par,'out_Iname')
            set_popup_on(hi(2*k-1),handles.crt_meas);
            corrupt_var = set_popup(hi(2*k-1),model_par.out_Iname{2*k-1},corrupt_var) ;
        else
            corrupt_var=1;
        end
    else
        set_popup_off(hi(2*k-1),['<Io1' 'A'+no-1 '>']);
    end    
  end 
else
    corrupt_var=1;
end

%Supply name
if (model_par.gen_sources==0)       % sources are not generated
    if isfield(model_par,'alim_Iname')
        set_popup_on(handles.popupmenu60,handles.crt_meas);
        corrupt_var = set_popup(handles.popupmenu60,model_par.alim_Iname,corrupt_var) ;
    else
        corrupt_var=1;
    end
else
    set_popup_off(handles.popupmenu60,'<I_s>')
end        

if isfield(model_par,'alim_Vname')
    set_popup_on(handles.popupmenu110,['<none>' handles.net_meas]);
    corrupt_var = set_popup(handles.popupmenu110,model_par.alim_Vname,corrupt_var) ;
else
    corrupt_var=1;
end


%Design variables
if isempty(des_var)
    set(handles.pushbutton25,'enable','Off');
else
   set(handles.pushbutton25,'enable','On');
   for k=1:size(des_var,2)
       for l=1:size(handles.des_var,2)
           if strcmp(des_var(k).name,handles.des_var(l).name)
               handles.des_var(l).value=des_var(k).value ;
           end
       end
   end
end 



% get design variables
vars_as_vect=[];
for i=1:size(handles.des_var,2)
    vars_as_vect{i}=handles.des_var(i).name;
end

%Populate diffI1 menu
set(handles.popupmenu61,'String',vars_as_vect);

if (model_par.gen_sources==0)       % sources are not generated
    if isfield(model_par,'mode_var_I')
        corrupt_var = set_popup(handles.popupmenu61,model_par.mode_var_I{1},corrupt_var) ;
    else 
        corrupt_var=1;
    end
else
    set_popup_off(handles.popupmenu61,'<DiffI1>')
end        
        
%Diff_mode IN
if isfield(model_par,'mode_diff_enabled')
        
    if model_par.mode_diff_enabled
        set(handles.checkbox14,'Enable','on');
        set(handles.checkbox14,'Value',1);
        handles.mode_diff_enabled=1;
        
        %Populate diffI2 menu
        set(handles.popupmenu104,'String',vars_as_vect);
              
        if (model_par.gen_sources==0)       % sources are not generated
           if isfield(model_par,'mode_var_I')
                corrupt_var = set_popup(handles.popupmenu104,model_par.mode_var_I{2},corrupt_var) ;
            else 
                corrupt_var=1;
           end
        else
            set_popup_off(handles.popupmenu104,'<DiffI2>')
        end
        %Populate In2 menu
        
        net_meas=handles.net_meas;
        crt_meas=handles.crt_meas;
        
        set(handles.popupmenu96,'String',net_meas);
        set(handles.popupmenu100,'String',crt_meas);
        

        if isfield(model_par,'in_kind')
        
            if isfield(model_par,'in_Vname')
                if size(model_par.in_Vname,2)>1
                    corrupt_var = set_popup(handles.popupmenu96,strrep(model_par.in_Vname{2},':n',''),corrupt_var) ;
                else
                    corrupt_var=1;
                end
            else
                corrupt_var=1;
            end

            if (model_par.gen_sources==0)       % sources are not generated
                if isfield(model_par,'in_Iname')
                    if size(model_par.in_Iname,2)>1
                        corrupt_var = set_popup(handles.popupmenu100,model_par.in_Iname{2},corrupt_var) ;
                    else
                        corrupt_var=1;
                    end
                else
                    corrupt_var=1;
                end
            else
                set_popup_off(handles.popupmenu100,'<Ii2>')
            end

        else
            corrupt_var=1;
        end
        
    else
        set(handles.checkbox14,'Enable','on');
        set(handles.checkbox14,'Value',0);
        
        set_popup_off(handles.popupmenu96,'<Vi2>')
        set_popup_off(handles.popupmenu100,'<Ii2>')
        
    end
else
    corrupt_var=1;
end


%Populate diffO1 menu

for k=1:model_par.numout
    set(hd(2*k-1),'String',vars_as_vect);
    if (model_par.gen_sources==0)       % sources are not generated
        if isfield(model_par,'mode_var_O')
            corrupt_var = set_popup(hd(2*k-1),model_par.mode_var_O{2*k-1},corrupt_var) ;
        else 
            corrupt_var=1;
        end
    else
        set_popup_off(hd(2*k-1),['<Diff1' 'A'+no-1 '>']);
    end
end

%Diff_mode OUT
handles.numout=model_par.numout ;
if isfield(model_par,'mode_diff_enabled_out')
    if model_par.mode_diff_enabled_out
        set(handles.popupmenu128,'Value',model_par.numout*2);
        st129='All' ; 
        for k=1:model_par.numout
            st129=[st129 '|' '0'+k];
        end
        set(handles.popupmenu129,'Value',1);
        set(handles.popupmenu129,'String',st129);
        handles.mode_diff_enabled_out=1;
        
        %Populate diffO2 menu
        for k=1:model_par.numout
            if (model_par.gen_sources==0)       % sources are not generated
                set(hd(2*k),'String',vars_as_vect);       
                if isfield(model_par,'mode_var_O')
                    corrupt_var = set_popup(hd(2*k),model_par.mode_var_O{2*k},corrupt_var) ;
                else 
                    corrupt_var=1;
                end
            else
                set_popup_off(hd(2*k),['<Diff2' 'A'+no-1 '>']);
            end
        end    

           
        
        
        %Populate Out2 menu
        
        %set(handles.popupmenu102,'Enable','on');
        
        net_meas=handles.net_meas;
        crt_meas=handles.crt_meas;
        
        for k=1:model_par.numout
            if isfield(model_par,'out_kind')

                if ~isempty(model_par.out_Vname{2*k})
                   set_popup_on(hv(2*k),handles.net_meas);
                   corrupt_var = set_popup(hv(2*k),strrep(model_par.out_Vname{2*k},':n',''),corrupt_var) ;
                else
                    corrupt_var=1;
                end

                if (model_par.gen_sources==0)       % sources are not generated
                    if ~isempty(model_par.out_Iname{2*k})
                        set_popup_on(hi(2*k),handles.crt_meas);
                        corrupt_var = set_popup(hi(2*k),model_par.out_Iname{2*k},corrupt_var) ;
                    else
                        corrupt_var=1;
                    end
                else
                     set_popup_off(hi(2*k),['<Io2' 'A'+no-1 '>']);
                end
            else
                corrupt_var=1;
            end
        end
        
    else
        set(handles.popupmenu128,'Value',model_par.numout*2-1);
        st129='All' ; 
        for k=1:model_par.numout
            st129=[st129 '|' '0'+k];
        end
        set(handles.popupmenu129,'Value',1);
        set(handles.popupmenu129,'String',st129);
        
%        set_popup_off(handles.popupmenu97,'<Vo2>')
%        set_popup_off(handles.popupmenu102,'<Io2>')
        
    end
else
    corrupt_var=1;
end
    
%%Transient

if ~isempty(trans_an)
    set(handles.checkbox17,'Value',1);
    handles.trans_enabled=1;
    
    %Unlock all TRANS features when TRANS analysis enabled
    set(handles.edit4,'Enable','on');
    set(handles.edit5,'Enable','on');
    set(handles.edit8,'Enable','on');
    set(handles.edit9,'Enable','on');
    set(handles.edit11,'Enable','on');
    set(handles.edit12,'Enable','on');
    set(handles.pushbutton27,'Enable','on');
                       
    %Populate features
    
    set(handles.popupmenu62,'String',vars_as_vect);
    set(handles.popupmenu63,'String',vars_as_vect);
    set(handles.popupmenu68,'String',vars_as_vect);
    
    if (model_par.gen_sources==0)       % sources are not generated
        if isfield(trans_an,'naminmax')            
            corrupt_var = set_popup(handles.popupmenu62,trans_an.naminmax,corrupt_var) ;
        else
            corrupt_var=1;
        end 


        if isfield(trans_an,'naminmin')
            corrupt_var = set_popup(handles.popupmenu63,trans_an.naminmin,corrupt_var) ;
        else
             corrupt_var=1;
        end 


        if isfield(trans_an,'nam_per_tr')
            corrupt_var = set_popup(handles.popupmenu68,trans_an.nam_per_tr,corrupt_var) ;
        else
             corrupt_var=1;
        end
    else
        set_popup_off(handles.popupmenu62,'<TR_max>');
        set_popup_off(handles.popupmenu63,'<TR_min>');
        set_popup_off(handles.popupmenu68,'<TR_per>');
    end
    
    if (model_par.gen_sources==1)
        if isfield(trans_an,'type')            
            corrupt_var = set_popup(handles.popupmenu109,trans_an.type,corrupt_var) ;
        else
            corrupt_var=1;
        end
    end

     
    if isfield(trans_an,'valinmax')    
        set(handles.edit5,'String',num2str(trans_an.valinmax));
    else
        corrupt_var=1;
    end
      
    if isfield(trans_an,'valinmin')    
        set(handles.edit4,'String',num2str(trans_an.valinmin));
    else
        corrupt_var=1;
    end
    
    if isfield(trans_an,'per_tr')    
        set(handles.edit8,'String',num2str(trans_an.per_tr));
    else
        corrupt_var=1;
    end
        
    if isfield(trans_an,'start')    
        set(handles.edit9,'String',num2str(trans_an.start));
    else
        corrupt_var=1;
    end
    
    if isfield(trans_an,'stop')    
        set(handles.edit12,'String',num2str(trans_an.stop));
    else
        corrupt_var=1;
    end
    
    if isfield(trans_an,'step')    
        set(handles.edit11,'String',num2str(trans_an.step));
    else
        corrupt_var=1;
    end
    
else
    set(handles.checkbox17,'Value',0);
    handles.trans_enabled=0;
end
    

%%DC

if ~isempty(dc_an)
    set(handles.checkbox20,'Value',1);
    handles.dc_enabled=1;
    set(handles.popupmenu132,'Enable','on');

    %Populate features
    
    vars_as_vect{1}='<None>';
    for i=1:size(handles.des_var,2)
            vars_as_vect{i+1}=handles.des_var(i).name;
    end
    
    set(handles.popupmenu132,'String',vars_as_vect);

    %Unlock all DC features when DC analysis enabled
    set(handles.edit13,'Enable','on');
        
    set(handles.edit14,'Enable','on');
        
    set(handles.edit15,'Enable','on');
    
    if isfield(model_par,'mode_diff_enabled')
        if model_par.mode_diff_enabled==1
            set(handles.edit37,'Enable','on');
        end
    end
        
    
    %Populate features 
    
    if (model_par.gen_sources==0)       % sources are not generated
        set(handles.popupmenu34,'String',vars_as_vect);
        if isfield(dc_an,'par_name')
            corrupt_var = set_popup(handles.popupmenu34,dc_an.par_name,corrupt_var) ;
        else
             corrupt_var=1;
        end
    else
        set_popup_off(handles.popupmenu34,'<DC_var>');
    end
    
    if isfield(dc_an,'par_start')    
        set(handles.edit13,'String',num2str(dc_an.par_start));
    else
        corrupt_var=1;
    end
    
    if isfield(dc_an,'par_stop')    
        set(handles.edit14,'String',num2str(dc_an.par_stop));
    else
        corrupt_var=1;
    end
    
    if isfield(model_par,'mode_diff_enabled')
        if model_par.mode_diff_enabled==1
            if isfield(dc_an,'par_diff_max')    
                set(handles.edit37,'String',num2str(dc_an.par_diff_max));
            else
                corrupt_var=1;
            end
        end
    end
    
    if isfield(dc_an,'par_gain')    
        set(handles.edit15,'String',num2str(dc_an.par_gain));
    else
        corrupt_var=1;
    end

    if isfield(dc_an,'naminC')
        if ~isempty(dc_an.naminC)
            corrupt_var = set_popup(handles.popupmenu132,dc_an.naminC,corrupt_var) ;
        else    
            set(handles.popupmenu132,'Value',1);
        end
    else
        corrupt_var=1;
    end
    
else
    set(handles.checkbox20,'Value',0);
    handles.dc_enabled=0;
end



%%Param

if ~isempty(par_an)
    set(handles.checkbox21,'Value',1);
    handles.par_enabled=1;
    
    %Unlock all Par features when Par analysis enabled
    set(handles.edit19,'Enable','on'); 
    set(handles.edit20,'Enable','on');
    set(handles.edit21,'Enable','on');
    set(handles.popupmenu77,'Enable','on');
    
    
    %Populate features     
    if (model_par.gen_sources==0)       % sources are not generated
        set(handles.popupmenu77,'String',vars_as_vect);
        if isfield(par_an,'var_name')    
            corrupt_var = set_popup(handles.popupmenu77,par_an.var_name,corrupt_var) ;
        else
             corrupt_var=1;
        end
    else
        set_popup_off(handles.popupmenu77,'<DC_OUT_var>');
    end
            
        
    if isfield(par_an,'start')    
        set(handles.edit19,'String',num2str(par_an.start));
    else
        corrupt_var=1;
    end
    
    if isfield(par_an,'stop')    
        set(handles.edit21,'String',num2str(par_an.stop));
    else
        corrupt_var=1;
    end
    
    if isfield(par_an,'npt')    
        set(handles.edit20,'String',num2str(par_an.npt));
    else
        corrupt_var=1;
    end
else
    set(handles.checkbox21,'Value',0);
    handles.par_enabled=0;
end

%%AC in

if (~isempty(ac_an))&&(isfield(ac_an,'start'))

    set(handles.checkbox25,'Value',1);
    handles.ac_in_enabled=1;
    
    %Unlock all AC in features when AC in analysis enabled
    
    set(handles.edit22,'Enable','on');
    set(handles.edit23,'Enable','on');
    set(handles.edit24,'Enable','on');
    set(handles.edit25,'Enable','on');
    set_check_on(handles.checkbox22);
    set(handles.popupmenu40,'Enable','on');
   
    %Populate features
    
    vars_as_vect{1}='<None>';
    for i=1:size(handles.des_var,2)
            vars_as_vect{i+1}=handles.des_var(i).name;
    end
    
    set(handles.popupmenu40,'String',vars_as_vect);

    if isfield(ac_an,'start')    
        set(handles.edit22,'String',num2str(ac_an.start));
    else
        corrupt_var=1;
    end
    
    if isfield(ac_an,'stop')    
        set(handles.edit24,'String',num2str(ac_an.stop));
    else
        corrupt_var=1;
    end
    
    if isfield(ac_an,'points')    
        set(handles.edit23,'String',num2str(ac_an.points));
    else
        corrupt_var=1;
    end
    
    if isfield(ac_an,'f0')    
        set(handles.edit25,'String',num2str(ac_an.f0));
    else
        corrupt_var=1;
    end

    if isfield(ac_an,'enable_ac_norm')   
        set(handles.checkbox32,'Enable','on');
        if ac_an.enable_ac_norm
          set(handles.checkbox32,'Value',1);
          handles.enable_ac_norm=1;
        else
          set(handles.checkbox32,'Value',0);
          handles.enable_ac_norm=0;
        end
    end
    
end


if (~isempty(ac_in_an))&&(isfield(ac_in_an,'naminC'))
    
    
    if isfield(ac_in_an,'naminC')
        if ~isempty(ac_in_an.naminC)
            corrupt_var = set_popup(handles.popupmenu40,ac_in_an.naminC,corrupt_var) ;
        else    
            set(handles.popupmenu40,'Value',1);
        end
    else
        corrupt_var=1;
    end
    
    
    if isfield(ac_in_an,'ord_Zin')    
          set(handles.checkbox22,'Enable','on');
          set(handles.checkbox22,'Value',1);
          set(handles.popupmenu85,'Value',ac_in_an.ord_Zin+1);
          set(handles.popupmenu85,'Enable','on');
          set(handles.popupmenu107,'Value',ac_in_an.ord_trf+1);
          set(handles.popupmenu107,'Enable','on');
          handles.extract_ac_in_pz=1;
    end
    
    
else
    set(handles.checkbox25,'Value',0);
    handles.ac_in_enabled=0;
end


%%AC out

if (~isempty(ac_out_an))&&(isfield(ac_out_an,'namoutC'))
    
    set(handles.checkbox29,'Value',1);
    handles.ac_out_enabled=1;
    
    %Unlock all AC in features when AC in analysis enabled
    
    set(handles.checkbox28,'Enable','on');
    %set(handles.checkbox28,'Value',0);
       
    
    set(handles.popupmenu93,'Enable','on');
      
    set(handles.popupmenu93,'String',vars_as_vect);
    
    if isfield(ac_out_an,'namoutC')
        if ~isempty(ac_out_an.namoutC)
            corrupt_var = set_popup(handles.popupmenu93,ac_out_an.namoutC,corrupt_var) ;
        else    
            set(handles.popupmenu93,'Value',1);
        end
    else
        corrupt_var=1;
    end
        
    if isfield(ac_out_an,'ord_Zout')    
          handles.extract_ac_out_pz=1;
          set(handles.checkbox28,'Enable','on');
          set(handles.checkbox28,'Value',1);
          set(handles.popupmenu94,'Value',ac_out_an.ord_Zout+1);
          set(handles.popupmenu94,'Enable','on');
          set(handles.popupmenu108,'Value',ac_out_an.ord_invf+1);
          set(handles.popupmenu108,'Enable','on');
    end
        
else
    set(handles.checkbox29,'Value',0);
    handles.ac_out_enabled=0;
end

%%vhdl

if isfield(model_par,'vhdl_filename')
    set(handles.edit42,'String',model_par.vhdl_filename);
end

%Verify corruption of variant file
if corrupt_var
    errordlg('Variant file corrupted! Only some parameters loaded.','Variant corrupted');
end