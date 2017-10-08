%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% PrevProc5

switch StepNumber
   
case 61,
   
   % delete Controls for inputing Matrix
   delete(h_ValueOfMatrix);
   delete(h_NameOfMatrix);
   
   if SensitivityFlag == -1
      
      StepNumber = 5111;
      if exist('h_HeadTitle1') 
         if ishandle(h_HeadTitle1)
            delete(h_HeadTitle1);
         end
      end
      TrackerType;
      
   elseif SensitivityFlag == 1
      SensitivityAnalysis;
   elseif SensitivityFlag == 2
      StepNumber = 5421;
      % input size of reduced model nr
      SizeOfReducedModel;
   elseif SensitivityFlag == 4
      StepNumber = 5441;
      % show Fixed filter gain 
      MatrixWindow;
      set(h_NameOfMatrix,'string','Fixed filter gain Wf:');
      set(h_ValueOfMatrix,'string',num2str(Wf));      
   end
   
   % About information
   help_string=['In this window, you can set the value of the fixed filter gain matrix to use for sensitivity analysis..', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''Close'' to abort the analysis.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case 70, % From popup menu back 
   
   % delete previous controls
   %delete(h_HeadTitle);
   delete(h_Popupmenu1);
   
   if TransitionProbabilityFlag == 1
     delete(h_HeadTitle1);
      MatrixWindow;
      % show default Transition Probability Matrix
      set(h_NameOfMatrix,'string','Transition Probability Matrix:');
      set(h_ValueOfMatrix,'string',num2str(TransPr));
      StepNumber = 51122;
      % back to offdiagonal window   
   elseif TransitionProbabilityFlag == 2
      if nmf == 2 
         StepNumber = 551 ;
         mode = nmf;
         SojournTimeInput ;     
         set(h_Edit1,'string',num2str(SojournTime(mode)));
         set(h_Edit2,'string',num2str(LowerLimit(mode)));
         set(h_Edit3,'string',num2str(UpperLimit(mode)));
         
         set(h_HeadTitle1,'string','Model 2');
      else
         StepNumber = 560;
         % input off diagonal coefficient
         OffDiagonalTranP;
      end   
   end
   
case 71,
   
   delete(h_NameOfMatrix);
   delete(h_ValueOfMatrix);
   
   % select model
   ModeSelection;
   if ~(mode-1)
      StepNumber = 70;
   else 
      StepNumber = 701;
   end
   
case {62,72}
   
   % show Ff
   if StepNumber == 72
      Ffstr = modeFfstr{mode};
   end
   
   set(h_NameOfMatrix,'string','Ff:');
   set(h_ValueOfMatrix,'string',Ffstr);
   
   if FilterModelFlag ~= 1
      set(h_ValueOfMatrix,'Enable','off');
   end
   
   StepNumber = StepNumber - 1;

   % About information
   set(h_HeadTitle, 'String','Tracker parameters (cont''d):');
   help_string=['Specify the filter system matrix Ff (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');

case {63,73}
   
   % show Gf
   if StepNumber == 73
      Gfstr = modeGfstr{mode};
   end
   
   set(h_NameOfMatrix,'string','Gf:');
   set(h_ValueOfMatrix,'string',Gfstr);
   
   StepNumber = StepNumber - 1;
   
   set(h_HeadTitle, 'String','Tracker parameters (cont''d):');
   help_string=['Specify the filter noise gain matrix Gf (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case {64,74}
   
   % show Hf
   if StepNumber == 74
      Hfstr = modeHfstr{mode};
   end
   
   set(h_NameOfMatrix,'string','Hf:');
   set(h_ValueOfMatrix,'string',Hfstr);
   
   StepNumber = StepNumber - 1;
   
   set(h_HeadTitle, 'String','Tracker parameters (cont''d):');
   help_string=['Specify the filter state-to-measurement matrix Hf (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case {65,75}
   
   % show If
   if StepNumber == 75
      Ifstr = modeIfstr{mode};
   end
   
   set(h_NameOfMatrix,'string','If:');
   set(h_ValueOfMatrix,'string',Ifstr);
   
   StepNumber = StepNumber - 1;
   
   set(h_HeadTitle, 'String','Tracker parameters (cont''d):');
   help_string=['Specify the filter measurement noise gain matrix If (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case {66,76}
   
   % show Qf
   if StepNumber == 76
      Qfstr = modeQfstr{mode};
   end
   
   set(h_NameOfMatrix,'string','Qf:');
   set(h_ValueOfMatrix,'string',Qfstr);
   
   StepNumber = StepNumber - 1;
   
   set(h_HeadTitle, 'String','Tracker parameters (cont''d):');
   help_string=['Specify the filter covariance matrix Qf of the process noise (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case {67,77}
   
   % show Rf
   if StepNumber == 77
      Rfstr = modeRfstr{mode};
   end
   
   set(h_NameOfMatrix,'string','Rf:');
   set(h_ValueOfMatrix,'string',Rfstr);
   
   StepNumber = StepNumber - 1;
   
   set(h_HeadTitle, 'String','Tracker parameters (cont''d):');
   help_string=['Specify the filter covariance matrix Rf of the measurement noise (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case {68,78,}
   % show x0
   if StepNumber == 78
      x0 = zeros(nx,1);
      x0 = modex0(:,mode);
   end
   
   set(h_NameOfMatrix,'string','x(0):');
   set(h_ValueOfMatrix,'string',num2str(x0));
   
   StepNumber = StepNumber - 1;
   
   % About information
   set(h_HeadTitle, 'String','Tracker parameters (cont''d):');
   help_string=['Specify the initial filter estimate x(0).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case {690,790,692,792}
   
   set(set_monte_menu,'Enable','off');

   delete(h_RadioButton1)
   delete(h_RadioButton2)

   switch StepNumber
   case {790,792}
       mode = nmf ;       
       P0 = zeros(nxf,nxf);
       P0(:) = modeP0(:,mode);
   end
   
   MatrixWindow ;
   % show P0
   set(h_NameOfMatrix,'string','P(0):');
   set(h_ValueOfMatrix,'string',num2str(P0));
   
      % StepNumber 
   switch StepNumber
   case {690,790}
      StepNumber = StepNumber/10 - 1;
   case {692,792}
      StepNumber = (StepNumber-2)/10 - 1;
   end
   
   % About information
   set(h_HeadTitle, 'String','Tracker parameters (cont''d):');
   help_string=['Specify the initial filter estimate P(0).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case {693,793}
   delete(h_Filename1) ;
   delete(h_Browse1) ;
   StepNumber = (StepNumber-1)/10 ;
   MonteSelection ;
   
case 701 % from modeselection back to show Rf
   
   mode = mode - 1 ;
   
   % delete previous controls
   %delete(h_HeadTitle);
   delete(h_Popupmenu1);
   
   if exist('h_HeadTitle1')  
      if ishandle(h_HeadTitle1)
         delete(h_HeadTitle1);
      end
   end
   
   MatrixWindow;
   
   % show P0
   
   P0 = zeros(nx,nx);
   P0(:) = modeP0(:,mode);
   
   set(h_NameOfMatrix,'string','P(0|0):');
   set(h_ValueOfMatrix,'string',num2str(P0));
   
   StepNumber = 78;
   
   % About information
   set(h_HeadTitle, 'String','Tracker parameters (cont''d):');
   help_string=['Specify the initial filter covariance P(0|0).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');

end

  
