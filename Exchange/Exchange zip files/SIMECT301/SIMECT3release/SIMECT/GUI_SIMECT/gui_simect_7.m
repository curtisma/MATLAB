%---------------------------------------------------
% Ce programme est la propriete exclusive de SUPELEC
% Tout  usage  non  authorise  ou reproduction de ce
% programme est strictement defendu. 
% Copyright  (c) 2010  SUPELEC  Departement SSE
% Tous droits reserves
%---------------------------------------------------
%
% fichier : gui_simect_7.m
% auteur  : P.BENABES & C.TUGUI 
% Copyright (c) 2010 SUPELEC
% Revision: 2.0  Date: 29/10/2010
% Revision: 2.1  Date: 25/11/2010
%
%---------------------------------------------------
%
% DESCRIPTION DU MODULE :
% Interface graphique  
%
% MODULES UTILISES :
%       * extract_cells
%       * extract_des_var
%       * extract_netlist
%       * extract_tech
%       * gui_alloff
%       * sys_funct_disp_mimo
%       * simect_run
%       * disp_DC
%       * disp_AC
%
%---------------------------------------------------

function varargout = gui_simect_7(varargin)
% GUI_SIMECT_7 M-file for gui_simect_7.fig
%      GUI_SIMECT_7, by itself, creates a new GUI_SIMECT_7 or raises the existing
%      singleton*.
%
%      H = GUI_SIMECT_7 returns the handle to a new GUI_SIMECT_7 or the handle to
%      the existing singleton*.
%
%      GUI_SIMECT_7('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SIMECT_7.M with the given input arguments.
%
%      GUI_SIMECT_7('Property','Value',...) creates a new GUI_SIMECT_7 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_simect_7_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_simect_7_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_simect_7

% Last Modified by GUIDE v2.5 10-May-2011 15:48:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_simect_7_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_simect_7_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT



% --- Executes just before gui_simect_7 is made visible.
function gui_simect_7_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_simect_7 (see VARARGIN)

% Choose default command line output for gui_simect_7
handles.output = hObject;

%Global parameters used

handles.des_var=[];
handles.net_meas=[];
handles.crt_meas=[];
handles.in_kind=[];
handles.out_kind=[];
handles.dc_enabled=0;
handles.trans_enabled=0;
handles.par_enabled=0;
handles.ac_in_enabled=0;
handles.ac_out_enabled=0;
handles.enable_ac_norm=0;
handles.extract_ac_in_pz=0;
handles.extract_ac_out_pz=0;
handles.mode_diff_enabled=0;
handles.mode_diff_enabled_out=0;
handles.disp_res_diffcomm=1;
handles.gen_sources=0;
handles.gen_supply=0;
handles.sim_subckt=0;
handles.level1_only=1;
handles.circuit_meas=[];

%Analyses
handles.model_par=[];
handles.trans_an=[];
handles.dc_an=[];
handles.par_an=[];
handles.ac_in_an=[];
handles.ac_out_an=[];

%Results
%handles.res=[];
handles.multi_in_out=[];

%Insert Supelec Logo

% Read in image
imageArray = imread('supelec.bmp');
% Switch active axes to the one you made for the image.
axes(handles.axes2);
% Put the image array into the axes so it will appear on the GUI
imshow(imageArray);

%Insert Simulation Logo

% Read in image
imageArray = imread('sim_setup.bmp');
% Switch active axes to the one you made for the image.
axes(handles.axes1);
% Put the image array into the axes so it will appear on the GUI
imshow(imageArray);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_simect_7 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = gui_simect_7_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%Force exit
set(handles.text126,'Visible','off');
set(handles.text127,'Visible','off');

%%Re-init
%Global parameters used

handles.des_var=[];
handles.net_meas=[];
handles.crt_meas=[];
handles.in_kind=[];
handles.out_kind=[];
handles.dc_enabled=0;
handles.trans_enabled=0;
handles.par_enabled=0;
handles.ac_in_enabled=0;
handles.ac_out_enabled=0;
handles.enable_ac_norm=0;
handles.extract_ac_in_pz=0;
handles.extract_ac_out_pz=0;
handles.mode_diff_enabled=0;
handles.mode_diff_enabled_out=0;
handles.disp_res_diffcomm=1;

%Analyses
handles.model_par=[];
handles.trans_an=[];
handles.dc_an=[];
handles.par_an=[];
handles.ac_in_an=[];
handles.ac_out_an=[];

%Results
%handles.res=[];
handles.multi_in_out=[];


%%Actual action
if exist('try_repository') %%Try to open the most recent repository
    if isdir(try_repository)
    try_repository = uigetdir(try_repository,'Select Cadence Simulation Repository: .../Sim/');
    end
else
    if (exist('.cdnrep','file'))
        fid=fopen('.cdnrep','r');
        cdn_repository=fgets(fid);
        fclose(fid);
    else
        [a,b]=strtok(fliplr(userpath),'/');
        cdn_repository=[fliplr(b) 'CADENCE'];
    end
    if isdir(cdn_repository)
        try_repository = uigetdir(cdn_repository,'Select Cadence Simulation Repository: .../Sim/');
    else
        try_repository = uigetdir('','Select Cadence Simulation Repository: .../Sim/');
    end
end
    
if ~ischar(try_repository)
    try_repository=num2str(try_repository);
end
gui_alloff ;
if isdir(try_repository)
    
    fid=fopen('.cdnrep','w');
    fwrite(fid,try_repository);
    fclose(fid);
    
    simrep=try_repository;
    handles.model_par.simrep=simrep;
    guidata(hObject, handles);
    set(handles.edit1,'String',simrep);
    set(handles.popupmenu2,'Enable','on');
    set(handles.popupmenu2,'Value',1);
    set(handles.edit36,'String','<Technology>');
    cells_as_vector=extract_cells(simrep);
    
    if ~isempty(cells_as_vector)
        set(handles.popupmenu2,'String',cells_as_vector);
    else
        set(handles.popupmenu2,'Enable','off');
        set(handles.popupmenu2,'String','<Empty>');
        set(handles.edit36,'String','<Technology>');
        
        %Insert Simulation Logo
        % Read in image
        imageArray = imread('sim_setup.bmp');
        % Switch active axes to the one you made for the image.
        axes(handles.axes1);
        % Put the image array into the axes so it will appear on the GUI
        imshow(imageArray);
        
        %Lock general features
        
    end
else
    simrep=[];
    set(handles.popupmenu2,'Enable','off');
    set(handles.popupmenu2,'String','<Cell>');
    set(handles.popupmenu2,'Value',1);
    set(handles.edit36,'String','<Technology>');
    %Insert Simulation Logo

        % Read in image
        imageArray = imread('sim_setup.bmp');
        % Switch active axes to the one you made for the image.
        axes(handles.axes1);
        % Put the image array into the axes so it will appear on the GUI
        imshow(imageArray);
                        
    set(handles.edit1,'String','<Select Cadence Simulation Repository: .../Sim/>');
    errordlg('Not a valid directory selected!','Simulation Directory');
end
% Update handles structure
guidata(hObject, handles);


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2

%%Re-init
%Global parameters used

handles.des_var=[];
handles.net_meas=[];
handles.crt_meas=[];
handles.in_kind=[];
handles.out_kind=[];
handles.numout=1;
handles.dc_enabled=0;
handles.trans_enabled=0;
handles.par_enabled=0;
handles.ac_in_enabled=0;
handles.ac_out_enabled=0;
handles.enable_ac_norm=0;
handles.extract_ac_in_pz=0;
handles.extract_ac_out_pz=0;
handles.mode_diff_enabled=0;
handles.mode_diff_enabled_out=0;
handles.disp_res_diffcomm=1;

%Analyses
handles.trans_an=[];
handles.dc_an=[];
handles.par_an=[];
handles.ac_in_an=[];
handles.ac_out_an=[];

%Results
%handles.res=[];
handles.multi_in_out=[];


%%Actual action
contents = get(hObject,'String');
handles.model_par.celldir=contents{get(hObject,'Value')};
pos=findstr(handles.model_par.celldir,':');
if (length(pos)>=2)
    handles.model_par.cell=handles.model_par.celldir(pos(1)+1:pos(2)-1) ;
else
    handles.model_par.cell=handles.model_par.celldir;
end

dirs=dir([handles.model_par.simrep '/' handles.model_par.celldir]);
simu=[] ;
k=1 ; pos=0 ; netpr=0 ;
for i=1:size(dirs,1)
    if (dirs(i).isdir==1) && (~strcmp(dirs(i).name,'.') && (~strcmp(dirs(i).name,'..')) )
        simu{k}=dirs(i).name;
        if strcmp(dirs(i).name,'spectre')
            pos=k ;
        end
        if strcmp(dirs(i).name,'netlist')
            netpr=1 ;
        end
        k=k+1;
    end
end

if (netpr==0)                                   %% no netlist directory
    set_popup_on(handles.popupmenu114,simu);
    if pos
        set(handles.popupmenu114,'Value',pos) ;
    end
    handles.model_par.netltype=char(simu(get(handles.popupmenu114,'Value')));

    dirs=dir([handles.model_par.simrep '/' handles.model_par.celldir '/' handles.model_par.netltype]);
    viewtype=[] ;
    k=1 ; pos=0 ;
    for i=1:size(dirs,1)
        if (dirs(i).isdir==1) && (~strcmp(dirs(i).name,'.') && (~strcmp(dirs(i).name,'..')) )
            viewtype{k}=dirs(i).name;
            if strcmp(dirs(i).name,'schematic')
                pos=k ;
            end
            k=k+1;
        end
    end
    set_popup_on(handles.popupmenu115,viewtype);
    if pos
        set(handles.popupmenu115,'Value',pos) ;
    end
    handles.model_par.viewtype=char(viewtype(get(handles.popupmenu115,'Value')));


else                                        %% directly the netlist
    handles.model_par.netltype=[] ;
    handles.model_par.viewtype=[] ;
    set_popup_off(handles.popupmenu114,'----');
    set_popup_off(handles.popupmenu115,'----');   
end

update_model ;
gui_alloff ;

if ~(isempty(tech)) %||isempty(net_meas)||isempty(crt_meas))
    if tech~=(-1)       
        gui_fill_vars ;      
    else
        set(handles.edit36,'String','TECHNOLOGY FILE ERROR!!!');
    end
