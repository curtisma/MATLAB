%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% ViewNEES, View NEES(Normalizied Innovation Squared)

subplot(1,1,1) ; % After filter gain
set(view_legend_menu,'Enable','on')
set(view_grid_menu,'Enable','on')

ViewStatusFlag =  DRAW_NEES ;
colordef none;
legend off;
zoom off;

filterbound = CRegion(nrun,nx,nz,ViewStatusFlag) ;
if filterbound(2) ~= 0 
    plot([1:kmax],longnees,'-',[1:kmax],filterbound(1),'-.',[1:kmax],filterbound(2),'-.');
else
    plot([1:kmax],longnees,'-');
end

title('Filter Consistency');
xlabel('k');
ylabel('Average NEES errors');

str1 = get(view_legend_menu,'checked');
if strcmp( str1,'on')
    if filterbound(2) ~= 0
        legend('NEES','95% Region',0);
    else
        legend('NEES') ;
    end
end

str1 = get(view_grid_menu,'checked');
if strcmp( str1,'on')
   grid on;
else
   grid off;
end
  
clear str1 ;



