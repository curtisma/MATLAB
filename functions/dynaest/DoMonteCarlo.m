%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% DoMonteCarlo, Run Monte Carlo simulations
% run monte carlo simulations
% Case 1 : No ExternalTruth, External Z
% Case 2 : Exist ExternalTruth, No ExternalZ
% Case 3 : Extist ExternalTruth, ExternalZ
% Case 4 : No ExternalTruth, ExternalZ  -->> DataResourceFlag = DATA_MEASUREMENT

clear Truth Measurement Estimation
StateFlag == 5 ;

if SensitivityFlag == 1
   Tx = eye(nx);%% ??
   nr = nxf;
   Mismatch;
elseif SensitivityFlag == 2
   Mismatch;
else
   if FilterAlgorithmFlag == ALGORITHM_KALMAN
      if DataResourceFlag == DATA_SIMULATION;
         % Kalman simulation
         KFMCRun ;
      elseif DataResourceFlag ==DATA_MEASUREMENT;
         % Kalman filter with measurement
         KFMCRunForMeasurement ;
      end
   elseif FilterAlgorithmFlag == ALGORITHM_IMM
      if DataResourceFlag == DATA_SIMULATION;      % IMM simulation
         IMMMCRun;
      elseif DataResourceFlag ==DATA_MEASUREMENT;
         IMMMCRunForMeasurement;
      end         
   elseif FilterAlgorithmFlag == ALGORITHM_alphabeta
      if DataResourceFlag == DATA_SIMULATION;      % alpha_beta simulation
         AlphaBetaMonteCarloRun;
      elseif DataResourceFlag ==DATA_MEASUREMENT;
         AlphaBetaMCRForMeasurement;
      end         
   elseif FilterAlgorithmFlag == ALGORITHM_alphabetagamma
      if DataResourceFlag == DATA_SIMULATION;      % alpha_beta_gamma simulation
         AlphaBetaGammaMonteCarloRun;
      elseif DataResourceFlag ==DATA_MEASUREMENT;
         AlphaBetaGammaMCRForMeasurement;
      end         

   end
end

clear Ft Gt Ht It Qt Rt;
clear Ff Gf Hf If Qf Rf;

% set some menu enable
set(view_result_menu, 'enable','on');
set(view_legend_menu,'enable','on');
set(view_grid_menu,'enable','on');
set(view_zoomin_menu,'enable','on');
set(view_zoomout_menu,'enable', 'on');
set(view_redraw_menu,'enable','on');
set(view_clear_menu,'enable','on');

MonteCarloFlag = 1;

CurrentTrajectory = 1;
StepNumber = 1000 ;
ExamineResults;
