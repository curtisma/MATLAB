%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% TrackerType , Select type of Tracker

if ( exist('h_CommonWindow') == 0 ) CommonWindow; end

if (ishandle(h_CommonWindow) == 0)  CommonWindow; end
if exist('h_HeadTitle1') 
   DelHandle('h_HeadTitle1');
end

new_title=1;
if (exist('h_HeadTitle') == 0)
else
  if ishandle(h_HeadTitle)
	new_title=0;
  end
end

if new_title<=0
	set(h_HeadTitle, 'String','Tracker type:');
  else
	h_HeadTitle = uicontrol('Parent',h_CommonWindow, ...
      'Units','points', ...
      'HorizontalAlignment','left', ...
      'ListboxTop',0, ...
      'Position',[1.1/12*cwsz(3) 9.3/10*cwsz(4) cwsz(3)/2 10], ...     
  	   'BackgroundColor',FrameBackColor, ...
      'Style','text', ...
      'String','Tracker type:',...  
	'FontWeight', 'bold', ...
      'Tag','StaticText2');
  end

h_RadioButton1 = uicontrol('Parent',h_CommonWindow, ...
   'Units','points', ...
   'Callback',['set(h_RadioButton1,''Value'',1);',...
      'set(h_RadioButton2,''Value'',0);',...
      'set(h_RadioButton3,''Value'',0);',...
      'set(h_RadioButton4,''Value'',0);',...
      'FilterAlgorithmFlag = ALGORITHM_KALMAN;',...
      'NewFlag = 1; StepNumber = 5111;'],...
   'ListboxTop',0, ...
   'BackgroundColor',FrameBackColor, ...
   'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+ fwsz(4)*(7/10) fwsz(3)*8/10 15], ...
   'String','Kalman filter', ...
   'Style','radiobutton', ...
   'Value',0,...
	'Tag','Radiobutton1');

h_RadioButton2 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
   'Callback',['set(h_RadioButton1,''Value'',0);',...
      'set(h_RadioButton2,''Value'',1);',...
      'set(h_RadioButton3,''Value'',0);',...
      'set(h_RadioButton4,''Value'',0);',...
      'FilterAlgorithmFlag = ALGORITHM_IMM;',...
      'NewFlag = 1; StepNumber = 5112;'],...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+ fwsz(4)*(7/10-1/7) fwsz(3)*8/10 15], ...
   'String','IMM estimator', ...
   'BackgroundColor',FrameBackColor, ...
	'Style','radiobutton', ...
	'Tag','Radiobutton2', ...
   'Value',0);

h_RadioButton3 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
   'BackgroundColor',FrameBackColor, ...
   'Callback',['set(h_RadioButton1,''Value'',0);',...
      'set(h_RadioButton2,''Value'',0);',...
      'set(h_RadioButton3,''Value'',1);',...
      'set(h_RadioButton4,''Value'',0);',...
      'FilterAlgorithmFlag = ALGORITHM_alphabeta;',...
      'NewFlag = 1; StepNumber = 5113;'],...
      'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+ fwsz(4)*(7/10-2/7) fwsz(3)*8/10 15], ...
      'enable','off',...
	'String','Alpha-beta filter', ...
	'Style','radiobutton', ...
	'Tag','Radiobutton3');

h_RadioButton4 = uicontrol('Parent',h_CommonWindow, ...
	'Units','points', ...
   'BackgroundColor',FrameBackColor, ...
   'callback',['set(h_RadioButton1,''Value'',0);',...
      'set(h_RadioButton2,''Value'',0);',...
      'set(h_RadioButton3,''Value'',0);',...
      'set(h_RadioButton4,''Value'',1);',...
      'FilterAlgorithmFlag = ALGORITHM_alphabetagamma;',...
      'NewFlag = 1; StepNumber = 5114;'],...
	'Enable','off', ...
	'ListboxTop',0, ...
    'Position',[fwsz(1)+fwsz(3)/10 fwsz(2)+ fwsz(4)*(7/10-3/7) fwsz(3)*8/10 15], ...
	'String','Alpha-beta-gamma filter', ...
	'Style','radiobutton', ...
	'Tag','Radiobutton4');

help_string=['In this window, you can select the tracker type to use in the estimation.', char(10), char(10), 'You have the following options: Kalman filter, IMM estimator, alpha-beta filter or, if applicable, alpha-beta-gamma filter.', char(10), char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];

set(h_About,'String',help_string, 'enable', 'inactive');

