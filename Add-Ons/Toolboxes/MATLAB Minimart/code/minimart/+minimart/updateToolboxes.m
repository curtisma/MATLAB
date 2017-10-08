function updateToolboxes( folder, mode )
%minimart.updateToolboxes  Update toolboxes
%
%  minimart.updateToolboxes(f,m) updates toolboxes from the folder f in
%  the mode m ('manual', 'auto' or 'query').  In manual mode, the user is
%  prompted to confirm upgrades and downgrades.  In auto mode, only
%  upgrades are applied.  In query mode, the user is informed of available
%  upgrades and downgrades and also of current and missing items.
%
%  minimart.updateToolboxes(f) uses the default mode 'manual'.

%  Copyright 2016 The MathWorks, Inc.
%  $Revision: 211 $ $Date: 2015-08-12 08:29:30 +0100 (Wed, 12 Aug 2015) $

% Handle inputs
narginchk( 0, 2 )
if nargin < 1
    folder = pwd(); % default
end
if nargin < 2
    mode = 'manual'; % default
else
    mode = validatestring( mode, {'auto','manual','query'} );
end

% Create waitbar
switch mode
    case 'auto'
        wbVisible = 'on';
    otherwise
        wbVisible = 'off';
end
wb = waitbar( 0, '', 'Name', 'Update Toolboxes', 'Visible', wbVisible );

% Update each installed toolbox in turn
waitbar( 0, wb, 'Querying installed toolboxes...' )
locals = matlab.addons.toolbox.installedToolboxes(); % all installed-
n = numel( locals );
waitbar( 1/(n+2), wb, 'Querying published toolboxes...' )
stores = minimart.publishedToolboxes( folder ); % all published
for ii = 1:n
    waitbar( (ii+1)/(n+2), wb, 'Updating toolboxes...' );
    local = locals(ii);
    matches = stores(1,strcmp( {stores.Guid}, local.Guid ));
    updateToolbox( local, matches, mode )
end
waitbar( 1, wb )
delete( wb )

end % updateToolboxes

function updateToolbox( local, stores, mode )
%update  Update toolbox
%
%  updateToolbox(local,stores,mode) updates the toolbox

if isempty( stores ) % missing
    switch mode
        case 'query'
            fprintf( 1, '''%s'' version %s is installed, but this toolbox is not in the store.\n', ...
                local.Name, local.Version );
    end
else
    localVersion = minimart.Version( local.Version );
    storeVersions = minimart.Version( {stores.Version} );
    [maxStoreVersion, index] = max( storeVersions );
    store = stores(index);
    if localVersion < maxStoreVersion % upgrade
        switch mode
            case 'query'
                fprintf( 1, '''%s'' version %s is installed, but a later version %s is available in the store.\n', ...
                    local.Name, local.Version, store.Version )
            case 'manual'
                p = sprintf( 'Upgrade ''%s'' from version %s to version %s? (y/n) ', ...
                    local.Name, local.Version, store.Version );
                switch input( p, 's' )
                    case 'y'
                        matlab.addons.toolbox.installToolbox( store.Filename );
                end
            case 'auto'
                fprintf( 1, 'Upgrading ''%s'' from version %s to version %s... ', ...
                    local.Name, local.Version, store.Version );
                matlab.addons.toolbox.installToolbox( store.Filename );
                fprintf( 1, 'done.\n' );
        end
    elseif localVersion > maxStoreVersion % downgrade
        switch mode
            case 'query'
                fprintf( 1, '''%s'' version %s is installed, but the latest version available in the store is version %s.\n', ...
                    local.Name, local.Version, store.Version )
            case 'manual'
                p = sprintf( 'Downgrade ''%s'' from version %s to version %s? (y/n) ', ...
                    local.Name, local.Version, store.Version );
                switch input( p, 's' )
                    case 'y'
                        matlab.addons.toolbox.installToolbox( store.Filename );
                end
        end
    else % latest
        switch mode
            case 'query'
                fprintf( 1, '''%s'' version %s is installed, and is the latest version in the store.\n', ...
                    local.Name, local.Version );
        end
    end
end

end % updateToolbox