function params = updateParams(params, newParams)
%% updateParams Updates and adds new params to an existing params
%  USAGE
%   params = updateParams(params, newParams)
% 
%  INPUTS
%   params - existing params struct generated from validateInput function
%   newParams - params struct containing the fields that need to be updated
%    in params
% 
%  OUTPUTS
%   params - Updated params struct
% 
%  EXAMPLE
%   deviceObj.UserData.params = updateParams(deviceObj.UserData.params,...
%                                            params);
% 
% Author: Curtis Mayberry
% 
% see also validateInput

    names = fieldnames(newParams);
    [length, ~] = size(names);
    for i = 1:length
        params.(names(i)) = newParams.(names(i));
    end
end
