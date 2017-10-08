function s = publishedToolboxes( f )
%minimart.publishedToolboxes  Return information about published toolboxes
%
%  t = minimart.publishedToolboxes(f) returns a struct array containing
%  information about published toolboxes in the folder f.  Each struct
%  contains the fields Filename, Name, Version and Guid.
%
%  See also: matlab.addons.toolbox.installedToolboxes

%  Copyright 2016 The MathWorks, Inc.
%  $Revision: 211 $ $Date: 2015-08-12 08:29:30 +0100 (Wed, 12 Aug 2015) $

if nargin == 0, f = pwd(); end % handle missing input
s = repmat( struct( 'Filename', '', 'Name', '', 'Version', '', ...
    'Guid', '' ), [1 0] );
d = dir( fullfile( f, '*.mltbx' ) );
for ii = 1:numel( d )
    if d(ii).isdir, continue, end
    n = fullfile( f, d(ii).name );
    m = mlAddonGetProperties( n ); % undocumented
    s(end+1) = struct( 'Filename', n, 'Name', m.name, ...
        'Version', m.version, 'Guid', m.GUID ); %#ok<AGROW>
end

end % publishedToolboxes