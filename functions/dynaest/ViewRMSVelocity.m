%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% ViewRMSVelocity, View RMS Velocity Estimation Error

subplot(1,1,1) ; % After filter gain
set(view_legend_menu,'Enable','on')
set(view_grid_menu,'Enable','on')

ViewStatusFlag = DRAW_RMS_VELOCITY;
colordef none;
legend off;
zoom off;

if nz == 2
   if nx ~=5 
      %plot([1:kmax],LongRMS2(2*nx/nz+4,:),'-',[1:kmax],LongsqP2(2*nx/nz+4,:),'-.');
      plot([1:kmax],LongRMS2(2*nx/nz+nx,:),'-',[1:kmax],LongsqP2(2*nx/nz+nx,:),'-.');
   else
      plot([1:kmax],LongRMS2(8,:),'-',[1:kmax],LongsqP2(8,:),'-.');
   end
   
elseif nz == 1
   %  plot([1:kmax],LongRMS2(nx/nz+4,:),'-',[1:kmax], LongsqP2(nx/nz+4,:),'-.');
   plot([1:kmax],LongRMS2(nx+2,:),'-',[1:kmax], LongsqP2(nx+2,:),'-.');
end

title('RMS velocity estimation errors');
xlabel('k');
ylabel('RMS velocity errors');

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


