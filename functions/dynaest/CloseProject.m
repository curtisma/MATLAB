%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% CloseProject, Close Current Project

DataResourceFlag = READY_FLAG;
FileterAlgorithmFlag = READY_FLAG;
EstimationFlag = READY_FLAG;
Project_Data_Filename = [];
Project_Estimation_Filename = [];


DisableProjectMenu;
for i=1:SubFigureNumber 
   if ishandle(h_SubFigure(i))
      delete(h_SubFigure(i)) ;
   end
end
ClearScreen;
CloseCommonWindow ;


