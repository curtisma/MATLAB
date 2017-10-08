classdef ( Hidden ) Version
    %Version  Software version
    
    %  Copyright 2016 The MathWorks, Inc.
    %  $Revision: 211 $ $Date: 2015-08-12 08:29:30 +0100 (Wed, 12 Aug 2015) $
    
    properties ( SetAccess = private )
        String % version string
        Numbers % version numbers
    end
    
    properties ( Constant, Access = private )
        MinimumLength = 2 % minimum length
    end
    
    methods
        
        function obj = Version( s )
            %minimart.Version  Software version
            %
            %  v = minimart.Version(s) creates a version object for the
            %  version string s.
            %
            %  v = minimart.Version(c) creates an array of version objects
            %  for the cell array of strings c.
            
            if nargin == 0
                obj.Numbers = 0;
            elseif ischar( s )
                [n, s] = obj.parse( s );
                obj.String = s;
                obj.Numbers = n;
            elseif iscellstr( s ) && isempty( s )
                obj = minimart.Version.empty( size( s ) );
            elseif iscellstr( s ) % && ~isempty( s )
                sz = size( s );
                for ii = 1:numel( s )
                    obj(ii) = minimart.Version( s{ii} ); %#ok<AGROW>
                end
                obj = reshape( obj, sz );
            else
                error( 'minimart:InvalidArgument', ...
                    'Input must be a string or a cell array of strings.' )
            end
            
        end % constructor
        
        function tf = eq( a, b )
            %eq  Determine equality
            %
            %  tf = eq(a,b) is called for tf = a == b.
            
            tf = strcmp( cellstr( a ), cellstr( b ) );
            
        end % eq
        
        function tf = ne( a, b )
            %ne  Determine inequality
            %
            %  tf = ne(a,b) is called for tf = a ~= b.
            
            tf = ~eq( a, b );
            
        end % ne
        
        function tf = lt( a, b )
            %lt  Determine less than
            %
            %  tf = lt(a,b) is called for tf = a < b.
            
            % Check sizes and perform scalar expansion
            if isscalar( a ) && ~isscalar( b )
                a = repmat( a, size( b ) );
            elseif ~isscalar( a ) && isscalar( b )
                b = repmat( b, size( a ) );
            else
                assert( isequal( size( a ), size( b ) ), ...
                    'minimart:InvalidArgument', 'Sizes must agree.' )
            end
            
            % Compare
            tf = true( size( a ) ); % preallocate
            for ii = 1:numel( a )
                na = a(ii).Numbers;
                nb = b(ii).Numbers;
                na(end+1:numel( nb )) = 0; % pad
                nb(end+1:numel( na )) = 0; % pad
                delta = na - nb;
                index = find( delta, 1 );
                tf(ii) = ~isempty( index ) && delta(index) < 0;
            end
            
        end % lt
        
        function tf = le( a, b )
            %le  Determine less than or equal to
            %
            %  tf = le(a,b) is called for tf = a <= b.
            
            tf = a == b | a < b;
            
        end % le
        
        function tf = gt( a, b )
            %gt  Determine greater than
            %
            %  tf = gt(a,b) is called for tf = a > b.
            
            tf = lt( b, a );
            
        end % gt
        
        function tf = ge( a, b )
            %ge  Determine greater than or equal to
            %
            %  tf = ge(a,b) is called for tf = a >= b.
            
            tf = le( b, a );
            
        end % ge
        
        function [o, j] = sort( obj, varargin )
            %sort  Sort versions
            %
            %  b = sort(a) sorts the elements of a in ascending order along
            %  the first array dimension whose size does not equal 1.
            %
            %  b = sort(a,dim) returns the sorted elements of a along
            %  dimension dim.  For example, if a is a matrix, then
            %  sort(a,2) sorts the elements in each row.
            %
            %  b = sort(...,direction) returns sorted elements of a in the
            %  order specified by direction using any of the previous
            %  syntaxes.  'ascend', indicates ascending order (default) and
            %  'descend' indicates descending order.
            %
            %  [b,i] = sort(...) also returns a collection of index vectors
            %  for any of the previous syntaxes.  i is the same size as a
            %  and describes the arrangement of the elements of a into b
            %  along the sorted dimension, such that b = a(i).
            
            [r, s] = rank( obj );
            [i, j] = sort( r, varargin{:} );
            o = s(i);
            
        end % sort
        
        function tf = issorted( obj, varargin )
            %issorted  Determine whether array is sorted
            %
            %  tf = issorted(a) returns true when the elements of a vector
            %  are listed in ascending order and false otherwise.
            
            r = rank( obj );
            tf = issorted( r, varargin{:} );
            
        end % issorted
        
        function [m, i] = min( obj, varargin )
            %min  Minimum version
            %
            %  Versions are sorted first by major, then by minor, then by
            %  revision, and finally by build.
            %
            %  If a is a vector, then min(a) returns the minimum element of
            %  a.
            %
            %  If a is a matrix, then min(a) is a row vector containing the
            %  minimum element of each column.
            %
            %  If a is a multidimensional array, then min(a) operates along
            %  the first array dimension whose size does not equal 1,
            %  treating the elements as vectors.  The size of this
            %  dimension becomes 1 while the sizes of all other dimensions
            %  remain the same.  If a is an empty array with first
            %  dimension 0, then min(a) returns an empty array with the
            %  same size as A.
            %
            %  m = min(a,[],dim) returns the smallest elements along
            %  dimension dim.  For example, if a is a matrix, then
            %  min(a,[],2) is a column vector containing the minimum value
            %  of each row.
            %
            %  [m,i] = min(...) finds the indices of the minimum values of
            %  a and returns them in output vector i, using any of the
            %  input arguments in the previous syntaxes.  If the minimum
            %  value occurs more than once, then min returns the index
            %  corresponding to the first occurrence.
            
            if nargin == 2
                validateattributes( obj, {'minimart.Version'}, {'scalar'} )
                validateattributes( varargin{:}, {'minimart.Version'}, {'scalar'} )
                [m, i] = min( [obj varargin{:}] );
            else
                [r, s] = rank( obj );
                [n, i] = min( r, varargin{:} );
                m = reshape( s(n), size( n ) );
            end
            
        end % min
        
        function [m, i] = max( obj, varargin )
            %max  Maximum version
            %
            %  Versions are sorted first by major, then by maxor, then by
            %  revision, and finally by build.
            %
            %  If a is a vector, then max(a) returns the maximum element of
            %  a.
            %
            %  If a is a matrix, then max(a) is a row vector containing the
            %  maximum element of each column.
            %
            %  If a is a multidimensional array, then max(a) operates along
            %  the first array dimension whose size does not equal 1,
            %  treating the elements as vectors.  The size of this
            %  dimension becomes 1 while the sizes of all other dimensions
            %  remain the same.  If a is an empty array with first
            %  dimension 0, then max(a) returns an empty array with the
            %  same size as A.
            %
            %  m = max(a,[],dim) returns the largeest elements along
            %  dimension dim.  For example, if a is a matrix, then
            %  max(a,[],2) is a column vector containing the maximum value
            %  of each row.
            %
            %  [m,i] = max(...) finds the indices of the maximum values of
            %  a and returns them in output vector i, using any of the
            %  input arguments in the previous syntaxes.  If the maximum
            %  value occurs more than once, then max returns the index
            %  corresponding to the first occurrence.
            
            if nargin == 2
                validateattributes( obj, {'minimart.Version'}, {'scalar'} )
                validateattributes( varargin{:}, {'minimart.Version'}, {'scalar'} )
                [m, i] = max( [obj varargin{:}] );
            else
                [r, s] = rank( obj );
                [n, i] = max( r, varargin{:} );
                m = reshape( s(n), size( n ) );
            end
            
        end % max
        
        function c = cellstr( obj )
            %cellstr  Convert to cell array of strings
            %
            %  c = cellstr(v) converts the version array v to a cell array
            %  of version strings c.
            
            c = reshape( {obj.String}, size( obj ) );
            
        end % cellstr
        
    end % public methods
    
    methods ( Access = private )
        
        function [r, s] = rank( obj )
            %rank  Rank objects
            %
            %  [r,s] = rank(v) returns a matrix of object ranks r that is
            %  the same size as v, and a sorted vector of objects s.
            
            if isempty( obj )
                m = zeros( size( obj ) );
            else
                for ii = 1:numel( obj )
                    n = obj(ii).Numbers;
                    m(ii,1:numel( n )) = n; %#ok<AGROW>
                end
            end
            [~, a] = sortrows( m );
            s = obj(a); % vector of sorted objects
            r(a) = transpose( 1:numel( a ) );
            r = reshape( r, size( obj ) ); % matrix of ranks
            
        end % rank
        
    end % helper methods
    
    methods ( Static, Access = private )
        
        function [n, s] = parse( s )
            %parse  Parse version string
            %
            %  [n,c] = minimart.Version.parse(s) parses the version string
            %  s and returns the version numbers n and the canonical
            %  version string c.
            
            % Check, split and parse
            assert( all( (s>='0'&s<='9')|(s=='.') ), ...
                'minimart:InvalidArgument', ...
                'Version strings can contain only digits and periods.' )
            c = strsplit( s, '.', 'CollapseDelimiters', false );
            assert( ~any( strcmp( c, '' ) ), ...
                'minimart:InvalidArgument', ...
                'Version strings cannot contain leading, trailing or consecutive periods.' )
            n = cellfun( @str2double, c );
            
            % Pad or trim
            ml = minimart.Version.MinimumLength; % minimum length
            lnz = find( n ~= 0, 1, 'last' ); % last non-zero
            if isempty( lnz )
                n = zeros( [1 ml] );
            elseif lnz > ml
                n(lnz+1:end) = []; % trim
            else
                n(end+1:ml) = 0; % pad
                n(ml+1:end) = []; % trim
            end
            
            % Create canonical string
            s = sprintf( '.%d', n );
            s(1) = []; % trim leading .
            
        end % parse
        
    end % static methods
    
end % classdef