%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%ISHERMIT    check whether a matrix is Hermitian (symmetric)
function yes=Ishermit(A)
if (any(any(A-conj(A)))~=0)
  yes=0;               % A is not Hermitian (symmetric)
else
  yes=1;               % A is Hermitian (symmetric)
end
return
