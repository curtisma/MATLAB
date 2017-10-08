%%% DynaEst 3.032 01/02/2001
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% Subfunction - GenerateProcessModel : generate initial process model matrix and initial value
%                        for system and filter                            

function [Ftstr,Gtstr,Qtstr,vmt] = GenerateProcessModel(SystemModelFlag, nx,nv,ncoor)

switch SystemModelFlag 
case 1   
   temp = nx/ncoor;
   switch(temp)
   case 1,
      str = num2str(eye(nx));
      for i = 1:nx 
         Ftstr{i} = str(i,:);
      end
      str = num2str(eye(nx,nv));
      for i = 1:nx 
         Gtstr{i} = str(i,:);
      end
   case 2,
      for i = 0: ncoor-1
         Ftstr{i*2 + 1} = [num2str(zeros(1,i*2)),' 1 T ',num2str(zeros(1,nx-i*2-2))];
         Ftstr{i*2 + 2} = [num2str(zeros(1,i*2)),' 0 1 ',num2str(zeros(1,nx-i*2-2))];
         Gtstr{i*2 + 1} = [num2str(zeros(1,i)),' T*T/2 ',num2str(zeros(1,nv-i-1))];
         Gtstr{i*2 + 2} = [num2str(zeros(1,i)),' T     ',num2str(zeros(1,nv-i-1))];      
      end
   case 3,
      str1 = [' 1 T T*T/2 '];
      str2 = [' 0 1 T     '];
      str3 = [' 0 0 1     '];
      for i = 0: ncoor-1
         Ftstr{i*3+1} = [num2str(zeros(1,i*3)),str1,num2str(zeros(1,nx-i*3-3))];
         Ftstr{i*3+2} = [num2str(zeros(1,i*3)),str2,num2str(zeros(1,nx-i*3-3))];
         Ftstr{i*3+3} = [num2str(zeros(1,i*3)),str3,num2str(zeros(1,nx-i*3-3))];
         Gtstr{i*3 + 1} = [num2str(zeros(1,i)),' T*T/2 ',num2str(zeros(1,nv-i-1))];
         Gtstr{i*3 + 2} = [num2str(zeros(1,i)),' T     ',num2str(zeros(1,nv-i-1))];
         Gtstr{i*3 + 3} = [num2str(zeros(1,i)),' 1     ',num2str(zeros(1,nv-i-1))];
      end
   end
   
case 2
   Ftstr = ['1  (sin(Om*T))/Om  0 -(1-cos(Om*T))/Om' ;
      '0     cos(Om*T)    0     -sin(Om*T)   ' ;
      '0 (1-cos(Om*T))/Om 1   (sin(Om*T))/Om ' ;
      '0    sin(Om*T)     0      cos(Om*T)   '  ] ;
   for i = 0: ncoor-1
      Gtstr{i*2 + 1} = [num2str(zeros(1,i)),' T*T/2 ',num2str(zeros(1,nv-i-1))];
      Gtstr{i*2 + 2} = [num2str(zeros(1,i)),' T     ',num2str(zeros(1,nv-i-1))];      
   end
   
case 3
   Ftstr = ['1  (sin(Om*T))/Om  0 -(1-cos(Om*T))/Om 0' ;
      '0     cos(Om*T)    0     -sin(Om*T)    0' ;
      '0 (1-cos(Om*T))/Om 1   (sin(Om*T))/Om  0' ;
      '0    sin(Om*T)     0      cos(Om*T)    0' ;
      '0        0         0          0        1' ] ;
   Gtstr{1} = [' T*T/2 ','  0  ', '  0  '];
   Gtstr{2} = [' T        ','  0  ', '  0  '];
   Gtstr{3} = ['  0  ',' T*T/2 ', '  0  '];
   Gtstr{4} = ['  0  ',' T        ', '  0  '];
   Gtstr{5} = ['  0  ','     0    ', '  T  '];
end

% Qt(nv,nv)                    % covariance matrix of process noise
str = num2str(0.01* eye(nv));
for i = 1:nv 
   Qtstr{i} = str(i,:);
end

vmt=zeros(nv,1);            % bias of     process noise 

