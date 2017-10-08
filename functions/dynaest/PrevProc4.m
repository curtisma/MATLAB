%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% PrevProc4

switch StepNumber
   
case 550,% back from select multimodel parameters to select tracker type
   
   delete(h_HeadTitle1);
   delete(h_Edit);
   delete(h_HeadTitle2);
   delete(h_RadioButton1);
   delete(h_RadioButton2);
   
   % select tracker type
   TrackerType;

case 551
   
   if mode==1
      %delete(h_HeadTitle); 
      delete(h_Text1);
      delete(h_Edit1);
      delete(h_Text2);
      delete(h_Edit2);
      delete(h_Text3);
      delete(h_Edit3);
      % select multimodel parameter: nmf and Transition probability matrix
      SelectMultimodelParameters;
      
   else
      
      mode = mode - 1;
      
      set(h_Edit1,'string',num2str(SojournTime(mode)));
      set(h_Edit2,'string',num2str(LowerLimit(mode)));
      set(h_Edit3,'string',num2str(UpperLimit(mode)));
      
      stemp = sprintf('Model %d',mode) ;
      set(h_HeadTitle1,'string',stemp);
      clear stemp ;   
      
   end
   
    
case 560,
   
   StepNumber = 551 ;
   
   % delete off diagonal controls
   if exist('h_HeadTitle')
       ClearOffDiagonalControls;
   end
   
   mode = nmf;
   
   SojournTimeInput;
   set(h_Edit1,'string',num2str(SojournTime(mode)));
   set(h_Edit2,'string',num2str(LowerLimit(mode)));
   set(h_Edit3,'string',num2str(UpperLimit(mode)));
   
   stemp = sprintf('Model %d',mode) ;
   set(h_HeadTitle1,'string',stemp);
   clear stemp ;   

end

  
