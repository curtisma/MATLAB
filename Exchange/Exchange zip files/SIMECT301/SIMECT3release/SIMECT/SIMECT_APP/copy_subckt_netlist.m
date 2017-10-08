%---------------------------------------------------
% This software is the exclusive property of SUPELEC
%
% It is distributed as a MATLAB toolbox
% No part of this software can be distributed or
% modified without reference to the authors
%
% Copyright  (c) 2011  SUPELEC SSE Departement
% All rights reserved
%
% http://www.supelec.fr/361_p_10063/philippe-benabes.html
%
%---------------------------------------------------
%
% file : copy_subckt_netlist.m
% authors  : P.BENABES & C.TUGUI 
% Copyright (c) 2011 SUPELEC
% Revision: 3.0  Date: 24/03/2011
%
%---------------------------------------------------
% Modifications history
% 24 MAR 2011 	: version 3.0
%---------------------------------------------------
%
% DESCRIPTION DU MODULE :
%   copy the netlist and modificates it to instantiate the subcircuit
%
% MODULES UTILISES :
%
%---------------------------------------------------

function [ind,subckt_net_meas,netlist]=copy_subckt_netlist(sel_sub_ckt,model_par)


simrep=model_par.simrep;
selected_cell=model_par.cell;
netlist_repository=model_par.netlist_repository;
netlist=[netlist_repository '_' model_par.subcell];
new_sim_rep=netlist;

needcopy=1 ;        % need to copy the directory
%Make new netlist repository
if isdir([netlist])
    if exist([netlist '/netlist'],'file')     
        orig=dir([netlist_repository '/netlist']);
        cop=dir([netlist '/netlist']);
        if cop.datenum>orig.datenum
            needcopy=0 ;
        end
    end
end

    
if (needcopy)
    if isdir([netlist]) 
        unix(['rm -r ' netlist]);
    end
    unix(['cp -r ' netlist_repository ' ' netlist]) ;
end

unix(['rm -f ' netlist '/netlist']);

%open original netlist
fid=fopen([netlist_repository '/netlist']);

%open new netlist in writing mode
fid2=fopen([netlist '/netlist'],'w+');

if (fid~=(-1)&&fid2~=(-1))
    
    %Just copy the first part of the schematic
    tline = fgetl(fid); %First netlist line is empty
    fwrite(fid2,tline); fprintf(fid2,'\n');
    
    tline = fgetl(fid);
    %tline2=tline;
    
    while ~feof(fid)
        
        if ~isempty(strfind(tline,'Cell name'))
            [dummy, cell_temp] = strtok(tline, ':');
            cell=strrep(strrep(cell_temp,':',''),' ','');
            if strcmp(cell,selected_cell)
                found_cell=1;
                break;
            else
                found_cell=0;
            end
        end
        
        if ~isempty(strfind(tline,'subckt'))
            [dummy, intr] = strtok(tline, ' ');
            [cell, io_cell] = strtok(intr, ' ');
            if strcmp(cell,sel_sub_ckt)
                if (io_cell(end)=='\')
                   tline2 = fgetl(fid);
                   io_sel_cell=[io_cell(1:end-1) tline2]; 
                   tline = [tline(1:end-1) tline2];
                else
                  io_sel_cell=io_cell;
                end
            end
        end
        
        fwrite(fid2,tline); fprintf(fid2,'\n');         
        tline = fgetl(fid);
    end
    
    %Here modify the schematic in order to simulate subckt
    if found_cell
            
           %Re-copy the original high-level cell 2 lines
            for i=1:2
                fwrite(fid2,tline);
                fprintf(fid2,'\n');
                tline = fgetl(fid);
            end
            
            net_subckt=textscan(io_sel_cell, '%s', 'delimiter', ' ', 'MultipleDelimsAsOne', 1);
            subckt_net_meas=net_subckt{1,1}';
            
            for i=1:size(subckt_net_meas,2)
                subckt_net_meas{i}=['net_' strrep(strrep(strrep(strrep(subckt_net_meas{i},'\',''),'/',''),'+',''),'-','')];
            end
            
            %Make the interesting sub-cell
            subcktline='Igen9988 (';
            for i=1:size(subckt_net_meas,1)-1
                subcktline=[subcktline subckt_net_meas{i} ' '];
            end
            
            subcktline=[subcktline subckt_net_meas{size(subckt_net_meas,2)} ') ' sel_sub_ckt];
            
            fwrite(fid2,subcktline);
            fprintf(fid2,'\n');
        
    end
    
    ind=fid&fid2;
        
    fclose(fid);
    
    fclose(fid2);
    
else
    
    ind=0;

end

return;

