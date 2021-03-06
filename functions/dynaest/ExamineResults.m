%%% DynaEst 3.032 02/09/2001
% Copyright (c) 2000 Yaakov Bar-Shalom

% ExamineResults, Examine the Results of Simulations

set(simu_montecarlo_menu,'enable','on');

if ~exist('h_CommonWindow')
   CommonWindow;
end

new_title=1;
if (exist('h_HeadTitle') == 0)

else
  if ishandle(h_HeadTitle)
	new_title=0;
  end
end

if ~new_title
   set(h_HeadTitle, 'String','Results to plot I:');
else
	h_HeadTitle = uicontrol('Parent',h_CommonWindow, ...
      'Units','points', ...
      'HorizontalAlignment','left', ...
      'ListboxTop',0, ...
      'Position',[1.1/12*cwsz(3) 9.3/10*cwsz(4) cwsz(3)/2 10], ...
      'BackgroundColor',FrameBackColor, ...
      'Style','text', ...
      'String','Results to plot I:',... 
	'FontWeight', 'bold', ... 
      'Tag','StaticText2');
end

% a small frame

h_RadioButton1 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'Callback',['set(h_RadioButton1,''Value'',1);',...
      'set(h_RadioButton2,''Value'',0);',...
      'set(h_RadioButton3,''Value'',0);',...
      'set(h_RadioButton4,''Value'',0);',...
      'set(h_RadioButton5,''Value'',0);',...
      'set(h_RadioButton6,''Value'',0);',...
      'set(h_RadioButton7,''Value'',0);',...
      'ResultFlag = 1;'],...
   'ListboxTop',0, ...
   'BackgroundColor',FrameBackColor, ...
   'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+fwsz(4)*(8.5/10) fwsz(3)*0.6 15], ...
	'String','Trajectories', ...
   'Style','radiobutton', ...
   'Value',0,...
	'Tag','Radiobutton1');

h_RadioButton2 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
   'Callback',['set(h_RadioButton1,''Value'',0);',...
      'set(h_RadioButton2,''Value'',1);',...
      'set(h_RadioButton3,''Value'',0);',...
      'set(h_RadioButton4,''Value'',0);',...
      'set(h_RadioButton5,''Value'',0);',...
      'set(h_RadioButton6,''Value'',0);',...
      'set(h_RadioButton7,''Value'',0);',...
      'ResultFlag = 2;'],...
   'ListboxTop',0, ...
   'BackgroundColor',FrameBackColor, ...
   'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+fwsz(4)*(8.5/10-1/9) fwsz(3)*0.6 15], ...
   'String','RMS position errors', ...
	'Style','radiobutton', ...
   'Tag','Radiobutton2', ...
   'Enable','on',...
	'Value',0);

h_RadioButton3 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
   'Callback',['set(h_RadioButton1,''Value'',0);',...
      'set(h_RadioButton2,''Value'',0);',...
      'set(h_RadioButton3,''Value'',1);',...
      'set(h_RadioButton4,''Value'',0);',...
      'set(h_RadioButton5,''Value'',0);',...
      'set(h_RadioButton6,''Value'',0);',...
      'set(h_RadioButton7,''Value'',0);',...
      'ResultFlag = 3;'],...
   'ListboxTop',0, ...
   'BackgroundColor',FrameBackColor, ...
   'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+fwsz(4)*(8.5/10-2/9) fwsz(3)*0.6 15], ...
	'String','RMS velocity errors', ...
   'Style','radiobutton', ...
   'Tag','Radiobutton3', ...
   'Enable','on',...
   'Value',0);

h_RadioButton4 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'BackgroundColor',[0.8 0.8 0.8], ...
	'Callback',['set(h_RadioButton1,''Value'',0);',...
      'set(h_RadioButton2,''Value'',0);',...
      'set(h_RadioButton3,''Value'',0);',...
      'set(h_RadioButton4,''Value'',1);',...
      'set(h_RadioButton5,''Value'',0);',...
      'set(h_RadioButton6,''Value'',0);',...
      'set(h_RadioButton7,''Value'',0);',...
      'ResultFlag = 4;'],...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+fwsz(4)*(8.5/10-3/9) fwsz(3)*0.6 15], ...
	'String','Mode probabilities', ...
   'Style','radiobutton', ...
   'Enable','on',...
   'Tag','Radiobutton4');

