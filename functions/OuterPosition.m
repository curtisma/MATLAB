function [ OuterPos ] = OuterPosition( computer, monitor, h, w, h_pos, w_pos )
%OUTERPOSITION A function for placing figures on the screen
%   OuterPosition( computer, monitor, h, w, h_pos, w_pos )
%    Inputs:
%     computer: The computer being used 
%      (Defines the screen resolution and number of screens)
%      monitor: Selected monitor
%       'left','right', 'only'
%      h: # of figures across the height
%      w: # of figures across the width
%      h_pos: position from the bottom
%      w_pos: position from the left

if(strcmp(computer,'desktop'))
    MenuBarWidth = 40;
    Resolution = [1920 1080-MenuBarWidth];
%     Screens = 2;
% elseif(strcmp(computer,'laptop')
%     Resolution = [1920 1080];
%     Screens = 1;
elseif(strcmp(computer,'laptop'))
    MenuBarWidth = 40;
    Resolution = [1600 900-MenuBarWidth];
elseif(strcmp(computer,'laptop-work-lab'))
    MenuBarWidth = 40;
    Resolution = [1920 1080-MenuBarWidth];
else
    error('OuterPosition:BadComputerType','Unrecognized computer type: unable to set resolution');
end

if(isstr(monitor))
    if(strcmp(monitor,'left'))
        monitor = 1;
    elseif(strcmp(monitor,'right'))
        monitor = 2;
    elseif(strcmp(monitor,'only'))
        monitor = 1;
    else
        error('OuterPosition:BadMonitorName','Unrecognized monitor type: unable to set monitor location');
    end
end
% [left, bottom, width, height]
OuterPos(1) = (w_pos-1)* Resolution(1)/w + (monitor-1)*Resolution(1);
OuterPos(2) = Resolution(2) - h_pos*Resolution(2)/h + MenuBarWidth;

OuterPos(3) = Resolution(1)/w;
OuterPos(4) = Resolution(2)/h;
end



