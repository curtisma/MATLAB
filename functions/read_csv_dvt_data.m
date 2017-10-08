% read_csv_dvt_data: Reads data from a .csv file generated by DVT
% 
% Author: Curtis Mayberry
% 
% Inputs Example
% FOLDER = 'C:\Documents and Settings\mayberc\My Documents\SKY77572\Matlab Script - plot Worse Case IMD\GUI_PHASE_IMD_PLOT_TEST'; % Folder data is located in
% DATAFILE = 'GK099G_01_IMD_BOND3_TF12_SN01_051512.csv'; % Filename of the DVT IMD Dataset.  Must be a .csv file with continuous data (no blank rows)
% HEADERS =    {'SET_TEMP' 'SERIALNUMBER' 'SET_FREQ_TX' 'SET_FREQ_BLOCKER' 'SET_IM3_FREQ' 'MEAS_IM3' 'SET_PHASE' 'SDATE' 'SET_PORT1'};
% DATA_TYPES = {'%d32'     '%s'           '%f32'        '%f32'             '%f32'         '%f32'     '%d32'      '%s'    '%s'};
function [DATA COL] = read_csv_dvt_data(DATAFILE, HEADERS, DATA_TYPES)


%Parse Data from CSV file (May need adjust if the column format changes)
FID = fopen(DATAFILE, 'r');

% Determine number of columns
rowData = fgetl(FID);
rowData = regexp(rowData, ',', 'split');
numCols   = numel(rowData);
fclose(FID);

% Extract Header
FID = fopen(DATAFILE, 'r');
DATA_HEADER_FORMAT = zeros(1,2*numCols);
DATA_HEADER_FORMAT(1:2:2*numCols) = '%';
DATA_HEADER_FORMAT(2:2:2*numCols) = 's';
DATA_HEADER_FORMAT = char(DATA_HEADER_FORMAT);
DATA_HEADER = textscan(FID, DATA_HEADER_FORMAT, 1, 'Delimiter', ',');
%DATA_Units = textscan(FID, DATA_HEADER_FORMAT, 1, 'Delimiter', ',');
textscan(FID, DATA_HEADER_FORMAT, 1, 'Delimiter', ',');

% Find Data Columns (May need to adjust labels if DVT isn't consist with
% their data labels)
DATA_FORMAT = cell(1, numCols);
init_COL = nan(1,length(HEADERS));
for i = 1:length(HEADERS)
    init_COL(i) = find(strcmp([DATA_HEADER{:}], HEADERS{i}));
    DATA_FORMAT(init_COL(i)) = cellstr(DATA_TYPES{i});
end
COL = nan(1,length(HEADERS));
DATA_FORMAT(cellfun('isempty',DATA_FORMAT)) = cellstr('%*s'); %Ignore all other columns
DATA_FORMAT = char(strcat(DATA_FORMAT{:}));
DATA = textscan(FID, DATA_FORMAT,'Delimiter',',');
fclose(FID);

%find the actual column index
for k = 1:length(HEADERS)
    COL(k) = find(sort(init_COL) == init_COL(k));
end
end