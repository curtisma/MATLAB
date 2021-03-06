%%% DynaEst 3.032 02/12/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% DefineSystem, Define system model


h_HeadTitle = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'HorizontalAlignment','left', ...
   'ListboxTop',0, ...
   'Position',[1.1/12*cwsz(3) 9.3/10*cwsz(4) cwsz(3)/2 10], ...
   'BackgroundColor',FrameBackColor, ...
   'Style','text', ...
   'String','Define system model:',...  
   'FontWeight', 'bold', ...
   'Tag','StaticText2');

h_HeadTitle1 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'BackgroundColor',FrameBackColor, ...
   'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(2)/10 fwsz(2)+fwsz(4)*9/10 fwsz(3)*0.7 10], ...
    'Style','text', ...
	'Tag','StaticText1');

h_RadioButton1 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'Callback',['set(h_RadioButton1,''Value'',1);',...
      'set(h_RadioButton2,''Value'',0);',...
      'set(h_RadioButton3,''Value'',0);',...
      'SystemModelFlag=1;',...
      'set(h_Edit1,''Enable'',''off'');'],...
   'ListboxTop',0, ...
   'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+ fwsz(4)*(7/10) fwsz(3)*8/10 15], ...
  	'BackgroundColor',FrameBackColor, ...
	'String','Linear system model', ...
   'Style','radiobutton', ...
   'Value',0,...
	'Tag','Radiobutton1');

h_RadioButton2 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
   'Callback',['set(h_RadioButton1,''Value'',0);',...
      'set(h_RadioButton2,''Value'',1);',...
      'set(h_RadioButton3,''Value'',0);',...
      'SystemModelFlag=2;',...
      'set(h_Edit1,''Enable'',''on'');'],...
   'ListboxTop',0, ...
  	'BackgroundColor',FrameBackColor, ...
    'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+ fwsz(4)*(7/10-1/7) fwsz(3)*8/10 15], ...
    'String','Coordinated turn model', ...
	'Style','radiobutton', ...
	'Tag','Radiobutton2', ...
   'Value',0);

h_RadioButton3 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
   'Callback',['set(h_RadioButton1,''Value'',0);',...
      'set(h_RadioButton2,''Value'',0);',...
      'set(h_RadioButton3,''Value'',1);',...
      'SystemModelFlag=3;',...
      'set(h_Edit1,''Enable'',''on'');'],...
   'ListboxTop',0, ...
  	'BackgroundColor',FrameBackColor, ...
    'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+ fwsz(4)*(7/10-2/7) fwsz(3)*8/10 15], ...
   'String','Nearly coordinated turn model', ...
	'Style','radiobutton', ...
	'Tag','Radiobutton3', ...
   'Value',0);

h_Text1 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'HorizontalAlignment','left', ...
  	'BackgroundColor',FrameBackColor, ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)/5 fwsz(2)+fwsz(4)*(7/10-3/6.7) fwsz(3)*3/5 15], ...
	'String','Constant/Initial angular ratio =', ...
	'Style','text', ...
   'Tag','StaticText1');

h_Edit1 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)*3.1/5 fwsz(2)+fwsz(4)*(7/10-3/6.7) fwsz(3)*0.12 15], ...
	'String','1', ...
   'Style','edit', ...
   'Enable','off',...
	'Tag','EditText2');

temp = sprintf('Multi System Model for leg %d', mode+1) ;
set(h_HeadTitle1,'String',temp) ;

if ~(ncoor == 2 & ( nx == 5 | nx == 4) ) 
   set(h_RadioButton2,'Enable','off');
   set(h_RadioButton3,'Enable','off');
   set(h_Edit1,'Enable','off');
   SystemModelFlag = 1 ;
end

set(h_Edit1,'string',num2str(omega)); 

SystemModelFlag = 1 ;

if SimulationFlag == 2 | NewFlag == OpenPrj 
   SystemModelFlag = ModeSystem{mode+1,9} ;
   omega = ModeSystem{mode+1,10} ;
   set(h_Edit1,'string',num2str(omega)); 
else if exist('ModeSystem') 
        [sizetemp dummy] = size(ModeSystem) ;
        if sizetemp >= mode+1
            omega = ModeSystem{mode+1,10} ;
            set(h_Edit1,'string',num2str(omega)); 
            SystemModelFlag = ModeSystem{mode+1,9} ;
        end
    end
end
    
switch SystemModelFlag
case 1
   set(h_RadioButton1,'Value',1);
case 2,
   set(h_RadioButton2,'Value',1);   
   set(h_Edit1,'Enable','on');
case 3,
   set(h_RadioButton3,'Value',1);
   set(h_Edit1,'Enable','on');
end

if SimulationFlag == 2 | NewFlag == OpenPrj 
    switch SystemModelFlag
    case 1
        set(h_RadioButton2,'Enable','Off');
        set(h_RadioButton3,'Enable','Off');
        set(h_Edit1,'Enable','on');
    case 2,
        set(h_RadioButton1,'Enable','Off');
        set(h_RadioButton3,'Enable','Off');
        set(h_Edit1,'Enable','on');
    case 3,
        set(h_RadioButton1,'Enable','Off');
        set(h_RadioButton2,'Enable','Off');
        set(h_Edit1,'Enable','on');
    end
end

help_string=['In this window, you can select the system model for the ground truth',...
      char(10), char(10), 'If you want to define',...
      'coordinated turn model or, nearly coordinated turn model',...
   'select ''Coordinated turn model'' and define the constant angular ratio,',...    
   'or ''Nearly coordinated turn model'' and definte the initial angular ratio.',....',...
      char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];

set(h_About,'String',help_string, 'enable', 'inactive');

clear sizetemp dummy  ;