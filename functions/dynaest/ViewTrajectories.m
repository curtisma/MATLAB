%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%ViewTrajectories 

subplot(1,1,1)
set(view_legend_menu,'Enable','on')
set(view_grid_menu,'Enable','on')

ViewStatusFlag = DRAW_TRAJECTORIES;
%colormap('default')
%colordef white;
legend off;
zoom off;

xtvalue = zeros(1,kmax);
ytvalue = zeros(1,kmax);
zxvalue = zeros(1,kmax);
zyvalue = zeros(1,kmax);
xvalue = zeros(1,kmax);
yvalue = zeros(1,kmax);

switch DataResourceFlag 
case DATA_SIMULATION
   if ncoor == 2 & nz ~= 1
      if nx == 5 & nxf == 5
          xtvalue(:) = Truth(CurrentTrajectory,1,:);
          ytvalue(:) = Truth(CurrentTrajectory,3,:);
          zxvalue(:) = Measurement(CurrentTrajectory,1,:);
          zyvalue(:) = Measurement(CurrentTrajectory,2,:);
          xvalue(:) = Estimation(CurrentTrajectory,1,:);
          yvalue(:) = Estimation(CurrentTrajectory,3,:);
      else if nx == 5 & nxf ~= 5
              xtvalue(:) = Truth(CurrentTrajectory,1,:);
              ytvalue(:) = Truth(CurrentTrajectory,3,:);
              zxvalue(:) = Measurement(CurrentTrajectory,1,:);
              zyvalue(:) = Measurement(CurrentTrajectory,2,:);
              xvalue(:) = Estimation(CurrentTrajectory,1,:);
              yvalue(:) = Estimation(CurrentTrajectory,nxf/nzf+1,:);
          else if nx ~= 5 & nxf == 5
                  xtvalue(:) = Truth(CurrentTrajectory,1,:);
                  ytvalue(:) = Truth(CurrentTrajectory,nx/nz+1,:);
                  zxvalue(:) = Measurement(CurrentTrajectory,1,:);
                  zyvalue(:) = Measurement(CurrentTrajectory,2,:);
                  xvalue(:) = Estimation(CurrentTrajectory,1,:);
                  yvalue(:) = Estimation(CurrentTrajectory,3,:);
              else 
                  xtvalue(:) = Truth(CurrentTrajectory,1,:);
                  ytvalue(:) = Truth(CurrentTrajectory,nx/nz+1,:);
                  zxvalue(:) = Measurement(CurrentTrajectory,1,:);
                  zyvalue(:) = Measurement(CurrentTrajectory,2,:);
                  xvalue(:) = Estimation(CurrentTrajectory,1,:);
                  yvalue(:) = Estimation(CurrentTrajectory,nxf/nzf+1,:);
              end
          end
      end
      plot(xtvalue(:),ytvalue(:),'-',...
          zxvalue(:),zyvalue(:),'--',...
          xvalue(:),yvalue(:),'-.');
      
  else if ncoor ==1 | nz == 1 
          xtvalue(:) = Truth(CurrentTrajectory,1,:);
          zxvalue(:) = Measurement(CurrentTrajectory,1,:);
          xvalue(:) = Estimation(CurrentTrajectory,1,:);
          plot([1:kmax],xtvalue(:),'-', [1:kmax],zxvalue(:),'--', [1:kmax],xvalue(:),'-.');
      end
  end
  title(['Trajectories from run ', num2str(CurrentTrajectory)]);
  str1 = get(view_legend_menu,'checked');
  if strcmp( str1,'on')
      legend('True trajectory','Measured trajectory','Estimated trajectory',0);
  end   
case DATA_MEASUREMENT
    if ncoor == 2 & nz ~= 1 
        if nxf == 5
            zxvalue(:) = Measurement(CurrentTrajectory,1,:);
            zyvalue(:) = Measurement(CurrentTrajectory,2,:);
            xvalue(:) = Estimation(CurrentTrajectory,1,:);
            yvalue(:) = Estimation(CurrentTrajectory,3,:);
        else 
            zxvalue(:) = Measurement(CurrentTrajectory,1,:);
            zyvalue(:) = Measurement(CurrentTrajectory,2,:);
            xvalue(:) = Estimation(CurrentTrajectory,1,:);
            yvalue(:) = Estimation(CurrentTrajectory,nxf/nzf+1,:);
        end
        plot(zxvalue(:),zyvalue(:),'-',...
            xvalue(:),yvalue(:),'--');
    elseif ncoor ==1 | nz == 1 
        zxvalue(:) = Measurement(CurrentTrajectory,1,:);
        xvalue(:) = Estimation(CurrentTrajectory,1,:);
        plot([1:kmax],zxvalue(:),'--',[1:kmax],xvalue(:),'-.');
    end
    title(['Trajectories from run ', num2str(CurrentTrajectory)]);
    str1 = get(view_legend_menu,'checked');
    if strcmp( str1,'on')
        legend('Measured trajectory','Estimated trajectory',0);
    end
end
if ncoor == 2 & nz ~= 1
   xlabel('X');
   ylabel('Y');
else 
   xlabel('k')
   ylabel('X');
end

str1 = get(view_grid_menu,'checked');
if strcmp( str1,'on')
   grid on;
else
   grid off;
end
