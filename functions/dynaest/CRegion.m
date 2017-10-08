%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% CRegion : Confidence region for the NEES, NIS

function y = CRegion(nrun,nx,nz,ViewStatusFlag )
switch ViewStatusFlag
    case 6 %DRAW_NEES 
        ntemp = nx ;
    case 7 %DRAW_NIS
        ntemp = nz ;
end

numDegreesofFreedom = nrun*ntemp; % this is what we need in the evaluation not nrun

% if nrun*ntemp > 100 
%     y(1) = 0.5*( 1.96 + sqrt(2*nrun-1) )^2 ;
%     y(2) = 0.5*( -1.96+ sqrt(2*nrun-1) )^2 ;
%     y = y/nrun ;
%     return ;
% end

%% problem:
%% nrun should be the number of degrees of freedom
%% y(1) and y(2) should be interchanged
%% because the values below suggest that y(1) corresponds to 0.975 prob.
%% and y(2) corresponds to 0.025 prob.

%% correction
if numDegreesofFreedom > 100
    y(1) = 0.5*(-1.96+ sqrt(2*numDegreesofFreedom-1)^2);
    y(2) = 0.5*(1.96 + sqrt(2*numDegreesofFreedom-1)^2);
    return;
end

switch numDegreesofFreedom
% switch nrun*ntemp 
case 1 
   y(1) = 0.001; , y(2) = 5.02 ;  
case 2 
   y(1) = 0.051; , y(2) = 7.38 ;   
case 3
    y(1) = .216;, y(2) = 9.35 ;
case 4
    y(1) = .484;, y(2) = 11.1 ;
case 5
    y(1) = .831;, y(2) = 12.8 ;
case 6
    y(1) = 1.24;, y(2) = 14.4 ;
case 7
    y(1) = 1.69;, y(2) = 16.1 ;
case 8
    y(1) = 2.18;, y(2) = 17.5 ;
case 9
    y(1) = 2.70;, y(2) = 19.0 ;
case 10
    y(1) = 3.25;, y(2) = 20.5 ;
case 11
    y(1) = 3.82;, y(2) = 22.0 ;
case 12
    y(1) = 4.40;, y(2) =  23.3;
case 13
    y(1) = 5.01;, y(2) = 24.7 ;
case 14
    y(1) = 5.63;, y(2) = 26.1 ;
case 15
    y(1) = 6.26;, y(2) = 27.5 ;
case 16
    y(1) = 6.91;, y(2) = 28.8 ;  
case 17
    y(1) = 7.56;, y(2) = 30.2 ;
case 18
    y(1) = 8.23;, y(2) = 31.5 ;
case 19
    y(1) = 8.91;, y(2) =  32.9;
case 20
    y(1) = 9.60;, y(2) = 34.2 ;
case 25
    y(1) = 13.1;, y(2) = 40.6 ;
case 30
    y(1) = 16.8;, y(2) = 47.0 ;
case 40
    y(1) = 24.4;, y(2) = 59.3 ;
case 50
    y(1) = 32.4;, y(2) = 71.4 ;
case 60
    y(1) = 40.5;, y(2) = 83.3 ;
case 70
    y(1) = 48.8;, y(2) = 95.0 ;
case 80
    y(1) = 57.2;, y(2) =  107;
case 90
    y(1) = 65.6;, y(2) = 118 ;
case 100
    y(1) = 74.2;, y(2) = 129.6 ;
otherwise
   y = zeros(2,1) ;
end

y = y/nrun ;