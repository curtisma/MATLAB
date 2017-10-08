function createLink(itemToLink,linkLocation,linkName)
% Create Windows shell link (.LNK) shortcuts
% 
% SYNTAX:
% createLink(itemToLink,linkLocation)
%     creates a Windows shell link (.lnk) shortcut to a file or directory
%     specified by and writing it to directory linkLocation.
%
% INPUTS:
% itemToLink:    A directory or file to make the destination of the link
%                 (full path)
% linkLocation:  The location to place the link (full path)
% linkName: Name of the link to be created in linkLocation.  Optional, If 
%     not provided, the name of the file or directory is used.
%
% EXAMPLES:
% Example 1: To create a link to the directory C:\DestinationDir
%            and place it in the directory C:\linkToDir with DestinationDir
%            as the name:
% 
%            createLink('C:\DestinationDir','C:\linkToDir')
%
% Example 1: To create a link to the file C:\DestinationFile.m
%            and place it in the directory C:\linkToDir with DestinationDir
%            as the name:
% 
%            createLink('C:\DestinationFile.m','C:\linkToDir')
%
% Example 3: To create a link to the file C:\DestinationDir
%            and place it in the directory C:\linkToDir with
%            DestinationName as the name:
% 
%            createLink('C:\DestinationFile.m','C:\linkToDir',...
%                       DestinationName)
%
% NOTE: To EXTRACT the target name from the links, file
%       getTargetFromLink might be useful. (It is available
%       on the MATLAB Central File Exchange.)
%
% createLink written by Curtis Mayberry
% Curtisma3@gmail.com
%
% createLinks written by Brett Shoelson, PhD
% brett.shoelson@mathworks.com
% Thanks to Jiro Doke, PhD. for his assistance.
%


if(nargin == 2)
    [~,linkName,~] = fileparts(itemToLink);
end

asvr = actxserver('WScript.Shell');
b = asvr.CreateShortcut(fullfile(linkLocation, [linkName,'.lnk']));
b.TargetPath = itemToLink;
b.Save();