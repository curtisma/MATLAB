function varargout = sys_funct_disp_mimo(varargin)
% SYS_FUNCT_DISP_MIMO M-file for sys_funct_disp_mimo.fig
%      SYS_FUNCT_DISP_MIMO, by itself, creates a new SYS_FUNCT_DISP_MIMO or raises the existing
%      singleton*.
%
%      H = SYS_FUNCT_DISP_MIMO returns the handle to a new SYS_FUNCT_DISP_MIMO or the handle to
%      the existing singleton*.
%
%      SYS_FUNCT_DISP_MIMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SYS_FUNCT_DISP_MIMO.M with the given input arguments.
%
%      SYS_FUNCT_DISP_MIMO('Property','Value',...) creates a new SYS_FUNCT_DISP_MIMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sys_funct_disp_mimo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sys_funct_disp_mimo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sys_funct_disp_mimo

% Last Modified by GUIDE v2.5 16-Jul-2010 14:53:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sys_funct_disp_mimo_OpeningFcn, ...
                   'gui_OutputFcn',  @sys_funct_disp_mimo_OutputFcn, ...
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


% --- Executes just before sys_funct_disp_mimo is made visible.
function sys_funct_disp_mimo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sys_funct_disp_mimo (see VARARGIN)

global MODEL_IN_OUT;

model_in_out=MODEL_IN_OUT;

%%Background image
if model_in_out.mode_diff_enabled
    if model_in_out.mode_diff_enabled_out
        % Read in image
        imageArray = imread('MIMO_sans_fig.jpg');
        % Switch active axes to the one you made for the image.
        axes(handles.axes11);
        % Put the image array into the axes so it will appear on the GUI
        imshow(imageArray);
    else
        % Read in image
        imageArray = imread('MISO_sans_fig.jpg');
        % Switch active axes to the one you made for the image.
        axes(handles.axes11);
        % Put the image array into the axes so it will appear on the GUI
        imshow(imageArray);
    end
else
    if model_in_out.mode_diff_enabled_out
        % Read in image
        imageArray = imread('SIMO_sans_fig.jpg');
        % Switch active axes to the one you made for the image.
        axes(handles.axes11);
        % Put the image array into the axes so it will appear on the GUI
        imshow(imageArray);
    else
        % Read in image
        imageArray = imread('SISO_sans_fig.jpg');
        % Switch active axes to the one you made for the image.
        axes(handles.axes11);
        % Put the image array into the axes so it will appear on the GUI
        imshow(imageArray);
    end
end


%%Functions - common


% Switch active axes
axes(handles.axes12);
cla reset;
%plots the TFD1

TFD1=freqs(model_in_out.Num_TF_dir1,model_in_out.Den_TF_dir1,2*pi*model_in_out.f);
loglog(model_in_out.f,abs(TFD1));
hold on;
title('Direct TF 1');

if isfield(model_in_out,'Num_TF_inv1')
    %plots the TFR1
    TFR1=freqs(model_in_out.Num_TF_inv1,model_in_out.Den_TF_inv1,2*pi*model_in_out.f);
    loglog(model_in_out.f,abs(TFR1),'g');
    grid on;
    %adds a title
    title('Direct TF 1 and Inverse TF 1');
end

%Zin1
Zin1=freqs(model_in_out.Num_Zin1,model_in_out.Den_Zin1,2*pi*model_in_out.f);

% Switch active axes
axes(handles.axes13);
cla reset;
%plots the Zin1
loglog(model_in_out.f,abs(Zin1));
grid on;
%adds a title
title('Zin1');


%Zout1
Zout1=freqs(model_in_out.Num_Zout1,model_in_out.Den_Zout1,2*pi*model_in_out.f);

% Switch active axes
axes(handles.axes14);
cla reset;
%plots the Zout1
loglog(model_in_out.f,abs(Zout1));
grid on;
%adds a title
title('Zout1');


%%Functions - specific


