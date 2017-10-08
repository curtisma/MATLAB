function installToolbox( remoteFilename, license, silent )
%installToolbox  Install toolbox file
%
%  minimart.installToolbox(filename,license,silent) installs the toolbox
%  file (.mltbx file) filename.  license is an indicator to accept the
%  toolbox license agreement (default false).  If the toolbox does not have
%  a license agreement, the value of license has no effect on installation.
%  silent is an indicator to install silently (default true).  If silent is
%  false, the user must click through a confirmation dialog to install the
%  toolbox.

%  Copyright 2016 The MathWorks, Inc.
%  $Revision: 211 $ $Date: 2015-08-12 08:29:30 +0100 (Wed, 12 Aug 2015) $

% Handle inputs
if nargin < 2, license = false; end
if nargin < 3, silent = true; end

% Install
try % URL
    url = java.net.URL( remoteFilename );
    protocol = char( url.getProtocol() );
    switch protocol
        case 'file'
            host = char( url.getHost() );
            file = char( java.io.File( url.getFile() ) );
            if isempty( host ) % \foo\bar or X:\foo\bar
                localFilename = file;
            else % \\foo\bar
                localFilename = sprintf( '\\\\%s%s', host, file );
            end
        case {'http','https'}
            localFilename = sprintf( '%s.mltbx', tempname() );
            websave( localFilename, remoteFilename );
        otherwise
            error( 'minimart:Unsupported', 'Unsupported protocol ''%s''.', ...
                protocol )
    end
catch % file
    localFilename = char( java.io.File( remoteFilename ) );
end

% Install
if silent
    matlab.addons.toolbox.installToolbox( localFilename, license )
else
    open( localFilename )
end

end % installToolbox