else
    set(handles.edit36,'String','UNABLE TO OPEN NETLIST!!!');

end

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
in_var=get(handles.edit3,'String');
if strcmp(in_var,'...')||~isstr(in_var)
    errordlg('Please set variant before saving!','SIMECT Save problem');
else
    if ~isdir([handles.model_par.simrep '/variables/'])
      mkdir([handles.model_par.simrep '/variables/']) ;
    end
    
    out_var=get(handles.edit3,'String');
    if (handles.sim_subckt==1)
      save_str=[handles.model_par.simrep '/variables/' 'var_' handles.model_par.cell '_' handles.model_par.subcell out_var '.m'];
    else
      save_str=[handles.model_par.simrep '/variables/' 'var_' handles.model_par.cell out_var '.m'];
    end
    [file,path] = uiputfile(save_str,'Save simulation variant');
    if (file(1)~=0)&&(path(1)~=0)
        %handles.model_par=[];%%%%%%%%%%%Will not recognize netlist
        %repository otherwise
        handles.trans_an=[];
        handles.dc_an=[];
        handles.par_an=[];
        handles.ac_in_an=[];
        handles.ac_out_an=[];

        %Read user input script
        read_user_input;

        %Write file
        verif_par;
        write_variant_to_file;

        %Update handles structure
        guidata(hObject, handles);
        
        if run_status
            msgbox('Successfuly saved variant!','Save','help');
        end
    end
end
      


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

model_par=[];
des_var=[];
ac_an=[];
ac_in_an=[];
ac_out_an=[];
dc_an=[];
par_an=[];
trans_an=[];

out_var=get(handles.edit3,'String');
if isfield(handles.model_par,'cell')
    if (handles.sim_subckt==1)
      file_title=[handles.model_par.simrep '/variables/' 'var_' handles.model_par.cell '_' handles.model_par.subcell out_var '.m'];
    else
      file_title=[handles.model_par.simrep '/variables/' 'var_' handles.model_par.cell out_var '.m'];
    end
else
    file_title=[handles.model_par.simrep '/variables/' 'var_generic' out_var '.m'];
end
[file,path] = uigetfile({'*.m','.m Matlab variant file';'*.*','All Files' },'Load variant file',file_title);
if (file(1)~=0)&&(path(1)~=0)

    %Retain current dir for return
    crt_dir=pwd;
    
    cd(path);
    
    clear(strrep(file,'.m',''));
    eval(strrep(file,'.m',''));
    
    cd(crt_dir);
    
    if isempty(model_par)
        errordlg('Not a valid variant file!','Load variant error');
    else
    
    write_variant_to_gui;

    %Update handles structure
    guidata(hObject, handles);
        
    end
end         



% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%handles.model_par=[];
handles.trans_an=[];
handles.dc_an=[];
handles.par_an=[];
handles.ac_in_an=[];
handles.ac_out_an=[];

%Read user input script
read_user_input;

%Run OCEAN enabled
handles.model_par.rnocn=1;

%Write files and verify status
verif_par;

%Update handles structure
guidata(hObject, handles);

if run_status
    
    set(handles.text126,'Visible','on');
    
    %Block model extraction button
    set(handles.pushbutton31,'Enable','off');
    set(handles.pushbutton33,'Enable','off');
    
    set(handles.popupmenu130,'Enable','off');
    set(handles.popupmenu131,'Enable','off');
    
%    for k=16:60, if ishghandle(k), close(k); end; end
    simect_run ;
    
    if run_good
        handles.verb=verb;
        handles.multi_in_out=multi_in_out;
        handles.model_in_out=model_in_out;

        %Update handles structure
        guidata(hObject, handles);

        %Unlock simulation buttons

        set(handles.pushbutton15,'Enable','on');
        set(handles.pushbutton16,'Enable','on');
        set(handles.pushbutton17,'Enable','on');
        set(handles.popupmenu129,'Enable','on');
        set(handles.pushbutton35,'Enable','on');

        %Unlock results disp buttons
        set(handles.checkbox42,'Enable','on');
        set(handles.checkbox42,'Value',0);
        set(handles.checkbox44,'Enable','on');
        set(handles.checkbox44,'Value',1);

        %Unlock model extraction button only when s-models enabled

        if handles.extract_ac_in_pz&&handles.extract_ac_out_pz
        set(handles.pushbutton31,'Enable','on');
        set(handles.pushbutton33,'Enable','on');
        set(handles.edit42,'Enable','on');
        
        set(handles.popupmenu130,'Enable','on');
        set(handles.popupmenu131,'Enable','on');
        end

        set(handles.text126,'Visible','off');
        
        % Read in image
        if handles.model_par.mode_diff_enabled
            if handles.model_par.mode_diff_enabled_out
                imageArray = imread('MIMO_scaled.jpg');
            else
                imageArray = imread('MISO_scaled.jpg');
            end
        else
            if handles.model_par.mode_diff_enabled_out
                imageArray = imread('SIMO_scaled.jpg');
            else
                imageArray = imread('SISO_scaled.jpg');
            end
        end
        % Switch active axes to the one you made for the image.
        axes(handles.axes3);
        % Put the image array into the axes so it will appear on the GUI
        imshow(imageArray);
        
        outdisp=get(handles.popupmenu129,'Value')-1 ;
        if ishghandle(21)
            disp_all_DC(handles.model_par,handles.multi_in_out,handles.disp_res_diffcomm,outdisp);
        end
        if get(handles.checkbox41,'Value')
            disprlc=1 ;
        else
            disprlc=0 ;
        end

        if ishghandle(41)
            disp_all_AC(handles.model_par,handles.multi_in_out,handles.model_in_out,handles.ac_an,handles.ac_in_an,handles.ac_out_an,outdisp,disprlc);  
        end
        if ishghandle(16)
          if handles.dc_an.enabled
            for k=0:handles.model_par.mode_diff_enabled %if out diff
                disp_int_DC(handles.model_par,handles.multi_in_out(3).simple_dc{k+1},k);
            end
          end
        end

        
    end
        
