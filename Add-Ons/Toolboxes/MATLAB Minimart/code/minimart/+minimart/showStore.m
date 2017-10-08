function showStore( store, varargin )
%showStore  Show store
%
%  minimart.showStore(s) shows the store s.
%
%  minimart.showStore(...,o) passes the extra inputs o to web.

%  Copyright 2016 The MathWorks, Inc.
%  $Revision: 211 $ $Date: 2015-08-12 08:29:30 +0100 (Wed, 12 Aug 2015) $

site = minimart.Site( store );
site.show( varargin{:} )

end % showStore