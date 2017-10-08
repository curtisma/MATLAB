%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% NextTrajectory , show next trajectory

if(FigureCheck)
   % create a new figure
   if isempty(Project_Filename)
      figure('NumberTitle','off', ...
         'name','Dynaest 3.0: Untitled.prj');
   else
      figure('NumberTitle','off', ...
         'name',['Dynaest 3.0: ',Project_Filename]);
   end
else
   figure(h_MainWindow);
end

CurrentTrajectory = CurrentTrajectory + 1;

if CurrentTrajectory > nrun
   CurrentTrajectory = nrun;
elseif CurrentTrajectory < 1
   CurrentTrajectory = 1;
end
if CurrentTrajectory < nrun
   temp = sprintf('&Next Trajectory (%d)',CurrentTrajectory+1);
   set(h_NextTrajectory,'label',temp);
   clear temp ;
   set(h_NextTrajectory,'enable','on');
else 
   temp = sprintf('&Next Trajectory');
   set(h_NextTrajectory,'label',temp);
   clear temp ;
   set(h_NextTrajectory,'enable','off');
end
if CurrentTrajectory > 1
   temp = sprintf('&Previous Trajectory (%d)',CurrentTrajectory-1);
   set(h_PrevTrajectory,'label',temp);
   clear temp ;   
   set(h_PrevTrajectory,'enable','on');
else
   temp = sprintf('&Previous Trajectory');
   set(h_PrevTrajectory,'label',temp);
   clear temp ;   
   set(h_PrevTrajectory,'enable','off');
end
ViewTrajectories;