else
    set(handles.pushbutton15,'Enable','off');
    set(handles.pushbutton16,'Enable','off');
    set(handles.pushbutton17,'Enable','off');
    set(handles.pushbutton31,'Enable','off');
    set(handles.pushbutton33,'Enable','off');
    set(handles.pushbutton35,'Enable','off');
    set(handles.popupmenu129,'Enable','off');
    
    set(handles.popupmenu130,'Enable','off');
    set(handles.popupmenu131,'Enable','off');

    %Lock results disp buttons
    set(handles.checkbox42,'Enable','off');
    set(handles.checkbox44,'Enable','off');
    set(handles.checkbox42,'Value',0);
    set(handles.checkbox44,'Value',0);
    
    %Clear model image
    axes(handles.axes3);
    cla reset;
    set(handles.axes3,'Visible','off');
end

% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

op=0;
for k=21:40,  if ishandle(k), op=1; end, end
outdisp=get(handles.popupmenu129,'Value')-1 ;
if (op),  for k=21:40, if ishghandle(k), close(k); end,  end
else
    disp_all_DC(handles.model_par,handles.multi_in_out,handles.disp_res_diffcomm,outdisp);
end
       

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%handles.model_par=[];
handles.trans_an=[];
handles.dc_an=[];
handles.par_an=[];
handles.ac_in_an=[];
handles.ac_out_an=[];

%Read user input script
read_user_input;

%Run OCEAN
handles.model_par.rnocn=0;

%Write files and verify status
verif_par;

%Verify if we can do extract only
%ind=1; %all an supposed to exist
ind=verif_extract_only(handles.model_par,handles);

%Update handles structure
guidata(hObject, handles);

if run_status&&ind
    
    set(handles.text126,'Visible','on');
    set(handles.text126,'String','                STARTING');
    
    %Block model extraction button
    set(handles.pushbutton31,'Enable','off');
    set(handles.pushbutton33,'Enable','off');
    
    %set_check_off(handles.checkbox14);
    
    pause(0.01);

    for k=16:60, if ishghandle(k), close(k); end; end
    simect_run;
    
    handles.verb=verb;
    handles.multi_in_out=multi_in_out;
    handles.model_in_out=model_in_out;
    
    %Update handles structure
    guidata(hObject, handles);
    
    %Unlock simulation buttons

    set(handles.pushbutton15,'Enable','on');
    set(handles.pushbutton17,'Enable','on');
    set(handles.pushbutton35,'Enable','on');
    set(handles.popupmenu129,'Enable','on');
    
    %Unlock results disp buttons
   
    set(handles.checkbox42,'Enable','on');
    set(handles.checkbox42,'Value',0);
    set(handles.checkbox44,'Enable','on');
    set(handles.checkbox44,'Value',1);
    
    
    %Unlock model extraction button only when s-models enabled
    
    if handles.extract_ac_in_pz&&handles.extract_ac_out_pz
        set(handles.pushbutton31,'Enable','on');
        set(handles.pushbutton33,'Enable','on');
        set(handles.edit42,'Enable','on');

        set(handles.popupmenu130,'Enable','on');
        set(handles.popupmenu131,'Enable','on');
    end
    
    set(handles.text126,'Visible','off');
    
    % Read in image
    if handles.model_par.mode_diff_enabled
        if handles.model_par.mode_diff_enabled_out
            imageArray = imread('MIMO_scaled.jpg');
        else
            imageArray = imread('MISO_scaled.jpg');
        end
    else
        if handles.model_par.mode_diff_enabled_out
            imageArray = imread('SIMO_scaled.jpg');
        else
            imageArray = imread('SISO_scaled.jpg');
        end
    end
    % Switch active axes to the one you made for the image.
    axes(handles.axes3);
    % Put the image array into the axes so it will appear on the GUI
    imshow(imageArray);
    
    
else
    set(handles.pushbutton15,'Enable','off');
    set(handles.pushbutton17,'Enable','off');
    set(handles.pushbutton31,'Enable','off');
    set(handles.pushbutton33,'Enable','off');
    set(handles.pushbutton35,'Enable','off');
    set(handles.popupmenu129,'Enable','off');
    
    set(handles.popupmenu130,'Enable','off');
    set(handles.popupmenu131,'Enable','off');
    
    %Lock results disp buttons
    set(handles.checkbox42,'Enable','off');
    set(handles.checkbox44,'Enable','off');
    set(handles.checkbox42,'Value',0);
    set(handles.checkbox44,'Value',0);
    
    %Clear model image
    axes(handles.axes3);
    cla reset;
    set(handles.axes3,'Visible','off');
end

% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
outdisp=get(handles.popupmenu129,'Value')-1 ;
if (handles.numout)==1
    outdisp=1 ;
end

if get(handles.checkbox41,'Value')
    disprlc=1 ;
else
    disprlc=0 ;
end

if handles.disp_res_diffcomm
    
    op=0;
    for k=41:60,  if ishandle(k), op=1; end, end
    if (op)
        for k=41:60, if ishghandle(k), close(k); end,  end   
    else
        disp_all_AC(handles.model_par,handles.multi_in_out,handles.model_in_out,handles.ac_an,handles.ac_in_an,handles.ac_out_an,outdisp,disprlc);  
    end
    
else
    
    if handles.ac_in_an.enabled && handles.ac_out_an.enabled && handles.extract_ac_in_pz && handles.extract_ac_out_pz
    
        global MODEL_IN_OUT;
        if (outdisp)
            MODEL_IN_OUT = handles.model_in_out{outdisp};
            sys_funct_disp_mimo;
        else
            errordlg('Select one output please','Warning');
            
        end
    
    else
        
        errordlg('AC in / out disabled or extract p/z disabled...','Error');
        
    end
    
end


% --- Executes on selection change in popupmenu40.
function popupmenu40_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu40 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu40


% --- Executes during object creation, after setting all properties.
function popupmenu40_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu34.
function popupmenu34_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu34 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu34


% --- Executes during object creation, after setting all properties.
function popupmenu34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu62.
function popupmenu62_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu62 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu62 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu62


% --- Executes during object creation, after setting all properties.
function popupmenu62_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu62 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu63.
function popupmenu63_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu63 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu63 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu63


% --- Executes during object creation, after setting all properties.
function popupmenu63_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu63 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%MODIFIED%%%%%%%%%%%%%%%
% --- Executes on button press in radiobutton57.
function radiobutton57_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton57 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton57

if get(hObject,'Value')==1
    handles.in_kind='V';
else
    handles.in_kind=[];
end

% Update handles structure
guidata(hObject, handles);

if get(handles.radiobutton58,'Value')==1
    set(handles.radiobutton58,'Value',0)
end

% --- Executes on selection change in popupmenu58.
function popupmenu58_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu58 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu58 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu58

% --- Executes during object creation, after setting all properties.
function popupmenu58_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu58 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%MODIFIED%%%%%%%%%%%%%%%
% --- Executes on button press in radiobutton58.
function radiobutton58_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton58 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton58

if get(hObject,'Value')==1
    handles.in_kind='I';
else
    handles.in_kind=[];
end

% Update handles structure
guidata(hObject, handles);

