%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% ViewRMSPosition, View RMS Position Estimation Error

subplot(1,1,1) ; % After filter gain
set(view_legend_menu,'Enable','on')
set(view_grid_menu,'Enable','on')

ViewStatusFlag = DRAW_RMS_POSITION;
colordef none;
legend off;
zoom off;

if nz == 2
   if nx ~= 5
      plot([1:kmax],LongRMS2(1+nx/nz,:),'-',[1:kmax],LongsqP2(1+nx/nz,:),'-.');
   else
      plot([1:kmax],LongRMS2(3,:),'-',[1:kmax],LongsqP2(3,:),'-.');
   end
elseif nz == 1
   plot([1:kmax],LongRMS2(1,:),'-',[1:kmax], LongsqP2(1,:),'-.');
end

title('RMS position estimation errors');
xlabel('k');
ylabel('RMS position errors');

str1 = get(view_legend_menu,'checked');
if strcmp( str1,'on')
   legend('Actual error','Filter calculated s.d.',0);
end

str1 = get(view_grid_menu,'checked');
if strcmp( str1,'on')
   grid on;
else
   grid off;
end
  





