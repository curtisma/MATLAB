%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% NextProc3 , Handle next message after the matrix has been inputed.

switch StepNumber
   
case 51
   % To design Tracker
   %delete(h_HeadTitle);
   delete(h_RadioButton1);
   delete(h_RadioButton2);
   delete(h_RadioButton3);
   delete(h_RadioButton4);
   delete(h_RadioButton5);
   
   switch NextSelectionFlag 
   case 1 
      % if select Design Tracker , then sensitivity flag is -1
      SensitivityFlag = -1;
      DesignTracker;
   case 2
      % select system state filename to export
      StepNumber = 521 ;
      SelectExportState ;
   case 3
      % select system data filename to export
      StepNumber = 523;
      SelectExportTruth;
   case 4
      % select measurement filename to export
      StepNumber = 525;
      SelectExportMeasurement;
   case 5
      % sensitivity Analysis
      SensitivityAnalysis;
   end
   
case 521 % select system state filename
   
   Project_State_Filename = get(h_Filename1,'string');
   % if do not exist this file
   if isempty(Project_State_Filename)
      msgbox('Please input filename. ','Instruction');
      return;
   end
   
   %delete(h_HeadTitle);
   delete(h_Filename1);
   delete(h_Browse1);
   ExportState;
   % return to next selection
   StepNumber = 51 ; 
   NextSelection;

case 523% select system data filename
   
   Project_Truth_Filename = get(h_Filename1,'string');
   % if do not exist this file
   if isempty(Project_Truth_Filename)
      msgbox('Please input filename. ','Instruction');
      return;
   end
   
   %delete(h_HeadTitle);
   delete(h_Filename1);
   delete(h_Browse1);
   ExportTruth;
   % return to next selection
   StepNumber = 51 ; 
   NextSelection;
   
case 525% select measurement filename
   
   Project_Measurement_Filename = get(h_Filename1,'string');
   % if is empty
   if isempty(Project_Measurement_Filename)
      msgbox('Please input filename. ','Instruction');
      return;
   end
   
   %delete(h_HeadTitle);
   delete(h_Filename1);
   delete(h_Browse1);
   
   ExportMeasurement;
   % return to Next Selection
   StepNumber = 51 ; 
   NextSelection;
   
case 511, % interactive setup Tracker
    
   %delete(h_HeadTitle);
   delete(h_RadioButton1);
   delete(h_RadioButton2);
   
   StepNumber =515 ;
   % Define Filter Type      
   InitialFilterParameters ;
   if NewFlag == OpenPrj 
      load ~temp.mat nxf nvf nzf nwf omegaf ;
   end
   FilterIni1 ;
   
case 515
   str = get(h_Edit1,'string');
   nxf = str2num(str);
   str = get(h_Edit2,'string');
   nvf = str2num(str);
   str = get(h_Edit3,'string');
   nzf = str2num(str);
   str = get(h_Edit4,'string');
   nwf = str2num(str);
   str = get(h_Edit5,'string');
   ncoor = str2num(str);

   if CheckParameters(nxf,nzf,ncoor,1) 
       return ;
   end

   ClearInitials ;  
   StepNumber = 516 ;
   DefineFilter;
      
case 516 
   
   str = get(h_Edit1,'string');
   omegaf = str2num(str);
          
   delete(h_RadioButton1);
   delete(h_RadioButton2);
   delete(h_RadioButton3);
   delete(h_Text1) ;
   delete(h_Edit1) ;
   TrackerType ;
   
case 512 % read filter from external file
   
   %delete(h_HeadTitle);
   delete(h_RadioButton1);
   delete(h_RadioButton2);
   
   StepNumber = 5121;
   SelectImportFilter;
        
case 5121 % select filter external filename
   
   Project_Filter_Filename= get(h_Filename1,'string');
   % if do not exist this file
   if isempty(Project_Filter_Filename)
      msgbox('Please input Filter definition filename(i.e KalmanDef.mat)','Instruction');
      return;
   end
   
   if exist(Project_Filter_Filename,'file') == 0
      msgbox('Can not find data file. Please check file name.','Status');
      return;
   end
   
   % delete head title ,and 2 radiobuttons
   delete(h_HeadTitle1); 
   delete(h_Filename1); 
   delete(h_Browse1); 
   
   load(Project_Filter_Filename);

   msgbox('External Filter file has been read successfully.','status');
   
   set(set_monte_menu,'Enable','on');

   StepNumber = 515 ;
   % FilterIni1
   FilterIni1 ;
   
