function y = myfunc( u )
%MYFUNC This function takes a numeric input and doubles it
%
%  Copyright 2016 The MathWorks, Inc.

% Check input argument
validateattributes( u, {'numeric'}, {'nonempty'} );

y = 2*u;

end