if get(handles.radiobutton57,'Value')==1
    set(handles.radiobutton57,'Value',0)
end

%%%%%%%%%%%%%%%MODIFIED%%%%%%%%%%%%%%%
% --- Executes on button press in radiobutton59.
function radiobutton59_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton59 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton59

if get(hObject,'Value')==1
    handles.out_kind='V';
else
    handles.out_kind=[];
end

% Update handles structure
guidata(hObject, handles);

if get(handles.radiobutton60,'Value')==1
    set(handles.radiobutton60,'Value',0)
end


% --- Executes on selection change in popupmenu59.
function popupmenu59_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu59 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu59 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from
%        popupmenu59

% --- Executes during object creation, after setting all properties.
function popupmenu59_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu59 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%MODIFIED%%%%%%%%%%%%%%%
% --- Executes on button press in radiobutton60.
function radiobutton60_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton60
if get(hObject,'Value')==1
    handles.out_kind='I';
else
    handles.out_kind=[];
end

% Update handles structure
guidata(hObject, handles);

if get(handles.radiobutton59,'Value')==1
    set(handles.radiobutton59,'Value',0)
end

% --- Executes on selection change in popupmenu60.
function popupmenu60_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu60 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from
%        popupmenu60

% --- Executes during object creation, after setting all properties.
function popupmenu60_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%%%%%%%%%%%%%%MODIFIED%%%%%%%%%%%%%%%
% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S

opn=1 ;
if (isfield(S,'fig'))
    if ishandle(S.fig)
        opn=0 ;
    end
end

if (opn)
    S.des_var=handles.des_var;
    S.model_par = handles.model_par ;
    S.edit3=handles.edit3 ;
    S.sim_subckt=handles.sim_subckt ;
    gui_set_des_var(handles.des_var);
    handles.des_var=S.des_var;
end


% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in checkbox14.
function checkbox14_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox14
if get(hObject,'Value')==1
    %Mode diff enabled on input
    handles.mode_diff_enabled=1;
    net_meas=handles.net_meas;
    crt_meas=handles.crt_meas;
    vars_as_vect=[] ;
    for i=1:size(handles.des_var,2)
        vars_as_vect{i}=handles.des_var(i).name;
    end
   
    %Populate 2nd input
    set(handles.popupmenu96,'Enable','on');
    set(handles.popupmenu96,'String',net_meas);

    %set_popup_on(handles.popupmenu96,net_meas);
    
    if (handles.gen_sources==0)
        
        set(handles.popupmenu104,'Enable','on');
        set(handles.popupmenu104,'String',vars_as_vect);
        set(handles.popupmenu100,'Enable','on');
        set(handles.popupmenu100,'String',crt_meas);
        %set_popup_on(handles.popupmenu104,vars_as_vect);
        %set_popup_on(handles.popupmenu100,crt_meas);
    end
    
    if handles.dc_enabled
        set(handles.edit37,'Enable','on');
    end

else
    %Mode diff disabled on input
    handles.mode_diff_enabled=0;
        
    %Disable 2nd input
    set(handles.popupmenu104,'Enable','off');
    set(handles.popupmenu96,'Enable','off');
    set(handles.popupmenu100,'Enable','off');
    set(handles.edit37,'Enable','off');

    %set_popup_off(handles.popupmenu104,'<Diff>');
    %set_popup_off(handles.popupmenu96,'<Vi2>');
    %set_popup_off(handles.popupmenu100,'<Ii2>');
    
end

% Update handles structure
guidata(hObject, handles);



% --- Executes on selection change in popupmenu61.
function popupmenu61_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu61 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu61 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu61


% --- Executes during object creation, after setting all properties.
function popupmenu61_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu61 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox17.
function checkbox17_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox17
if get(hObject,'Value')==1
    handles.trans_enabled=1;  
    vars_as_vect=[] ;
    for i=1:size(handles.des_var,2)
            vars_as_vect{i}=handles.des_var(i).name;
    end
   
    %Unlock all TRANS features when TRANS analysis enabled
    set(handles.edit4,'Enable','on');
    set(handles.edit5,'Enable','on');
    set(handles.edit8,'Enable','on');
    set(handles.edit9,'Enable','on');
    set(handles.edit11,'Enable','on');
    set(handles.edit12,'Enable','on');
    set(handles.pushbutton27,'Enable','on');
    
    if ~handles.gen_sources
        set_popup_on(handles.popupmenu62,vars_as_vect);
        set_popup_on(handles.popupmenu63,vars_as_vect);
        set_popup_on(handles.popupmenu68,vars_as_vect);
    else
        set_popup_off(handles.popupmenu62,'<TR_max>');
        set_popup_off(handles.popupmenu63,'<TR_min>');
        set_popup_off(handles.popupmenu68,'<TR_per>');
    end
    
else
    handles.trans_enabled=0;
    
    set_edit_off(handles.edit4);
    set_edit_off(handles.edit5);
    set_edit_off(handles.edit8);
    set_edit_off(handles.edit9);
    set_edit_off(handles.edit11);
    set_edit_off(handles.edit12);

    set(handles.pushbutton27,'Enable','off');
        
    set_popup_off(handles.popupmenu62,'<TR_max>');
    set_popup_off(handles.popupmenu63,'<TR_min>');
    set_popup_off(handles.popupmenu68,'<TR_per>');
end

% Update handles structure
guidata(hObject, handles);    


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.mode_diff_enabled
    if ~isempty(get(handles.edit37,'String'))
        set(handles.edit4,'String',['-' get(handles.edit37,'String')]);
        set(handles.edit5,'String',get(handles.edit37,'String'));
    else
        set(handles.edit4,'String',handles.des_var(get(handles.popupmenu63,'value')).value)   ;
        set(handles.edit5,'String',handles.des_var(get(handles.popupmenu62,'value')).value)   ;
    end
else
    if ~isempty(get(handles.edit13,'String')) && ~isempty(get(handles.edit14,'String'))
        set(handles.edit4,'String',get(handles.edit13,'String'));
        set(handles.edit5,'String',get(handles.edit14,'String'));    
    else
        set(handles.edit4,'String',handles.des_var(get(handles.popupmenu63,'value')).value)   ;
        set(handles.edit5,'String',handles.des_var(get(handles.popupmenu62,'value')).value)   ;
    end
end

f0=str2num(get(handles.edit25,'String'));
if isempty(f0)
  per_tr=handles.des_var(get(handles.popupmenu68,'value')).value ;
else
  per_tr=1/f0;
end

if ~(per_tr==0)
    set(handles.edit8,'String',num2str(per_tr));
    set(handles.edit9,'String',num2str(0));
    set(handles.edit11,'String',num2str(per_tr/10));
    set(handles.edit12,'String',num2str(10*per_tr));
else
    per_tr=1e3;
    set(handles.edit8,'String',num2str(per_tr));
    set(handles.edit9,'String',num2str(0));
    set(handles.edit11,'String',num2str(per_tr/10));
    set(handles.edit12,'String',num2str(10*per_tr));
    warndlg('Default values generated for transient analysis.Correct them, if needed.','TRANS Period')
end

% --- Executes on selection change in popupmenu68.
function popupmenu68_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu68 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu68 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu68


% --- Executes during object creation, after setting all properties.
function popupmenu68_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu68 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox20.
function checkbox20_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox20
if get(hObject,'Value')==1
    handles.dc_enabled=1;
   
    %Unlock all DC features when DC analysis enabled
    set(handles.edit13,'Enable','on');
        
    set(handles.edit14,'Enable','on');
        
    set(handles.edit15,'Enable','on');
    
    if handles.mode_diff_enabled
        set(handles.edit37,'Enable','on');
    end
        
    vars_as_vect=[] ;
    for i=1:size(handles.des_var,2)
            vars_as_vect{i}=handles.des_var(i).name;
    end 
    if ~handles.gen_sources
        set_popup_on(handles.popupmenu34,vars_as_vect)
    else
        set_popup_off(handles.popupmenu34,'<DC_var>')
    end
    
    vars_as_vect{1}='<None>';
    for i=1:size(handles.des_var,2)
            vars_as_vect{i+1}=handles.des_var(i).name;
    end   
    set_popup_on(handles.popupmenu132,vars_as_vect);

