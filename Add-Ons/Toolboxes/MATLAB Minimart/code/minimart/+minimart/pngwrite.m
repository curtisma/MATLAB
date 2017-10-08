function pngwrite( cdata, map, alpha, filename )
%pngwrite  Write image data to PNG file
%
%  minimart.pngwrite(cdata,map,alpha,filename) writes a PNG file with the
%  specified color data, color map and transparency data to the specified
%  filename.  Unlike imwrite, pngwrite handles empty color maps and
%  transparency data gracefully.

%  Copyright 2016 The MathWorks, Inc.
%  $Revision: 211 $ $Date: 2015-08-12 08:29:30 +0100 (Wed, 12 Aug 2015) $

if isempty( map )
    data = {cdata};
else
    data = {cdata map};
end
if isempty( alpha )
    options = {};
else
    options = {'Alpha', alpha};
end
imwrite( data{:}, filename, 'png', options{:} );

end % pngwrite