h_RadioButton5 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'BackgroundColor',[0.8 0.8 0.8], ...
	'Callback',['set(h_RadioButton1,''Value'',0);',...
      'set(h_RadioButton2,''Value'',0);',...
      'set(h_RadioButton3,''Value'',0);',...
      'set(h_RadioButton4,''Value'',0);',...
      'set(h_RadioButton5,''Value'',1);',...
      'set(h_RadioButton6,''Value'',0);',...
      'set(h_RadioButton7,''Value'',0);',...
      'ResultFlag = 5;'],...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+fwsz(4)*(8.5/10-4/9) fwsz(3)*0.6 15], ...
	'String','Filter Gain', ...
   'Style','radiobutton', ...
   'Enable','on',...
   'Tag','Radiobutton5');

h_RadioButton6 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'BackgroundColor',[0.8 0.8 0.8], ...
	'Callback',['set(h_RadioButton1,''Value'',0);',...
      'set(h_RadioButton2,''Value'',0);',...
      'set(h_RadioButton3,''Value'',0);',...
      'set(h_RadioButton4,''Value'',0);',...
      'set(h_RadioButton5,''Value'',0);',...
      'set(h_RadioButton6,''Value'',1);',...
      'set(h_RadioButton7,''Value'',0);',...
      'ResultFlag = 6;'],...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+fwsz(4)*(8.5/10-5/9) fwsz(3)*0.6 15], ...
	'String','NEES', ...
   'Style','radiobutton', ...
   'Enable','on',...
   'Tag','Radiobutton6');

h_RadioButton7 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'BackgroundColor',[0.8 0.8 0.8], ...
	'Callback',['set(h_RadioButton1,''Value'',0);',...
      'set(h_RadioButton2,''Value'',0);',...
      'set(h_RadioButton3,''Value'',0);',...
      'set(h_RadioButton4,''Value'',0);',...
      'set(h_RadioButton5,''Value'',0);',...
      'set(h_RadioButton6,''Value'',0);',...
      'set(h_RadioButton7,''Value'',1);',...
      'ResultFlag = 7;'],...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+fwsz(4)*(8.5/10-6/9) fwsz(3)*0.6 15], ...
	'String','NIS', ...
   'Style','radiobutton', ...
   'Enable','on',...
   'Tag','Radiobutton7');

h_Check = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
   'BackgroundColor',FrameBackColor, ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)/15 fwsz(2)+fwsz(4)*(8.5/10-7/9) fwsz(3)*0.6 15], ...
   'String','Create a new window to plot', ...
	'Style','checkbox', ...
	'Tag','Checkbox1');

if FilterAlgorithmFlag == ALGORITHM_IMM
   set(h_RadioButton4,'Enable','on');
   set(h_RadioButton5,'Enable','off');
else
   set(h_RadioButton4,'Enable','off');
   set(h_RadioButton5,'Enable','on');
end
if (FilterAlgorithmFlag == ALGORITHM_alphabetagamma )
    set(h_RadioButton7,'Enable','off');
end
  %else
 %   set(h_RadioButton7,'Enable','on');
 %end
if nx/ncoor == 1
   set(h_RadioButton3,'Enable','off');
end

if ResultFlag == 4 & FilterAlgorithmFlag ~= ALGORITHM_IMM
   ResultFlag = 1;
end

if SimulationFlag == 4  
   set(h_RadioButton2,'Enable','off');
   set(h_RadioButton3,'Enable','off');
   set(h_RadioButton6,'Enable','off');
   set(h_RadioButton7,'Enable','off');
end

switch ResultFlag 
case 1 
   set(h_RadioButton1,'value',1);
case 2
   set(h_RadioButton2,'value',1);
case 3
   set(h_RadioButton3,'value',1);
case 4
   set(h_RadioButton4,'value',1);
case 5
   set(h_RadioButton5,'value',1);
case 6
   set(h_RadioButton6,'value',1);
case 7
   set(h_RadioButton7,'value',1);
end

help_string=[' If you want to plot the true, measured and estimated trajectories,',... 
      'select ''Trajectories''. To plot the RMS position and velocity errors,',...
      'select ''RMS position errors'', and ''RMS velocity errors'',respectively.',...
      'To view the mode probabilities in an IMM estimator, select ''Mode probabilities''.',...
      'To view the filter gain, select ''Filter gain''.',...
      'To view the NEES or NIS, select ''NEES'', or ''NIS''.' char(10), char(10),...
   'If you want to open a new window to plot the results (instead of overwriting the current one),',...
      'check the option''Create a new window to plot''.', char(10), char(10),...
      'Press ''Next >>'' when done to go to the next step. Press ''Close'' to quit without plotting results.'];

set(h_About,'String',help_string, 'enable', 'inactive');

set(h_Prev,'enable','off');
