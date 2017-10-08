function [L,U,p] = lu(A)
    [L,U,p] = lutx(A);
    L = fp16(L);
    U = fp16(U);
    % p = flints
end % fp16/lu