%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% GetModeString


function RetString = GetModeString(mode)
switch(mode)
case 1,
   RetString = ' leg 1';
case 2,
   RetString = ' leg 2';
case 3,
   RetString = ' leg 3';
case 4,
   RetString = ' leg 4';
case 5,
   RetString = ' leg 5';
otherwise
   msgbox('mode is too big');  
end
