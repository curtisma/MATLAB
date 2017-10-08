%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% SelectMeasurement, select a measurement filename to export measurement

set(h_HeadTitle, 'String','Measurement export file:');

h_Filename1 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)/6 fwsz(2)+fwsz(4)*1.2/2 fwsz(3)*0.6 fwsz(4)*0.15], ...
	'String',Project_Measurement_Filename, ...
	'Style','edit', ...
	'Tag','EditText2');

h_Browse1 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
   'ListboxTop',0, ...
   'Position',[fwsz(1)+fwsz(3)*2/5 fwsz(2)+fwsz(4)/4 fwsz(3)*0.2 fwsz(4)*0.15], ...
   'String','Browse', ...
   'CallBack', [...
      '[filename pathname] = uiputfile(''*.mes'',''Measurement Export File'');',...
      'if filename ',...
      'Project_Measurement_Filename = [pathname,filename];',...
      'set(h_Filename1,''String'',Project_Measurement_Filename);',...
   	 'end'],...
	'Tag','Pushbutton7');

help_string=['In this window, you can select the file to which the measurements are exported.', char(10), char(10), 'Click on ''Browise'' to select the export file.', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''Close'' to abort the export.'];

set(h_About,'String',help_string, 'enable', 'inactive');