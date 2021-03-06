function y = fp8(x)
% FP8.  Constructor for "fp8" 8-bit floating point,
% also known as "quarter precision".
% y = fp8(x) has one field, y.u, a uint8 packed with
% one sign bit, 3 exponent bits, and 4 fraction bits.
% See also: fp8/double

    if nargin == 0
        y.u = uint8([]);
        y = class(y,'fp8');       
    elseif isa(x,'fp8')
        y = x;
    else
        [m,n] = size(x);
        u = zeros(m,n,'uint8');
        for k = 1:m
            for j = 1:n
                u(k,j) = pack8(double(x(k,j)));
            end
        end
        y.u = u;
        y = class(y,'fp8');
    end

    % ---------------------------------------------------------
    
    function u = pack8(x)
    % u = pack8(x) packs single or double x into uint8 u.
        if x == 0
            u = uint8(0);
        elseif isnan(x)
            u = uint8(Inf);
        elseif isinf(x)
            u = uint8(112);
        else
            % finite and nonzero x
            [f,e] = log2(abs(x));
            f = 2*f-1;  % Remove hidden bit
            e = e-1;
            if e > 4
                % overflow u, inf = 7*2^4
                u = uint8(112);
            elseif e < -2
                % denormal u
                u = uint8(fix(2^(6+e)*(1+f)));
            else
                % normal (finally)
                u = bitxor(uint8(fix(16*f)), bitshift(uint8(e+3),4));
            end
        end
        s = 1-min(sign(x)+1,1); % sign bit
        u = bitxor(u,bitshift(s,7));
    end
end
