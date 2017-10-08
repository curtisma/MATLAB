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
% file : solvev.m
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
%   cherche l'indice pour lequel un vecteur croissant est nul
%
% MODULES UTILISES :
%
%---------------------------------------------------

function [ ind ] = solvev( vect )
%SOLVEV Summary of this function goes here
%   Detailed explanation goes here

    ind = find(vect==0,1,'first') ;     % look for value 0
    if isempty(ind)                     % if not found
        id = find(vect<0,1,'last') ;
        if (isempty(id))
            ind = (vect(2)-2*vect(1))/(vect(2)-vect(1)) ;
        elseif id==length(vect) 
            ind = id-vect(id)/(vect(id)-vect(id-1)) ;
        else
            ind = id-vect(id)/(vect(id+1)-vect(id)) ;
        end
    end


end

