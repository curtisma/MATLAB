%%% DynaEst 3.032 11/29/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% Export System State, Export State

if nmt == 1
   save(Project_State_Filename,...
      'SystemModelFlag','Tmin','Tmax','nx','nv','nz','nw','nrun','nseed','ncoor','nmt','kmax','omega',...
      'Ftstr','Gtstr','Htstr','Itstr','Qtstr','Rtstr','xt0','vmt','wmt')
else
   save(Project_State_Filename,...
      'SystemModelFlag','Tmax','Tmin','Tmulti','nx','nv','nz','nw','nrun','nseed','ncoor','nmt','kmax','omega',...
      'ModeSystem','FromTime','ToTime','xt0','vmt','wmt')
end

msgbox('system file saved successfully.','status');



