%% validateInputDefault
function parameters = validateInputDefault(argsIn,validParametersDefaults,force)
%% validateInputDefault validates input and sets defaults
% 
%  USAGE
%   parameters = validateInputDefault(varargin,validParametersDefaults,force)
% 
%  INPUTS
%   varargin - varargin input to function
%   validParametersDefaults - A cell of 1x2 cells containing strings or 
%    cells with the valid arguements in the first column and and the 
%    arguement's default value in the second column - see examples below
%    validParameters={{{'size','s'},5},{{'print','p'},false},...
%                    {'name','Curtis'}};
%    Will accept the following as valid input:
%           print, -print, p, -p
%           size, -size, s, -s
%           name, -name
%    and set the following defaults if the parameter is not specified:
%           parameters.print = 5; 
%           parameters.size  = false;
%           parameters.name  = 'Curtis';
%    If the input pararameter is specified as 'yes', 'on', or 'true' then the
%    parameter is set as true. If it is 'no', 'off', or 'false' then it
%    is returned as false. This is for when calling programs with out
%    parenthesis.
%   force - Force the output parameters struct to have all validParameters,
%    even if they are not given. All non-specified input will be set to
%    'false'.
%   
%  OUTPUTS
%   parameters - a structure with each given input argument. In the case
%    that there are multiple options, the output is set to the first
%    'option'. 'size' and 's' will both set the 'parameters.size' field.
% 
%  EXAMPLES
%   (validateInputDefault is intended to be called from within a function)
% 
%   varargin={'p','s',10,'name','john doe'}
%   validParameters={{{'size','s'},5},{{'print','p'},false},...
%                    {'name','Curtis'}};
%   parameters=validateInput(varargin,validParameters)
%   
%   varargin={'p','on','s',10,'name','john doe'}
%   validParameters={{{'size','s'},5},{{'print','p'},false},...
%                    {'name','Curtis'}};
%   parameters=validateInput(varargin,validParameters)
%   
%   varargin={'p'}
%   validParameters={{{'size','s'},5},{{'print','p'},false},...
%                    {'name','Curtis'}};
%   parameters=validateInput(varargin,validParameters,true)
% 
% Author: Curtis Mayberry
% 
% see also validateInput updateParams

%% Check inputs
error(nargchk(1, 3, nargin, 'struct'))
if nargin<3
    force=false;
else
    force=logical(force);
end

%% Split validParametersDefaults into valid parameters and defaults 
[~, length] = size(validParametersDefaults);
validParametersFirst = cell(1,length);
validParameters = cell(1,length);
defaultParameters = cell(1,length);
for i = 1:length
   validParameters{i}   = validParametersDefaults{i}{1};
   validParametersFirst{i} = validParameters{i}{1};
   defaultParameters{i} = validParametersDefaults{i}{2};
end

%% Validate input parameters
parameters = validateInput(argsIn,validParameters,force);

%% Set Defaults for all non-specified parameters
parametersDefaultNeeded = ~isfield(parameters,validParametersFirst);
numDefaults = sum(parametersDefaultNeeded);
parametersDefaultNeeded = find(parametersDefaultNeeded);
for k = 1:numDefaults
    parameters.(validParametersFirst{parametersDefaultNeeded(k)}) = ...
     defaultParameters{parametersDefaultNeeded(k)};
end

end