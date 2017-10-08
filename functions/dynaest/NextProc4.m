%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% NextProc4 , Steps for the sojourn time and trans probability of the adjusted IMM

switch StepNumber
   
case 550,%Transition probability matrix depends on sojourn time
   
   % Get nmf from Edit
   str = get(h_Edit,'string');
   nmf = str2num(str);
   if nmf > 4 | nmf < 2 
      msgbox('The number of models of IMM should be 2, 3, or 4.','Error');
      return;
   end
   
   %InitialFilter4 
   if TrackerSetupFlag == 1 
      % create TranProEdit and sojourn time 
      TranProEdit = zeros(nmf,nmf);
            
      % if no sojournTime, create variable
      SojournTime = 2*ones(1,nmf);
      LowerLimit = 0.1*ones(1,nmf);
      UpperLimit = 0.9*ones(1,nmf);
      
      DefaultIMMParameters ;
      if NewFlag == OpenPrj
         load ~temp.mat Ffstr Gfstr Hfstr Ifstr Qfstr Rfstr vmf wmf x0 P0 ;
         load ~temp.mat TransPr modePr0 ;
         load ~temp.mat modeFfstr modeGfstr modeHfstr modeIfstr modeQfstr modeRfstr modevmf modewmf modex0 modeP0 
         load ~temp.mat TranProEdit SojournTime LowerLimit UpperLimit 
      end
   end
   
   %delete(h_HeadTitle);
   delete(h_Edit);
   delete(h_HeadTitle2);
   delete(h_RadioButton1);
   delete(h_RadioButton2);

   % input sojourn time for each model 
   mode = 1;
   StepNumber = 551 ;
   SojournTimeInput;
   
case 551, % input sojourn time for model 2
   
   % get parameters for model 1
   SojournTime(mode) = str2num(get(h_Edit1,'string'));
   LowerLimit(mode) = str2num(get(h_Edit2,'string'));
   UpperLimit(mode) = str2num(get(h_Edit3,'string'));
   
   mode = mode + 1;
   if mode > nmf
      
      %delete(h_HeadTitle);
      delete(h_Text1);
      delete(h_Edit1);
      delete(h_Text2);
      delete(h_Edit2);
      delete(h_Text3);
      delete(h_Edit3);
      
      if nmf == 2
         StepNumber = 70 ;
         mode = 1 ;
         ModeSelection ;
      else
         if nmf <=4 & nmf ~= 2
            
             StepNumber = 560;
            % input off diagonal coefficient when nmf 
            OffDiagonalTranP;
         else 
            StepNumber = 559;
            % -------------
         end
      end      
   else
      
      stemp = sprintf('Model %d',mode) ;
      set(h_HeadTitle1,'string',stemp);
      clear stemp ;   
     
  end
   
   
%case 559
   % the second part of off diagonal window
   %msgbox('under construction');
   
   %OffDiagonal2;
   
case 560
   
   % read parameters 
   GetOffDiagValue;
   ClearOffDiagonalControls;
   
   
   StepNumber = 70;
   mode = 1;
   ModeSelection;
   
end

   
   


   
   

