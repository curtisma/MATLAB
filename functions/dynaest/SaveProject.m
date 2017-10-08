%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%SaveProject , Save Current Project File 

NewFlag = SavePrj ;
if isempty(Project_Filename)
   [filename pathname] = uiputfile('*.prj','Save Project File');
else
   [filename pathname] = uiputfile(Project_Filename,'Save Project File');
end

if filename == 0 return; end;

if isempty(findstr(filename,'.')) 
   filename = [filename,'.prj'];
end

Project_Filename = [pathname,filename];
if exist('h_CommonWindow')
   if ishandle(h_CommonWindow)
      set(h_CommonWindow,'name',['Project: ',Project_Filename]); 
   end
end

set(h_MainWindow,'name',['Dynaest 3.0: ',Project_Filename]);

%NewFlag = 0;

save ~temp;

v = version;
v = v(1:3);

if v == 5.1
   str = 'copy ~temp.mat';
   str = sprintf('dos(''%s %s'');',str,Project_Filename);
   eval(str);
   return;
end

[status massage] = copyfile('~temp.mat',Project_Filename);
if status == 0
   msgbox(massage,'Error in saving project file');
end


