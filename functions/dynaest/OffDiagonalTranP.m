%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% OffDiagonalTranP, input the off diagonal coefficient of Transition Probability

if exist('h_HeadTitle1') 
  if ishandle(h_HeadTitle1)
	delete(h_HeadTitle1);
  end
end

new_title=1;
if exist('h_HeadTitle') 
  if ishandle(h_HeadTitle)
	new_title=0;
  end
end

if new_title ==0
	set(h_HeadTitle, 'String','IMM estimator parameters:');
else
	h_HeadTitle = uicontrol('Parent',h_CommonWindow, ...
      'Units','points', ...
      'HorizontalAlignment','left', ...
      'ListboxTop',0, ...
      'Position',[1.1/12*cwsz(3) 9.3/10*cwsz(4) cwsz(3)/2 10], ...
      'BackgroundColor',FrameBackColor, ...
      'Style','text', ...
      'String','IMM estimator parameters:',... 
	'FontWeight', 'bold', ... 
      'Tag','StaticText2');
end

%% to set string for the h_Edit4
if size(TranProEdit) < 4
   TranProEdit(:,4) = zeros(3,1) ;
   TranProEdit(4,:) = zeros(1,4) ;
end

h_HeadTitle1 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
   'BackgroundColor',FrameBackColor, ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+fwsz(4)*8/10 fwsz(3)*0.5 15], ...
	'String','Off-diagonal values:', ...
	'Style','text', ...
	'Tag','StaticText1');

h_Text11 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
   'HorizontalAlignment','right', ...
   'BackgroundColor',FrameBackColor, ...
	'enable','off',...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*0.08 fwsz(2)+fwsz(4)*0.6 fwsz(3)*0.06 10], ...
	'String','P11:', ...
	'Style','text', ...
	'Tag','StaticText2');
h_Edit11 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
   'HorizontalAlignment','right', ...
   'enable','off',...
   'ListboxTop',0, ...
   'Position',[fwsz(1)+fwsz(3)*0.15 fwsz(2)+fwsz(4)*0.58 fwsz(3)*0.08 15], ...
	'Style','edit', ...
	'Tag','EditText2');

h_Text12 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
   'ListboxTop',0, ...   
   'BackgroundColor',FrameBackColor, ...
   'Position',[fwsz(1)+fwsz(3)*(0.08+0.25) fwsz(2)+fwsz(4)*0.6 fwsz(3)*0.06 10], ...
   'String','P21:', ...
   'enable','off',...
	'Style','text', ...
	'Tag','StaticText2');
h_Edit12 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'BackgroundColor',[1 1 1], ...
   'HorizontalAlignment','right', ...
   'string',TranProEdit(1,2),...
   'enable','off',...
   'ListboxTop',10, ...
   'Position',[fwsz(1)+fwsz(3)*(0.15+0.25) fwsz(2)+fwsz(4)*0.58 fwsz(3)*0.08 15], ...
	'Style','edit', ...
	'Tag','EditText2');

h_Text13 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
   'ListboxTop',0, ...
   'BackgroundColor',FrameBackColor, ...
   'Position',[fwsz(1)+fwsz(3)*(0.08+0.5) fwsz(2)+fwsz(4)*0.6 fwsz(3)*0.06 10], ...
   'String','P31:', ...
   'enable','off',...
	'Style','text', ...
	'Tag','StaticText2');
h_Edit13 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
   'HorizontalAlignment','right', ...
   'ListboxTop',0, ...
   'string',TranProEdit(1,3),...
   'Position',[fwsz(1)+fwsz(3)*(0.15+0.5) fwsz(2)+fwsz(4)*0.58 fwsz(3)*0.08 15], ...
   'Style','edit', ...
   'enable','off',...
	'Tag','EditText2');

h_Text14 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
   'ListboxTop',0, ...
   'BackgroundColor',FrameBackColor, ...
   'Position',[fwsz(1)+fwsz(3)*(0.08+0.75) fwsz(2)+fwsz(4)*0.6 fwsz(3)*0.06 10], ...
   'String','P41:', ...
   'enable','off',...
	'Style','text', ...
	'Tag','StaticText2');
