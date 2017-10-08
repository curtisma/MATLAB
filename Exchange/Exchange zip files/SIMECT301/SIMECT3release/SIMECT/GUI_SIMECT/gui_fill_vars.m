if isempty(des_var)
    set(handles.pushbutton25,'enable','Off');
else
    set(handles.pushbutton25,'Enable','on');    
end

set(handles.edit36,'String',tech);

%Insert Success Logo        
% Read in image
imageArray = imread('suc_setup.bmp');
% Switch active axes to the one you made for the image.
axes(handles.axes1);
% Put the image array into the axes so it will appear on the GUI
imshow(imageArray);

vars_as_vect=[] ;
for i=1:size(handles.des_var,2)
        vars_as_vect{i}=handles.des_var(i).name;
end


%Unlock general features
if isempty(des_var)
    set(handles.pushbutton25,'enable','Off');
else
    set(handles.pushbutton25,'Enable','on');    
end


set_popup_on(handles.popupmenu58,net_meas)
set_popup_on(handles.popupmenu101,crt_meas)
set_popup_on(handles.popupmenu61,vars_as_vect);

set_popup_on(handles.popupmenu59,net_meas)
set_popup_on(handles.popupmenu103,crt_meas)
set_popup_on(handles.popupmenu105,vars_as_vect);



set_popup_on(handles.popupmenu60,crt_meas)
set_popup_on(handles.popupmenu110,['<none>' net_meas])
set_popup_off(handles.popupmenu112,'<GND>')       

set(handles.radiobutton57,'Enable','on');
set(handles.radiobutton58,'Enable','on');
set(handles.radiobutton59,'Enable','on');
set(handles.radiobutton60,'Enable','on');

set(handles.radiobutton57,'Value',0);
set(handles.radiobutton58,'Value',0);
set(handles.radiobutton59,'Value',0);
set(handles.radiobutton60,'Value',0);

set_check_on(handles.checkbox14);
set(handles.popupmenu128,'Enable','on');
set(handles.popupmenu128,'Value',1);

set_check_on(handles.checkbox40);


%Unlock generation of sources
set_check_on(handles.checkbox34);
handles.gen_sources=0;


set(handles.popupmenu109,'Enable','off');
set(handles.popupmenu109,'String','Constant');
set(handles.popupmenu109,'Value',1);

set_check_off(handles.checkbox35);
handles.gen_supply=0;


%Unlock DC features
set_check_on(handles.checkbox20);


%Unlock Param features
set_check_on(handles.checkbox21);


%Unlock AC in features
set_check_on(handles.checkbox25);


%Unlock AC out features
set_check_on(handles.checkbox29);

set_popup_off(handles.popupmenu93,'<None>');        

set_check_off(handles.checkbox28);

set_popup_off(handles.popupmenu94,[]);        
set_popup_off(handles.popupmenu108,[]);        

%Unlock Transient
set_check_on(handles.checkbox17);

set(handles.pushbutton27,'Enable','off');


%Unlock simulation buttons
set(handles.pushbutton14,'Enable','on');
set(handles.pushbutton16,'Enable','on');
set(handles.pushbutton34,'Enable','on');

%Unlock save and load buttons
set(handles.pushbutton3,'Enable','on');
set(handles.pushbutton4,'Enable','on');


%Clear model image
axes(handles.axes3);
cla reset;
set(handles.axes3,'Visible','off');

%Unlock subckts
set_check_on(handles.checkbox36);
