classdef ( Hidden ) Site < handle
    %Site  Store site
    
    %  Copyright 2016 The MathWorks, Inc.
    %  $Revision: 211 $ $Date: 2015-08-12 08:29:30 +0100 (Wed, 12 Aug 2015) $
    
    properties ( SetAccess = immutable )
        Store
    end
    
    properties ( GetAccess = private, SetAccess = immutable )
        Root
        Index
        Cache
    end
    
    properties
        Waitbar = 'on'
    end
    
    properties ( Constant, Access = private )
        CacheVersion = '1.0'
    end
    
    methods
        
        function obj = Site( store )
            %minimart.Site  Construct site
            %
            %  s = minimart.Site(f) constructs a site for files in the
            %  folder f.
            
            % Check input
            validateattributes( store, {'char'}, {'row'} );
            assert( exist( store, 'dir' ) == 7,...
                'The store location ''%s'' does not exist.', store )
            
            % Store properties
            obj.Store = char( java.io.File( store ) );
            obj.Root = fullfile( obj.Store, 'www' );
            obj.Index = fullfile( obj.Root, 'index.html' );
            obj.Cache = fullfile( obj.Root, 'toolboxcache.mat' );
            
        end % constructor
        
        function set.Waitbar( obj, value )
            
            % Check and set
            obj.Waitbar = validatestring( value, {'on','off'} );
            
        end % set.Waitbar
        
        function build( obj )
            %build  Build site
            %
            %  s.build() builds the site s.
            
            % Create waitbar
            wb = waitbar( 0, 'Finding toolboxes...', ...
                'Name', 'Build Site', 'Visible', obj.Waitbar );
            
            % Find toolboxes
            toolboxes = minimart.publishedToolboxes( obj.Store );
            
            % If unchanged since last time then return
            version = obj.CacheVersion;
            if exist( obj.Cache, 'file' )
                cache = load( obj.Cache );
                if isequal( cache.version, version ) && ...
                        isequal( cache.toolboxes, toolboxes )
                    waitbar( 1, wb )
                    delete( wb )
                    return
                end
            end
            
            % Purge old files
            if exist( obj.Root, 'dir' )  == 7
                rmdir( obj.Root, 's' );
            end
            mkdir( obj.Root )
            
            % Copy resources
            pk = fileparts( mfilename( 'fullpath' ) );
            tbx = fileparts( pk );
            folders = {'css','js','images'};
            for ii = 1:numel( folders )
                copyfile( fullfile( tbx, 'resources', folders{ii} ), ...
                    fullfile( obj.Root, folders{ii} ) )
            end
            
            % Copy MATLAB shipped files
            copyfile( fullfile( docroot, 'includes', 'product', 'scripts', 'jquery', 'jquery-latest.js' ), ...
                    fullfile( obj.Root, 'js', 'jquery.js' ) )
            copyfile( fullfile( docroot, 'includes', 'product', 'scripts', 'bootstrap.min.js' ), ...
                    fullfile( obj.Root, 'js', 'bootstrap.min.js' ) )
            copyfile( fullfile( docroot, 'includes', 'product', 'css', 'bootstrap.min.css' ), ...
                    fullfile( obj.Root, 'css', 'bootstrap.min.css' ) )
            
            % Retrieve toolbox metadata
            nt = numel( toolboxes );
            if nt == 0
                groupedMetadata = cell( [1 0] );
            else
                for ii = 1:nt
                    waitbar( ii/nt/2, wb, 'Extracting metadata...' )
                    filename = toolboxes(ii).Filename;
                    flatMetadata(ii) = minimart.toolboxMetadata( filename ); %#ok<AGROW>
                end
                groupedMetadata = groupMetadata( flatMetadata );
            end
            
            % Create index page
            latestMetadata = cellfun( @(x)x(1), groupedMetadata );
            waitbar( 1/2, wb, 'Creating index...' )
            minimart.createIndexPage( obj.Index, latestMetadata );
            
            % Create detail pages
            ng = numel( groupedMetadata );
            for ii = 1:ng
                waitbar( 1/2+ii/ng/2, wb, 'Building toolbox pages...' )
                detailPageName = fullfile( obj.Root, [groupedMetadata{ii}(1).Guid '.html'] );
                minimart.createDetailPage( detailPageName, groupedMetadata{ii} );
            end
            
            % Save cache
            save( obj.Cache, 'toolboxes', 'version', '-mat' )
            
            % Clean up
            delete( wb )
            
        end % build
        
        function show( obj, varargin )
            %show  Show site
            %
            %  s.show() shows the site s.
            %
            %  s.show(o) shows the store using the browser options o.
            
            web( obj.Index, varargin{:} )
            
        end % show
        
    end % public methods
    
    methods ( Static, Hidden )
        
        function pingBrowser()
            %pingBrowser  Ping browser
            
            [~, browser] = web(); % get current browser
            browser.executeScript( 'pingFromMatlab();' ) % ping
            
        end % pingBrowser
        
    end % hidden static methods
    
end % classdef

function g = groupMetadata( s )
%groupMetadata  Group and sort toolbox metadata
%
%  g = groupMetadata(s) groups toolbox metadata by GUID, sorting versions
%  by Version and groups by Name.

if isempty( s )
    g = cell( size( s ) );
else
    t = struct2table( s ); % convert to table
    t.Version = minimart.Version( t.Version ); % convert version to sortable object
    t = sortrows( t, 'Version', 'descend' ); % sort by Version
    t.Version = cellstr( t.Version ); % convert version back to string
    s = transpose( table2struct( t ) ); % convert back to struct
    g = splitapply( @(x){x}, s, findgroups( {s.Guid} ) ); % group by Guid
    n = cellfun( @(o)o(1).Name, g, 'UniformOutput', false ); % extract names
    [~, i] = sort( n ); % sort names
    g = g(i); % sort groups by Name
end

end % groupMetadata