else
    handles.dc_enabled=0;

    set_popup_off(handles.popupmenu132,'<None>');
    set_edit_off(handles.edit13);
    set_edit_off(handles.edit14);
    set_edit_off(handles.edit15);
    set_edit_off(handles.edit37);        
    set_popup_off(handles.popupmenu34,'<DC_var>')
end

% Update handles structure
guidata(hObject, handles);
        


function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_extract_off ;

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_extract_off ;

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu77.
function popupmenu77_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu77 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu77 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu77


% --- Executes during object creation, after setting all properties.
function popupmenu77_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu77 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox21.
function checkbox21_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox21
if get(hObject,'Value')==1
    handles.par_enabled=1;
   
    %Unlock all Par features when Par analysis enabled
    set(handles.edit19,'Enable','on');
        
    set(handles.edit20,'Enable','on');
        
    set(handles.edit21,'Enable','on');
        
    vars_as_vect=[] ;
    for i=1:size(handles.des_var,2)
            vars_as_vect{i}=handles.des_var(i).name;
    end
    
    if ~handles.gen_sources
        set_popup_on(handles.popupmenu77,vars_as_vect)
    else
        set_popup_off(handles.popupmenu77,'<DC_OUT_var>')
    end
    
else
    handles.par_enabled=0;
    
    set_edit_off(handles.edit19);
    set_edit_off(handles.edit20);
    set_edit_off(handles.edit21);        
    set_popup_off(handles.popupmenu77,'<DC_OUT_var>');
   
end

% Update handles structure
guidata(hObject, handles);


function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_extract_off ;

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_extract_off ;

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_extract_off ;

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox22.
function checkbox22_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox22
if get(hObject,'Value')==1
    handles.extract_ac_in_pz=1;
   
    %Unlock model orders features when enabled

    set(handles.popupmenu85,'Enable','on');
    set(handles.popupmenu85,'Value',1);
    set(handles.popupmenu107,'Enable','on');
    set(handles.popupmenu107,'Value',1);
else
    handles.extract_ac_in_pz=0;
    
    %Lock AC in features      
       
    set(handles.popupmenu85,'Enable','off');
    set(handles.popupmenu85,'Value',1);
    set(handles.popupmenu107,'Enable','off');
    set(handles.popupmenu107,'Value',1);
end

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in checkbox25.
function checkbox25_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox25
if get(hObject,'Value')==1
    handles.ac_in_enabled=1;
   
    %Unlock all AC in features when AC in analysis enabled
    
    set(handles.edit22,'Enable','on');  
    set(handles.edit23,'Enable','on');   
    set(handles.edit24,'Enable','on');
    set(handles.edit25,'Enable','on');
    
    set_check_on(handles.checkbox22);
    set_check_on(handles.checkbox32);
               
    vars_as_vect{1}='<None>';
    for i=1:size(handles.des_var,2)
            vars_as_vect{i+1}=handles.des_var(i).name;
    end
    
    set_popup_on(handles.popupmenu40,vars_as_vect);
    set_popup_off(handles.popupmenu85,[]);
    set_popup_off(handles.popupmenu107,[]);

else
    handles.ac_in_enabled=0;
    
    %Lock AC in features
    if (handles.ac_out_enabled==0)   
        set_edit_off(handles.edit22);
        set_edit_off(handles.edit23);
        set_edit_off(handles.edit24);
        set_edit_off(handles.edit25);

        set_check_off(handles.checkbox32);
    end

    set_popup_off(handles.popupmenu40,'<None>');
    set_popup_off(handles.popupmenu85,[]);
    set_popup_off(handles.popupmenu107,[]);
        
    set_check_off(handles.checkbox22);
    
end

% Update handles structure
guidata(hObject, handles);    
    
    
        

    


function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_extract_off ;

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_extract_off ;

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_extract_off ;

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_extract_off ;
% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu85.
function popupmenu85_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu85 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu85 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu85
set(handles.pushbutton15,'Enable','off');
set(handles.pushbutton17,'Enable','off');
set(handles.pushbutton31,'Enable','off');
set(handles.pushbutton17,'Enable','off');
set(handles.pushbutton35,'Enable','off');


% --- Executes during object creation, after setting all properties.
function popupmenu85_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu85 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in popupmenu93.
function popupmenu93_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu93 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu93 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu93


% --- Executes during object creation, after setting all properties.
function popupmenu93_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu93 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox28.
function checkbox28_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox28
if get(hObject,'Value')==1
    handles.extract_ac_out_pz=1;
   
    %Unlock model orders features when enabled

    set(handles.popupmenu94,'Enable','on');
    set(handles.popupmenu94,'Value',1);
    if (get(handles.checkbox40,'value')==1)
        set(handles.popupmenu108,'Enable','on');
        set(handles.popupmenu108,'Value',1);
    end
else
    handles.extract_ac_out_pz=0;
    
    %Lock AC out features      
       
    set(handles.popupmenu94,'Enable','off');
    set(handles.popupmenu94,'Value',1);
    set(handles.popupmenu108,'Enable','off');
    set(handles.popupmenu108,'Value',1);
end

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in checkbox29.
function checkbox29_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox29
if get(hObject,'Value')==1
    handles.ac_out_enabled=1;
   
    %Unlock all AC out features when AC out analysis enabled
    set(handles.edit22,'Enable','on');  
    set(handles.edit23,'Enable','on');   
    set(handles.edit24,'Enable','on');
    set(handles.edit25,'Enable','on');
    
    set_check_on(handles.checkbox32);
    set_check_on(handles.checkbox28);
    
    vars_as_vect{1}='<None>';
    for i=1:size(handles.des_var,2)
            vars_as_vect{i+1}=handles.des_var(i).name;
    end
    
    set_popup_on(handles.popupmenu93,vars_as_vect);
    set_popup_off(handles.popupmenu94,[]);
    set_popup_off(handles.popupmenu108,[]);

else
    handles.ac_out_enabled=0;
    
    %Lock AC out features
    if (handles.ac_in_enabled==0)   
        set_edit_off(handles.edit22);
        set_edit_off(handles.edit23);
        set_edit_off(handles.edit24);
        set_edit_off(handles.edit25);

        set_check_off(handles.checkbox32);
    end
    
    set_popup_off(handles.popupmenu93,'<None>');
    set_popup_off(handles.popupmenu94,[]);
    set_popup_off(handles.popupmenu108,[]);
        
    set_check_off(handles.checkbox28);
        
end

% Update handles structure
guidata(hObject, handles);  



% --- Executes on selection change in popupmenu94.
function popupmenu94_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu94 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu94 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu94
set(handles.pushbutton15,'Enable','off');
set(handles.pushbutton17,'Enable','off');
set(handles.pushbutton31,'Enable','off');
set(handles.pushbutton33,'Enable','off');
set(handles.pushbutton35,'Enable','off');


% --- Executes during object creation, after setting all properties.
function popupmenu94_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu94 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit36_Callback(hObject, eventdata, handles)
% hObject    handle to edit36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit36 as text
%        str2double(get(hObject,'String')) returns contents of edit36 as a double


% --- Executes during object creation, after setting all properties.
function edit36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.ac_in_an.enabled && handles.ac_out_an.enabled && handles.par_an.enabled && handles.ac_in_an.extract_pz

    set(handles.text127,'Visible','on');
    
    pause(0.01);

    convert_res_model(handles,handles.model_in_out);

    set(handles.text127,'Visible','off');
    
