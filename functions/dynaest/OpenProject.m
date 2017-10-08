%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% OpenProject Open a Project File
NewFlag = OpenPrj ;

if exist('h_CommonWindow')
   ButtonName = questdlg('Do you want to save a current project file?',...
      'Close Project');
   switch ButtonName 
   case 'Yes',
      SaveProject;
   case 'Cancel' 
      clear ButtonName ;
      return;
   end
   if exist('h_CommonWindow')
      delete(h_CommonWindow) ;
      clear h_CommonWindow ;
   end
   clear ButtonName ;
end

for i=1:SubFigureNumber 
   if ishandle(h_SubFigure(i))
      delete(h_SubFigure(i)) ;
   end
end
clear h ; 

[filename pathname] = uigetfile('*.prj','Choose a Project File to Open');

if filename == 0 return; end;

Project_Filename = [pathname,filename];

fid = fopen([pathname filename],'rt');
if fid == -1 errordlg('Can not open project file when Opening.'); end;

% copy project file to matlab.mat
[status massage] = copyfile(Project_Filename,'~temp.mat');
if ~status 
   errordlg(massage,'Open Project file error');
   return;
end

LoadTemp ;

DisableProjectMenu ; 
EnableProjectMenu ;

if StateFlag >= 3
   set(set_export_menu,'Enable','on');
end
if StateFlag >= 4 
   set(set_monte_menu,'Enable','on');
end
if StateFlag >= 5 
   set(view_result_menu,'Enable','on');
   set(view_legend_menu,'Enable','on');
   set(view_grid_menu,'Enable','on');
   set(view_zoomin_menu,'Enable','on');
   set(view_zoomout_menu,'Enable','on');
   set(view_redraw_menu,'Enable','on');
   set(view_clear_menu,'Enable','on');
   set(simu_montecarlo_menu,'Enable','on');
end

ClearScreen;

set(h_MainWindow,'name',['Dynaest 3.0: ',Project_Filename]);
CommonWindow ;
DataResource;


