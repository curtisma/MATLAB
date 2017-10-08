%%% DynaEst 3.032 01/02/2001
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% Subfunction - GenereatObservationModel : generate initial observation model matrix

function [Htstr,Itstr,Rtstr,wmt] = GenerateObservationModel(SystemModelFlag, nx,nz,nw,ncoor)
switch SystemModelFlag 
case 1   
   if nz == ncoor
      if nx/nz == 2
         for i = 0: nz-1
            Htstr{i+1} = [num2str(zeros(1,i*2)),' 1 0 ',num2str(zeros(1,nx-i*2-2))];
         end
      elseif nx/nz == 3
         for i = 0: nz-1
            Htstr{i+1} = [num2str(zeros(1,i*3)),' 1 0 0 ',num2str(zeros(1,nx-i*3-3))];
         end
      else
         str = num2str(eye(nz,nx));
         for i = 1:nz 
            Htstr{i} = str(i,:);
         end
      end
   else
      str = num2str(eye(nz,nx));
      for i = 1:nz 
         Htstr{i} = str(i,:);
      end
   end
case 2
   if nz == ncoor
      for i = 0: nz-1
         Htstr{i+1} = [num2str(zeros(1,i*2)),' 1 0 ',num2str(zeros(1,nx-i*2-2))];
      end
   else
      str = num2str(eye(nz,nx));
      for i = 1:nz 
         Htstr{i} = str(i,:);
      end
   end
case 3
   switch  nz 
   case 2
      for i = 0: 1
         Htstr{i+1} = [num2str(zeros(1,i*2)),' 1 0 ',num2str(zeros(1,nx-i*2-2))];
      end
   case 3
      for i = 0: 1
         Htstr{i+1} = [num2str(zeros(1,i*2)),' 1 0 ',num2str(zeros(1,nx-i*2-2))];
      end
      Htstr{3} = [num2str(zeros(1,4)),' 1 '];
   case {1,4,5}
      str = num2str(eye(nz,nx));
      for i = 1:nz 
         Htstr{i} = str(i,:);
      end
   end
end

      
% It(nz,nw);
str = num2str(eye(nz,nw));
for i = 1:nz 
   Itstr{i} = str(i,:);
end

% Rt (nw,nw)
str = num2str(1* eye(nw));
for i = 1:nw 
   Rtstr{i} = str(i,:);
end

wmt=zeros(nw,1);;            % bias of measurement noise 


%ipwcfghit(1)=0;           % index for piecewise constant Ft, Gt, Ht, and It
%itvfghit(1)=0;            % index for time-varying Ft, Gt, Ht, and It

% TRUE NOISE STATISTICS:
%ipwcqrvwt(1)=0;           %index for Qt, Rt, vmt, and wmt
%itvqrvwt(1)=0;            %index for time-varying Qt, Rt, vmt, and wmt

