%%% DynaEst 3.032 02/16/2001
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%Xactaul : Output the actual dimension of X 
function y = Xactual(ncoor,nx,nxf,nmt,ModeSystem)

nxactual = nx ;
if (nx == 4 | nx == 5) & (nxf == 4 | nxf ==5) & ncoor == 2
    if (nx == 4 | nxf == 4) & ncoor == 2 
        nxactual = 4;
    end
    if nmt > 1 
        if ~isempty(find([ModeSystem{:,9}]~=3)) & nxf == 5 
            nxactual = 4 ;
        end
    else
        if nx~= 5 & nxf == 5
            nxaxtual = 4 ;
        end
    end
end

y = nxactual ;
    
    