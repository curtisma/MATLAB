%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% System Initialize 1

%cwsz = [scrsz(3)/9.5 scrsz(4)/9.5 scrsz(3)/1.9 scrsz(4)/1.9] ;
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
    
  % 'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+ fwsz(4)*7/10 fwsz(3)*8/10 15], ...

h_Text1 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
  	'BackgroundColor',FrameBackColor, ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+fwsz(4)*8.2/10 fwsz(3)*0.6 15], ...
	'String','Minimum sampling interval, Tmin =', ...
	'Style','text', ...
	'Tag','StaticText1');
% 	'Position',[47.25 266.25 173.25 16.5], ...

h_Edit1 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*0.72 fwsz(2)+fwsz(4)*8.2/10 fwsz(3)*0.12 15], ...
	'String','1', ...
	'Style','edit', ...
	'Tag','EditText2');
%	'Position',[227.25 269.25 31.5 15], ...

h_Text2 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
   'HorizontalAlignment','right', ...
   'BackgroundColor',FrameBackColor, ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+fwsz(4)*(8.2/10-1/6.5) fwsz(3)*0.6 15], ...
	'String','Maximum sampling interval, Tmax =', ...
	'Style','text', ...
   'Tag','StaticText1');
h_Edit2 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*0.72 fwsz(2)+fwsz(4)*(8.2/10-1/6.5) fwsz(3)*0.12 15], ...
	'String','1', ...
	'Style','edit', ...
	'Tag','EditText2');


%	'Position',[227.25 246.75 31.5 15], ...
h_Text3 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+fwsz(4)*(8.2/10-2/6.5) fwsz(3)*0.6 15], ...
   'BackgroundColor',FrameBackColor, ...
	'String','Dimension of state vector, nx =', ...
	'Style','text', ...
	'Tag','StaticText1');
%   'Position',[47.25 222.75 173.25 16.5], ...
h_Edit3 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*0.72 fwsz(2)+fwsz(4)*(8.2/10-2/6.5) fwsz(3)*0.12 15], ...
	'String','4', ...
	'Style','edit', ...
	'Tag','EditText2');

h_Text4 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
   'ListboxTop',0, ...
   'BackgroundColor',FrameBackColor, ...
   'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+fwsz(4)*(8.2/10-3/6.5) fwsz(3)*0.6 15], ...
	'String','Dimension of process noise vector, nv =', ...
	'Style','text', ...
	'Tag','StaticText1');
h_Edit4 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*0.72 fwsz(2)+fwsz(4)*(8.2/10-3/6.5) fwsz(3)*0.12 15], ...
    'String','2', ...
	'Style','edit', ...
	'Tag','EditText2');
h_Text5 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
   'ListboxTop',0, ...
   'BackgroundColor',FrameBackColor, ...
   'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+fwsz(4)*(8.2/10-4/6.5) fwsz(3)*0.6 15], ...
   'String','Dimension of measurement vector, nz =', ...
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
   'Position',[fwsz(1)+fwsz(3)/20 fwsz(2)+fwsz(4)*(8.2/10-5/6.5) fwsz(3)*0.65 15], ...
	'String','Dimension of measurement noise vector,  nw =', ...
	'Style','text', ...
	'Tag','StaticText1');
h_Edit6 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*0.72 fwsz(2)+fwsz(4)*(8.2/10-5/6.5) fwsz(3)*0.12 15], ...
	'String','2', ...
	'Style','edit', ...
   'Tag','EditText2');


set(h_Edit1,'string',num2str(Tmin)); % minimum sampling interval       
set(h_Edit2,'string',num2str(Tmax));  % maximum sampling interval                  
set(h_Edit3,'string',num2str(nx)); % dimension of state vector          
set(h_Edit4,'string',num2str(nv));  % dimension of process noise vector  
set(h_Edit5,'string',num2str(nz));  % dimension of measurement vector    
set(h_Edit6,'string',num2str(nw));  % dimension of measurement noise vector


% if read from external state, user can not modify everythings
if SimulationFlag == 2 | NewFlag == OpenPrj 
   set(h_Edit1,'enable','off');
   set(h_Edit2,'enable','off');
   set(h_Edit3,'enable','off');  
   set(h_Edit4,'enable','off');
   set(h_Edit5,'enable','off');
   set(h_Edit6,'enable','off');
end

help_string=['In this window, you can define the parameters for scenario generation.', char(10), char(10), 'To generate measurements at time-varying revisit intervals, select different values for ''Minimum sampling interval'' and ''Maximum sampling interval''. In this case, the revisit interval will be a random number uniformly distributed between the minimum and the maximum. To use a constant revisit interval, use equal values for the above parameters. You can also define the dimensions of the state and measurement vectors.', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];

set(h_About,'String',help_string, 'enable', 'inactive');



