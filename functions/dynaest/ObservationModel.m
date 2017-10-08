%%% DynaEst 3.032 01/02/2001
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% Subfunction ObservationModel : generate observation model for ground truth and measurement

function [Ht,It,Rt] = ObservationModel(nz,nw,Htstr,Itstr,Rtstr)


for i=1:nz
   Ht(i,:) = eval(['[',Htstr{i},']']);  
   It(i,:) = eval(['[',Itstr{i},']']);  
end
for i=1:nw
   Rt(i,:) = eval(['[',Rtstr{i},']']);  
end
