%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% AboutDialog, show the about dialog

h_AboutDialog = dialog('Units','points', ...
	'Color',[0.8 0.8 0.8], ...
	'Colormap',mat0, ...
	'Name','About', ...
	'NumberTitle','off', ...
	'PointerShapeCData',mat1, ...
	'Position',[300 300 210 110], ...
	'Tag','Fig2');

uicontrol('Parent',h_AboutDialog, ...
   'Units','points', ...
   'ListboxTop',0, ...
   'Position',[80 7 36 16], ...
   'String','OK', ...
   'callback','close(''About'');',...
   'Tag','Pushbutton1');

uicontrol('Parent',h_AboutDialog, ...
	'Units','points', ...
	'BackgroundColor',[0.8 0.8 0.8], ...
	'FontWeight','bold', ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[9 77 137 16], ...
	'String',['DynaEst ', DYNAEST_VERSION], ...
	'Style','text', ...
	'Tag','StaticText1');
uicontrol('Parent',h_AboutDialog, ...
	'Units','points', ...
	'BackgroundColor',[0.8 0.8 0.8], ...
	'FontWeight','bold', ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[9 57 137 16], ...
	'String',['Last modified on ', DYNAEST_DATE], ...
	'Style','text', ...
	'Tag','StaticText1');
uicontrol('Parent',h_AboutDialog, ...
	'Units','points', ...
	'BackgroundColor',[0.8 0.8 0.8], ...
	'FontWeight','bold', ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[9 37 187 16], ...
	'String',['Copyright (c) ', DYNAEST_DATE(length(DYNAEST_DATE)-3:length(DYNAEST_DATE)), ' Yaakov Bar-Shalom'], ...
	'Style','text', ...
	'Tag','StaticText1');
