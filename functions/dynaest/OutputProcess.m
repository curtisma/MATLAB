%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%OutputProcess :  Output the state estimation results 

colordef none;

% select one trajectory to view
if ResultFlag == 1
   if exist('CurrentTrajectory','var') == 0
      errordlg('Can''t be occured : Output Process') ;
      CurrentTrajectory = 1;
   end
   Answer{1} = num2str(CurrentTrajectory);
   Answer  = inputdlg('From which run do you want to view the trajectories?',...
      'Select Trajectory',1,Answer);
   if isempty(Answer)
      return;
   end
   
   CurrentTrajectory = str2num(Answer{1});
   if CurrentTrajectory > nrun
      CurrentTrajectory = nrun;
   elseif CurrentTrajectory < 1
      CurrentTrajectory = 1;
   end
   
   if CurrentTrajectory < nrun
      temp = sprintf('&Next Trajectory(%d)',CurrentTrajectory+1);
      set(h_NextTrajectory,'label',temp);
      clear temp ;
      set(h_NextTrajectory,'enable','on');
   else 
      temp = sprintf('&Next Trajectory') ;
      set(h_NextTrajectory,'label',temp);
      clear temp ;
      set(h_NextTrajectory,'enable','off');
   end
   
   if CurrentTrajectory > 1
      temp = sprintf('&Previous Trajectory(%d)',CurrentTrajectory-1);
      set(h_PrevTrajectory,'label',temp);
      clear temp ;   
      set(h_PrevTrajectory,'enable','on');
   else
      temp = sprintf('&Previous Trajectory');
      set(h_PrevTrajectory,'label',temp);
      clear temp ;   
      set(h_PrevTrajectory,'enable','off');
   end
end

if(FigureCheck)
   % create a new figure
   SubFigureNumber = SubFigureNumber + 1 ;
   if NewFlag == OpenPrj | NewFlag == SavePrj 
      h_SubFigure(SubFigureNumber) = figure('NumberTitle','off', ...
         'name',['DynaEst 3.3: ',Project_Filename]);
   else
      h_SubFigure(SubFigureNumber)= figure('NumberTitle','off', ...
         'name','DynaEst 3.3: Untitled.prj');
   end
else
   figure(h_MainWindow);
end

switch ResultFlag
case 1,
   ViewTrajectories;
case 2,
   ViewRMSPosition;
case 3,
   ViewRMSVelocity;
case 4,
   ViewModelProbability;
case 5,
   ViewFilterGain;
case 6,
   ViewNEES;
case 7,
   ViewNIS;
end

