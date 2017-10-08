%%% DynaEst 3.032 11/27/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% CloseDynaest, close dynaest 3.0 application.

if exist('h_CommonWindow')
   figure(h_CommonWindow)
end
ButtonName = questdlg('Do you want to save a current project file?',...
   'Close Dynaest');
switch ButtonName 
case 'Yes',
   SaveProject;
case 'Cancel' 
   clear ButtonName ;
   return;
end
if exist('h_CommonWindow')
   delete(h_CommonWindow)
end
delete(h_MainWindow);

for i=1:SubFigureNumber 
   if ishandle(h_SubFigure(i))
      delete(h_SubFigure(i)) ;
   end
end

if exist('~temp.mat','file')
   delete ~temp.mat ;
end

clear all ;