else
    
    errordlg('AC in, AC out, PARAM and Extract s-model on AC in and AC out should be enabled for model extraction!','Extract model error');
    
end


% --- Executes on selection change in popupmenu96.
function popupmenu96_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu96 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu96 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu96


% --- Executes during object creation, after setting all properties.
function popupmenu96_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu96 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in popupmenu97.
function popupmenu97_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu97 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu97 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu97


% --- Executes during object creation, after setting all properties.
function popupmenu97_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu97 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox42.
function checkbox42_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox42
if get(handles.checkbox42,'Value')==1
    set(handles.checkbox44,'Value',0);
    handles.disp_res_diffcomm=0;
else
    set(handles.checkbox44,'Value',1);
    handles.disp_res_diffcomm=1;
end
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in checkbox44.
function checkbox44_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox44
if get(handles.checkbox44,'Value')==1
    set(handles.checkbox42,'Value',0)
    handles.disp_res_diffcomm=1;
else
    set(handles.checkbox42,'Value',1);
    handles.disp_res_diffcomm=0;
end
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close ;


function edit37_Callback(hObject, eventdata, handles)
% hObject    handle to edit37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_extract_off ;

% Hints: get(hObject,'String') returns contents of edit37 as text
%        str2double(get(hObject,'String')) returns contents of edit37 as a double


% --- Executes during object creation, after setting all properties.
function edit37_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu100.
function popupmenu100_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu100 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu100 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu100


% --- Executes during object creation, after setting all properties.
function popupmenu100_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu100 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu101.
function popupmenu101_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu101 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu101 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu101


% --- Executes during object creation, after setting all properties.
function popupmenu101_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu101 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu102.
function popupmenu102_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu102 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu102 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu102


% --- Executes during object creation, after setting all properties.
function popupmenu102_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu102 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu103.
function popupmenu103_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu103 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu103 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu103


% --- Executes during object creation, after setting all properties.
function popupmenu103_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu103 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in checkbox32.
function checkbox32_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox32
if get(hObject,'Value')==1
    handles.enable_ac_norm=1;
else
    handles.enable_ac_norm=0;
end
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.ac_in_an.enabled && handles.ac_out_an.enabled && handles.par_an.enabled && handles.ac_in_an.extract_pz

    set(handles.text139,'Visible','on');
    pause(0.01);
    
   model_type= get(handles.popupmenu130,'Value');

    fil=convert_res_vhdl(handles.model_par,handles.dc_an,handles.ac_an,handles.model_in_out,handles.multi_in_out,model_type,get(handles.edit42,'String'),1);
    set(handles.edit42,'String',fil);
    set(handles.text139,'Visible','off');
    
else
    
    errordlg('AC in, AC out, PARAM and Extract s-model on AC in and AC out should be enabled for model extraction!','Extract model error');
    
end


% --- Executes on selection change in popupmenu104.
function popupmenu104_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu104 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu104 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu104


% --- Executes during object creation, after setting all properties.
function popupmenu104_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu104 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu105.
function popupmenu105_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu105 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu105 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu105


% --- Executes during object creation, after setting all properties.
function popupmenu105_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu105 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu106.
function popupmenu106_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu106 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu106 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu106


% --- Executes during object creation, after setting all properties.
function popupmenu106_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu106 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit38_Callback(hObject, eventdata, handles)
% hObject    handle to edit38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit38 as text
%        str2double(get(hObject,'String')) returns contents of edit38 as a double


% --- Executes during object creation, after setting all properties.
function edit38_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu107.
function popupmenu107_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu107 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu107 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu107
set(handles.pushbutton15,'Enable','off');
set(handles.pushbutton17,'Enable','off');
set(handles.pushbutton31,'Enable','off');
set(handles.pushbutton33,'Enable','off');
set(handles.pushbutton35,'Enable','off');


% --- Executes during object creation, after setting all properties.
function popupmenu107_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu107 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu108.
function popupmenu108_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu108 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu108 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu108
set(handles.pushbutton15,'Enable','off');
set(handles.pushbutton17,'Enable','off');
set(handles.pushbutton31,'Enable','off');
set(handles.pushbutton33,'Enable','off');
set(handles.pushbutton35,'Enable','off');


% --- Executes during object creation, after setting all properties.
function popupmenu108_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu108 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox34.
function checkbox34_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox34

%hv=[handles.popupmenu59 handles.popupmenu97 handles.popupmenu119 handles.popupmenu118 handles.popupmenu125 handles.popupmenu124];
%hi=[handles.popupmenu103 handles.popupmenu102 handles.popupmenu121 handles.popupmenu120 handles.popupmenu127 handles.popupmenu126];
%hd=[handles.popupmenu105 handles.popupmenu106 handles.popupmenu117 handles.popupmenu116 handles.popupmenu123 handles.popupmenu122];
handpopmenu ;

if get(hObject,'Value')==1
    %Mode diff enabled on input
    handles.gen_sources=1;
    set(handles.edit39,'Enable','on');
    set(handles.edit39,'String','');
    
    set(handles.edit40,'Enable','on');
    set(handles.edit40,'String','');
           
    set_check_on(handles.checkbox35);
    handles.gen_supply=0;
    
    set(handles.popupmenu109,'Enable','on');
    set(handles.popupmenu109,'String',{'Constant','Sine','Square'});
    
    nets_as_vect{1}='<None>';
    if size(handles.net_meas,2)>size(handles.net_meas,1)
        sz=size(handles.net_meas,2);
    else
        sz=size(handles.net_meas,1);
    end
        
    for i=1:sz
        nets_as_vect{i+1}=handles.net_meas{i};
    end
    
    set(handles.popupmenu112,'Enable','on');
    set(handles.popupmenu112,'String',nets_as_vect);
    set(handles.popupmenu112,'Value',1);

    set_popup_off(handles.popupmenu100,'<Ii2>');
    set_popup_off(handles.popupmenu101,'<Ii1>');
    set_popup_off(handles.popupmenu104,'<DiffI2>');
    set_popup_off(handles.popupmenu60,'<I_s>');
    set_popup_off(handles.popupmenu61,'<DiffI1>');
    set_popup_off(handles.popupmenu62,'<TR_max>');
    set_popup_off(handles.popupmenu63,'<TR_min>');
    set_popup_off(handles.popupmenu68,'<TR_per>');
    set_popup_off(handles.popupmenu34,'<DC_var>');
    set_popup_off(handles.popupmenu77,'<DC_OUT_var>');
    
    for no=0:2
      for df=1:2
        set_popup_off(hi(no*2+df),['<Io' num2str(df) 'A'+no '>']);
        set_popup_off(hd(no*2+df),['<Diff' num2str(df) 'A'+no '>']);
      end
    end

% Update handles structure
guidata(hObject, handles);

