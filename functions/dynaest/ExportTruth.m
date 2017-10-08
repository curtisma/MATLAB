%%% DynaEst 3.032 12/29/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% ExportTruth, export truth to an external file

% generate truth
switch SimulationFlag
case {1,2}
   % Always generate truth
   GenerateTruth ;
case 3  
   % ExportiImported ground truth
case 4   
   % Never occur
end

% If don't exist Exteranl T, generate new External T from Tmin and Tmax
% It can be a problem becuase Truth can be used with different T ...????
if exist('ExternalT','var') == 0
   ExternalT = zeros(1,nrun);
   for nmc=1:nrun
      ExternalT(nmc) = Tmin+(Tmax-Tmin)*rand;
   end
end

fid = fopen(Project_Truth_Filename,'wt');

if fid == -1 
   errordlg('Can not open file when saving ground truth file'); 
end

fprintf(fid,'nmc=%d\n',nmc);
fprintf(fid,'nx=%d\n',nx);
fprintf(fid,'kmax=%d\n',kmax);
fprintf(fid,'run number  , frame , sample interval , truth:\n');
for nmc=1:nrun
   for k = 1:kmax
      fprintf(fid,'%d  %d %f ',nmc,k,ExternalT(nmc));
      fprintf(fid,' %f',ExternalTruth(nmc,:,k));
      fprintf(fid,'\n');
   end
end

fclose(fid);

msgbox('Ground Truth file saved successfully.','status');



