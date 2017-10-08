%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% System Initialize 2

% Next step

set(h_HeadTitle, 'String','Simulation parameters (cont''d):');

set(h_Text1,'string','Number of Monte Carlo runs, nrun =');
set(h_Text2,'string','Seed for random number generator, nseed =');
set(h_Text3,'string','Dimension of geometry, ncoor =');
set(h_Text3,'enable','on');% previous window may disable this text

set(h_Text4,'string','Number of true motion legs (modes), nmt =');
set(h_Text5,'string','Maximum number of sensor revisits, kmax =');     


set(h_Edit1,'string',num2str(nrun));  % number of Monte Carlo runs         
set(h_Edit2,'string',num2str(nseed)); % seed for random number generator   
set(h_Edit3,'string',num2str(ncoor)); % number of coordinates              
set(h_Edit3,'enable','on'); % previous window may disable this edit

set(h_Edit4,'string',num2str(nmt));   % number of system modes             
set(h_Edit5,'string',num2str(kmax));  % maximum number of time steps       

% if read from external state, user can not modify 3~6
if SimulationFlag == 2 | NewFlag == OpenPrj ;
   set(h_Edit1,'enable','on');
   set(h_Edit2,'enable','on');
   set(h_Edit3,'enable','off');  
   set(h_Edit4,'enable','off');
   set(h_Edit5,'enable','on');
end

help_string=[' In this window, you can define the parameters for scenario generation.', char(10),...  
   ' Specify the number of Monte Carlo runs and the seed for random number generation.',...
      ' Select the dimension of the geometry (the number of coordinates).',...
      ' If the true target motion consists a number of legs, each with different motion parameters,',...
      ' select it as well. You can also specify the maximum number of sensor revisits',...
 ' If you select nmt larger than 1,  kmax will be defined from the Leg Time and randomly choosen T.',...  
   char(10),   char(10), 'Press ''Next >>'' when done to go to the next step. Press ''<< Prev'' to go back to the previous step. Press ''Close'' to abort the project definition.'];

set(h_About,'String',help_string, 'enable', 'inactive');