else
    %Mode diff disabled on input
    handles.gen_sources=0;
    handles.gen_supply=0;
    vars_as_vect=[] ;
    for i=1:size(handles.des_var,2)
        vars_as_vect{i}=handles.des_var(i).name;
    end
    crt_meas=handles.crt_meas;
    
    set_edit_off(handles.edit39);
    set_edit_off(handles.edit40);

    set_check_off(handles.checkbox35);
    handles.gen_supply=0;
    set_edit_off(handles.edit41);
    set_popup_off(handles.popupmenu109,'Constant');
    
    set_popup_off(handles.popupmenu112,'<GND>');

    set_popup_on(handles.popupmenu101,crt_meas);
    set_popup_on(handles.popupmenu60,crt_meas);
    set_popup_on(handles.popupmenu61,vars_as_vect);

    if (handles.mode_diff_enabled==1);
        set_popup_on(handles.popupmenu104,vars_as_vect);
        set_popup_on(handles.popupmenu100,crt_meas);
    end

    for no=0:2
      for df=1:2
        set_popup_off(hi(no*2+df),['<Io' num2str(df) 'A'+no '>']);
        set_popup_off(hd(no*2+df),['<Diff' num2str(df) 'A'+no '>']);
      end
    end
    
    for no=1:handles.numout
      for df=0:handles.mode_diff_enabled_out
         %Populate outputs
        if (handles.gen_sources==0)
            set_popup_on(hi(no*2+df-1),crt_meas);
            set_popup_on(hd(no*2+df-1),vars_as_vect);
        else
            set_popup_off(hi(no*2+df-1),['<Io' num2str(df+1) 'A'+no-1 '>']  );
            set_popup_off(hd(no*2+df-1),['<Diff' num2str(df+1) 'A'+no-1 '>'] );    
        end
      end
    end
    
    if (handles.trans_enabled==1);   
        set_popup_on(handles.popupmenu62,vars_as_vect);
        set_popup_on(handles.popupmenu63,vars_as_vect);
        set_popup_on(handles.popupmenu68,vars_as_vect);
    end
    
    if (handles.dc_enabled==1);
        set_popup_on(handles.popupmenu34,vars_as_vect);
    end
    
    if (handles.par_enabled==1);
        set_popup_on(handles.popupmenu77,vars_as_vect);
    end
    

end

% Update handles structure
guidata(hObject, handles);



function edit39_Callback(hObject, eventdata, handles)
% hObject    handle to edit39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_extract_off ;

% Hints: get(hObject,'String') returns contents of edit39 as text
%        str2double(get(hObject,'String')) returns contents of edit39 as a double


% --- Executes during object creation, after setting all properties.
function edit39_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit40_Callback(hObject, eventdata, handles)
% hObject    handle to edit40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_extract_off ;

% Hints: get(hObject,'String') returns contents of edit40 as text
%        str2double(get(hObject,'String')) returns contents of edit40 as a double


% --- Executes during object creation, after setting all properties.
function edit40_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox35.
function checkbox35_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox35
if get(hObject,'Value')==1
    %Gen supply enabled on input
    handles.gen_supply=1;
    set(handles.edit41,'Enable','on');
    set(handles.edit41,'String','');
 
else
    %Gen supply disabled on input    
    handles.gen_supply=0;
    set_edit_off(handles.edit41);  

end

% Update handles structure
guidata(hObject, handles);


function edit41_Callback(hObject, eventdata, handles)
% hObject    handle to edit41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_extract_off ;

% Hints: get(hObject,'String') returns contents of edit41 as text
%        str2double(get(hObject,'String')) returns contents of edit41 as a double


% --- Executes during object creation, after setting all properties.
function edit41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu109.
function popupmenu109_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu109 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu109 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu109


% --- Executes during object creation, after setting all properties.
function popupmenu109_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu109 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu110.
function popupmenu110_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu110 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu110 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu110


% --- Executes during object creation, after setting all properties.
function popupmenu110_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu110 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu111.
function popupmenu111_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu111 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu111 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu111
sel_sub_ckt=[];
contents = get(hObject,'String');
sel_sub_ckt=contents{get(hObject,'Value')};
handles.model_par.subcell=sel_sub_ckt;
[ind,subckt_net_meas,handles.model_par.netlist]=copy_subckt_netlist(sel_sub_ckt,handles.model_par);

set_popup_on(handles.popupmenu58,subckt_net_meas);
if handles.mode_diff_enabled
    set_popup_on(handles.popupmenu96,subckt_net_meas);
end

handpopmenu
for k=1:length(hv)/2
    for l=1:2
       set_popup_off(hv(k*2+l-2),subckt_net_meas) ;
    end

end


set_popup_on(handles.popupmenu110,['<none>' subckt_net_meas]);

%gui_alloff ;


handles.circuit_meas=handles.net_meas;
% Update handles structure
guidata(hObject, handles);

handles.net_meas=subckt_net_meas;

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu111_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu111 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox36.
function checkbox36_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox36
if get(hObject,'Value')==1
    %Extract subcircuit
    if ~isempty(handles.sub_syst_first_vect)
        handles.sim_subckt=1;

        set(handles.radiobutton81,'Enable','on');
        set(handles.radiobutton82,'Enable','on');


        set(handles.radiobutton81,'Value',1);
        set(handles.radiobutton82,'Value',0);
        
        handles.circuit_meas=handles.net_meas;

        set_popup_on(handles.popupmenu111,handles.sub_syst_first_vect);
        popupmenu111_Callback(handles.popupmenu111, eventdata, handles)
        
    else
        set(hObject,'Value',0);
        msgbox('The circuit does not contain any subcircuit');
    end
else
    %Extract system
    handles.sim_subckt=0;
    
    popupmenu2_Callback(handles.popupmenu2, eventdata, handles)
    
%     handles.model_par.subcell=handles.model_par.cell ;
%     handles.model_par.netlist=handles.model_par.netlist_repository ;
%     
%     
%     set_popup_off(handles.popupmenu111,'<Subckt>');  
% 
%     set(handles.radiobutton81,'Enable','off');
%     set(handles.radiobutton82,'Enable','off');
% 
%         
%     set(handles.radiobutton81,'Value',0);
%     set(handles.radiobutton82,'Value',0);
%     
%     handles.net_meas=handles.circuit_meas;
%     
%     set_popup_on(handles.popupmenu58,handles.net_meas);
%     set_popup_on(handles.popupmenu59,handles.net_meas);
%     set_popup_on(handles.popupmenu110,handles.net_meas);
%     
%     if handles.mode_diff_enabled
%         set_popup_on(handles.popupmenu96,handles.net_meas);
%     end
%     
%     if handles.mode_diff_enabled_out
%         set_popup_on(handles.popupmenu97,handles.net_meas);
%     end
end

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in radiobutton81.
function radiobutton81_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton81 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton81
if get(hObject,'Value')==1
   set_popup_on(handles.popupmenu111,handles.sub_syst_first_vect);
else
   set_popup_off(handles.popupmenu111,'<Subckt>');
end

% Only first level on
handles.level1_only=1;

% Update handles structure
guidata(hObject, handles);

if get(handles.radiobutton81,'Value')==1
    set(handles.radiobutton82,'Value',0)
end
guidata(hObject, handles);

% --- Executes on button press in radiobutton82.
function radiobutton82_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton82 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton82
if get(hObject,'Value')==1
   set_popup_on(handles.popupmenu111,handles.sub_syst_all_vect);
else
   set_popup_off(handles.popupmenu111,'<Subckt>');
end

% Only first level off
handles.level1_only=0;

% Update handles structure
guidata(hObject, handles);

if get(handles.radiobutton82,'Value')==1
    set(handles.radiobutton81,'Value',0)
end
guidata(hObject, handles);


% --- Executes on selection change in popupmenu112.
function popupmenu112_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu112 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu112 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu112


% --- Executes during object creation, after setting all properties.
function popupmenu112_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu112 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton87.
function radiobutton87_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton87 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton87


% --- Executes on button press in radiobutton88.
function radiobutton88_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton88 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton88



% --- Executes on selection change in popupmenu114.
function popupmenu114_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu114 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu114 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu114
simu=get(handles.popupmenu114,'String');

handles.model_par.netltype=char(simu(get(handles.popupmenu114,'Value')));

dirs=dir([handles.model_par.simrep '/' handles.model_par.celldir '/' handles.model_par.netltype]);
viewtype=[] ;
k=1 ; pos=0 ;
for i=1:size(dirs,1)
    if (dirs(i).isdir==1) && (~strcmp(dirs(i).name,'.') && (~strcmp(dirs(i).name,'..')) )
        viewtype{k}=dirs(i).name;
        if strcmp(dirs(i).name,'schematic')
            pos=k ;
        end
        k=k+1;
    end
end
set_popup_on(handles.popupmenu115,viewtype);
if pos
    set(handles.popupmenu115,'Value',pos) ;
