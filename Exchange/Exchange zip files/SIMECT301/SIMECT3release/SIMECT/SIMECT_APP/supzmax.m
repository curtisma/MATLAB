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
% file : supzmax.m
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
%   supprime les zeros d'une fonction trop �loign�s
%
% MODULES UTILISES :
%
%---------------------------------------------------

function   A_Fct =supzmax(A, fmax)

A_Fct=A ;
if length(A)>1
    rt=roots(A) ;
    for k=1:length(rt)
        if (abs(rt(k))>2*pi*fmax)
            [A_Fct,R]=deconv(A_Fct,[-1/rt(k) 1]) ;
            A_Fct(end)=A_Fct(end)+R(end) ;
        end
    end
    A_Fct=real(A_Fct);
end

