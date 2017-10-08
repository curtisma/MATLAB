function mksandbox( toolboxName, varargin )
%mksandbox Create a template sandbox in a pre-specified
%location.
%
% e.g:
%    mksandbox( 'MyToolbox' )
%    mksandbox( 'MyToolbox', 'C:\Work\Examples' )
%
% Copyright 2016 The MathWorks, Inc.

cdir = fileparts( mfilename( 'fullpath' ) );
mlver = ver( 'matlab' );
items = { 'getting_started.html',   'GETTING_STARTED',  'Getting Started',      'Learn the basics of the toolbox'; ...
          'classes.html',           'CLASS',            'Classes',              'List of toolbox classes'; ...
          'functions.html',         'FUNCTION',         'Functions',            'List of toolbox functions';...
          'examples.html',          'EXAMPLES',         'Examples',             'Examples to illustrate toolbox functionalities' };

% Check input arguments
assert( nargin > 0, 'Please provide a valid toolbox name as an input argument.' );
validateattributes( toolboxName, {'char'}, {'nonempty'}, '', '', 1 );

if nargin > 1
    sdir = varargin{1};
else
    sdir = pwd;
end

sbname = [toolboxName '_sandbox'];
toolboxRoot = fullfile( sdir, sbname );

% Check if toolbox location exists
if ~exist( toolboxRoot, 'dir' )
    mkdir( toolboxRoot );
else
    error( 'DIR:EXIST', [ 'Directory ''%s'' already exists. ' ...
        'Please delete this folder and run the function again.' ], toolboxRoot );
end

% Copy files and folders into template folders
copyfile( fullfile( cdir, 'template' ), toolboxRoot );
tbxFolder = fullfile( toolboxRoot, 'tbx' );

% Rename toolbox folder name
movefile( fullfile( tbxFolder, '_tbxname_' ), ...
    fullfile( tbxFolder, toolboxName ) );

% Create project file at the toolbox root location
prjName = [ toolboxName '.prj'];
projectFile = fullfile( toolboxRoot, prjName );

service = com.mathworks.toolbox_packaging.services.ToolboxPackagingService();
config = service.createConfiguration( projectFile );
service.setToolboxRoot( config, tbxFolder );
service.setAuthorName( config, getenv( 'USERNAME' ) );
service.setVersion( config, '1.0' );
service.setSplashScreen(config, fullfile( toolboxRoot, 'image', 'mltoolbox.png' ) );

service.save( config );
service.closeProject( config );

% Write Contents.m file
writeContentsFile();

% Write doc files
writeinfoxml();
writehelptocxml();
writehelphtml();

