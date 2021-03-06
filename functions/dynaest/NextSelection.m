%%% DynaEst 3.032 12/23/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% NextSelection : Run Tracker or export measurement

set(set_export_menu,'enable','on');
StateFlag == 2 ;

new_title=1;
if (exist('h_HeadTitle') == 0)
else
  if ishandle(h_HeadTitle)
	new_title=0;
  end
end

if new_title<=0
	set(h_HeadTitle, 'String','Defined simulation parameters. Next action::');
else
	h_HeadTitle = uicontrol('Parent',h_CommonWindow, ...
      'Units','points', ...
      'HorizontalAlignment','left', ...
      'ListboxTop',0, ...
      'Position',[1.1/12*cwsz(3) 9.3/10*cwsz(4) cwsz(3)/2 10], ...
      'BackgroundColor',FrameBackColor, ...
      'Style','text', ...
      'String','Defined simulation parameters. Next action::',... 
	'FontWeight', 'bold', ... 
      'Tag','StaticText2');
end

h_RadioButton1 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'Callback',['set(h_RadioButton1,''Value'',1);',...
      'set(h_RadioButton2,''Value'',0);',...
      'set(h_RadioButton3,''Value'',0);',...
      'set(h_RadioButton4,''Value'',0);',...
      'set(h_RadioButton5,''Value'',0);',...
      'NextSelectionFlag = 1;'],...
   'ListboxTop',0, ...
	'BackgroundColor',FrameBackColor, ...
    'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+ fwsz(4)*8/10 fwsz(3)*8/10 15], ...
	'String','Define tracker', ...
   'Style','radiobutton', ...
   'Value',0,...
	'Tag','Radiobutton1');

h_RadioButton2 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
   'Callback',['set(h_RadioButton1,''Value'',0);',...
      'set(h_RadioButton2,''Value'',1);',...
      'set(h_RadioButton3,''value'',0);',...
      'set(h_RadioButton4,''Value'',0);',...
      'set(h_RadioButton5,''Value'',0);',...
      'NextSelectionFlag = 2;'],...
   'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+ fwsz(4)*(8/10-1/6.5) fwsz(3)*8/10 15], ...
  	'BackgroundColor',FrameBackColor, ...
	'String','Export system state to an external file', ...
	'Style','radiobutton', ...
	'Tag','Radiobutton2', ...
	'Value',0);

h_RadioButton3 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
   'Callback',['set(h_RadioButton1,''Value'',0);',...
      'set(h_RadioButton2,''Value'',0);',...
      'set(h_RadioButton3,''Value'',1);',...
      'set(h_RadioButton4,''Value'',0);',...
      'set(h_RadioButton5,''Value'',0);',...
      'NextSelectionFlag = 3;'],...
   'ListboxTop',0, ...
   'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+ fwsz(4)*(8/10-2/6.5) fwsz(3)*8/10 15], ...
  	'BackgroundColor',FrameBackColor, ...
	'String','Generate/export ground truth to an external file', ...
	'Style','radiobutton', ...
	'Tag','Radiobutton3', ...
   'Value',0);

h_RadioButton4 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'Callback',['set(h_RadioButton1,''Value'',0);',...
      'set(h_RadioButton2,''Value'',0);',...
      'set(h_RadioButton3,''Value'',0);',...
      'set(h_RadioButton4,''Value'',1);',...
      'set(h_RadioButton5,''Value'',0);',...
      'NextSelectionFlag = 4;'],...
  	'BackgroundColor',FrameBackColor, ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+ fwsz(4)*(8/10-3/6.5) fwsz(3)*8/10 15], ...
	'String','Generate/export measurements to an external file', ...
	'Style','radiobutton', ...
	'Tag','Radiobutton4');

h_RadioButton5 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'Callback',['set(h_RadioButton1,''Value'',0);',...
      'set(h_RadioButton2,''Value'',0);',...
      'set(h_RadioButton3,''Value'',0);',...
      'set(h_RadioButton4,''Value'',0);',...
      'set(h_RadioButton5,''Value'',1);',...
      'NextSelectionFlag = 5;'],...
  	'BackgroundColor',FrameBackColor, ...
	'ListboxTop',0, ...
      'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+ fwsz(4)*(8/10-4/6.5) fwsz(3)*8/10 15], ...
	'String','Perform sensitivity analysis', ...
	'Style','radiobutton', ...
	'Tag','Radiobutton5');

help_string=['Select the next action and press ''Next >>'' to' ...
      ' continue. You can define the tracker to use for estimation,',...
      ' export the measurements to an external file,',...
      ' export the ground truth and system state to an external file,',...
      ' or proceed to carry out sensitity analysis on the system (see Section 5.6 in the book).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];

set(h_About,'String',help_string, 'enable', 'inactive');

%  if from external ground truth, can not do external system states
if SimulationFlag == 3 
   set(h_RadioButton2,'enable','off');
   set(h_RadioButton3,'string','Export truth to an external file');
   set(h_RadioButton5,'enable','off');
end

% if from external measurement, can not do sensitivity analysis
if SimulationFlag == 4
   set(h_RadioButton2,'enable','off');
   set(h_RadioButton3,'enable','off');
   set(h_RadioButton5,'enable','off');
   set(h_RadioButton4,'string','Export measurements to an external file');
end

if NewFlag == OpenPrj
   set(h_RadioButton5,'enable','off');
end

if SystemModelFlag ~= 1 
   set(h_RadioButton5,'enable','off');
end

if nmt > 1 
   %if ~isempty( find ([ModeSystem{:,9}] == 3) ) | ~isempty( find ([ModeSystem{:,9}] == 2) );
       set(h_RadioButton5,'enable','off');
       %end
end

if NextSelectionFlag == 1
   set(h_RadioButton1,'value',1);
elseif NextSelectionFlag == 2
   set(h_RadioButton2,'value',1);
elseif NextSelectionFlag == 3
   set(h_RadioButton3,'value',1);
elseif NextSelectionFlag == 4
   set(h_RadioButton4,'value',1);
elseif NextSelectionFlag == 5
   set(h_RadioButton5,'value',1);
end
   
   


   
