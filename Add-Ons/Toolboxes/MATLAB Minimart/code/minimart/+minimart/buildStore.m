function buildStore( store )
%buildStore  Build store
%
%  minimart.buildStore(s) builds the store s.

%  Copyright 2016 The MathWorks, Inc.
%  $Revision: 211 $ $Date: 2015-08-12 08:29:30 +0100 (Wed, 12 Aug 2015) $

site = minimart.Site( store );
site.build()

end % buildStore