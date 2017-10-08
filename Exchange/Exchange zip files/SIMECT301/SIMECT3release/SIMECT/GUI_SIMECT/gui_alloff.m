%---------------------------------------------------
% Ce programme est la propriete exclusive de SUPELEC
% Tout  usage  non  authorise  ou reproduction de ce
% programme est strictement defendu. 
% Copyright  (c) 2010  SUPELEC  Departement SSE
% Tous droits reserves
%---------------------------------------------------
%
% fichier : gui_alloff.m
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

%Lock subckts
set_check_off(handles.checkbox36);
set_check_off(handles.radiobutton81);
set_check_off(handles.radiobutton82);
set_popup_off(handles.popupmenu111,'<Subckt>')

handles.sim_subckt=0;
handles.level1_only=1;

%Lock save and load buttons
set(handles.pushbutton3,'Enable','off');
set(handles.pushbutton4,'Enable','off'); 

%Lock general features

set_check_off(handles.checkbox14);

set_check_off(handles.radiobutton57);
set_check_off(handles.radiobutton58);
set_check_off(handles.radiobutton59);
set_check_off(handles.radiobutton60);

set(handles.popupmenu128,'Enable','off');
set(handles.popupmenu128,'Value',1);

set(handles.pushbutton25,'Enable','off');

set_popup_off(handles.popupmenu58,'<Vi1>')
set_popup_off(handles.popupmenu96,'<Vi2>')
set_popup_off(handles.popupmenu101,'<Ii1>')
set_popup_off(handles.popupmenu100,'<Ii2>')
set_popup_off(handles.popupmenu61,'<DiffI1>')
set_popup_off(handles.popupmenu104,'<DiffI2>')

handpopmenu
for k=1:length(hv)/2
    for l=1:2
       set_popup_off(hv(k*2+l-2),['<Vo' num2str(l) 'A'+k-1 '>']) ;
       set_popup_off(hi(k*2+l-2),['<Io' num2str(l) 'A'+k-1 '>']) ;
       set_popup_off(hd(k*2+l-2),['<Diffo' num2str(l) 'A'+k-1 '>']) ;
    end

end

%Lock generation of sources
set_check_off(handles.checkbox34);
handles.gen_sources=0;

set_edit_off(handles.edit39);
set_edit_off(handles.edit40);

set_popup_off(handles.popupmenu109,'<Constant>')
set_check_off(handles.checkbox35);
handles.gen_supply=0;

set_edit_off(handles.edit41);
set_popup_off(handles.popupmenu112,'<GND>')
set_popup_off(handles.popupmenu110,'<V_s>')
set_popup_off(handles.popupmenu60,'<I_s>')

%Lock Transient
set_check_off(handles.checkbox17);

set_edit_off(handles.edit4);
set_edit_off(handles.edit5);
set_edit_off(handles.edit8);
set_edit_off(handles.edit9);
set_edit_off(handles.edit11);
set_edit_off(handles.edit12);

set(handles.pushbutton27,'Enable','off');

set_popup_off(handles.popupmenu68,'<TR_per>')
set_popup_off(handles.popupmenu63,'<TR_min>')
set_popup_off(handles.popupmenu62,'<TR_max>')


%Lock DC features
set_popup_off(handles.popupmenu132,'<None>');
set_check_off(handles.checkbox20);
set_popup_off(handles.popupmenu34,'<DC_var>')

set_edit_off(handles.edit13);
set_edit_off(handles.edit14);
set_edit_off(handles.edit15);
set_edit_off(handles.edit37);

%Lock Param features
set_check_off(handles.checkbox21);

set_edit_off(handles.edit19);
set_edit_off(handles.edit20);
set_edit_off(handles.edit21);

set_popup_off(handles.popupmenu77,'<DC_OUT_var>');

%Lock AC features
set_check_off(handles.checkbox25);
set_edit_off(handles.edit22);
set_edit_off(handles.edit23);
set_edit_off(handles.edit24);
set_edit_off(handles.edit25);

%Lock AC input features

set_popup_off(handles.popupmenu40,'<None>');
set_check_off(handles.checkbox22);
set(handles.popupmenu85,'Enable','off');
set(handles.popupmenu85,'Value',1);
set(handles.popupmenu107,'Enable','off');
set(handles.popupmenu107,'Value',1);
set_check_off(handles.checkbox32);

%Lock AC out features
set_check_off(handles.checkbox29);
set_popup_off(handles.popupmenu93,'<None>');
set_check_off(handles.checkbox28);
set(handles.popupmenu94,'Enable','off');
set(handles.popupmenu94,'Value',1);
set(handles.popupmenu108,'Enable','off');
set(handles.popupmenu108,'Value',1);


%Lock simulation buttons
set(handles.pushbutton14,'Enable','off');
set(handles.pushbutton16,'Enable','off');
set(handles.pushbutton15,'Enable','off');
set(handles.pushbutton17,'Enable','off');
set(handles.pushbutton35,'Enable','off');
set(handles.popupmenu129,'Enable','off');
set(handles.pushbutton34,'Enable','off');

%Lock results disp buttons
set_check_off(handles.checkbox42);
set_check_off(handles.checkbox44);

%Lock model extraction button
set(handles.pushbutton31,'Enable','off');
set(handles.pushbutton33,'Enable','off');

set(handles.popupmenu130,'Enable','off');
set(handles.popupmenu131,'Enable','off');
set_check_off(handles.checkbox40);


%Clear model image
axes(handles.axes3);
cla reset;
set(handles.axes3,'Visible','off');


% lock vhdl model path
set_edit_off(handles.edit42);

        