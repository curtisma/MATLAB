%%% DynaEst 3.032 11/09/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% CheckLegTime : Check Each Leg Times are Resonable


% check the relationship between FromTime and ToTime
temp = 0 ;

FromTime(nmt+1) = inf ;
for i=1:nmt
   if FromTime(i) > ToTime(i) | ToTime(i) > FromTime(i+1) | ToTime(i) == inf    
      temp = 1 ;
   end
end

