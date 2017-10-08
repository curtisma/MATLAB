% REPLACE_NAN Replaces all nan string entries in a csv file with a matlab readable NaN
%
% replace_nan(DATAFILE_IN, DATAFILE_OUT, ORIGINAL_NAN)
%
% INPUTS:
%
%   DATAFILE_IN: Input datafile that will have its nan values removed.
%       Must be a csv file.  STRING
%   DATAFILE_OUT: (optional) The output datafile with the nan values
%       removed.  Must be a .csv file The default adds _NANS_REPLACED to
%       DATAFILE_IN as the output file name. STRING
%	ORIGINAL_NAN: (optional) The original nan value that will be replaced.
%       If not specified the default value is the dvt nan value 1.#QNAN000
%       STRING
%
% EXAMPLES:
%   DATAFILE = 'Test.csv';
%	DATAFILE_OUT = 'Test_NAN_REP.csv';
%   ORIGINAL_NAN = 'NAN1';
%
%	replace_nan(DATAFILE_IN, DATAFILE_OUT)
%   % Replaces all '1.#QNAN000' entries in 'Test.csv' with matlab readable 
%   % NaN entries and saves the data to 'Test_NAN_REP.csv'
%   
%	replace_nan(DATAFILE_IN)
%   % Replaces all '1.#QNAN000' entries in 'Test.csv' with matlab readable 
%   % NaN entries and saves the data to 'Test_NANS_REPLACED.csv'
%
%	replace_nan(DATAFILE_IN, ORIGINAL_NAN)
%   % Replaces all 'NAN1' entries in 'Test.csv' with matlab readable 
%   % NaN entries and saves the data to 'Test_NANS_REPLACED.csv'
%
%   Author: Curtis Mayberry
%   Skyworks, Inc.
%   Rev 1: 8/2/12

function replace_nan(DATAFILE_IN, varargin)
% Check Inputs and set defaults if necessary
if(~strcmp(DATAFILE_IN(end-3:end), '.csv'))
    error('SWPostProc:replace_NaN:DATAFILE_INisNotCSV', 'DATAFILE_IN must be a .csv file');
end
if(nargin == 3)
    if(~strcmp(varargin{1}(end-3:end), '.csv'))
        error('SWPostProc:replace_NaN:DATAFILE_OUTisNotCSV', 'DATAFILE_OUT must be a .csv file');
    end
    DATAFILE_OUT = varargin{1};
    original_nan = varargin{2};
elseif(nargin == 2)
    if(~strcmp(varargin{1}(end-3:end), '.csv'))
        DATAFILE_OUT = [DATAFILE_IN(1:end-4) '_NANS_REPLACED.csv'];
        original_nan = varargin{1};
    else
        DATAFILE_OUT = varargin{1};
        original_nan = '1.#QNAN000'; % Default DVT NaN string
    end
elseif(nargin == 1)
    DATAFILE_OUT = [DATAFILE_IN(1:end-4) '_NANS_REPLACED.csv'];
    original_nan = '1.#QNAN000'; % Default DVT NaN string
else
    error('SWPostProc:replace_NaN:IncorrectNumberOfArguements', 'Only supports 1, 2, or 3 input arguements, type "help replace_NaN" for info on proper usage');
end

% copy over the header
FID_IN = fopen(DATAFILE_IN, 'r');
FID_OUT = fopen(DATAFILE_OUT, 'w+');
header = fgets(FID_IN);
% header_split = regexp(header, ',', 'split');
% numCols   = numel(header_split);
fwrite(FID_OUT, header);
% Copy Units line
fwrite(FID_OUT, fgets(FID_IN));

% replace all 1.#QNAN000 entries with NaN to make them readable by matlab
row_data = fgets(FID_IN);
while (row_data ~= -1)
    nan_loc = strfind(row_data, original_nan);
    if(~isempty(nan_loc))
        for nan_num  = 1:length(nan_loc)
            % replace each instance (idx: nan_num) of the nan with 'NaN'
            row_data = [row_data(1:(nan_loc(nan_num)-7*(nan_num-1)-1)) 'NaN' row_data((nan_loc(nan_num)-7*(nan_num-1)+10):end)];
        end
    end
    fwrite(FID_OUT, row_data);
    row_data = fgets(FID_IN);
end

% Close both files
fclose('all');
