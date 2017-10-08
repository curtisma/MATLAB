%%% DynaEst 3.032 11/26/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
% SetupProcess

if exist('h_CommonWindow')
   figure(h_CommonWindow)
   delete(h_CommonWindow) ;
   clear h_CommonWindow ;
end

switch SetupNumber 
case 1
   StepNumber = 1111 ;
   CommonWindow ;
   DataResource ;
   set(set_export_menu,'Enable','off');
case 2
   CommonWindow ;
   StepNumber = 51 ;
   NextSelection ;
   set(set_monte_menu,'Enable','off');
   set(simu_montecarlo_menu,'Enable','off');
case 3
   CommonWindow ;
   MonteSelection ;
case 4
   StepNumber = 1000 ;
   ExamineResults ;
   
case 5
   ButtonName = questdlg(['Number of Monte Carlo runs is ',num2str(nrun),'. Do you want to continue with these runs?'],...
      'Monte Carlo Runs','Yes','No','Yes');
   if strcmp(ButtonName,'Yes')
      DoMonteCarlo;
   end
end

   
   
   