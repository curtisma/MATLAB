function createIndexPage( filename, toolboxes )
%createIndexPage  Create index page
%
%  minimart.createIndexPage(f,t) creates an index page for toolboxes t at
%  the filename f.

%  Copyright 2016 The MathWorks, Inc.
%  $Revision: 211 $ $Date: 2015-08-12 08:29:30 +0100 (Wed, 12 Aug 2015) $

% Constants
title = 'MATLAB Minimart (demo)';

% Extract folder from filename
folder = fileparts( filename );

% Create summaries
n = numel( toolboxes );
if n == 0
    content = '<p style="text-align: center;">Nothing to see here.</p>';
else
    cards = cell( n, 1 ); % initialize
    for ii = 1:n
        cards{ii} = card( folder, toolboxes(ii) );
    end
    content = [cards{:}];
end

% Fill in template
package = fileparts( mfilename( 'fullpath' ) );
resources = fullfile( package, '..', 'resources' );
s = fileread( fullfile( resources, 'template.html' ) );
s = strrep( s, '<!-- title -->', title );
s = strrep( s, '<!-- content -->', content );

% Write to file
f = fopen( filename, 'w+' );
fileCleanUp = onCleanup( @() fclose( f ) );
fprintf( f, '%s', s );

end % createIndexPage

function s = card( folder, toolbox )
%card  Create summary card for one toolbox
%
%  s = card(f,t) creates a summary for the toolbox t for the folder f.

% Constants
thumbnailHeight = 200; % thumbnail height [pixels]
spacing = 1.25; % line spacing [multiplier]
fontSize = 14; % font size [pixels]
numSummaryLines = 3; % number of summary lines

% Create
imageName = sprintf( '%s-%s.png', toolbox.Guid, toolbox.Version );
ss = toolbox.Screenshot;
minimart.pngwrite( ss.cdata, ss.map, ss.alpha, fullfile( folder, 'images', imageName ) )
image = sprintf( '<img src="images/%s" class="toolboxCardThumbnail" alt="thumbnail"/>', imageName );
imageContainer = sprintf( '<div class="thumbnailContainer" style="text-align: center; height: %dpx;">%s</div>', thumbnailHeight, image );
title = sprintf( '<h3>%s</h3>', strtrunc( toolbox.Name, 20 ) );
summary = sprintf( '<p style="line-height: %f; font-size: %dpx; height: %fpx;overflow-y: auto">%s</p>', spacing, fontSize, spacing * fontSize * numSummaryLines, toolbox.Summary );
detailFilename = sprintf( '%s.html', toolbox.Guid );
button = sprintf( '<a href="%s" class="btn btn_secondary">More info...</a>', detailFilename );
buttonContainer = sprintf( '<p style="text-align: right;">%s</p>', button );
caption = sprintf( '<div class="caption">%s%s%s</div>', title, summary, buttonContainer );
thumbnail = sprintf( '<div class="thumbnail">%s%s</div>', imageContainer, caption );
s = sprintf( '<div class="col-sm-6 col-md-4 col-lg-3">%s</div>', thumbnail );

end % summary

function s = strtrunc( s, n )
%strtrunc  Truncate string

if numel( s ) > n
    s = sprintf( '%s...', s(1:n-3) );
end

end % strtrunc