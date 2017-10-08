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
% file : valv.m
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
%   get the value of a vector for a position (can be non-integer)
%
% MODULES UTILISES :
%
%---------------------------------------------------

function [ v ] = valv( vect, pos )
%SOLVEV Summary of this function goes here
%   Detailed explanation goes here

    if (length(vect)==1)
        v=vect ;
    else
        if (pos<1)
            v = vect(1)- (1-pos)*(vect(2)-vect(1)) ;
        elseif (pos>=length(vect)) 
            v = vect(end) + (pos-length(vect))*(vect(end)-vect(end-1)) ;
        else
            p=floor(pos) ;
            v=vect(p)+(pos-p)*(vect(p+1)-vect(p)) ;
        end
    end
end

