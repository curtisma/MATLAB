%---------------------------------------------------
% Ce programme est la propriete exclusive de SUPELEC
% Tout  usage  non  authorise  ou reproduction de ce
% programme est strictement defendu. 
% Copyright  (c) 2010  SUPELEC  Departement SSE
% Tous droits reserves
%---------------------------------------------------
%
% fichier : extract_des_var.m
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

function des_var=extract_des_var(net_rep)

des_var=[];

fid=fopen([net_rep '/' '.designVariables']);

i=1;
if fid~=(-1)
    tline = fgetl(fid);
    while tline~=(-1)      
    rdc_tline=strrep(strrep(tline,'parameters',''),'\','');
    des_vars_line=textscan(rdc_tline, '%s', 'delimiter', ' ', 'MultipleDelimsAsOne', 1);
    
    for j=1:size(des_vars_line{1,1},1)
    [des_var(i).name, rough_value] = strtok(char(des_vars_line{1,1}(j)), '=');
    
    if ~isempty(rough_value)
        rough_value=strrep(rough_value,'=','');
        real_value=textscan(rough_value, '%f%s');

        switch char(real_value{1,2})
            case 'm'
                des_var(i).value=real_value{1,1}*1e-3;
            case 'u'
                des_var(i).value=real_value{1,1}*1e-6;
            case 'n'
                des_var(i).value=real_value{1,1}*1e-9;
            case 'p'
                des_var(i).value=real_value{1,1}*1e-12;
            case 'f'
                des_var(i).value=real_value{1,1}*1e-15;
            case {'k','K'}
                des_var(i).value=real_value{1,1}*1e3;
            case {'M'}
                des_var(i).value=real_value{1,1}*1e6;
            case {'G'}
                des_var(i).value=real_value{1,1}*1e9;
            case {'T'}
                des_var(i).value=real_value{1,1}*1e12;
            otherwise
                des_var(i).value=real_value{1,1};
        end
    else
       des_var(i).value=[];
    end
    des_var(i).npt=1 ;
    
    i=i+1;
    
    end
    
    tline = fgetl(fid);
    
    end

    fclose(fid);

else
    des_var=[];
end

return;        