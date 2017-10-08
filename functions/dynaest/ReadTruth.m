%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% ReadTruth , Read Ground Truth from an external file

fid = fopen(Project_Truth_Filename,'rt');

if fid == -1 
   errordlg('Can not open file when reading ground truth file'); 
end

nrun = fscanf(fid,'nmc=%d');
if nrun == -1
   fclose(fid);
   errordlg('read nmc error.','status');
   return;
end

nx = fscanf(fid,'\nnx=%d');
if nx == -1
   fclose(fid);
   errordlg('read nx error.','status');
   return;
end

kmax = fscanf(fid,'\nkmax=%d');
if kmax == -1
   fclose(fid);
   errordlg('read kmax error.','status');
   return;
end
clear temp ;
% skip the first line
line = fgetl(fid);
% should be ' series number  , sample interval , measurements:\n'
if line == -1
   fclose(fid);
   errordlg('read ground truth error1.','status');
   return;
end

ExternalTruth = zeros(nrun,nx,kmax);
ExternalT = zeros(1,nrun);
nrun1 = fscanf(fid,'\n%d',1);
if isempty(nrun1)
   fclose(fid);
   errordlg('read ground truth error2.','status');
   return;
end

Hf_wait = waitbar(0,'Reading external ground truth file. Please Wait...');
   
while( nrun1 ~= -1) 
   k = fscanf(fid,'%d',1);
   waitbar(nrun1*k/(nrun*kmax));
   ExternalT(nrun1) = fscanf(fid,'%f',1);
   for i = 1: nx
      ExternalTruth(nrun1,i,k) = fscanf(fid,'%f',1);
   end
   nrun1 = fscanf(fid,'\n%d',1);
   if isempty(nrun1)
      break;
   end
end
waitbar(1);
fclose(fid);
close(Hf_wait);

msgbox('External ground truth file has been read successfully.','status');
