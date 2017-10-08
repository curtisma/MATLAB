%%% DynaEst 3.032 02/23/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% ModeChanging

function y = ModeChanging(PrevSystemModelFlag, SystemModelFlag, xt, omega)

[nxsize dummy] = size(xt) ;

if PrevSystemModelFlag == SystemModelFlag
   if nxsize == 5 & SystemModelFlag ~=3
      y = xt(1:4) ;
      return ;
   else
      y = xt ;
      return ;
   end
end

if PrevSystemModelFlag == 3 | SystemModelFlag == 3 
   if PrevSystemModelFlag < SystemModelFlag 
      y = [xt',omega]' ;
      return ;
   else
      y = xt(1:4) ;
      return ;
   end
else
   y= xt ;
   return ;
end

      
