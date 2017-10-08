%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% redraw, redraw current plot on the screen

switch ViewStatusFlag
case READY_FLAG,
   return;
case DRAW_TRAJECTORIES,
   ViewTrajectories;
case DRAW_RMS_POSITION,
   ViewRMSPosition;
case DRAW_RMS_VELOCITY
   ViewRMSVelocity;
case DRAW_MODEL_PROBABILITY
   ViewModelProbability;
case DRAW_FILTER_GAIN
   ViewFilterGain ; 
case DRAW_NEES,
   ViewNEES;

otherwise
   errordlg('Unknown View Status Codes in redraw.m','error');
end
