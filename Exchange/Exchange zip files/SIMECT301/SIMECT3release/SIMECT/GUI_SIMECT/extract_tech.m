%---------------------------------------------------
% Ce programme est la propriete exclusive de SUPELEC
% Tout  usage  non  authorise  ou reproduction de ce
% programme est strictement defendu. 
% Copyright  (c) 2010  SUPELEC  Departement SSE
% Tous droits reserves
%---------------------------------------------------
%
% fichier : extract_tech.m
% auteur  : P.BENABES & C.TUGUI 
% Copyright (c) 2010 SUPELEC
% Revision: 2.0  Date: 29/10/2010
%
%---------------------------------------------------
%
% DESCRIPTION DU MODULE :
%   
%
% MODULES UTILISES :
%
%---------------------------------------------------

function tech=extract_tech(net_rep)

dr=dir([net_rep '/' '.modelFiles']);
if (isempty(dr))     % file does not exist
    fid=fopen([net_rep '/' 'corners.scs']);    
elseif (dr.bytes==0) % file is empty
    fid=fopen([net_rep '/' 'corners.scs']);     
else  % file exists
        fid=fopen([net_rep '/' '.modelFiles']);   
end

if fid~=(-1)
    tline = fgetl(fid);
    while isempty(findstr(tline,'section')) && (feof(fid)==0)
        tline = fgetl(fid);        
    end
    if ~isempty(tline)
        
        rdc_tline=strrep(strrep(tline,'include',''),'"','');
        inv_tline=fliplr(rdc_tline);
        [str, remain] = strtok(inv_tline, '/');
        tech=fliplr(remain);
    else
        tech=-1;
    end
    
    fclose(fid);

else
    tech=[];
end

return;        