end
handles.model_par.viewtype=char(viewtype(get(handles.popupmenu115,'Value')));
netpr=0 ;
update_model ;

gui_alloff ;

if ~(isempty(tech)) %||isempty(net_meas)||isempty(crt_meas))
    if tech~=(-1)       
        gui_fill_vars ;      
    else
        set(handles.edit36,'String','TECHNOLOGY FILE ERROR!!!');
    end
else
    set(handles.edit36,'String','UNABLE TO OPEN NETLIST!!!');        
end

guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function popupmenu114_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu114 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu115.
function popupmenu115_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu115 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu115 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu115
viewtype=get(handles.popupmenu115,'String');
handles.model_par.viewtype=char(viewtype(get(handles.popupmenu115,'Value')));
netpr=0 ;
update_model ;

gui_alloff ;

if ~(isempty(tech)) %||isempty(net_meas)||isempty(crt_meas))
    if tech~=(-1)       
        gui_fill_vars ;      
    else
        set(handles.edit36,'String','TECHNOLOGY FILE ERROR!!!');
    end
else
    set(handles.edit36,'String','UNABLE TO OPEN NETLIST!!!');        
end

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popupmenu115_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu115 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit42_Callback(hObject, eventdata, handles)
% hObject    handle to edit42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit42 as text
%        str2double(get(hObject,'String')) returns contents of edit42 as a double


% --- Executes during object creation, after setting all properties.
function edit42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu116.
function popupmenu116_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu116 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu116 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu116


% --- Executes during object creation, after setting all properties.
function popupmenu116_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu116 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu117.
function popupmenu117_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu117 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu117 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu117


% --- Executes during object creation, after setting all properties.
function popupmenu117_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu117 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu118.
function popupmenu118_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu118 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu118 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu118


% --- Executes during object creation, after setting all properties.
function popupmenu118_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu118 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu119.
function popupmenu119_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu119 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu119 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu119


% --- Executes during object creation, after setting all properties.
function popupmenu119_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu119 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu120.
function popupmenu120_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu120 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu120 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu120


% --- Executes during object creation, after setting all properties.
function popupmenu120_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu120 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu121.
function popupmenu121_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu121 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu121 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu121


% --- Executes during object creation, after setting all properties.
function popupmenu121_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu121 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu122.
function popupmenu122_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu122 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu122 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu122


% --- Executes during object creation, after setting all properties.
function popupmenu122_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu122 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu123.
function popupmenu123_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu123 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu123 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu123


% --- Executes during object creation, after setting all properties.
function popupmenu123_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu123 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu124.
function popupmenu124_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu124 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu124 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu124


% --- Executes during object creation, after setting all properties.
function popupmenu124_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu124 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu125.
function popupmenu125_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu125 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu125 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu125


% --- Executes during object creation, after setting all properties.
function popupmenu125_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu125 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu126.
function popupmenu126_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu126 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu126 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu126


% --- Executes during object creation, after setting all properties.
function popupmenu126_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu126 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu127.
function popupmenu127_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu127 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu127 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu127


% --- Executes during object creation, after setting all properties.
function popupmenu127_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu127 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu128.
function popupmenu128_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu128 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu128 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from
%        popupmenu128
%hv=[handles.popupmenu59 handles.popupmenu97 handles.popupmenu119 handles.popupmenu118 handles.popupmenu125 handles.popupmenu124];
%hi=[handles.popupmenu103 handles.popupmenu102 handles.popupmenu121 handles.popupmenu120 handles.popupmenu127 handles.popupmenu126];
%hd=[handles.popupmenu105 handles.popupmenu106 handles.popupmenu117 handles.popupmenu116 handles.popupmenu123 handles.popupmenu122];

handpopmenu

net_meas=handles.net_meas;
crt_meas=handles.crt_meas;
vars_as_vect=[] ;
for i=1:size(handles.des_var,2)
    vars_as_vect{i}=handles.des_var(i).name;
end

for no=0:2
    for df=1:2
        set(hv(no*2+df),'Enable','off');
        set(hi(no*2+df),'Enable','off');
        set(hd(no*2+df),'Enable','off');
    end
end
        
handles.numout = floor((get(hObject,'Value')+1)/2) ;
handles.mode_diff_enabled_out=mod(get(hObject,'Value')-1,2);

for no=1:handles.numout
    for df=0:handles.mode_diff_enabled_out

         %Populate outputs
        set(hv(no*2+df-1),'Enable','on');
        set(hv(no*2+df-1),'String',net_meas);
        %set_popup_on(hv(no*2+df-1),net_meas);   
        if (handles.gen_sources==0)
            set(hi(no*2+df-1),'Enable','on');
            set(hi(no*2+df-1),'String',crt_meas);
            set(hd(no*2+df-1),'Enable','on');
            set(hd(no*2+df-1),'String',vars_as_vect);

            %set_popup_on(hi(no*2+df-1),crt_meas);
            %set_popup_on(hd(no*2+df-1),vars_as_vect);
        else
            set_popup_off(hi(no*2+df-1),['<Io' num2str(df+1) 'A'+no-1 '>']  );
            set_popup_off(hd(no*2+df-1),['<Diff' num2str(df+1) 'A'+no-1 '>'] );    
        end
    end
end
st129='All' ; 
for k=1:handles.numout
    st129=[st129 '|' '0'+k];
end
set(handles.popupmenu129,'Value',1);
set(handles.popupmenu129,'String',st129);


guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function popupmenu128_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu128 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox40.
function checkbox40_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox40
if get(hObject,'value')==1
    if (get(handles.checkbox28,'value')==1)
        set(handles.popupmenu108,'Enable','on');
        set(handles.popupmenu108,'Value',1);
    end
        set(handles.pushbutton15,'Enable','off');
        set(handles.pushbutton16,'Enable','off');
        set(handles.pushbutton17,'Enable','off');
        set(handles.pushbutton31,'Enable','off');
        set(handles.pushbutton33,'Enable','off');
        set(handles.pushbutton35,'Enable','off');
    
else
        set(handles.popupmenu108,'Enable','off');
        set(handles.popupmenu108,'Value',1);
end



% --- Executes on selection change in popupmenu129.
function popupmenu129_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu129 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu129 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu129


% --- Executes during object creation, after setting all properties.
function popupmenu129_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu129 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function uipanel32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function uipanel32_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uipanel32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox41.
function checkbox41_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox41


% --- Executes on selection change in popupmenu130.
function popupmenu130_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu130 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu130 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu130


% --- Executes during object creation, after setting all properties.
function popupmenu130_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu130 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu131.
function popupmenu131_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu131 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu131 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu131


% --- Executes during object creation, after setting all properties.
function popupmenu131_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu131 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%handles.model_par=[];
handles.trans_an=[];
handles.dc_an=[];
handles.par_an=[];
handles.ac_in_an=[];
handles.ac_out_an=[];

%Read user input script
read_user_input;

%Run OCEAN enabled
handles.model_par.rnocn=1;

%Write files and verify status
verif_par;

%Update handles structure
guidata(hObject, handles);

if (run_status)
    for k=16:60, if ishghandle(k), close(k); end; end

    set(handles.text126,'Visible','on');
    simect_runpar ;
    set(handles.text126,'Visible','off');
end

        


% --- Executes on selection change in popupmenu132.
function popupmenu132_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu132 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu132 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu132


% --- Executes during object creation, after setting all properties.
function popupmenu132_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu132 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton35.
function pushbutton35_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

op=0;
for k=16:19,  if ishandle(k), op=1; end, end
if (op),  for k=16:19, if ishghandle(k), close(k); end,  end
else
    if handles.dc_an.enabled
        for k=0:handles.model_par.mode_diff_enabled %if out diff
            disp_int_DC(handles.model_par,handles.multi_in_out(3).simple_dc{k+1},k);
        end
    end
end
