function s = toolboxMetadata( n )
%minimart.toolboxMetadata  Query metadata of toolbox
%
%  s = minimart.toolboxMetadata(n) returns a struct s containing metadata
%  for the toolbox with filename n.  The struct contains the fields
%  Filename, Name, Version, Guid, Author, Contact, Organization, Summary,
%  Description and Screenshot.

%  Copyright 2016 The MathWorks, Inc.
%  $Revision: 211 $ $Date: 2015-08-12 08:29:30 +0100 (Wed, 12 Aug 2015) $

m = mlAddonGetProperties( n ); % undocumented
s = struct( 'Filename', n, 'Name', m.name, ...
    'Version', m.version, 'Guid', m.GUID, 'Author', m.authorName, ...
    'Contact', m.authorContact, 'Organization', m.authorOrganization, ...
    'Summary', m.summary, 'Description', m.description, ...
    'Screenshot', getScreenShot( n ) );

end % toolboxMetadata

function s = getScreenShot( addonFilename )
%getScreenShot  Get screenshot from mltbx file

extension = 'png';
addon = com.mathworks.mladdonpackaging.AddonPackage( addonFilename ); % undocumented
icon = addon.getScreenShot();
image = icon.getImage();
if isempty( image )
    pk = fileparts( mfilename( 'fullpath' ) );
    imageFilename = fullfile( pk, '..', 'resources', 'images', 'ml_logo.png' );
    [s.cdata, s.map, s.alpha] = imread( imageFilename );
else
    [addonPath, addonName] = fileparts( addonFilename );
    imageFilename = fullfile( addonPath, [addonName extension] );
    javax.imageio.ImageIO.write( image, extension, java.io.File( imageFilename ) );
    [s.cdata, s.map, s.alpha] = imread( imageFilename );
    delete( imageFilename ) % clean up
end

end % getScreenShot