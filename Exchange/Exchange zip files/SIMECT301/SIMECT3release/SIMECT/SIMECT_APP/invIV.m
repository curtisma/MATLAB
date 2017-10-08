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
% file : invIV.m
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
%   inverse les lettres i et v
%
% MODULES UTILISES :
%
%---------------------------------------------------

function [ out ] = invIV( in )
    %INVIV Summary of this function goes here
    %   Detailed explanation goes here
    switch in
        case 'V',
            out='I' ;
        case 'I',
            out='V' ;
        case 'i',
            out='v';
        case 'v',
            out='i' ;
        otherwise,
            out=[] ;
    end

end

