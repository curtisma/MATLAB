%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%FindMultiModel : Find Multi Model for the Multi System 

function [Ftstr, Gtstr,Htstr,Itstr,Qtstr,Rtstr,vmt,wmt,SystemModelFlag,omega] = FindMultiModel(k,T,FromTime,ToTime,ModeSystem,nmt) ;

mode =  0 ;
realT = k*T ;
if   FromTime(1) <= realT & realT <= ToTime(1) 
   mode = 1 ;
else if  FromTime(2) <= realT & realT <= ToTime(2) 
      mode = 2 ;
   else if FromTime(3) <= realT & realT <= ToTime(3) 
         mode = 3 ;
      else if FromTime(4) <= realT & realT <= ToTime(4) 
            mode = 4 ;
         else if FromTime(5) <= realT & realT <= ToTime(5) 
               mode = 5 ;
            end
         end
      end
   end
end

if mode > nmt 
   errordlg('FATAL ERROR, mode is lager than nmt at GererateTruthMulti','error')
   break ;
end

Ftstr =  ModeSystem{mode,1} ;
Gtstr =  ModeSystem{mode,2} ;
Htstr =  ModeSystem{mode,3} ;
Itstr =  ModeSystem{mode,4} ;
Qtstr =  ModeSystem{mode,5} ;
Rtstr =  ModeSystem{mode,6} ;
vmt = ModeSystem{mode,7} ;
wmt = ModeSystem{mode,8} ;
SystemModelFlag = ModeSystem{mode,9}; 
omega = ModeSystem{mode,10} ;