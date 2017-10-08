classdef csvResults < matlab.mixin.SetGet & matlab.mixin.Copyable
    %csvResults Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Table
%         Type % Monte Carlo or Corners
%         FileType % CSV (or eventually xlsx)
        ResultsView % The Result Type specified in ADEXL.
                    % Summary, details, details (Transpose), etc.
        FilePath
        FileName
    end
    
    methods
        function obj = csvResults(varargin)
%             assert(~isempty(in),'adexl:csvResults:emptyInput','The input is empty')
            % Directory of csv files
            if(nargin > 0)
                in = varargin{1};
                if(ischar(in) && isdir(in))
                    d = dir(in);
                    fileNames = string({d.name})';
                    csvFiles = fileNames(endsWith(fileNames,'.csv'));
                    obj(length(csvFiles)) = adexl.csvResults(fullfile(in,char(csvFiles(length(csvFiles)))));
                    if(length(csvFiles)>1)
                        for nFile = 1:(length(csvFiles)-1)
                            obj(nFile) = adexl.csvResults(fullfile(in,char(csvFiles(nFile))));
                            obj(nFile).categorize
%                             if(strcmp(obj.ResultsView,'Yield'))
%                                 
%                             end
                        end
                    end
                % Cell
    %             elseif(iscell(in))
    %                 obj = in{1};
                %csv file
                else
                    obj.Table = readtable(in,'FileType','text');
                    obj.categorize;
                    obj.FilePath = in;
                    [~,name,~] = fileparts(in);
                    obj.FileName = name;
                end
            end
        end
        function summary(obj)
            out = table;
            for outN = 1:length(obj.Table)
                obj.Table
                
            end
        end
        function addFileName(obj)
        % addFileName - Adds the filename as a variable to the Table.
            for objN = 1:length(obj)
                if(~isempty(obj(objN).Table) && ~isempty(obj(objN).FileName))
                    [Filename{1:height(obj(objN).Table)}] = deal(obj(objN).FileName);
                    Filename = Filename';
                    obj(objN).Table.Filename = string(Filename);
                    Filename = [];
                end
            end
        end
%         function combine(obj)
%         % Vertically concatenates all elements of an array that have the
%         % same variables.
%         % Currently only works when all elements of a csvResults array have
%         % the same variables.
%         % TO DO: Handle heterogenous arrays
%             if(length(obj)>2)
%                 objTableOut = [obj(1).Table;obj(2).Table];
%                 for objN = 3:length(obj)
%                     objTableOut = [objTableOut;obj(objN).Table];
%                 end
%                 obj.Table = objTableOut;
%             elseif(length(obj)==2)
%                 obj.Table = [obj(1).Table;obj(2).Table];
%             end
%         end
    end
    
    methods (Access = protected)
        function categorize(obj)
            % Categorize results view type
            if(strcmp(obj.Table.Properties.VariableNames{1},'Test')  && ...
            	strcmp(obj.Table.Test{1}(1:14),'Yield Estimate'))
            	 obj.ResultsView = 'Yield';
                 obj.Table.Properties.UserData = obj.Table.Test{1};
                [testName{1:height(obj.Table)}] = deal(obj.Table.Test{2});
                obj.Table.Test = testName';
                obj.Table(1:2,:) = [];
            elseif(any(strcmp(obj.Table.Properties.VariableNames,'Min')))
                obj.ResultsView = 'Summary';
            end
        end
    end
    
end