if model_in_out.mode_diff_enabled
    
    if model_in_out.mode_diff_enabled_out

    %TFD2    

    % Switch active axes
    axes(handles.axes15);
    cla reset;
    %plots the TFD2
    TFD2=freqs(model_in_out.Num_TF_dir2,model_in_out.Den_TF_dir2,2*pi*model_in_out.f);
    loglog(model_in_out.f,abs(TFD2));
    hold on ;
    title('Direct TF 2');   
    
    
    if isfield(model_in_out,'Num_TF_inv2')
        TFR2=freqs(model_in_out.Num_TF_inv2,model_in_out.Den_TF_inv2,2*pi*model_in_out.f);
        loglog(model_in_out.f,abs(TFR2),'g');   
        grid on;
        %adds a title
        title('Direct TF 2 and inverse TF 2');   
    end
        

    %TFD3    

    % Switch active axes
    axes(handles.axes16);
    cla reset;
    %plots the TFD3
    TFD3=freqs(model_in_out.Num_TF_dir3,model_in_out.Den_TF_dir3,2*pi*model_in_out.f);
    loglog(model_in_out.f,abs(TFD3));
    hold on ;
    title('Direct TF 3');
    
    
    if isfield(model_in_out,'Num_TF_inv3')
        TFR3=freqs(model_in_out.Num_TF_inv3,model_in_out.Den_TF_inv3,2*pi*model_in_out.f);
        loglog(model_in_out.f,abs(TFR3),'g');
        grid on;
        %adds a title
        title('Direct TF 3 and inverse TF 3');
    end
    
    %Zin_diff1
    Zin_diff1=freqs(model_in_out.Num_Zin_diff1,model_in_out.Den_Zin_diff1,2*pi*model_in_out.f);
    Zin_diff2=freqs(model_in_out.Num_Zin_diff2,model_in_out.Den_Zin_diff2,2*pi*model_in_out.f);

    % Switch active axes
    axes(handles.axes17);
    cla reset;
    %plots the 
    loglog(model_in_out.f,abs(Zin_diff1));
    hold on;
    loglog(model_in_out.f,abs(Zin_diff2),'g');    
    grid on;
    %adds a title
    title('Zin DIFF');
    
    
    %TFD4 and TFR4


    % Switch active axes
    axes(handles.axes19);
    cla reset;
    %plots the TFD4
    TFD4=freqs(model_in_out.Num_TF_dir4,model_in_out.Den_TF_dir4,2*pi*model_in_out.f);
    loglog(model_in_out.f,abs(TFD4));
    hold on;
    title('Direct TF 4');
    
    
    if isfield(model_in_out,'Num_TF_inv4')
        %plots the TFR4
        TFR4=freqs(model_in_out.Num_TF_inv4,model_in_out.Den_TF_inv4,2*pi*model_in_out.f);
        loglog(model_in_out.f,abs(TFR4),'g');
        grid on;
        %adds a title
        title('Direct TF 4 and Inverse TF 4');
    end
    
    
    %Zin2
    Zin2=freqs(model_in_out.Num_Zin2,model_in_out.Den_Zin2,2*pi*model_in_out.f);

    % Switch active axes
    axes(handles.axes20);
    cla reset;
    %plots the Zin2
    loglog(model_in_out.f,abs(Zin2));
    grid on;
    %adds a title
    title('Zin2');


    %Zout2
    Zout2=freqs(model_in_out.Num_Zout2,model_in_out.Den_Zout2,2*pi*model_in_out.f);

    % Switch active axes
    axes(handles.axes21);
    cla reset;
    %plots the Zout2
    loglog(model_in_out.f,abs(Zout1));
    grid on;
    %adds a title
    title('Zout2');
    
    %Zout_diff1
    Zout_diff1=freqs(model_in_out.Num_Zout_diff1,model_in_out.Den_Zout_diff1,2*pi*model_in_out.f);
    Zout_diff2=freqs(model_in_out.Num_Zout_diff2,model_in_out.Den_Zout_diff2,2*pi*model_in_out.f);

    % Switch active axes
    axes(handles.axes18);
    cla reset;
    %plots the 
    loglog(model_in_out.f,abs(Zout_diff1));
    hold on;
    loglog(model_in_out.f,abs(Zout_diff2),'g');    
    grid on;
    %adds a title
    title('Zout DIFF');
    
    else %DIFF In COMM Out
    
    %Zin_diff1
    Zin_diff1=freqs(model_in_out.Num_Zin_diff1,model_in_out.Den_Zin_diff1,2*pi*model_in_out.f);
    Zin_diff2=freqs(model_in_out.Num_Zin_diff2,model_in_out.Den_Zin_diff2,2*pi*model_in_out.f);

    % Switch active axes
    axes(handles.axes17);
    cla reset;
    %plots the 
    loglog(model_in_out.f,abs(Zin_diff1));
    hold on;
    loglog(model_in_out.f,abs(Zin_diff2),'g');    
    grid on;
    %adds a title
    title('Zin DIFF');
    
    %TFD2 and TFR2 - index 3 in SIMECT
    TFD2=freqs(model_in_out.Num_TF_dir3,model_in_out.Den_TF_dir3,2*pi*model_in_out.f);
    pos=get(handles.axes19,'position');
    set(handles.axes19,'position',[pos(1) pos(2)+22 pos(3) pos(4)]);   
    % Switch active axes
    axes(handles.axes19);
    cla reset;
    %plots the TFD2
    loglog(model_in_out.f,abs(TFD2));
    hold on;
    %adds a title
    title('Direct TF 2');
    
    if isfield(model_in_out,'Num_TF_inv3')
        TFR2=freqs(model_in_out.Num_TF_inv3,model_in_out.Den_TF_inv3,2*pi*model_in_out.f);
        %plots the TFR2
        loglog(model_in_out.f,abs(TFR2),'g');
        grid on;
        %adds a title
        title('Direct TF 2 and Inverse TF 2');
    end

    
    pos=get(handles.axes20,'position');
    
    set(handles.axes20,'position',[pos(1) pos(2)+5 pos(3) pos(4)]);
    
    %Zin2
    Zin2=freqs(model_in_out.Num_Zin2,model_in_out.Den_Zin2,2*pi*model_in_out.f);

    % Switch active axes
    axes(handles.axes20);
    cla reset;
    %plots the Zin2
    loglog(model_in_out.f,abs(Zin2));
    grid on;
    %adds a title
    title('Zin2');
   
    end
    