case {5111,5113,5114} % input parameters for Kalman filter, alpha-beta, alpha-beta-gamma filter
   
   % InitialFilter1 : Ffstr Gfstr Hfstr Ifstr Qfstr Rfstr vmf wmf x0 P0 at TrackerSetupFlag = 1 
   if TrackerSetupFlag == 1 
      DefaultKalmanParameters;
      if NewFlag == OpenPrj
         load ~temp.mat Ffstr Gfstr Hfstr Ifstr Qfstr Rfstr vmf wmf x0 P0
      end
   end
   
   % delete previous controls
   %delete(h_HeadTitle);
   delete(h_RadioButton1);
   delete(h_RadioButton2);
   delete(h_RadioButton3);
   delete(h_RadioButton4);
   
if (exist('h_HeadTitle1') == 1)  % from where title1 ?????????????
  if ishandle(h_HeadTitle1)
	delete(h_HeadTitle1);
  end
end
   
   MatrixWindow;
   
   % Input Matrix Ff
   StepNumber = 61;
   set(h_NameOfMatrix,'string','Ff:');
   set(h_ValueOfMatrix,'string',Ffstr);
   
   if FilterModelFlag ~= 1
      set(h_ValueOfMatrix,'Enable','Off');
   end
   
   % About information
   set(h_HeadTitle, 'String','Tracker parameters (cont''d):');
   help_string=['Specify the filter system matrix Ff (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');

case 5112, % input parameters for IMM
   
   % Initialfilter2 : nmf at TrackerSetupFlag = 1 
   if TrackerSetupFlag == 1 
      nmf = 2 ; 
      if NewFlag == OpenPrj
         load ~temp.mat nmf ;
      end
   end

   % delete previous controls
   % delete(h_HeadTitle);
   delete(h_RadioButton1);
   delete(h_RadioButton2);
   delete(h_RadioButton3);
   delete(h_RadioButton4);
   
   % select multimodel parameter: nmf and Transition probability matrix
   SelectMultimodelParameters;
   
