%---------------------------------------------------
% This software is the exclusive property of SUPELEC
%
% It is distributed as a MATLAB toolbox
% No part of this software can be distributed or
% modified without reference to the authors
%
% Copyright  (c) 2011  SUPELEC SSE Departement
% All rights reserved
%
% http://www.supelec.fr/361_p_10063/philippe-benabes.html
%
%---------------------------------------------------
%
% file : ls_estimate.m
% authors  : P.BENABES & C.TUGUI 
% Copyright (c) 2011 SUPELEC
% Revision: 3.0  Date: 24/03/2011
%
%---------------------------------------------------
% Modifications history
% 24 JAN 2010 	: version 1.0
% 28 OCT 2010   : version 2.0
% 24 MAR 2011 	: version 3.0
%---------------------------------------------------
%
% DESCRIPTION DU MODULE :
%   estimates the non-linear coefficients by a mean-square method 
%
% MODULES UTILISES :
%
%---------------------------------------------------


function     [nl] = ls_estimate(xs,ys,out1,gn)
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here
    x0=mean(xs);
    delx=max(xs)-x0 ;
    
    y0=mean(ys);
    dely=max(ys)-y0 ;
    

%    a=(mean(mean(xs*out1'))-x0*V0)/mean((xs-x0).^2)
%    b=(mean(mean(ys'*out1))-y0*V0)/mean((ys-y0).^2) 
    
    Mx2 = mean((xs-x0).^2) ;
    My2 = mean((ys-y0).^2) ;
    Mx4 = mean((xs-x0).^4) ;
    My4 = mean((ys-y0).^4) ;
    Mx6 = mean((xs-x0).^6) ;
    My6 = mean((ys-y0).^6) ;
    Mx2y2 = mean(mean((((ys-y0).^2)*((xs-x0).^2)))) ;

    Mm = mean(mean(out1)) ;
    Mxm = mean(mean((ones(size(ys))*(xs-x0)).*out1)) ;
    Mym = mean(mean(((ys-y0)*ones(size(xs))).*out1)) ;
 %   Mxym = mean(mean(((ys-y0)*(xs-x0)).*out1)) ;
    Mx2m = mean(mean((ones(size(ys))*((xs-x0).^2)).*out1)) ;
    My2m = mean(mean((((ys-y0).^2)*ones(size(xs))).*out1)) ;
    Mx3m = mean(mean((ones(size(ys))*((xs-x0).^3)).*out1)) ;
    My3m = mean(mean((((ys-y0).^3)*ones(size(xs))).*out1)) ;
    

%    a=Mxm/Mx2
%    b=Mym/My22
    cxy=mean(mean(((ys-y0)*(xs-x0)).*out1))/Mx2/My2 ;
    
    r=[Mx2m Mm My2m] / [ Mx2 Mx4 Mx2y2 ; 1 Mx2 My2 ; My2 Mx2y2 My4 ]' ;
    c0=r(1) ; cx2=r(2) ; cy2=r(3) ;

    r=[Mxm Mx3m] / [ Mx2 Mx4 ; Mx4 Mx6 ]' ;
    cx1=r(1) ; cx3=r(2) ;
    
    r=[Mym My3m] / [ My2 My4 ; My4 My6 ]' ;
    cy1=r(1) ; cy3=r(2) ;
    
    % estimation lineaire
    Vs=Mm ;
    cx1s=Mxm/Mx2 ;
    cy1s=Mym/My2 ;
    
    %p=c0+cx1*(ones(size(ys))*(xs-x0))+cy1*((ys-y0)*ones(size(xs)))+cxy*((ys-y0)*(xs-x0))+cx2*(ones(size(ys))*((xs-x0).^2))+cy2*(((ys-y0).^2)*ones(size(xs)))+cx3*(ones(size(ys))*((xs-x0).^3))+cy3*(((ys-y0).^3)*ones(size(xs))) ;
    p1=Vs+cx1s*(ones(size(ys))*(xs-x0))+cy1s*((ys-y0)*ones(size(xs))) ;
    
    %err=out1-p ;    % erreur residuelle apres suppression de tous les termes
    err1=out1-p1 ;
        
    %See the description of parameters in doc -> they are non-dimensional
    nl.cx1n=cx1*delx /(gn*delx) ;
    nl.cy1n=cy1*dely /(gn*delx) ;
    nl.cxyn=cxy*delx*dely /(gn*delx) ;
    nl.cx2n=cx2*delx^2 /(gn*delx) ;
    nl.cy2n=cy2*dely^2 /(gn*delx) ;
    nl.cx3n=cx3*delx^3 /(gn*delx) ;
    nl.cy3n=cy3*dely^3 /(gn*delx) ;
    nl.ct=sqrt(mean(mean(err1.*err1))) ;       % non linearite totale
    nl.c0=c0 ;
    nl.cx1=cx1 ;
    nl.cy1=cy1 ;
    nl.cx2=cx2 ;
    nl.cy2=cy2 ;
    nl.cxy=cxy ;
    nl.cx3=cx3 ;
    nl.cy3=cy3 ;
    