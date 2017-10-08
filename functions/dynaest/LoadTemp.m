%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% LoadTemp

load ~temp.mat DataResourceFlag SimulationFlag SystemModelFlag kmax Tmin Tmax nx nv nz nw    
load ~temp.mat nrun nseed ncoor nmt kmax omega    
load ~temp.mat Ftstr Gtstr Htstr Itstr Qtstr Rtstr xt0 vmt wmt 
if nmt > 1 
   load ~temp.mat  ModeSystem FromTime ToTime 
end
load ~temp.mat nxf nvf nzf nwf omegaf 
load ~temp.mat FilterAlgorithmFlag FilterModelFlag Ffstr Gfstr Hfstr Ifstr Qfstr Rfstr x0 P0 vmf wmf

switch FilterAlgorithmFlag 
case ALGORITHM_IMM 
   load ~temp.mat TransitionProbabilityFlag nmf TransPr modePr0
   load ~temp.mat modeFfstr modeGfstr modeHfstr modeIfstr modeQfstr modeRfstr modevmf modewmf modex0 modeP0 
   if TransitionProbabilityFlag == 2
      load ~temp.mat TranProEdit SojournTime LowerLimit UpperLimit 
   end
end
load ~temp.mat NextSelectionFlag TrackerSetupFlag FilterModelFlag SensitivityFlag
load ~temp.mat MonteSetupFlag ResultFlag ResultFlag2 ViewStatusFlag FigureCheck StateFlag; 
load ~temp.mat Project_Measurement_Filename Project_State_Filename Project_Truth_Filename Project_Filter_Filename ;          

% if Monte Carle has been finished
%load result - ?? longxt longxt longz longx
load ~temp.mat Measurement Estimation;

if DataResourceFlag == DATA_SIMULATION
   load ~temp.mat Truth LongRMS2 LongsqP2 longnees longnis ;
end
if FilterAlgorithmFlag == ALGORITHM_KALMAN
   load ~temp.mat longmodePr 
else
   load ~temp.mat FilterGain
end
