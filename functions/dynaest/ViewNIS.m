%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% ViewNEES, View NEES(Normalizied Innovation Squared)

subplot(1,1,1) ; % After filter gain
set(view_legend_menu,'Enable','on')
set(view_grid_menu,'Enable','on')

ViewStatusFlag =  DRAW_NIS ;
colordef none;
legend off;
zoom off;

filterbound = CRegion(nrun,nx,nz,ViewStatusFlag) ;
if filterbound(2) ~= 0 
    plot([1:kmax],longnis,'-',[1:kmax],filterbound(1),'-.',[1:kmax],filterbound(2),'-.');
else
    plot([1:kmax],longnis,'-');
end

title('Filter Consistency');
xlabel('k');
ylabel('Average NIS errors');

str1 = get(view_legend_menu,'checked');
if strcmp( str1,'on')
    if filterbound(2) ~= 0
        legend('NIS','95% Region',0);
    else
        legend('NIS') ;
    end
end

str1 = get(view_grid_menu,'checked');
if strcmp( str1,'on')
   grid on;
else
   grid off;
end
  
clear str1 ;



