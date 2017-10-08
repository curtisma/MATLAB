%---------------------------------------------------
% Ce programme est la propriete exclusive de SUPELEC
% Tout  usage  non  authorise  ou reproduction de ce
% programme est strictement defendu. 
% Copyright  (c) 2010  SUPELEC  Departement SSE
% Tous droits reserves
%---------------------------------------------------
%
% fichier : extract_cells.m
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


function cells_as_vector=extract_cells(simrep)

v=[];

%All dirs in sim_rep
dirs=dir(simrep);

%Select only the consistent
j=1;
for i=1:size(dirs,1)
    %if (dirs(i).isdir) & (~(dirs(i).name=='.')) & (~isempty(dir([simrep '/' dirs(i).name '/spectre/schematic/netlist'])))
    if (dirs(i).isdir) & (~(dirs(i).name=='.')) 
            v{j}=dirs(i).name;
            j=j+1;
    end
end

cells_as_vector=v;

return;        