h_Edit14 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
   'HorizontalAlignment','right', ...
   'ListboxTop',0, ...
   'Position',[fwsz(1)+fwsz(3)*(0.15+0.75) fwsz(2)+fwsz(4)*0.58 fwsz(3)*0.08 15], ...
   'Style','edit', ...
   'string',TranProEdit(1,4),... 
   'enable','off',...
	'Tag','EditText2');

h_Text21 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
   'ListboxTop',0, ...
   'BackgroundColor',FrameBackColor, ...
   'Position',[fwsz(1)+fwsz(3)*0.08 fwsz(2)+fwsz(4)*0.6*0.7 fwsz(3)*0.06 10], ...
      'String','P21:', ...
   'enable','off',...
	'Style','text', ...
	'Tag','StaticText2');
h_Edit21 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
   'HorizontalAlignment','right', ...
  	'BackgroundColor',[1 1 1], ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*0.15 fwsz(2)+fwsz(4)*0.58*0.7 fwsz(3)*0.08 15], ...
   'Style','edit', ...   
   'enable','off',...
   'string',TranProEdit(2,1),...
	'Tag','StaticText2');

h_Text22 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
	'ListboxTop',0, ...
   'Position',[fwsz(1)+fwsz(3)*(0.08+0.25) fwsz(2)+fwsz(4)*0.6*0.7 fwsz(3)*0.06 10], ...
   'enable','off',...
   'String','P22:', ...
   'BackgroundColor',FrameBackColor, ...
	'Style','text', ...
	'Tag','StaticText2');
h_Edit22 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'HorizontalAlignment','right', ...
	'ListboxTop',0, ...
   'enable','off',...
   'Position',[fwsz(1)+fwsz(3)*(0.15+0.25) fwsz(2)+fwsz(4)*0.58*0.7 fwsz(3)*0.08 15], ...
   'Style','edit', ...
   'Tag','EditText2');

h_Text23 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*(0.08+0.5) fwsz(2)+fwsz(4)*0.6*0.7 fwsz(3)*0.06 10], ...
   'BackgroundColor',FrameBackColor, ...
   'enable','off',...
	'String','P23:', ...
	'Style','text', ...
	'Tag','StaticText2');
h_Edit23 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'HorizontalAlignment','right', ...
	'BackgroundColor',[1 1 1], ...
	'ListboxTop',0, ...
   'Position',[fwsz(1)+fwsz(3)*(0.15+0.5) fwsz(2)+fwsz(4)*0.58*0.7 fwsz(3)*0.08 15], ...
   'Style','edit', ...   
   'string',TranProEdit(2,3),...
   'enable','off',...
	'Tag','EditText2');

h_Text24 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*(0.08+0.75) fwsz(2)+fwsz(4)*0.6*0.7 fwsz(3)*0.06 10], ...
   'enable','off',...
   'String','P24:', ...
   'BackgroundColor',FrameBackColor, ...
	'Style','text', ...
	'Tag','StaticText2');
h_Edit24 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'HorizontalAlignment','right', ...
	'BackgroundColor',[1 1 1], ...
   'ListboxTop',0, ...
   'enable','off',...
   'Position',[fwsz(1)+fwsz(3)*(0.15+0.75) fwsz(2)+fwsz(4)*0.58*0.7 fwsz(3)*0.08 15], ...
      'string',TranProEdit(2,4),...
	'Style','edit', ...
	'Tag','EditText2');

h_Text31 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
   'ListboxTop',0, ...
   'enable','off',...
   'Position',[fwsz(1)+fwsz(3)*0.08 fwsz(2)+fwsz(4)*0.6*0.4 fwsz(3)*0.06 10], ...
	'String','P31:', ...
   'Style','text', ...
   'BackgroundColor',FrameBackColor, ...
   'Tag','StaticText2');

