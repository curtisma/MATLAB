	%%% DynaEst 3.032 01/16/2001
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% NextProc1: handle the message when 'Next' button pressed
% Handle steps before Matrix inputing

switch StepNumber
   
case 11
   clear ExternalZ ExternalTruth ExternalT;
   %% Will be updated later
   DisableProjectMenu ;
   EnableProjectMenu ;
   %%
   %  delete(h_HeadTitle); 
   delete(h_RadioButton1); 
   delete(h_RadioButton2); 
   delete(h_RadioButton3);    
   delete(h_RadioButton4); 
   % enable the Prev of DataResource
   set(h_Prev,'enable','on');
   
   % InitialSystem 1 : Tmin Tmax nx nv nz nw nrun nseed ncoor nmt kmax omega 
   InitialParameters ;
   if NewFlag == OpenPrj
      load ~temp.mat Tmin Tmax nx nv nz nw nrun nseed ncoor nmt kmax omega 
   end
   
   switch SimulationFlag 
   case 1 % system initialization 1
      %delete(h_HeadTitle); 
      StepNumber = 1111 ;
      SystemIni1;

   case 2 
      StepNumber = 1121; 
      SelectImportState; 
   case 3 
      StepNumber = 1131;
      SelectImportTruth;
   case 4
      % Select External Measurement file
      StepNumber = 1221;
      SelectImportMeasurement ;
   end
   
   
case 1111, % system initialization 2
   % get value of system initialize 1
   str = get(h_Edit1,'string');
   Tmin = str2num(str);
   str = get(h_Edit2,'string');
   Tmax = str2num(str);
   str = get(h_Edit3,'string');
   nx = str2num(str);
   str = get(h_Edit4,'string');
   nv = str2num(str);
   str = get(h_Edit5,'string');
   nz = str2num(str);
   str = get(h_Edit6,'string');
   nw = str2num(str);
   
   % check the relationship between Tmin and Tmax
   if Tmin > Tmax 
    errordlg('Tmin should be smaller than Tmax.','Error');
      return;
   end
   
   % system initialize 2
   StepNumber = 11111;
   delete(h_Text6) ;
   delete(h_Edit6) ;
   SystemIni2;
   
case 11111, % generate default truth 
   % Get value of system initialize 2
   str = get(h_Edit1,'string');
   nrun = str2num(str);
   str = get(h_Edit2,'string');
   nseed = str2num(str);
   str = get(h_Edit3,'string');
   ncoor = str2num(str);
   str = get(h_Edit4,'string');
   nmt = str2num(str);
   str = get(h_Edit5,'string');
   kmax = str2num(str);
   
   % Check the validity of the initial parameters 
   if CheckParameters(nx,nz,ncoor,nmt) 
      return ;
   end
   
   ClearInitials ; 
   
   if nmt == 1 
      StepNumber = 11112 ;
      DefineSystem ; 
      
   else
      %Initialsystem 4 : FromTime, ToTime at SimulationFlag == 1 and nmt > 1     
      if SimulationFlag == 1 
         FromTime = zeros(1,5);
         ToTime = 40*ones(1,5);
         % default value
         for i = 2:5
            FromTime(i) = ToTime(i-1);
            ToTime(i)= ToTime(i-1)+40;
         end   
         if NewFlag == OpenPrj
            load ~temp.mat FromTime ToTime ;
         end
      end
      MultiSystem;   
      StepNumber = 80;
   end
   
