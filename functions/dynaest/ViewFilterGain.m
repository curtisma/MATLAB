%%% DynaEst 3.032 01/13/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%ViewFilterGain

ViewStatusFlag = DRAW_FILTER_GAIN ;
colordef none;
legend off;
zoom off;

gaintemp = zeros(kmax,1) ;
lastcolumn = 0 ;
if SensitivityFlag == 2
   tempx = nr ;
else
   tempx = nxf ;
end

for i=1:tempx
   for j=1:nz
      gaintemp(:) = FilterGain(i,j,:) ;
      subplot(tempx,nz,lastcolumn+j);
      plot([1:kmax],gaintemp);
      stemp = sprintf('Filter Gain (%d, %d)',i,j);
      title(stemp,'FontSize',8) ;
      % xlabel('k');
      grid on;
   end
   lastcolumn = lastcolumn+j ;
end
clear stemp lastcolumn gaintemp tempx ;   
set(view_legend_menu,'Enable','off')
set(view_grid_menu,'Enable','off')


