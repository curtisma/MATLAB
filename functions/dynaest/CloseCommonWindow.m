%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% CloseCommonWindow, close CommonWindow 3.0 application.

DisableProjectMenu ;

ButtonName = questdlg('Do you want to save a current project file?',...
   'Close Project');
switch ButtonName 
case 'Yes',
   SaveProject;
case 'Cancel' 
   return;
end
if exist('h_CommonWindow')
   delete(h_CommonWindow) ;
   clear h_CommonWindow ;
end
clear ButtonName ;
set(h_MainWindow,'name','DynaEst 3.0: Untitled.prj');