case 51121 % fixed Transition Probability Matrix
   
   % Get nmf from Edit
   str = get(h_Edit,'string');
   nmf = str2num(str);
    if nmf > 4 | nmf < 2 
      errordlg('The number of models of IMM should be 2, 3, or 4.','Error');
      return;
   end
   
   %Initialfilter3 : TransPr modePr0 Ffstr Gfstr Hfstr Ifstr Qfstr Rfstr vmf wmf x0 P0 at TrackerSetupFlag = 1 
   if TrackerSetupFlag == 1 
      DefaultIMMParameters ;
      if NewFlag == OpenPrj
         load ~temp.mat Ffstr Gfstr Hfstr Ifstr Qfstr Rfstr vmf wmf x0 P0 ;
         load ~temp.mat TransPr modePr0 ;
         load ~temp.mat modeFfstr modeGfstr modeHfstr modeIfstr modeQfstr modeRfstr modevmf modewmf modex0 modeP0 
      end
   end
   
   delete(h_HeadTitle1);
   delete(h_Edit);
   delete(h_HeadTitle2);
   delete(h_RadioButton1);
   delete(h_RadioButton2);
   
   MatrixWindow;
      
   StepNumber = 51122;
   
   set(h_NameOfMatrix,'string','Transition probability matrix:');
   set(h_ValueOfMatrix,'string',num2str(TransPr));
   help_string=['In this window, you can values in the fixed mode transition probability matrix.', char(10), char(10), 'Make sure that the row sum is 1.0.', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''Close'' to abort the tracker definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case 51122,
   
   % Get Transition Probability Matrix
   str = get(h_ValueOfMatrix,'string');
   TransPr = str2num(str);
   
   delete(h_NameOfMatrix);
   delete(h_ValueOfMatrix);
      
   StepNumber = 70;
   mode = 1;
   ModeSelection;
   
case 541, % input parameters for Kalman filter
   
   %load default Kalman filter parameter
   FilterAlgorithmFlag = ALGORITHM_KALMAN;
   InitialFilterParameters ;
   DefaultKalmanParameters;
   % delete previous controls
   %delete(h_HeadTitle);
   delete(h_RadioButton1);
   delete(h_RadioButton2);
   delete(h_RadioButton3);
   delete(h_RadioButton4); 
   if (exist('h_HeadTitle1') == 1)
      if ishandle(h_HeadTitle1)
         delete(h_HeadTitle1);
      end
   end   

   MatrixWindow;
   
   % Input Matrix Ff
   StepNumber = 61;
   set(h_NameOfMatrix,'string','Ff:');
   set(h_ValueOfMatrix,'string',Ffstr);
   
   set(h_HeadTitle, 'String','Tracker parameters (cont''d):');
   help_string=['Specify the filter system matrix Ff (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case 542,% Reduced Order model
   %load default Kalman filter parameter
   FilterAlgorithmFlag = ALGORITHM_KALMAN;

   % delete previous controls
   %delete(h_HeadTitle);
   delete(h_RadioButton1);
   delete(h_RadioButton2);
   delete(h_RadioButton3);
   delete(h_RadioButton4);
   
   StepNumber = 5421;
   % input size of reduced model nr
   SizeOfReducedModel;
   
case 5421, % 
   
   % Get Reduced Order Model matrix
   str = get(h_Edit1,'string');
   nr = str2num(str);
   if nr > nx
      msgbox('Dimension of the reduced order filter state cannot be greater than that of actual state.','Error');
      return;
   end
   
   % delete previous controls
   delete(h_Text1);
   delete(h_Edit1);
   
   % Generate Tx
   Tx = eye(nr,nx);
   nxf = nr ;
   % Generate default filter parameters of reduced order model 
   DefaultReducedKalmanParameters;
      
   % Input Matrix Ff
   StepNumber = 61;
   
   if (exist('h_HeadTitle1') == 1)
      if ishandle(h_HeadTitle1)
         delete(h_HeadTitle1);
      end
   end
   
   MatrixWindow;
   set(h_NameOfMatrix,'string','Ff:');
   set(h_ValueOfMatrix,'string',Ffstr);
   % About information
   set(h_HeadTitle, 'String','Tracker parameters (cont''d):');
   help_string=['Specify the filter system matrix Ff (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');

   
case 543,
   
   msgbox('Under Construction');   
   
case 544, % fixed filter gain 
   %load default Kalman filter parameter
   FilterAlgorithmFlag = ALGORITHM_KALMAN;

   % delete previous controls
   %delete(h_HeadTitle);
   delete(h_RadioButton1);
   delete(h_RadioButton2);
   delete(h_RadioButton3);
   delete(h_RadioButton4);
   
   % input filter gain 
   MatrixWindow;
   Wf = zeros(nx,nz);
   if nx == 4 & nz == 2
      Wf = [ 0.8 0;
             0.5 0;
             0   0.8;
             0   0.5];
   else
      Wf = 0.2*ones(nx,nz);
   end
   
   % Input Matrix Ff
   StepNumber = 5441;
   set(h_HeadTitle, 'String','Fixed gain sensitivity analysis:');
   set(h_NameOfMatrix,'string','Fixed filter gain Wf:');
   set(h_ValueOfMatrix,'string',num2str(Wf));
   help_string=['In this window, you can set the value of the fixed filter gain matrix to use for sensitivity analysis..', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''Close'' to abort the analysis.'];
   
   set(h_About,'String',help_string, 'enable', 'inactive');

case 5441, % input parameters for Kalman filter
   
   % Get Fixed Filter Gain Value
   str = get(h_ValueOfMatrix,'string');
   Wf = str2num(str);

   %load default Kalman filter parameter
   InitialFilterParameters ;
   DefaultKalmanParameters;
   
   % Input Matrix Ff
   StepNumber = 61;
   
   if (exist('h_HeadTitle1') == 1)
      if ishandle(h_HeadTitle1)
         delete(h_HeadTitle1);
      end
   end
   
   set(h_NameOfMatrix,'string','Ff:');
   set(h_ValueOfMatrix,'string',Ffstr);
   set(h_HeadTitle, 'String','Tracker parameters (cont''d):');
   
   help_string=['Specify the filter system matrix Ff (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
end

   
   


   
   