else
    if model_in_out.mode_diff_enabled_out
    
    
    %TFD2 and TFR2
    TFD2=freqs(model_in_out.Num_TF_dir2,model_in_out.Den_TF_dir2,2*pi*model_in_out.f);


    pos=get(handles.axes19,'position');
    
    set(handles.axes19,'position',[pos(1) pos(2)+22 pos(3) pos(4)]);
    
    % Switch active axes
    axes(handles.axes19);
    cla reset;
    %plots the TFD2
    loglog(model_in_out.f,abs(TFD2));
    hold on;
    title('Direct TF 2');
    
    if isfield(model_in_out,'Num_TF_inv2')
        TFR2=freqs(model_in_out.Num_TF_inv2,model_in_out.Den_TF_inv2,2*pi*model_in_out.f);
        %plots the TFR2
        loglog(model_in_out.f,abs(TFR2),'g');
        grid on;
        %adds a title
        title('Direct TF 2 and Inverse TF 2');
    end

    pos=get(handles.axes21,'position');
    
    set(handles.axes21,'position',[pos(1) pos(2)+5 pos(3) pos(4)]);
    
    
    %Zout2freqs
    Zout2=freqs(model_in_out.Num_Zout2,model_in_out.Den_Zout2,2*pi*model_in_out.f);

    % Switch active axes
    axes(handles.axes21);
    cla reset;
    %plots the Zout2
    loglog(model_in_out.f,abs(Zout2));
    grid on;
    %adds a title
    title('Zout2');
    
    %Zout_diff1
    Zout_diff1=freqs(model_in_out.Num_Zout_diff1,model_in_out.Den_Zout_diff1,2*pi*model_in_out.f);
    Zout_diff2=freqs(model_in_out.Num_Zout_diff2,model_in_out.Den_Zout_diff2,2*pi*model_in_out.f);

    % Switch active axes
    axes(handles.axes18);
    cla reset;
    %plots the 
    loglog(model_in_out.f,abs(Zout_diff1));
    hold on;
    loglog(model_in_out.f,abs(Zout_diff2),'g');    
    grid on;
    %adds a title
    title('Zout DIFF');
    
    else
        
        %No special function for comm/comm
        
    end
    
end

% Choose default command line output for sys_funct_disp_mimo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sys_funct_disp_mimo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sys_funct_disp_mimo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;
