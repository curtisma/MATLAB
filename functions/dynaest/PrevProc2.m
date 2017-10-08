%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% PrevProcess, Process the "Prev" Button Message

switch StepNumber
case 41,
   % Back to system initialize 2 
   delete(h_ValueOfMatrix);
   delete(h_NameOfMatrix);
   
   StepNumber = 11112;
   DefineSystem ;
   
case 42,   % Gt Back to Ft
   
   StepNumber = StepNumber - 1;

   % Input Matrix Ft
   set(h_NameOfMatrix,'string','Ft:');
   set(h_ValueOfMatrix,'string',Ftstr);
   if SystemModelFlag ~= 1
      set(h_ValueOfMatrix,'Enable','Off');
   end
   set(h_HeadTitle, 'String','Simulation parameters (cont''d):');
   help_string=['Specify the true system matrix Ft (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case 43,
   
   StepNumber = StepNumber - 1;

   % show default Matrix Gt
   set(h_NameOfMatrix,'string','Gt:');
   set(h_ValueOfMatrix,'string',Gtstr);
   set(h_HeadTitle, 'String','Simulation parameters (cont''d):');
   help_string=['Specify the true process noise gain matrix Gt (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case 44,
   
   StepNumber = StepNumber - 1;

   % show Ht
   set(h_NameOfMatrix,'string','Ht:');
   set(h_ValueOfMatrix,'string',Htstr);
   set(h_HeadTitle, 'String','Simulation parameters (cont''d):');
   help_string=['Specify the true state-to-measurement matrix Ht (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case 45,
   
    StepNumber = StepNumber - 1;

   % show It
   set(h_NameOfMatrix,'string','It:');
   set(h_ValueOfMatrix,'string',Itstr);
   set(h_HeadTitle, 'String','Simulation parameters (cont''d):');
   help_string=['Specify the true measurement noise gain matrix It (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case 46,
   
   StepNumber = StepNumber - 1;

   % show Qt
   set(h_NameOfMatrix,'string','Qt:');
   set(h_ValueOfMatrix,'string',Qtstr);
   set(h_HeadTitle, 'String','Simulation parameters (cont''d):');
   help_string=['Specify the true covariance matrix Qt of the process noise (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case 47,
   
   StepNumber = StepNumber - 1;

   % show Rt
   set(h_NameOfMatrix,'string','Rt:');
   set(h_ValueOfMatrix,'string',Rtstr);
   set(h_HeadTitle, 'String','Simulation parameters (cont''d):');
   help_string=['Specify the true covariance matrix Rt of the measurement noise (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
   
case 401,
   
   % Back to system initialize 2 
   delete(h_ValueOfMatrix);
   delete(h_NameOfMatrix);
   StepNumber = 1132 ;
   SystemIni3 ;
   
case 402,   % Gt Back to Ft
   
   StepNumber = StepNumber - 1;

   set(h_NameOfMatrix,'string','Ht:');
   set(h_ValueOfMatrix,'string',Htstr);
   
   help_string=['Specify the true state-to-measurement matrix Ht (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_HeadTitle, 'String','Simulation parameters (cont''d):');
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case 403,
   
   StepNumber = StepNumber - 1;

   % show It
   set(h_NameOfMatrix,'string','It:');
   set(h_ValueOfMatrix,'string',Itstr);
   set(h_HeadTitle, 'String','Simulation parameters (cont''d):');
   help_string=['Specify the true measurement noise gain matrix It (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case 80,% Back from multi_model sojourn time input 
   
   ClearMultiSystem;
   StepNumber = 11111;
   SystemIni1;
   delete(h_Text6) ;
   delete(h_Edit6) ;
   SystemIni2;
   
case 801
   
   delete(h_HeadTitle1) ;
   delete(h_RadioButton1) ;
   delete(h_RadioButton2) ;
   delete(h_RadioButton3) ;
   delete(h_Text1) ;
   delete(h_Edit1) ;

   
   if mode == 0
      StepNumber = 80 ;
      MultiSystem ;      
   else
      
      StepNumber = 86;
      ModeString = GetModeString(mode);
      MatrixWindow ;
      set(h_NameOfMatrix,'string',['Rt for ',ModeString]);
      Rtstr = ModeSystem{mode,6};
      if SystemModelFlag ~= 1
         set(h_ValueOfMatrix,'Enable','On');
      end
      set(h_ValueOfMatrix,'string',Rtstr);
      help_string=['Specify the true covariance matrix Rt of the measurement noise (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
      set(h_About,'String',help_string, 'enable', 'inactive');
   end
   
case 81,
   
   % From multi system Ft
   mode = mode - 1;
   StepNumber = 801;
   delete(h_ValueOfMatrix);
   delete(h_NameOfMatrix);
   DefineMultiSystem;   
    
case 82,
   % show Ft
   set(h_NameOfMatrix,'string',['Ft for ',ModeString]);
   Ftstr = ModeSystem{mode,1};
   SystemModelFlag = ModeSystem{mode,7} ;
   set(h_ValueOfMatrix,'string',Ftstr);
   if SystemModelFlag ~= 1
      set(h_ValueOfMatrix,'Enable','Off');
   end
   StepNumber = StepNumber - 1;
   help_string=['Specify the true system matrix Ft (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');   
   
case 83,
   % show Gt
   set(h_NameOfMatrix,'string',['Gt for ',ModeString]);
   Gtstr = ModeSystem{mode,2};
   set(h_ValueOfMatrix,'string',Gtstr);
   StepNumber = StepNumber - 1;
   help_string=['Specify the true process noise gain matrix Gt (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');   
   
case 84,
   % show Ht
   set(h_NameOfMatrix,'string',['Ht for ',ModeString]);
   Htstr = ModeSystem{mode,3};
   set(h_ValueOfMatrix,'string',Htstr);
   StepNumber = StepNumber - 1;
      help_string=['Specify the true state-to-measurement matrix Ht (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case 85,
   % show It
   set(h_NameOfMatrix,'string',['It for ',ModeString]);
   Itstr = ModeSystem{mode,4};
   set(h_ValueOfMatrix,'string',Itstr);
   StepNumber = StepNumber - 1;
      help_string=['Specify the true measurement noise gain matrix It (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case 86,
   % show Qt
   set(h_NameOfMatrix,'string',['Qt for ',ModeString]);
   Qtstr = ModeSystem{mode,5};
   set(h_ValueOfMatrix,'string',Qtstr);
   StepNumber = StepNumber - 1;
      help_string=['Specify the true covariance matrix Qt of the process noise (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case 87,
   % From xt(0) to previous
   % show Rt
   mode = nmt;
   ModeString = GetModeString(mode);
   set(h_NameOfMatrix,'string',['Rt for ',ModeString]);   
   Rtstr = ModeSystem{mode,6};
   set(h_ValueOfMatrix,'string',Rtstr);
   StepNumber = StepNumber - 1;
   help_string=['Specify the true covariance matrix Rt of the measurement noise (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
end
