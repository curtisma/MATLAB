%%% DynaEst 3.032 12/21/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% Export Filter, Export tracking filter

Project_Filter_Filename= get(h_Filename1,'string');

switch (FilterAlgorithmFlag) 
case {ALGORITHM_KALMAN,ALGORITHM_alphabeta,ALGORITHM_alphabetagamma}
   save(Project_Filter_Filename,...
      'FilterModelFlag','FilterAlgorithmFlag','Ffstr','Gfstr','Hfstr','Ifstr','Qfstr','Rfstr','x0','P0','vmf','wmf',...
      'nxf','nvf','nzf','nwf','ncoor','omegaf') ;
  
case ALGORITHM_IMM,
   if TransitionProbabilityFlag == 1
      save(Project_Filter_Filename,...
         'FilterModelFlag','FilterAlgorithmFlag','TransitionProbabilityFlag','nmf','TransPr','modePr0',...
         'modeFfstr','modeGfstr','modeHfstr','modeIfstr','modeQfstr','modeRfstr','modevmf','modewmf',...
         'modex0','modeP0','vmf','wmf','nxf','nvf','nzf','nwf','ncoor','omegaf') ;
   elseif TransitionProbabilityFlag == 2
      save(Project_Filter_Filename,...
         'FilterModelFlag','FilterAlgorithmFlag','TransitionProbabilityFlag','nmf','TransPr','modePr0',...
         'modeFfstr','modeGfstr','modeHfstr','modeIfstr','modeQfstr','modeRfstr','modevmf','modewmf',...
         'modex0','modeP0','TranProEdit','SojournTime','LowerLimit','UpperLimit','vmf','wmf',...
               'nxf','nvf','nzf','nwf','ncoor','omegaf') ;
   end
end
msgbox('Tracking filter file saved successfully.','status');



