%%% DynaEst 3.032 01/16/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% CheckParameters : Check the validity of the inital parameters of the system
function check = CheckParameters(nx,nz,ncoor,nmt) 
   check = 0 ; 
   % check the validity of the dimension 
   if ((ncoor ~= 1) & (ncoor ~= 2) )
      errordlg('ncoor should be 1 or 2.','Error');
      check = 1 ;
      return;
   end
   
   % check the relationship between nx and ncoor
   if nx ~= 5 
      temp = nx/ncoor;
      if (temp ~= 1) & (temp ~= 2) & (temp ~= 3)  
         errordlg('nx / ncoor should be 1, 2 or 3','Error');
         check = 1 ;
         clear temp ;
         return;
      end
   else
      if ncoor ~= 2
         errordlg('If nx is 5, ncoor should be 2','Error');
         check = 1 ;
         return
      end
   end
   
   % check the relationship between nx and nz
   if nz > nx
      errordlg('nz should be less than nx');
      check = 1 ;
      return ;
   end
   
   % check the nmt
   if nmt > 5 
      errordlg('Maximum number of the legs is 5.','Error');
      check = 1 ;
      return;
   end  
   
   clear temp ;