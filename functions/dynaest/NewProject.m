%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% NewProject, Create a new Project

NewFlag = NewPrj ;

clear ButtonName ;
if exist('h_CommonWindow') 
   figure(h_CommonWindow)
   CloseCommonWindow ;
end
if exist('ButtonName','var')
   if ButtonName == 'Cancel' 
      return ;
   end
end
clear ButtonName ;

for i=1:SubFigureNumber
   if ishandle(h_SubFigure(i))
      delete(h_SubFigure(i)) ;
   end
end
clear h ; 

ClearScreen ; 

%% Define Flag
DataResourceFlag = DATA_SIMULATION; 
SimulationFlag = 1 ; 
SystemModelFlag = 1 ;

NextSelectionFlag = 1  ;
TrackerSetupFlag = 1  ; 

FilterModelFlag = 1 ;
FilterAlgorithmFlag = ALGORITHM_KALMAN; 
TransitionProbabilityFlag = 1 ;

MonteSetupFlag = 1 ;

ResultFlag = 1  ;

ViewStatusFlag = 1 ;

SensitivityFlag = READY_FLAG ;
SetupNumber = 0 ;
FigureCheck = 0 ;

StateFlag = 0;
%%
Project_Filename = 'MySample.prj' ; % default saving filename

Project_Measurement_Filename = 'Measure.mes'; % default measurement filename
Project_State_Filename = 'System.mat'; % default system state filename
Project_Truth_Filename = 'System.dat'; % default system truth filename
Project_Filter_Filename = 'FilterKalman.mat'; % default filter filename

%Project_Data_Filename = 'inputs\sysinp.m'; % default data filename  %% 
%Project_Estimation_Filename = 'input\KFinp.m'; % default Estimation filename

clear ExternalT  ExternalZ  ExternalTruth Truth Measurement Estimation;
clear Ftstr  Gtstr  Htstr  Qtstr  Itstr  Rtstr xt0 ;
clear Ffstr Gfstr Hfstr Qfstr Ifstr Rfstr x0 P0 ;
clear ModeSystem  FromTime ToTime ;

% ----------will be deleted -------------------------------
%EstimationFlag = ESTIMATION_EXTERNAL_FILE; % default selection is From External File %%  <- for what ??
%NewFlag = 1; %%  <- for what ??

%ipwcfghit(1)=0;           % index for piecewise constant Ft, Gt, Ht, and It  %% < - for what ?
%itvfghit(1)=0;            % index for time-varying Ft, Gt, Ht, and It  %% < - for what ?
 
% TRUE NOISE STATISTICS:
%ipwcqrvwt(1)=0;           %index for Qt, Rt, vmt, and wmt %% < - for what ?
%itvqrvwt(1)=0;            %index for time-varying Qt, Rt, vmt, and wmt %% < - for what ?
% -----------------------------------------------------------------------


set(h_MainWindow,'name','DynaEst 3.3: Untitled.prj');
DisableProjectMenu ;
EnableProjectMenu;

CommonWindow; % Show Common window

DataResource; % start from the Data Resourse window

