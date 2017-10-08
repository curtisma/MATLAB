%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% PrevProcess, Process the "Prev" Button Message

switch StepNumber
   
% Steps before 'Matrix input'
case {1111,11111,11112,1121,1131,1132,1221}
   PrevProc1;
   
% Steps between 'Matrix input'
case {41,42,43,44,45,46,47,401,402,403,80,801,81,82,83,84,85,86,87}
   PrevProc2;
   
% Steps after 'NextSelection'
case {51,521,523,525, 511,515,516,512,5121,...
         5111,5112,51121,51122,5113,5114,541,542,5421,543,544,5441}   
   PrevProc3;
   
   % Steps for the sojourn time and trans probability ofr the adjusted imm
case {550,551,559,560}
   PrevProc4;
   % Steps for the matrix input of the fiter
case {61,62,63,64,65,66,67,68,690,692,693,...
         70,701,71,72,73,74,75,76,77,78,790,792,793}
   PrevProc5 ;
   
otherwise
   errordlg('Fata Error : Unknown step number at Previous Process') ;
   
end


   
