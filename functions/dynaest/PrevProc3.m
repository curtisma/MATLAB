%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% PrevProc3

switch StepNumber
case {51} % back to show Rt
   
   delete(h_RadioButton1); 
   delete(h_RadioButton2); 
   delete(h_RadioButton3);
   delete(h_RadioButton4);
   delete(h_RadioButton5);
   set(set_export_menu,'enable','off');
   
   if SimulationFlag == 4 % measurement come from external 
      StepNumber = 1221;
      SelectImportMeasurement;
      return;
   end
   
   MatrixWindow;
   
   if SimulationFlag == 3 % truth come from external file
      StepNumber = 403 ;
      set(h_NameOfMatrix,'string','Rt:');
      set(h_ValueOfMatrix,'string',Rtstr);
      set(h_HeadTitle, 'String','Simulation parameters (cont''d):');
      help_string=['Specify the true covariance matrix Rt of the measurement noise (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
      set(h_About,'String',help_string, 'enable', 'inactive');
   else
      if nmt == 1 % single mode case
         StepNumber = 47;
      else % multi_model case
         mode = nmt;
         ModeString = GetModeString(mode);
         StepNumber = 87;
      end
      % show xt0
      set(h_NameOfMatrix,'string','xt(0):');
      set(h_ValueOfMatrix,'string',num2str(xt0));
      set(h_HeadTitle, 'String','Simulation parameters (cont''d):');
      help_string=['Specify the true initial state vector xt(0).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
      set(h_About,'String',help_string, 'enable', 'inactive');
   end
   
case {511,512} % back to Next Selection(Design Tracker / Export Measurement)
   
   %  delete(h_HeadTitle);
   delete(h_RadioButton1); 
   delete(h_RadioButton2); 
         
   % Next Selection 
   StepNumber = 51 ; 
   NextSelection;
   
case {515}
    
   if ishandle(h_Edit1) delete(h_Edit1); end
   if ishandle(h_Edit2) delete(h_Edit2); end
   if ishandle(h_Edit3) delete(h_Edit3); end
   if ishandle(h_Edit4) delete(h_Edit4); end
   if ishandle(h_Edit5) delete(h_Edit5); end
   
   if ishandle(h_Text1) delete(h_Text1); end
   if ishandle(h_Text2) delete(h_Text2); end
   if ishandle(h_Text3) delete(h_Text3); end
   if ishandle(h_Text4) delete(h_Text4); end
   if ishandle(h_Text5) delete(h_Text5); end
   
   clear h_Edit1 h_Edit2 h_Edit3 h_Edit4 h_Edit5 
   clear h_Text1 h_Text2 h_Text3 h_Text4 h_Text5 

   switch TrackerSetupFlag 
   case 1
      StepNumber = 511 ;
      DesignTracker  ;
   case 2
      StepNumber = 5121 ;
      SelectImportFilter ;
   end
      
case 516
    
   delete(h_RadioButton1); 
   delete(h_RadioButton2); 
   delete(h_RadioButton3); 
   delete(h_Edit1); 
   delete(h_Text1); 
   
   StepNumber = 515 ;
   FilterIni1 ;
   
case {521,523,525}
%   delete(h_HeadTitle);
   delete(h_Filename1);
   delete(h_Browse1);
   
   % Next Selection 
   StepNumber = 51 ; 
   NextSelection;
   
case {541,542,543,544} % back from sensitivity analysis to next selection
   %delete(h_HeadTitle);
   delete(h_RadioButton1);
   delete(h_RadioButton2);
   delete(h_RadioButton3);
   delete(h_RadioButton4);
   
   % next selection
   StepNumber = 51 ; 
   NextSelection;

case {5111,5112,5113,5114}% From Tracker Type to Desigh Tracker
   % delete previous controls
   if TrackerSetupFlag == 2
      delete(h_HeadTitle); 
   end
   delete(h_RadioButton1);
   delete(h_RadioButton2);
   delete(h_RadioButton3);
   delete(h_RadioButton4);
   
   StepNumber = 516 ;
   DefineFilter ;
   
   
case 51121,
   delete(h_HeadTitle1);
   delete(h_Edit);
   delete(h_HeadTitle2);
   delete(h_RadioButton1);
   delete(h_RadioButton2);

   % select tracker type

   TrackerType;
case 51122,
   delete(h_NameOfMatrix);
   delete(h_ValueOfMatrix);

   % select multimodel parameter: nmf and Transition probability matrix

   SelectMultimodelParameters;
case 5121, % back from select Filter external filename to DesignTracker;
           % TrackerSetupFlag = 2;   
   % delete previous controls
   delete(h_HeadTitle1); 
   new_title = 1 ;
   
   delete(h_Filename1);
   delete(h_Browse1);
   
   StepNumber = 512;
   
   % show design Tracker window
   DesignTracker;
case 5421, % back from Reduced Order Model Matrix window to Sensitiviy Analysis
   delete(h_Text1);
   delete(h_Edit1);
   StepNumber = 542;
   SensitivityAnalysis;   
   
case 5441, % back from Fixed Filter Gain window to Sensitiviy Analysis
   delete(h_NameOfMatrix);
   delete(h_ValueOfMatrix);
   StepNumber = 544;
   SensitivityAnalysis;   
    
end