% Print success statement
fprintf( 'The sandbox ''%s'' has been successfully created.\n', ...
    toolboxRoot );


    function writeContentsFile()
        %writeContentsFile
        
        cfname =  fullfile( tbxFolder, toolboxName, 'Contents.m' );
        cfid = fopen( cfname, 'w' );
        
        try
            % Write
            fprintf( cfid, '%% %s\n', toolboxName );
            fprintf( cfid, [ '%% Version 1.0 ' mlver.Release, ' ',  datestr(today) '\n' ] );
            fprintf( cfid, '%%\n' );
            fprintf( cfid, '%% Classes\n' );
            fprintf( cfid, '%%   myClass  - Perform simple arithmetics.\n%%\n' );
            fprintf( cfid, '%% Functions\n' );
            fprintf( cfid, '%%   myfunc   - Multiply input by 2.\n%%\n' );
            fprintf( cfid, '%%  Copyright 2016 The MathWorks, Inc.\n' );
            fclose(cfid);
        catch
            fclose(cfid);
            warning( 'Unable to write ''%s''', cfname );
        end
        
    end

    function writeinfoxml()
        %writeinfoxml
        
        ifname =  fullfile( tbxFolder, 'doc', 'info.xml' );
        ifid = fopen( ifname, 'w' );
        mlrelease = regexprep( regexprep( mlver.Release, '(', '' ), ')', '' );
        
        try
            % Write
            fprintf( ifid, '<productinfo xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="optional">\n' );
            fprintf( ifid, '<?xml-stylesheet type="text/xsl"href="optional"?>\n' );
            fprintf( ifid, '<!-- Copyright %s The MathWorks Ltd. -->\n\n', datestr( now, 'yyyy' ) );
            fprintf( ifid, '<matlabrelease>%s</matlabrelease>\n', mlrelease );
            fprintf( ifid, '<name>%s</name>\n', toolboxName );
            fprintf( ifid, '<type>toolbox</type>\n' );
            fprintf( ifid, '<icon></icon>\n' );
            fprintf( ifid, '<help_location>.</help_location>\n\n' );
            fprintf( ifid, '</productinfo>\n' );
            fclose(ifid);
        catch
            fclose(ifid);
            warning( 'Unable to write ''%s''', ifname );
        end
        
    end

    function writehelptocxml()
        %writehelptocxml
        
        hfname =  fullfile( tbxFolder, 'doc', 'helptoc.xml' );
        hfid = fopen( hfname, 'w' );
        
        try
            % Write
            fprintf( hfid, '<?xml version=''1.0'' encoding="utf-8"?>\n\n' );
            fprintf( hfid, '<toc version="2.0">\n' );
            fprintf( hfid, ['    <tocitem target="toolbox_overview.html"> ' toolboxName ' Toolbox\n'] );
            
            for k = 1:size( items, 1 )
                fprintf( hfid, ['        <tocitem target="' items{k,1} '" image="HelpIcon.' items{k,2} '">\n' ] );
                fprintf( hfid, ['            ' items{k,3} '\n'] );
                fprintf( hfid, '        </tocitem>\n' );
            end
            
            fprintf( hfid, '    </tocitem>\n' );
            fprintf( hfid, '</toc>\n' );
            fclose(hfid);
        catch
            fclose(hfid);
            warning( 'Unable to write ''%s''', hfname );
        end
        
    end

    function writehelphtml()
        %writehelphtml
        
        hfname =  fullfile( tbxFolder, 'doc', 'toolbox_overview.html' );
        hfid = fopen( hfname, 'w' );
        
        try
            % Write
            fprintf( hfid, '<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">\n' );
            fprintf( hfid, '<link href="css/doc_center.css" rel="stylesheet" type="text/css">\n\n' );
            fprintf( hfid, '<section id="doc_center_content" lang="en">\n' );
            fprintf( hfid, '    <div id="pgtype-topic">\n' );
            fprintf( hfid, '        <span id="top" class="anchor_target"></span>\n' );
            fprintf( hfid, ['        <h1 class="title r2015b" id="">' toolboxName ' Toolbox</h1>\n'] );
            fprintf( hfid, '        <div itemprop="content">\n' );
            fprintf( hfid, '            <h2 id="descrip">Description</h2>\n' );
            fprintf( hfid, '            <p>This MATLAB toolbox provides functionality to:\n' );
            fprintf( hfid, '                <ul>\n' );
            fprintf( hfid, '                    <li><p>*feature 1*<p></li>\n' );
            fprintf( hfid, '                    <li><p>*feature 2*<p></li>\n' );
            fprintf( hfid, '                </ul>\n' );
            fprintf( hfid, '            </p>\n' );
            fprintf( hfid, '        </div>\n' );
            fprintf( hfid, '    </div>\n\n\n' );
            
            for k = 1:size( items, 1 )
                fprintf( hfid, ['    <h3><a href="' items{k,1} '"> ' items{k,3} '</a></h3>\n' ] );
                fprintf( hfid, ['    <p class="category_desc"> ' items{k,4} '</p>\n\n'] );
            end
            
            fprintf( hfid, '</section>\n' );
            
            fclose(hfid);
        catch
            fclose(hfid);
            warning( 'Unable to write ''%s''', hfname );
        end
    end
        
end %mksandbox