h_Edit31 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'HorizontalAlignment','right', ...
	'BackgroundColor',[1 1 1], ...
   'ListboxTop',0, ...
   'enable','off',...
     'Position',[fwsz(1)+fwsz(3)*0.15 fwsz(2)+fwsz(4)*0.58*0.4 fwsz(3)*0.08 15], ...
   'Style','edit', ...
   'string',TranProEdit(3,1),...
	'Tag','EditText2');

h_Text32 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'enable','off',...
	'HorizontalAlignment','right', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*(0.08+0.25) fwsz(2)+fwsz(4)*0.6*0.4 fwsz(3)*0.06 10], ...
   'String','P32:', ...
   'BackgroundColor',FrameBackColor, ...
	'Style','text', ...
	'Tag','StaticText2');
h_Edit32 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'HorizontalAlignment','right', ...
	'BackgroundColor',[1 1 1], ...
   'ListboxTop',0, ...
   'enable','off',...
    'Position',[fwsz(1)+fwsz(3)*(0.15+0.25) fwsz(2)+fwsz(4)*0.58*0.4 fwsz(3)*0.08 15], ...
   'Style','edit', ...
   'string',TranProEdit(3,2),...
	'Tag','EditText2');

h_Text33 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*(0.08+0.5) fwsz(2)+fwsz(4)*0.6*0.4 fwsz(3)*0.06 10], ...
   'enable','off',...
	'String','P33:', ...
   'Style','text', ...
   'BackgroundColor',FrameBackColor, ...
	'Tag','StaticText2');
h_Edit33 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'HorizontalAlignment','right', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*(0.15+0.5) fwsz(2)+fwsz(4)*0.58*0.4 fwsz(3)*0.08 15], ...
   'enable','off',...
   'Style','edit', ...
	'Tag','EditText2');

h_Text34 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
   'ListboxTop',0, ...
   'enable','off',...
   'Position',[fwsz(1)+fwsz(3)*(0.08+0.75) fwsz(2)+fwsz(4)*0.6*0.4 fwsz(3)*0.06 10], ...
   'String','P34:', ...
   'BackgroundColor',FrameBackColor, ...
	'Style','text', ...
	'Tag','StaticText2');
h_Edit34 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'HorizontalAlignment','right', ...
   'BackgroundColor',[1 1 1], ...
   'enable','off',...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*(0.15+0.75) fwsz(2)+fwsz(4)*0.58*0.4 fwsz(3)*0.08 15], ...
    'Style','edit', ...
   'string',TranProEdit(3,4),...
	'Tag','EditText2');

h_Text41 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*0.08 fwsz(2)+fwsz(4)*0.6*0.1 fwsz(3)*0.06 10], ...
   'enable','off',...
   'BackgroundColor',FrameBackColor, ...
	'String','P41:', ...
	'Style','text', ...
	'Tag','StaticText2');
h_Edit41 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'HorizontalAlignment','right', ...
   'BackgroundColor',[1 1 1], ...
   'enable','off',...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*0.15 fwsz(2)+fwsz(4)*0.58*0.1 fwsz(3)*0.08 15], ...
     'Style','edit', ...
   'string',TranProEdit(4,1),...
	'Tag','EditText2');

h_Text42 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*(0.08+0.25) fwsz(2)+fwsz(4)*0.6*0.1 fwsz(3)*0.06 10], ...
    'String','P42:', ...
   'Style','text', ...
   'enable','off',...
   'BackgroundColor',FrameBackColor, ...
	'Tag','StaticText2');
h_Edit42 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'HorizontalAlignment','right', ...
	'BackgroundColor',[1 1 1], ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*(0.15+0.25) fwsz(2)+fwsz(4)*0.58*0.1 fwsz(3)*0.08 15], ...
   'Style','edit', ...
   'enable','off',...
   'string',TranProEdit(4,2),...
	'Tag','EditText2');

