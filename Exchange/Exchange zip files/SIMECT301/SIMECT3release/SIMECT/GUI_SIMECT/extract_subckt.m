function [syst_nm sub_syst_all_vect sub_syst_first_vect]=extract_subckt(sim_repository,cell)

syst_nm=[];

sub_syst_all_vect=[];

sub_syst_first_vect=[];

%Open netlist
netl=[sim_repository '/netlist'];

fid=fopen(netl);

found_cell=0;
m=1;

%Extract all the subcircuits
if fid~=(-1)
    
    tline = fgetl(fid);
    while ~feof(fid)
        if ~isempty(strfind(tline,'Cell name'))
            [dummy, cell_temp] = strtok(tline, ':');
            cell_new=strrep(strrep(cell_temp,':',''),' ','');
            if strcmp(cell_new,cell)
                found_cell=1;
                syst_nm=cell_new;
                extract_subckt_first_level;
            else
                sub_syst_all_vect{m} = cell_new;
                m=m+1;
            end
        end
        
        tline = fgetl(fid);
        
    end
    
    sub_syst_all_vect=unique(sub_syst_all_vect);

    sub_syst_first_vect=unique(sub_syst_first_vect);
    
   fclose(fid);
   
end

return;