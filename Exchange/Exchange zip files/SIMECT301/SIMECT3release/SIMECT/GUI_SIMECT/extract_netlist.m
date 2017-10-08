%---------------------------------------------------
% Ce programme est la propriete exclusive de SUPELEC
% Tout  usage  non  authorise  ou reproduction de ce
% programme est strictement defendu. 
% Copyright  (c) 2010  SUPELEC  Departement SSE
% Tous droits reserves
%---------------------------------------------------
%
% fichier : extract_netlist.m
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

function [crt_meas,net_meas]=extract_netlist(net_rep,in_cell)

net_meas=[];
crt_meas=[];

fid=fopen([net_rep '/' 'netlist']);

skip_l=0; %Skip multiple lines in the netlist for the same component
i=1;
m=1;

found_cell=0;

if fid~=(-1)
    
    while ~feof(fid)  
        tline = fgetl(fid);
        if ~isempty(strfind(tline,'Cell name'))
            [dummy, cell_temp] = strtok(tline, ':');
            cell=strrep(strrep(cell_temp,':',''),' ','');
            if strcmp(cell,in_cell)
                found_cell=1;
                break;
            else
                found_cell=0;
            end
        end        
%        tline = fgetl(fid);       
    end 
    
    if found_cell
    while ~feof(fid) 
        tline = fgetl(fid);
        if ~(strcmp(tline,'') || strcmp(tline(1:2),'//')) %Skip first lines of netlist
           
           while tline(end)=='\'
                tline=[tline(1:end-1) fgetl(fid)];
           end

           duplicate_crt=0;
            
           if ~skip_l 
            [str, remain] = strtok(tline, ')');
            [inst_name,inst_nodes]=strtok(str,'(');
            inst_name=strrep(inst_name,' ','');
            inst_kind=remain(3);
            
            for j=1:size(crt_meas,2)
                    if strcmp(inst_name,crt_meas(j))
                        duplicate_crt=1;
                    end
            end
            
            if (~duplicate_crt) && (inst_kind=='v' || inst_kind=='c')
                crt_meas{m}=inst_name;
                m=m+1;
            end
               
            rdc_str=strrep(inst_nodes,'(','');
            net_meas_line=textscan(rdc_str, '%s', 'delimiter', ' ', 'MultipleDelimsAsOne', 1);
            
            for j=1:size(net_meas_line{1,1},1)
                
                duplicate=0;
                exclude=0;
                
                %Verify if not added
                temp=net_meas_line{1,1}(j);
                
                 if  strcmp(cell2mat(temp),'0') 
                    temp={'gnd!'} ;
                 end   
                    
               for k=1:size(net_meas,2)
                    if strcmp(temp,net_meas(k))
                        duplicate=1;
                    end
                end
                
                tempmat=cell2mat(temp);
                
                %Verify if not to be excluded
                
                
                if  strcmp(tempmat(1:1),'M') || strcmp(tempmat(1:1),'R') || strcmp(tempmat(1:1),'C')
                    exclude=1;
                end
                    
                
                if ~(duplicate || exclude)
                    net_meas{i}=tempmat;
                    i=i+1;
                end
            end             
            
           end

           if strcmp(tline(size(tline,2)),'\')
               skip_l=1;
           else
               skip_l=0;
           end
           
        end

    
    end
    
    fclose(fid);
    
    else
    net_meas=[];
    end
else
    net_meas=[];
end

for k=1:size(net_meas,2)
    for i=1:size(net_meas,2)-1
        if strcmpc(net_meas{i+1},net_meas{i})<=0
            aux=net_meas{i};
            net_meas{i}=net_meas{i+1};
            net_meas{i+1}=aux;
        end
    end
end

for k=1:size(crt_meas,2)
    for i=1:size(crt_meas,2)-1
        if strcmpc(crt_meas{i+1},crt_meas{i})<=0
            aux=crt_meas{i};
            crt_meas{i}=crt_meas{i+1};
            crt_meas{i+1}=aux;
        end
    end
end

return;