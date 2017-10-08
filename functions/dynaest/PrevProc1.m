%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% PrevProcess, Process the "Prev" Button Message

switch StepNumber
   
case 1111, 
   % System initialize 1,back to Data Resource 
   % delete six Texts and six edits
      delete(h_Text1); 
   if ishandle(h_Text2) delete(h_Text2); end
   if ishandle(h_Text3) delete(h_Text3); end
   if ishandle(h_Text4) delete(h_Text4); end
   if ishandle(h_Text5) delete(h_Text5); end
   if ishandle(h_Text6) delete(h_Text6); end
   
   if ishandle(h_Edit1) delete(h_Edit1); end
   if ishandle(h_Edit2) delete(h_Edit2); end
   if ishandle(h_Edit3) delete(h_Edit3); end
   if ishandle(h_Edit4) delete(h_Edit4); end
   if ishandle(h_Edit5) delete(h_Edit5); end
   if ishandle(h_Edit6) delete(h_Edit6); end
   if SimulationFlag == 1;
      StepNumber = 11;
      DataResource ;
   elseif SimulationFlag == 2;
      StepNumber = 1121;
      SelectImportState ; 
   end      
case 11111, % SystemIni2 to system Ini 1
   StepNumber = 1111; % Back to system initialize 1
   delete(h_Text1); 
   if ishandle(h_Text2) delete(h_Text2); end
   if ishandle(h_Text3) delete(h_Text3); end
   if ishandle(h_Text4) delete(h_Text4); end
   if ishandle(h_Text5) delete(h_Text5); end
   if ishandle(h_Text6) delete(h_Text6); end
   
   if ishandle(h_Edit1) delete(h_Edit1); end
   if ishandle(h_Edit2) delete(h_Edit2); end
   if ishandle(h_Edit3) delete(h_Edit3); end
   if ishandle(h_Edit4) delete(h_Edit4); end
   if ishandle(h_Edit5) delete(h_Edit5); end
   if ishandle(h_Edit6) delete(h_Edit6); end
   SystemIni1;
   
case 11112 ;
   
   delete(h_RadioButton1) ;
   delete(h_RadioButton2) ;
   delete(h_RadioButton3) ;
   delete(h_Text1) ;
   delete(h_Edit1) ;

   
   StepNumber = 11111; 
   SystemIni1;
   delete(h_Text6) ;
   delete(h_Edit6) ;
   SystemIni2;
   
case {1121,1131}
   
   %delete(h_HeadTitle);
   if ishandle(h_Filename1) delete(h_Filename1); end
   if ishandle(h_Browse1) delete(h_Browse1); end
   
   % Back to Simulation 
   DataResource ;
   
case 1132 % SystemIni3 to SlectImportMeasurement 
   StepNumber = 1131 ;
   delete(h_Text1); 
   if ishandle(h_Text2) delete(h_Text2); end
   if ishandle(h_Text3) delete(h_Text3); end
   if ishandle(h_Text4) delete(h_Text4); end
   if ishandle(h_Text5) delete(h_Text5); end
   if ishandle(h_Text6) delete(h_Text6); end
   
   if ishandle(h_Edit1) delete(h_Edit1); end
   if ishandle(h_Edit2) delete(h_Edit2); end
   if ishandle(h_Edit3) delete(h_Edit3); end
   if ishandle(h_Edit4) delete(h_Edit4); end
   if ishandle(h_Edit5) delete(h_Edit5); end
   if ishandle(h_Edit6) delete(h_Edit6); end
   
   SelectImportTruth  ;
   
case 1221,
   % has filename controls, should delete them first
%   delete(h_HeadTitle);
   delete(h_Filename1); 
   delete(h_Browse1); 
   StepNumber = 11 ;
   DataResource ;
end
