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

function   [Bsim,Asim] = sup_pzmax(B, A, fmax, rempoles)

Asim=A ;
Bsim=B ; 

if length(A)>1
    rtA=roots(A) ;
else
    rtA=[] ;
end
if length(B)>1
    rtB=roots(B) ;
else
    rtB=[] ;
end

nRA=length(find(abs(rtA)>2*pi*fmax)) ;      % nombre de poles trop eleves
nRB=length(find(abs(rtB)>2*pi*fmax)) ;      % nombre de zeros torp eleves

if (rempoles==1)            % if pairs are removed remove the minimum number of pairs
    nRA=min(nRA,nRB) ;
    nRB=nRA ;
end

[s,ca]=sort(abs(rtA)) ;
[s,cb]=sort(abs(rtB)) ;
ca=fliplr(ca);
cb=fliplr(cb);

for k=1:nRA
        [Asim,R]=deconv(Asim,[-1/rtA(ca(k)) 1]) ;
        Asim(end)=Asim(end)+R(end) ;
end
Asim=real(Asim);

for k=1:nRB
        [Bsim,R]=deconv(Bsim,[-1/rtB(cb(k)) 1]) ;
        Bsim(end)=Bsim(end)+R(end) ;
end
Bsim=real(Bsim);



