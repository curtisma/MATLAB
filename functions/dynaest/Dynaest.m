%%% DynaEst 3.35 04/03/2001
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% DYNAEST   DynaEst startup M-file


if exist('h_MainWindow')
    figure(h_MainWindow)
    return ;
end

clear all
%casesen off
global DYNAEST_PWD DYNAEST_VERSION PATH_TO_MATLAB

%casesen on
DYNAEST_PWD=pwd;
PATH_TO_MATLAB=path;
DYNAEST_VERSION='3.351';
DYNAEST_DATE='04/03/2001';

save StartUp.mat DYNAEST_PWD DYNAEST_VERSION PATH_TO_MATLAB

%% Define Preparameters
READY_FLAG = -1;
% Defien New and Open Project
OpenPrj = 0 ;
NewPrj = 1 ;
SavePrj = 2 ;

% Define Data Input Type
DATA_SIMULATION = 1;
DATA_MEASUREMENT = 2;  % External Measurement(Z)
% Define Estimation Algorithm Flag
ALGORITHM_KALMAN = 1;
ALGORITHM_IMM = 2;
ALGORITHM_alphabeta = 3;
ALGORITHM_alphabetagamma = 4;
% define View status contants
DRAW_TRAJECTORIES = 1;
DRAW_RMS_POSITION = 2;
DRAW_RMS_VELOCITY = 3;
DRAW_MODEL_PROBABILITY = 4;
DRAW_FILTER_GAIN = 5 ;
DRAW_NEES = 6 ;
DRAW_NIS = 7 ;
%%

%% Define Flag
NewFlag = READY_FLAG ;
DataResourceFlag =READY_FLAG;
SimulationFlag = READY_FLAG;
SystemModelFlag = READY_FLAG;

NextSelectionFlag = READY_FLAG ;
TrackerSetupFlag = READY_FLAG ; 

FilterModelFlag = READY_FLAG;
FilterAlgorithmFlag = READY_FLAG;
TransitionProbabilityFlag = READY_FLAG ;

MonteSetupFlag = READY_FLAG;

ResultFlag = READY_FLAG ;
ResultFlag2 = READY_FLAG ; 

ViewStatusFlag = READY_FLAG;
SensitivityFlag = READY_FLAG ;
StateFlag = READY_FLAG ;

SetupNumber = 0 ;
FigureCheck = 0 ;

SubFigureNumber = 0 ;
%%

%% Define Filename
Project_Filename = []  ;

Project_State_Filename = [];
Project_Truth_Filename = [];
Project_Measurement_Filename = [];
Project_Filter_Filename = [];

%Project_Data_Filename = [];    
%Project_Estimation_Filename = [];    
%%

%% ---------------will be deleted -------------------
%Define Estimation Type
%ESTIMATION_INTERACTIVE = 1;  % <-for what ?
%ESTIMATION_EXTERNAL_FILE = 2;    % <-for what ?
% initialize the project status
%EstimationFlag = READY_FLAG;     % <-for what ?
%GridFlag = 0;   % < - will be deleted 
%% -------------------------------------------------

MainWindow
