%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%ViewModelProbability 
subplot(1,1,1) ; % After filter gain
ViewStatusFlag = DRAW_MODEL_PROBABILITY;
colordef none;

legend off;
zoom off;

if nmf== 2 
   plot([1:kmax],longmodePr(1,:),'-',[1:kmax],longmodePr(2,:),'--'); 
end
if nmf== 3 
   plot([1:kmax],longmodePr(1,:),'-',...
      [1:kmax],longmodePr(2,:),'--',...
      [1:kmax],longmodePr(3,:),'-.'); 
end
if nmf== 4 
   plot([1:kmax],longmodePr(1,:),'-',...
      [1:kmax],longmodePr(2,:),'--',...
      [1:kmax],longmodePr(3,:),'--',...
      [1:kmax],longmodePr(4,:),':'); 
end

title('Mode probabilities');
xlabel('k');
ylabel('Probabilities');

str1 = get(view_legend_menu,'checked');
if strcmp( str1,'on')
   if nmf == 2 legend('Model 1','Model 2',0); end
   if nmf == 3 legend('Model 1','Model 2','Model 3',0); end
   if nmf == 4 legend('Model 1','Model 2','Model 3','Model 4',0); end   
end

hold off;

str1 = get(view_grid_menu,'checked');
if strcmp( str1,'on')
   grid on;
else
   grid off;
end





