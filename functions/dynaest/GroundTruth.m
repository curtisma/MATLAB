%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% GroundTruth  Show Ground Truth Window, and Set System Parameters

load GroundTruth

% default selection is Read From file to setup Ground Truth
% if has not been setup , this value is -1;
rec(1) = 1; 

h0 = figure('Units','points', ...
	'Color',[0.8 0.8 0.8], ...
	'Colormap',mat0, ...
	'Name','Set Up Dynamic Ground Truth', ...
	'NumberTitle','off', ...
	'PointerShapeCData',mat1, ...
	'Position',[137 91 435 310], ...
	'Tag','Fig2');
h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
   'Callback',[' Close(''Set Up Dynamic Ground Truth''); FilterAlgorithm; ',...
      'if rec(1) == 1 SetupSystemFromFile; ',...
      'else', ...
      ' msgbox(''Step by step setup has not been finished'', ''Sorry'');',...
      'end'],...
	'ListboxTop',0, ...
	'Position',[333 270.75 69 22.5], ...
	'String','Next >>', ...
	'Tag','Pushbutton1');
h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'Callback','Close(''Set Up Dynamic Ground Truth''); Start;', ...
	'ListboxTop',0, ...
	'Position',[333 230.25 69 22.5], ...
	'String','<< Prev', ...
	'Tag','Pushbutton2');
% $$$ h1 = uicontrol('Parent',h0, ...
% $$$ 	'Units','points', ...
% $$$ 	'Callback','Close(''Set Up Dynamic Ground Truth''); Start;', ...
% $$$ 	'ListboxTop',0, ...
% $$$ 	'Position',[333 187.5 69 22.5], ...
% $$$ 	'String','Reset', ...
% $$$ 	'Tag','Pushbutton3');
% $$$ h1 = uicontrol('Parent',h0, ...
% $$$ 	'Units','points', ...
% $$$ 	'ListboxTop',0, ...
% $$$ 	'Position',[333 148.5 69 22.5], ...
% $$$ 	'String','Auto Play', ...
% $$$ 	'Tag','Pushbutton4');
% $$$ h1 = uicontrol('Parent',h0, ...
% $$$ 	'Units','points', ...
% $$$ 	'ListboxTop',0, ...
% $$$ 	'Position',[333 64.5 69 22.5], ...
% $$$ 	'String','Info', ...
% $$$ 	'Tag','Pushbutton5');
h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'Callback','Close(''Set Up Dynamic Ground Truth''); end;', ...
	'ListboxTop',0, ...
	'Position',[333 23.25 69 22.5], ...
	'String','Close', ...
	'Tag','Pushbutton6');
h_Edit = uicontrol('Parent',h0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[33 22.5 277.5 114.75], ...
	'String','About Dynamic System Set Up....', ...
   'Style','edit', ...
   'Max',100,...
  	'Tag','EditText1');
h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'ListboxTop',0, ...
	'Position',[33.75 157.5 273 137.25], ...
	'Style','frame', ...
	'Tag','Frame1');
h_RadioButton1 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'ListboxTop',0, ...
	'Position',[64.5 257.25 153 21], ...
	'String','Set Up Step By Step', ...
   'Style','radiobutton', ...
   'CallBack', 'set(h_RadioButton2,''value'',0); set(h_RadioButton1,''Value'',1); rec(1) = 2;',...
   'Tag','Radiobutton1');
h_RadioButton2 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'ListboxTop',0, ...
	'Position',[65.25 219 118.5 15], ...
   'String','Use Store File to Set Up', ...
   'Style','radiobutton', ...
   'CallBack', 'set(h_RadioButton1,''Value'',0); set(h_RadioButton2,''Value'',1); rec(1) = 1;',...
	'Tag','Radiobutton2', ...
	'Value',1);
h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'ListboxTop',0, ...
	'Position',[83.25 195 60 19.5], ...
	'String','FileName:', ...
	'Style','text', ...
	'Tag','StaticText1');
h_filename = uicontrol('Parent',h0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[136.5 199.5 73.5 15], ...
	'String','sysinp.m', ...
	'Style','edit', ...
	'Tag','EditText2');
h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'ListboxTop',0, ...
	'Position',[240.75 196.5 52.5 18.75], ...
   'String','Browse', ...
   'CallBack', [...
      '[filename pathname] = uigetfile(''*.*'',''Choose a Parameter File for Dynamic System'');',...
      'set(h_filename,''String'',filename);'],...
   'Tag','Pushbutton7');
h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'ListboxTop',0, ...
	'Position',[170.25 166.5 52.5 18.75], ...
   'String','View', ...
   'CallBack','SetupSystemFromFile; ViewSys; ',...
	'Tag','Pushbutton8');

