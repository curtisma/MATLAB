%%% DynaEst 3.032 12/31/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% System Initialize 3 % System Parameters after load ground truth

h_HeadTitle = uicontrol('Parent',h_CommonWindow, ...
      'Units','points', ...
      'HorizontalAlignment','left', ...
      'ListboxTop',0, ...
      'Position',[1.1/12*cwsz(3) 9.3/10*cwsz(4) cwsz(3)/2 10], ...
  	   'BackgroundColor',FrameBackColor, ...
      'Style','text', ...
      'String','Simulation parameters:',...  
	'FontWeight', 'bold', ...
      'Tag','StaticText2');

h_Text1 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
  	'BackgroundColor',FrameBackColor, ...
     'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+fwsz(4)*8.5/10 fwsz(3)*0.6 15], ...
	'String','Dimension of state vector, nx =', ...
	'Style','text', ...
	'Tag','StaticText1');
h_Edit1 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'HorizontalAlignment','left', ...
   'ListboxTop',0, ...
   'Position',[fwsz(1)+fwsz(3)*0.72 fwsz(2)+fwsz(4)*8.2/10 fwsz(3)*0.12 15], ...
	'String','1', ...
	'Style','edit', ...
	'Tag','EditText2');
h_Text2 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
   'HorizontalAlignment','right', ...
   'BackgroundColor',FrameBackColor, ...
   'ListboxTop',0, ...
   'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+fwsz(4)*(8.5/10-1/6.5) fwsz(3)*0.6 15], ...
	'String','Dimension of measurement vector, nz =', ...
	'Style','text', ...
   'Tag','StaticText1');
h_Edit2 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'HorizontalAlignment','left', ...
   'ListboxTop',0, ...
   'Position',[fwsz(1)+fwsz(3)*0.72 fwsz(2)+fwsz(4)*(8.2/10-1/6.5) fwsz(3)*0.12 15], ...
	'String','2', ...
	'Style','edit', ...
	'Tag','EditText2');
h_Text3 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
   'ListboxTop',0, ...
   'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+fwsz(4)*(8.5/10-2/6.5) fwsz(3)*0.6 15], ...
   'BackgroundColor',FrameBackColor, ...
	'String','Dimension of measurement noise vector,  nw =', ...
	'Style','text', ...
	'Tag','StaticText1');
h_Edit3 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'HorizontalAlignment','left', ...
   'ListboxTop',0, ...
   'Position',[fwsz(1)+fwsz(3)*0.72 fwsz(2)+fwsz(4)*(8.2/10-2/6.5) fwsz(3)*0.12 15], ...
	'String','2', ...
	'Style','edit', ...
	'Tag','EditText2');
h_Text4 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
   'ListboxTop',0, ...
   'BackgroundColor',FrameBackColor, ...
   'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+fwsz(4)*(8.5/10-3/6.5) fwsz(3)*0.6 15], ...
'String','Number of Monte Carlo runs, nrun =', ...
	'Style','text', ...
	'Tag','StaticText1');
h_Edit4 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'HorizontalAlignment','left', ...
   'ListboxTop',0, ...
   'Position',[fwsz(1)+fwsz(3)*0.72 fwsz(2)+fwsz(4)*(8.2/10-3/6.5) fwsz(3)*0.12 15], ...
	'String','10', ...
	'Style','edit', ...
   'Tag','EditText2');


h_Text5 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
   'ListboxTop',0, ...
   'BackgroundColor',FrameBackColor, ...
      'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+fwsz(4)*(8.5/10-4/6.5) fwsz(3)*0.6 15], ...
'String','Dimension of geometry, ncoor =',...
	'Style','text', ...
	'Tag','StaticText1');

h_Edit5 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'HorizontalAlignment','left', ...
   'ListboxTop',0, ...
       'Position',[fwsz(1)+fwsz(3)*0.72 fwsz(2)+fwsz(4)*(8.2/10-4/6.5) fwsz(3)*0.12 15], ...
'String','2', ...
	'Style','edit', ...
	'Tag','EditText2');

h_Text6 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
   'ListboxTop',0, ...
   'BackgroundColor',FrameBackColor, ...
      'Position',[fwsz(1)+fwsz(3)/20 fwsz(2)+fwsz(4)*(8.5/10-5/6.5) fwsz(3)*0.65 15], ...
'String','Maximum number of sensor revisits, kmax =', ...
	'Style','text', ...
	'Tag','StaticText1');
h_Edit6 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*0.72 fwsz(2)+fwsz(4)*(8.2/10-5/6.5) fwsz(3)*0.12 15], ...
'String','20', ...
	'Style','edit', ...
   'Tag','EditText2');


set(h_Edit1,'string',num2str(nx)); 
set(h_Edit2,'string',num2str(nz));  
set(h_Edit3,'string',num2str(nw)); 
set(h_Edit4,'string',num2str(nrun));  
set(h_Edit5,'string',num2str(ncoor));  
set(h_Edit6,'string',num2str(kmax));  


set(h_Edit1,'Enable','Off');
set(h_Edit4,'Enable','Off');
set(h_Edit6,'Enable','Off');

help_string=['In this window, you can define the parameters for measurment generation.',...
      ' define the dimensions of the measurement and measurement noise vectors.',...
   char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];

set(h_About,'String',help_string, 'enable', 'inactive');



