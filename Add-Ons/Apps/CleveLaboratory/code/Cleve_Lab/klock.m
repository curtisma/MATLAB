function klock(~)
% KLOCK Analog display clock.

%   Copyright 2016-2017 Cleve Moler
%   Copyright 2016-2017 The MathWorks, Inc.

% Called by Lab1 with nargin == 1 to get thumbnail.
thumb = (nargin == 1);

p = init_graphics;
while pawsit(thumb)
   c = clock;
   set(p.date, ...
       'string',datestr(c))
   s = floor(c(6));
   m = c(5) + s/60;
   h = c(4) + m/60;
   set(p.sec, ...
       'xdata',[0 p.x(s+1)], ...
       'ydata',[0 p.y(s+1)])
   set(p.min, ...
       'xdata',[0 sin(2*pi*m/60)], ...
       'ydata',[0 cos(2*pi*m/60)])
   set(p.hour, ...
       'xdata',[0 0.8*sin(2*pi*h/12)], ...
       'ydata',[0 0.8*cos(2*pi*h/12)])
   if ~thumb
       pause(0.99)
   end
   drawnow
end
finalize_graphics

% ------------------------------------

    function p = init_graphics
       if thumb
           cla
           set(gca, ...
               'xlim',[-1.25 1.25], ...
               'ylim',[-1.25 1.25])
           lw = 2;
           dotsize = 1;
           bigdotsize = get(0,'defaultlinemarkersize');
       else
           clf
           shg
           set(gcf, ...
               'menubar','none', ...
               'numbertitle','off', ...
               'name','klock', ...
               'color','w')
           axis([-1.1 1.1 -1.1 1.1])
           axis square off
           lw = 4;
           dotsize = 2;
           bigdotsize = get(0,'defaultlinemarkersize')+12;
           uicontrol('style','pushbutton', ...
              'units','normalized', ...
              'position',[.90 .92 .08 .06], ...
              'string','info', ...
              'fontweight','bold', ...
              'background','white', ...
              'callback', ...
                  'web(''info/klock_info.html'',''-notoolbar'')'); 
       end
       p.x = sin(2*pi*(0:59)/60);
       p.y = cos(2*pi*(0:59)/60);
       line(p.x,p.y, ...
           'linestyle','none', ...
           'marker','o', ...
           'color','black', ...
           'markersize',dotsize)
       k = 0:5:55;
       line(p.x(k+1),p.y(k+1), ...
           'linestyle','none', ...
           'marker','.', ...
           'color','black', ...
           'markersize',bigdotsize)
       p.sec = line([0 0],[0 0], ...
           'color',[0 2/3 0], ...
           'linewidth',lw/2);
       p.min = line([0 0],[0,0], ...
           'color','blue', ...
           'linewidth',lw);
       p.hour = line([0 0],[0 0], ...
           'color','blue', ...
           'linewidth',lw);
       onoff = {'on','off'};
       p.date = text(0.0,1.15,datestr(now), ...
           'fontsize',16, ...
           'horiz','center', ...
           'visible',onoff{thumb+1});
    end

    function finalize_graphics
        if ~thumb
           close
        end
    end
end %klock
        