h_Text43 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*(0.08+0.5) fwsz(2)+fwsz(4)*0.6*0.1 fwsz(3)*0.06 10], ...
   'BackgroundColor',FrameBackColor, ...
   'String','P43:', ...
   'enable','off',...
	'Style','text', ...
	'Tag','StaticText2');
h_Edit43 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'HorizontalAlignment','right', ...
	'BackgroundColor',[1 1 1], ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*(0.15+0.5) fwsz(2)+fwsz(4)*0.58*0.1 fwsz(3)*0.08 15], ...
   'Style','edit', ...
   'enable','off',...
   'string',TranProEdit(4,3),...
	'Tag','EditText2');

h_Text44 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','right', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*(0.08+0.75) fwsz(2)+fwsz(4)*0.6*0.1 fwsz(3)*0.06 10], ...
   'BackgroundColor',FrameBackColor, ...
	'String','P44:', ...
   'Style','text', ...  
   'enable','off',...
	'Tag','StaticText2');
h_Edit44 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'HorizontalAlignment','right', ...
	'ListboxTop',1, ...
    'Position',[fwsz(1)+fwsz(3)*(0.15+0.75) fwsz(2)+fwsz(4)*0.58*0.1 fwsz(3)*0.08 15], ...
   'Style','edit', ...   
   'enable','off',...
	'Tag','EditText2');

if nmf > 1
   set(h_Text12,'enable','on');
   set(h_Edit12,'enable','on');
   set(h_Text21,'enable','on');
   set(h_Edit21,'enable','on');
else
   set(h_Text12,'visible','off');
   set(h_Edit12,'visible','off');
   set(h_Text21,'visible','off');
   set(h_Edit21,'visible','off');
   set(h_Text22,'visible','off');
   set(h_Edit22,'visible','off');
end
   
if nmf > 2
      set(h_Text13,'enable','on');
      set(h_Edit13,'enable','on');
      set(h_Text23,'enable','on');
      set(h_Edit23,'enable','on');
      set(h_Text32,'enable','on');
      set(h_Edit32,'enable','on');
      set(h_Text31,'enable','on');
      set(h_Edit31,'enable','on');
else
      set(h_Text13,'visible','off');
      set(h_Edit13,'visible','off');
      set(h_Text23,'visible','off');
      set(h_Edit23,'visible','off');
      set(h_Text32,'visible','off');
      set(h_Edit32,'visible','off');
      set(h_Text31,'visible','off');
      set(h_Edit31,'visible','off');
      set(h_Text33,'visible','off');
      set(h_Edit33,'visible','off');
end
   
if nmf > 3
      set(h_Text14,'enable','on');
      set(h_Edit14,'enable','on');
      set(h_Text24,'enable','on');
      set(h_Edit24,'enable','on');
      set(h_Text34,'enable','on');
      set(h_Edit34,'enable','on');
      set(h_Text41,'enable','on');
      set(h_Edit41,'enable','on');
      set(h_Text42,'enable','on');
      set(h_Edit42,'enable','on');
      set(h_Text43,'enable','on');
      set(h_Edit43,'enable','on');
else
      set(h_Text14,'visible','off');
      set(h_Edit14,'visible','off');
      set(h_Text24,'visible','off');
      set(h_Edit24,'visible','off');
      set(h_Text34,'visible','off');
      set(h_Edit34,'visible','off');
      set(h_Text41,'visible','off');
      set(h_Edit41,'visible','off');
      set(h_Text42,'visible','off');
      set(h_Edit42,'visible','off');
      set(h_Text43,'visible','off');
      set(h_Edit43,'visible','off');
      set(h_Text44,'visible','off');
      set(h_Edit44,'visible','off');
end

help_string=['In this window, you can set the weights of the off-diagonal values in the mode transition probability matrix.', char(10), char(10), 'Make sure that the weights should add up to 1.0. An off-diagonal value is calculated by multiplying the difference between 1.0 and the diagonal value in the same row by corresponding weight. ', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''Close'' to abort the project definition.'];

set(h_About,'String',help_string, 'enable', 'inactive');
