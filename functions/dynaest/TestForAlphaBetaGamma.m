%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%TestForAlphaBetaGamma Test Ft,Ht and Gt to find whether alpha_beta_gamma Filter is suitable

function result = TestForAlphaBetaGamma(ncoor,nx,nz,Ftstr,Htstr,Gtstr)

result = 0;
if nx ~= (ncoor*3)
   return;
end

 T = 100000;
 A = eye(ncoor);
 F = [
    1 T T^2/2
    0 1 T
    0 0 1];
 H = [1 0 0];
 G = [
    T^2/2 
    T    
    1
    ];
    
 for i=1:nx
    F2(i,:) = eval(['[',Ftstr{i},']']);  
    G2(i,:) = eval(['[',Gtstr{i},']']);  
 end
 for i=1:nz
    H2(i,:) = eval(['[',Htstr{i},']']);  
 end


 F1 = kron(A,F);
 [m1 n1] = size(F1);
 [m2 n2] = size(F2);
 if m1== m2 & n1 == n2
    if F1 == F2
    else   return;
    end
 else
    return;
 end
 
 
 H1 = kron(A,H);
 [m1 n1] = size(H1);
 [m2 n2] = size(H2);
 if m1== m2 & n1 == n2
    if H1 == H2
    else   return;
    end
 else
    return;
 end
 
 G1 = kron(A,G);
 [m1 n1] = size(G1);
 [m2 n2] = size(G2);
 if m1== m2 & n1 == n2
    if G1 == G2
    else   return;
    end
 else
    return;
 end
 
 result = 1;
 return;
 