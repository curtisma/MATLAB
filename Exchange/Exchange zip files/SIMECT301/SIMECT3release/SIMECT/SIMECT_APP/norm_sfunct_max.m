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
% file : norm_sfunc_max.m
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
%   normalise une fonction en S par rapport au gain a l'infini
%
% MODULES UTILISES :
%
%---------------------------------------------------

function [B_norm A_norm]=norm_sfunct_max(B,A)


if max(abs(A))>max(abs(B))
    max_pz=max(abs(A));
else
    max_pz=max(abs(B));
end

B_norm=B./max_pz;

A_norm=A./max_pz;

return