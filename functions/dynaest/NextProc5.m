%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% NextProc5 : Steps for the matrix window for the filter 

switch StepNumber
case {70,701}
   
   mode = get(h_Popupmenu1,'value');
   %delete(h_HeadTitle);
   delete(h_Popupmenu1);
   
   MatrixWindow;
   
   if exist('h_HeadTitle1') 
      if ishandle(h_HeadTitle1)
         delete(h_HeadTitle1);
      end
   end   
   
   Ffstr = modeFfstr{mode};

   set(h_NameOfMatrix,'string','Ff:');
   set(h_ValueOfMatrix,'string',Ffstr);
   
   if FilterModelFlag ~= 1 
      set(h_ValueOfMatrix,'Enable','Off');
   end
   
   StepNumber = 71;
   
   set(h_HeadTitle, 'String','Tracker parameters (cont''d):');
   help_string=['Specify the filter system matrix Ff (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case {61,71}
   
   % Get Matrix Ff from Edit
   Ffstr = get(h_ValueOfMatrix,'string');
   if StepNumber == 71 
      modeFfstr{mode} = Ffstr;
      Gfstr = modeGfstr{mode};
   end
   
   % show default Matrix Gf(nx*nv)
   set(h_NameOfMatrix,'string','Gf:');
   set(h_ValueOfMatrix,'string',Gfstr);
   
   if FilterModelFlag ~= 1
      set(h_ValueOfMatrix,'Enable','On');
   end
   
   StepNumber = StepNumber + 1;
   
   set(h_HeadTitle, 'String','Tracker parameters (cont''d):');
   help_string=['Specify the filter process noise gain matrix Gf (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case {62,72}
   
   % Get Matrix Gf
   Gfstr = get(h_ValueOfMatrix,'string');
   
   if StepNumber == 72 
      modeGfstr{mode} = Gfstr;
      Hfstr = modeHfstr{mode};
   end
      
   % show Hf
   set(h_NameOfMatrix,'string','Hf:');
   set(h_ValueOfMatrix,'string',Hfstr);
   
   StepNumber = StepNumber + 1;
   
   set(h_HeadTitle, 'String','Tracker parameters (cont''d):');
   help_string=['Specify the filter state-to-measurement matrix Hf (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
   case {63,73}
   
   % Get Hf
   Hfstr = get(h_ValueOfMatrix,'string');
   if StepNumber == 73
      modeHfstr{mode} = Hfstr;
      Ifstr = modeIfstr{mode};
   end
   
   % show If
   set(h_NameOfMatrix,'string','If:');
   set(h_ValueOfMatrix,'string',Ifstr);
   
   StepNumber = StepNumber + 1;
   
   set(h_HeadTitle, 'String','Tracker parameters (cont''d):');
   help_string=['Specify the filter measurement noise gain matrix If of the process noise (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case {64,74}
   
   % Get If
   Ifstr = get(h_ValueOfMatrix,'string');
   if StepNumber == 74
      modeIfstr{mode} = Ifstr;
      Qfstr = modeQfstr{mode};
   end
   
   % show Qf
   set(h_NameOfMatrix,'string','Qf:');
   set(h_ValueOfMatrix,'string',Qfstr);
   
   StepNumber = StepNumber + 1;
   
   set(h_HeadTitle, 'String','Tracker parameters (cont''d):');
   help_string=['Specify the filter covariance matrix Qf of the process noise (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case {65,75}
   % Get Qf
   Qfstr = get(h_ValueOfMatrix,'string');
   if StepNumber == 75 
      modeQfstr{mode} = Qfstr;
      Rfstr= modeRfstr{mode};
   end
   
   % show Rf
   set(h_NameOfMatrix,'string','Rf:');
   set(h_ValueOfMatrix,'string',Rfstr);
   
   StepNumber = StepNumber + 1;
   
   set(h_HeadTitle, 'String','Tracker parameters (cont''d):');
   help_string=['Specify the filter covariance matrix Rf of the measurement noise (if necessary, as a function of the revisit interval T).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case {66,76}
   
   % Get Rf
   Rfstr = get(h_ValueOfMatrix,'string');
   if StepNumber == 76 
      modeRfstr{mode} = Rfstr;
      x0 = zeros(nx,1);
      x0= modex0(:,mode);
   end
   
   % show x0
   set(h_NameOfMatrix,'string','x(0):');
   set(h_ValueOfMatrix,'string',num2str(x0));
   
   StepNumber = StepNumber + 1;
   
   set(h_HeadTitle, 'String','Tracker parameters (cont''d):');
   help_string=['Specify the initial filter estimate x(0).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case {67,77}
   
   % Get x0
   x0 = zeros(nxf,1);
   x0 = str2num(get(h_ValueOfMatrix,'string'));
   
   if StepNumber == 77 
      modex0(:,mode) = x0;
      P0 = zeros(nxf,nxf);
      P0(:) = modeP0(:,mode);
   end
   
   % show P0
   set(h_NameOfMatrix,'string','P(0|0):');
   set(h_ValueOfMatrix,'string',num2str(P0));
   
   StepNumber = StepNumber + 1;
   
   set(h_HeadTitle, 'String','Tracker parameters (cont''d):');
   help_string=['Specify the initial filter covariance P(0|0).', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];
   set(h_About,'String',help_string, 'enable', 'inactive');
   
case {68,78}
   
   % Get P0
   P0 = zeros(nxf,nxf);
   P0(:) = str2num(get(h_ValueOfMatrix,'string'));
   if StepNumber == 78 
      modeP0(:,mode) = P0(:);
      if TrackerSetupFlag ==1 
         modevmf(:,mode)=vmf;
         modewmf(:,mode)=wmf;
      end
   end
     
   if StepNumber == 78
            
      mode = mode + 1;
      if mode > nmf
         delete(h_ValueOfMatrix);
         delete(h_NameOfMatrix);
         clear h_NameOfMatrix,h_ValueOfMatrix;
         clear mode ;
         MonteSelection ;
      else
         % Set Scenario is OK.
         delete(h_ValueOfMatrix);
         delete(h_NameOfMatrix);
         clear h_NameOfMatrix,h_ValueOfMatrix;
         
         ModeSelection;
         StepNumber = 701;
      end
      
   else
      
      delete(h_ValueOfMatrix);
      delete(h_NameOfMatrix);
      clear h_NameOfMatrix,h_ValueOfMatrix;
      MonteSelection ;
      
   end
   
case {690,790}
   
   ButtonName = questdlg('Do you want to save a current project file?',...
      'Close Project');
   switch ButtonName 
   case 'Yes',
      SaveProject;
   case 'Cancel' 
      clear ButtonName ;
      return;
   end
   if exist('h_CommonWindow')
      delete(h_CommonWindow) ;
      clear h_CommonWindow ;
   end
   clear ButtonName ;

   set(simu_montecarlo_menu,'enable','on');
   DoMonteCarlo ;
  
case {692,792}
   
   delete(h_RadioButton1) ;
   delete(h_RadioButton2) ;

   StepNumber = StepNumber + 1 ; 
   
   SelectExportFilter ;
   
case {693,793}
   
   Project_Filter_Filename = get(h_Filename1,'string');
   % if do not exist this file
   if isempty(Project_Filter_Filename)
      msgbox('Please input filename. ','Instruction');
      return;
   end
   
   ExportFilter ;
   
   delete(h_Filename1);
   delete(h_Browse1)
   
   MonteSelection ;
   
end

