%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% NextProc2, handle 'Next' button preseed message, Steps of inputting Matrix

switch StepNumber
case 41,
   % Get Matrix Ft from Edit
   Ftstr = get(h_ValueOfMatrix,'string');
   if SystemModelFlag ~= 1
      set(h_ValueOfMatrix,'Enable','On');
   end
   
   % show default Matrix Gt
   set(h_NameOfMatrix,'string','Gt:');
   set(h_ValueOfMatrix,'string',Gtstr);
   StepNumber = StepNumber + 1;
   set(h_HeadTitle, 'String','Simulation parameters (cont''d):');
   help_string=['Specify the true process noise gain matrix Gt (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
case 42,
   % Get Matrix Gt
   Gtstr = get(h_ValueOfMatrix,'string');
   % show Ht
   set(h_NameOfMatrix,'string','Ht:');
   set(h_ValueOfMatrix,'string',Htstr);
   StepNumber = StepNumber + 1;
   set(h_HeadTitle, 'String','Simulation parameters (cont''d):');
   help_string=['Specify the true state-to-measurement matrix Ht (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
case 43,
   % Get Ht
   Htstr = get(h_ValueOfMatrix,'string');
   % show It
   set(h_NameOfMatrix,'string','It:');
   set(h_ValueOfMatrix,'string',Itstr);
   StepNumber = StepNumber + 1;
   set(h_HeadTitle, 'String','Simulation parameters (cont''d):');
   help_string=['Specify the true measurement noise gain matrix It (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
case 44,
   % Get It
   Itstr = get(h_ValueOfMatrix,'string');
   % show Qt
   set(h_NameOfMatrix,'string','Qt:');
   set(h_ValueOfMatrix,'string',Qtstr);
   StepNumber = StepNumber + 1;
   set(h_HeadTitle, 'String','Simulation parameters (cont''d):');
   help_string=['Specify the true covariance matrix Qt of the process noise (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
case 45,
   % Get Qt
   Qtstr = get(h_ValueOfMatrix,'string');
   
   % show Rt
   set(h_NameOfMatrix,'string','Rt:');
   set(h_ValueOfMatrix,'string',Rtstr);
   if SimulationFlag == 3 
      % if external ground truth, no initial xt0
      StepNumber = 47 ;
   else
      StepNumber = StepNumber + 1;
   end
   set(h_HeadTitle, 'String','Simulation parameters (cont''d):');
   help_string=['Specify the true covariance matrix Rt of the measurement noise (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
case 46,
   % Get Rt
   Rtstr = get(h_ValueOfMatrix,'string');
   
   % show xt0
   set(h_NameOfMatrix,'string','xt(0):');
   set(h_ValueOfMatrix,'string',num2str(xt0));
   StepNumber = StepNumber + 1;
   set(h_HeadTitle, 'String','Simulation parameters (cont''d):');
   help_string=['Specify the true initial state vector xt(0).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
case 47,
   if SimulationFlag ~= 3 
      % Get xt0
      xt0 = str2num(get(h_ValueOfMatrix,'string'));
   else
       Rtstr = get(h_ValueOfMatrix,'string');
   end

   % Set Scenario is OK.
   delete(h_ValueOfMatrix);
   delete(h_NameOfMatrix);
   clear h_NameOfMatrix,h_ValueOfMatrix;
   
   StepNumber = 51 ;
   NextSelection;
   
   
case 401,
   % Get Ht
   Htstr = get(h_ValueOfMatrix,'string');
   % show It
   set(h_NameOfMatrix,'string','It:');
   set(h_ValueOfMatrix,'string',Itstr);
   StepNumber = StepNumber + 1;
   set(h_HeadTitle, 'String','Simulation parameters (cont''d):');
   help_string=['Specify the true measurement noise gain matrix It (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case 402,
   % Get It
   Itstr = get(h_ValueOfMatrix,'string');
   % show Rt
   
   set(h_NameOfMatrix,'string','Rt:');
   set(h_ValueOfMatrix,'string',Rtstr);

   StepNumber = StepNumber + 1;
   set(h_HeadTitle, 'String','Simulation parameters (cont''d):');
   help_string=['Specify the true covariance matrix Rt of the measurement noise (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case 403,
   Rtstr = get(h_ValueOfMatrix,'string');
   
   % Set Scenario is OK.
   delete(h_ValueOfMatrix);
   delete(h_NameOfMatrix);
   clear h_NameOfMatrix,h_ValueOfMatrix;
   
   StepNumber = 51 ;
   NextSelection;
   
case 80,
   % check input value ------------------------------------
   % ------------------------------------------------------
   
   % get input from edit
   GetFromAndToTime;
   
   for mode =1 : nmt-1 
      if ToTime(mode) ~= FromTime(mode+1)
         errordlg('Time should be continous.','error') ;
         return ;
      end
   end
   
   % check leg time
   CheckLegTime;
   if temp 
      errordlg('leg time error.','Error');
      return ;
   end
   clear temp ;
   
   ClearMultiSystem;
   
   % if nmt > 1, T will be fixed for all Monte Carlo runs and kmax will be decided by the T and Leg Time
   Tmulti = Tmin+(Tmax-Tmin)*rand ;
   kmax = fix( (ToTime(nmt) - FromTime(1)) / Tmulti ) ;
   
   StepNumber = 801 ;
   mode = 0 ;
   DefineMultiSystem ;
   
case 801 
   
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

   % InitialSystem 5 : ModeSystem at SimulationFlag = 1 and nmt > 1 
   mode = mode + 1    ;
   if SimulationFlag == 1    
      clear Ftstr Gtstr Htstr Itstr Qtstr Rtstr vmt wmt ;
      % Fix system parameter for coordinated turn model 
      % generate default system model parameters
      [Ftstr,Gtstr,Qtstr,vmt] = GenerateProcessModel(SystemModelFlag, nx,nv,ncoor) ;
      [Htstr,Itstr,Rtstr,wmt] = GenerateObservationModel(SystemModelFlag, nx,nz,nw,ncoor) ;
      ModeSystem{mode,1} = Ftstr;
      ModeSystem{mode,2} = Gtstr;
      ModeSystem{mode,3} = Htstr;
      ModeSystem{mode,4} = Itstr;
      ModeSystem{mode,5} = Qtstr;
      ModeSystem{mode,6} = Rtstr;
      ModeSystem{mode,7} = vmt ;
      ModeSystem{mode,8} = wmt ;
      ModeSystem{mode,9} = SystemModelFlag ;
      ModeSystem{mode,10} = omega ;
      
      if mode == 1 
          xt0 = InitialX(SystemModelFlag,nx,omega) ;
      end
   end
   %    if NewFlag == OpenPrj
   %      load ~temp.mat ModeSystem ;
   %   end
      % Show Matrix Window
   delete(h_HeadTitle1) ;
   delete(h_RadioButton1) ;
   delete(h_RadioButton2) ;
   delete(h_Text1) ;
   delete(h_Edit1) ;
   delete(h_RadioButton3) ;
   MatrixWindow;
   % Input Matrix Ht
   StepNumber = 81;
   ModeString = GetModeString(mode);
   set(h_NameOfMatrix,'string',['Ft for ',ModeString]);
   Ftstr = ModeSystem{mode,1};
   set(h_ValueOfMatrix,'string',Ftstr);
   if SystemModelFlag ~= 1
      set(h_ValueOfMatrix,'Enable','Off');
   end
   help_string=['Specify the true system matrix Ft (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');

case 81,
   % Get Matrix Ft from Edit
   Ftstr = get(h_ValueOfMatrix,'string');
   ModeSystem{mode,1} = Ftstr;
   % show default Matrix Gt
   if SystemModelFlag ~= 1
      set(h_ValueOfMatrix,'Enable','On');
   end
   set(h_NameOfMatrix,'string',['Gt for ',ModeString]);
   Gtstr = ModeSystem{mode,2};
   set(h_ValueOfMatrix,'string',Gtstr);
   StepNumber = StepNumber + 1;
   help_string=['Specify the true process noise gain matrix Gt (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case 82,
   % Get Matrix Gt
   Gtstr = get(h_ValueOfMatrix,'string');
   ModeSystem{mode,2} = Gtstr;
   % show Ht
   set(h_NameOfMatrix,'string',['Ht for ',ModeString]);
   Htstr = ModeSystem{mode,3};
   set(h_ValueOfMatrix,'string',Htstr);
   StepNumber = StepNumber + 1;
   help_string=['Specify the true state-to-measurement matrix Ht (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case 83,
   % Get Ht
   Htstr = get(h_ValueOfMatrix,'string');
   ModeSystem{mode,3} = Htstr;

   % show It
   set(h_NameOfMatrix,'string',['It for ',ModeString]);
   Itstr = ModeSystem{mode,4};
   set(h_ValueOfMatrix,'string',Itstr);
   StepNumber = StepNumber + 1;
   help_string=['Specify the true measurement noise gain matrix It (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case 84,
   % Get It
   Itstr = get(h_ValueOfMatrix,'string');
   ModeSystem{mode,4} = Itstr;

   % show Qt
   set(h_NameOfMatrix,'string',['Qt for ',ModeString]);
   Qtstr = ModeSystem{mode,5};
   set(h_ValueOfMatrix,'string',Qtstr);
   StepNumber = StepNumber + 1;
   help_string=['Specify the true covariance matrix Qt of the process noise (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
case 85,
   % Get Qt
   Qtstr = get(h_ValueOfMatrix,'string');
   ModeSystem{mode,5} = Qtstr;

   % show Rt
   set(h_NameOfMatrix,'string',['Rt for ',ModeString]);
   Rtstr = ModeSystem{mode,6};
   set(h_ValueOfMatrix,'string',Rtstr);
   StepNumber = StepNumber + 1;
   help_string=['Specify the true covariance matrix Rt of the measurement noise (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case 86,
   % Get Rt
   Rtstr = get(h_ValueOfMatrix,'string');
   ModeSystem{mode,6} = Rtstr;

   if mode >= nmt
      % show xt0
      set(h_NameOfMatrix,'string','xt(0):');
      set(h_ValueOfMatrix,'string',num2str(xt0));
      StepNumber = 87;
      help_string=['Specify the true initial state vector xt(0).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
      set(h_About,'String',help_string, 'enable', 'inactive');
   else
      StepNumber = 801;
      delete(h_ValueOfMatrix);
      delete(h_NameOfMatrix);
      clear h_NameOfMatrix,h_ValueOfMatrix;
      DefineMultiSystem ;
   end
   
case 87,
   % Get xt0
   xt0 = str2num(get(h_ValueOfMatrix,'string'));
   delete(h_ValueOfMatrix);
   delete(h_NameOfMatrix);
   clear h_NameOfMatrix,h_ValueOfMatrix;
   clear mode ;
   StepNumber = 51 ;
   NextSelection;
   
end
   

