%%% DynaEst 3.032 12/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% NextProc9 , Handle next message after the Monte Carlo Run

switch StepNumber
case 1000 
   FigureCheck = get(h_Check,'value');
   delete(h_CommonWindow);
   clear h_CommonWindow ;
   OutputProcess ; 
end

