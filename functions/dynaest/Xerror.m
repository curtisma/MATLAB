%%% DynaEst 3.032 01/02/2001
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% Xerror : calucalter xe according to the nxactual
function y = Xerror(nxactual,nx,xt,nxf,x)

if (nx == nxactual) & (nxf == nxactual)
    y = xt - x ;
end
if nx > nxactual 
    xt = xt(1:4); 
end
if nxf > nxactual 
    x = x(1:4) ;
end
y = xt-x ;
