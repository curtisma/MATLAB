%%% DynaEst 3.032 11/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% ExportMeasurement, export measurement

switch SimulationFlag
case {1,2,3}
   GenerateMeasurement ;
case 4  
end

fid = fopen(Project_Measurement_Filename,'wt');

if fid == -1 
   errordlg('Can not open file when saving project file'); 
end

fprintf(fid,'nmc=%d\n',nmc);
fprintf(fid,'nz=%d\n',nz);
fprintf(fid,'kmax=%d\n',kmax);
fprintf(fid,'run number  , frame , sample interval , measurements:\n');
for nmc=1:nrun
   for k = 1:kmax
      fprintf(fid,'%d  %d %f ',nmc,k,ExternalT(nmc));
      fprintf(fid,' %f',ExternalZ(nmc,:,k));
      fprintf(fid,'\n');
   end
end

fclose(fid);

msgbox('measurement file saved successfully.','status');



