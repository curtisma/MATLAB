function varargout = svd(A)
    if nargout <= 1
        varargout{1} = svdtx(A);
    else
        [U,s,V] = svdtx(A);
        varargout{1} = fp16(U);
        varargout{2} = fp16(diag(s));
        varargout{3} = fp16(V);
    end
end % fp16/svd