case 11112 ; % nmt == 1 
   str = get(h_Edit1,'string');
   omega = str2num(str);
   nxtemp = nx ;
   if SystemModelFlag == 3
      nx = 5 ;
      nv = 3 ;
   else if nxtemp == 5 & SystemModelFlag ~=3
           nx = 4 ;
           nv = 2 ;
       end
   end
   
   delete(h_RadioButton1); 
   delete(h_RadioButton2); 
   delete(h_RadioButton3);    
   delete(h_Text1) ;
   delete(h_Edit1) ;
   
   % InitialSystem2 : Ftstr Gtstr Qtstr vmt xt0 Htstr Itstr Rtstr wmt after Define interactively
   if SimulationFlag == 1 % | SimulationFlag == 2  
      clear Ftstr Gtstr Htstr Itstr Qtstr Rtstr xt0 vmt wmt ;
      % Fix system parameter for coordinated turn model 
      % generate default system model parameters
      [Ftstr,Gtstr,Qtstr,vmt] = GenerateProcessModel(SystemModelFlag, nx,nv,ncoor) ;
      [Htstr,Itstr,Rtstr,wmt] = GenerateObservationModel(SystemModelFlag, nx,nz,nw,ncoor) ;
      xt0 = InitialX(SystemModelFlag,nx,omega);
      if NewFlag == OpenPrj
         load ~temp.mat Ftstr Gtstr Qtstr vmt xt0 Htstr Itstr Rtstr wmt ;
      end
   end
   
   % Show Matrix Window
   MatrixWindow;
   
   % Input Matrix Ft
   StepNumber = 41;
   set(h_NameOfMatrix,'string','Ft:');
   set(h_ValueOfMatrix,'string',Ftstr);
   set(h_HeadTitle, 'String','Simulation parameters (cont''d):');
   help_string=['Specify the true system matrix Ft (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   if SystemModelFlag ~= 1
      set(h_ValueOfMatrix,'Enable','Off');
   end
      
case 1121, % select system state file
      
   Project_State_Filename= get(h_Filename1,'string');
   % if do not exist this file
   if isempty(Project_State_Filename)
      msgbox('Please input filename. ','Instruction');
      return;
   end
   
   if exist(Project_State_Filename,'file') == 0
      msgbox('Can not find data file. Please check file name.','Status');
      return;
   end
   
   delete(h_Filename1); 
   delete(h_Browse1); 
  
   load(Project_State_Filename);
   msgbox('External system file has been read successfully.','status');
   
   set(set_export_menu,'Enable','on')
   StepNumber = 1111;
   SystemIni1;
   
case 1131,% read external truth file
   Project_Truth_Filename= get(h_Filename1,'string');
   % if do not exist this file
   if isempty(Project_Truth_Filename)
      msgbox('Please input filename. ','Instruction');
      return;
   end
   
   if exist(Project_Truth_Filename,'file') == 0
      msgbox('Can not find data file. Please check file name.','Status');
      return;
   end
   
   % delete head title ,and 2 radiobuttons
   % delete(h_HeadTitle); 
   delete(h_Filename1); 
   delete(h_Browse1); 
   
   % Read External Ground Truth File
   ReadTruth;
   
   nmt = 1 ; % After reading external ground truth, system will be treated single mode system
   % if ground truth including the Nearly coordinated turn model
   if nx == 5 
      nv = 3 ;
      SystemModelFlag = 3 ;
   end
   
   StepNumber =  1132 ;
   SystemIni3 ;
   
case 1132
   
   str = get(h_Edit2,'string');
   nz = str2num(str);
   str = get(h_Edit3,'string');
   nw = str2num(str);
   str = get(h_Edit5,'string');
   ncoor = str2num(str);
   
   % Check the validity of the initial parameters 
   if CheckParameters(nx,nz,ncoor,1) 
      return ;
   end
   
   ClearInitials ; 
   if ishandle(h_Text6) delete(h_Text6); end
   if ishandle(h_Edit6) delete(h_Edit6); end

   
   % InitialSystem 3 :  vmt Htstr Itstr Rtstr wmt at SimulationFlag == 3 
   vmt=zeros(nv,1);            % bias of process noise 
   [Htstr,Itstr,Rtstr,wmt] = GenerateObservationModel(SystemModelFlag,nx,nz,nw,ncoor) ;         
   if NewFlag == OpenPrj
      load ~temp.mat vmt Htstr Itstr Rtstr wmt
   end
   
   % Show Matrix Window
   MatrixWindow;
   % Input Matrix Ht
   StepNumber = 401;
   set(h_NameOfMatrix,'string','Ht:');
   set(h_ValueOfMatrix,'string',Htstr);
   set(h_HeadTitle, 'String','Simulation parameters (cont''d):');
   help_string=['Specify the true state-to-measurement matrix Ht (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case 1221,   % Read measurement from external file

   Project_Measurement_Filename = get(h_Filename1,'string');
   % if do not exist this file
   if isempty(Project_Measurement_Filename)
      msgbox('Please input filename. ','Instruction');
      return;
   end
   
   if exist(Project_Measurement_Filename,'file') == 0
      msgbox('Can not find data file. Please check file name.','Status');
      return;
   end
   
   % delete preceeding controls
   delete(h_Filename1); 
   delete(h_Browse1); 
   
   % Read measurement from external file
   ReadMeasurement;
   
   % set next selection
   StepNumber = 51 ;
   NextSelection;
   
end

   


