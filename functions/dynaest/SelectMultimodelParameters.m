%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%SelectMultimodelParameters, For IMM filter algorithm, select the number of model(nmf) and
% transition probability matrix type

% show title

if (exist('h_HeadTitle1') == 1)
  if ishandle(h_HeadTitle1)
	delete(h_HeadTitle1);
  end
end

new_title=1;
if exist('h_HeadTitle') 
  if ishandle(h_HeadTitle)
	new_title=0;
  end
end

if new_title ==0
	set(h_HeadTitle, 'String','IMM estimator parameters:');
else
	h_HeadTitle = uicontrol('Parent',h_CommonWindow, ...
      'Units','points', ...
      'HorizontalAlignment','left', ...
      'ListboxTop',0, ...
      'Position',[1.1/12*cwsz(3) 9.3/10*cwsz(4) cwsz(3)/2 10], ...
      'BackgroundColor',FrameBackColor, ...
      'Style','text', ...
      'String','IMM estimator parameters:',... 
	'FontWeight', 'bold', ... 
      'Tag','StaticText2');
end

h_HeadTitle1 = uicontrol('Parent',h_CommonWindow,...
   'Units','points',...
   'HorizontalAlignment','right', ...
   'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+ fwsz(4)*0.8 fwsz(3)*0.3 10], ...
   'String','Number of models:', ...
   'BackgroundColor',FrameBackColor,...
   'Style','text',...
   'Tag','StaticText1');

% show nmf
h_Edit = uicontrol('Parent',h_CommonWindow, ...
   'Units','points',...
   'HorizontalAlignment','left',...
   'Position',[fwsz(1)+fwsz(3)*0.45 fwsz(2)+ fwsz(4)*0.77 fwsz(3)*0.1 15], ...
  	'BackgroundColor',[1 1 1], ...
   'String',num2str(nmf),...
   'Style','edit',...
   'Tag','EditText2');

h_HeadTitle2 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'BackgroundColor',FrameBackColor, ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+ fwsz(4)*0.5 fwsz(3)*0.5 10], ...
	'String','Transition probability matrix type:', ...
	'Style','text', ...
	'Tag','StaticText2');


h_RadioButton1 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'Callback',['set(h_RadioButton1,''Value'',1);',...
      'set(h_RadioButton2,''Value'',0);',...
      'TransitionProbabilityFlag = 1;',...
      'StepNumber = 51121;'],...
	'BackgroundColor',FrameBackColor, ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+ fwsz(4)*0.35 fwsz(3)*0.5 15], ...
	'String','Fixed', ...
   'Style','radiobutton', ...
   'value',0,...
	'Tag','Radiobutton1');

h_RadioButton2 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
    'Callback',['set(h_RadioButton1,''Value'',0);',...
      'set(h_RadioButton2,''Value'',1);',...
      'TransitionProbabilityFlag = 2;',...
       'StepNumber = 550;'],...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+ fwsz(4)*0.2 fwsz(3)*0.5 15], ...
	'String','Adaptive (depends on sojourn times)', ...
	'BackgroundColor',FrameBackColor, ...
   'Style','radiobutton', ...
   'value',0,...
	'Tag','Radiobutton2');

if exist('TransitionProbabilityFlag','var') == 0
   TransitionProbabilityFlag = 1;
end

if TransitionProbabilityFlag == 1
   set(h_RadioButton1,'value',1);
   StepNumber = 51121;
elseif TransitionProbabilityFlag == 2
   set(h_RadioButton2,'value',1);
   StepNumber = 550;
end
if TrackerSetupFlag == 2 
   set(h_Edit,'enable','off');         
   switch TransitionProbabilityFlag
   case 1
      set(h_RadioButton2,'enable','off');         
      set(h_RadioButton1,'value',1);
      StepNumber = 51121;
   case 2
      set(h_RadioButton1,'enable','off');         
      set(h_RadioButton2,'value',1);
      StepNumber = 550;
   end
end



   
   
   
   
   
help_string=['In this window, you can set the parameters for the IMM estimator.', char(10), char(10), 'First, select the number of models in the IMM estimator. Also select how the values of the mode transition probability matrix are defined. If they are fixed, select ''Fixed transition probability matrix''. Alternatively, if they are evaluated based on the revisit interval and the sojourn times of the models in the estimator, select ''Depends on sojourn times''. In this case, the mode transition probability matrix is modified at each revisit.', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''Close'' to abort the estimator definition.'];

set(h_About,'String',help_string, 'enable', 'inactive');


