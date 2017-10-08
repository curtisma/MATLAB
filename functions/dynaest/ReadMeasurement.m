%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% ReadMeasurement, Read Measurement from external measurement file

fid = fopen(Project_Measurement_Filename,'rt');

if fid == -1 
   errordlg('Can not open file when reading measurement file'); 
end

nmc = fscanf(fid,'nmc=%d');
if nmc == -1
   fclose(fid);
   errordlg('read nmc error.','status');
   return;
else
   nrun = nmc ;
end

nz = fscanf(fid,'\nnz=%d');
if nz == -1
   fclose(fid);
   errordlg('read nz error.','status');
   return;
end

kmax = fscanf(fid,'\nkmax=%d');
if kmax == -1
   fclose(fid);
   errordlg('read kmax error.','status');
   return;
end

% skip the first line
line = fgetl(fid);
% should be ' series number  , sample interval , measurements:\n'
if line == -1
   fclose(fid);
   errordlg('read measurement error.','status');
   return;
end

ExternalZ = zeros(nrun,nz,kmax);
ExternalT = zeros(1,nrun);
nrun1 = fscanf(fid,'\n%d',1);
if isempty(nrun1)
   fclose(fid);
   errordlg('read measurement error.','status');
   return;
end

Hf_wait = waitbar(0,'Reading external measurements. Please Wait...');
   
while( nrun1 ~= -1) 
   k = fscanf(fid,'%d',1);
   waitbar(nrun1*k/(nrun*kmax));
   ExternalT(nrun1) = fscanf(fid,'%f',1);
   for i = 1: nz
      ExternalZ(nrun1,i,k) = fscanf(fid,'%f',1);
   end
   nrun1 = fscanf(fid,'\n%d',1);
   if isempty(nrun1)
      break;
   end
end
waitbar(1);
fclose(fid);
close(Hf_wait);
msgbox('measurement file read successfully.','status');
