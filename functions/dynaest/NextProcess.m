%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% NextProcess

switch StepNumber
   
% Steps before 'Matrix input'
case {11,1111,11111,11112,1121,1131,1132,1221}
   NextProc1;
   
% Steps between 'Matrix input'
case {41,42,43,44,45,46,47,401,402,403,80,801,81,82,83,84,85,86,87}
   NextProc2;
   
% Steps after 'NextSelection'
case {51,521,523,525, 511,515,516,512,5121,...
         5111,5112,51121,51122,5113,5114,541,542,5421,543,544,5441}   
   NextProc3;
   
   % Steps for the sojourn time and trans probability ofr the adjusted imm
case {550,551,559,560}
   NextProc4;
   % Steps for the matrix input of the fiter
   
case {61,62,63,64,65,66,67,68,690,692,693,...
         70,701,71,72,73,74,75,76,77,78,790,792,793}
   NextProc5 ;

% Steps after 'Monte Carlo Run'
case {1000,1001}
   NextProc9 ;
   
otherwise
   errordlg('Fata Error : Unknown step number at Next Process') ;
   
end