%alphabeta, alphabetagamma filter is available only when SimulationFlag =1,2

if (SimulationFlag == 3 | SimulationFlag == 4) & FilterModelFlag == 1 
    switch nxf 
    case 4
        set(h_RadioButton3,'enable','on');
        set(h_RadioButton4,'enable','off');
    case 6
        set(h_RadioButton3,'enable','off');
        set(h_RadioButton4,'enable','on');
    end
end
    
temptestab = 1 ;
temptestabc = 1 ;

if nmt > 1 
   if ~isempty( find ([ModeSystem{:,9}] == 3) ) | ~isempty( find ([ModeSystem{:,9}] == 2) );
       temptestab = 0 ;
       temptestabc = 0 ;
   end
end
if (SimulationFlag == 1 | SimulationFlag == 2)& FilterModelFlag == 1
    if nx~=2 & nx ~=4 
        temptestab = 0 ;       
    end
    
    if nx~=3 & nx ~=6 
        temptestabc = 0 ;       
    end

end

        
if SystemModelFlag == 1 & (SimulationFlag == 1 | SimulationFlag == 2 ) & FilterModelFlag == 1 & (temptestab | temptestabc) 
    if nmt > 1 
       for mode =1:nmt-1 
           Ftstr =  ModeSystem{mode,1} ;
           Gtstr =  ModeSystem{mode,2} ;
          Htstr =  ModeSystem{mode,3} ;
          Ftstr2 =  ModeSystem{mode+1,1} ;
          Gtstr2 =  ModeSystem{mode+1,2} ;
          Htstr2 =  ModeSystem{mode+1,3} ;
          T = 10 ;
          for i=1:nx
              F1(i,:) = eval(['[',Ftstr{i},']']);  
              G1(i,:) = eval(['[',Gtstr{i},']']);  
              F2(i,:) = eval(['[',Ftstr2{i},']']);  
              G2(i,:) = eval(['[',Gtstr2{i},']']);  
          end
          for i=1:nz
              H1(i,:) = eval(['[',Htstr{i},']']);  
              H2(i,:) = eval(['[',Htstr2{i},']']);  
          end
          if  F1 == F2         else     temptestab = 0 ;    temptestabc = 0 ;      end
          if G1 == G2        else     temptestab = 0 ;    temptestabc = 0 ;           end
          if H1 == H2         else    temptestab = 0 ;    temptestabc = 0 ;          end
      end
  end
  if temptestab 
      % check if alpha_beta filter should be available
      if TestForAlphaBeta(ncoor,nx,nz,Ftstr,Htstr,Gtstr)      
         set(h_RadioButton3,'enable','on');
      end
  end
  if temptestabc
      if TestForAlphaBetaGamma(ncoor,nx,nz,Ftstr,Htstr,Gtstr)      
         set(h_RadioButton4,'enable','on');
      end
   end
   
end

if TrackerSetupFlag == 1 
   switch (FilterAlgorithmFlag) 
   case ALGORITHM_KALMAN,
      set(h_RadioButton1,'value',1);
      StepNumber = 5111; 
   case ALGORITHM_IMM,
      set(h_RadioButton2,'value',1);
      StepNumber = 5112;
   case ALGORITHM_alphabeta
      set(h_RadioButton3,'value',1);
      StepNumber = 5113;
   case ALGORITHM_alphabetagamma
      set(h_RadioButton4,'value',1);
      StepNumber = 5114;
   end
else if TrackerSetupFlag == 2 
      set(h_RadioButton1,'enable','off');
      set(h_RadioButton2,'enable','off');
      set(h_RadioButton3,'enable','off');
      set(h_RadioButton4,'enable','off');
      switch (FilterAlgorithmFlag) 
      case ALGORITHM_KALMAN,
         set(h_RadioButton1,'enable','on');
         set(h_RadioButton1,'value',1);
         StepNumber = 5111; 
      case ALGORITHM_IMM,
         set(h_RadioButton2,'enable','on');
         set(h_RadioButton2,'value',1);
         StepNumber = 5112;
      case ALGORITHM_alphabeta
         set(h_RadioButton3,'value',1);
         set(h_RadioButton3,'enable','on');
         StepNumber = 5113;
      case ALGORITHM_alphabetagamma
         set(h_RadioButton4,'enable','on');         
         set(h_RadioButton4,'value',1);
         StepNumber = 5114;
      end
   end   
end

clear temptest T Ftstr2 Gtstr2 Htstr2  F1 F2 G1 G2 H1 H2        ;
         

   


      
      

