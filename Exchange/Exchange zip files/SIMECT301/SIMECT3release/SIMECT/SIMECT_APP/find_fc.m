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
% file : find_fc.m
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
%   gets the cutoff frequency of an impedance
%
% MODULES UTILISES :
%
%---------------------------------------------------


function [fc phase_at_f0 Q]=find_fc(rep_ac,ac_an,numout,err_param)

%Find first cut-off frequency - Bandpass Filter
%Find max and pos_max

TF=rep_ac.TF{numout} ;
fTF=rep_ac.f ;

passb_mag=db(max(TF(1,:)));
for i=1:size(TF,2)
    if  db(TF(1,i))==passb_mag
        pos_max=i;
    end
end;

found_fc=0;
mn=err_param.max;

%Search for cut-off freq after max
for i=1:size(TF,2)
    if  (abs(passb_mag-db(TF(1,i))-3)<=mn)&&(i>pos_max)
        mn=abs(passb_mag-db(TF(1,i))-3);
        pos_freq=i;
        found_fc=1;
    end
end;

if found_fc
    
    diff=db(TF(1,pos_freq))-(passb_mag-3);
    if (diff>3)
        error('When computing the cut-off frequency, the error is >3dB!');
    end
    
    fc=fTF(pos_freq);
    if (ac_an.enable_ac_norm==1)
        id=find(fTF<=1, 1, 'last' );
    else
        id=find(fTF<=ac_an.f0, 1, 'last' );
    end
    phase_at_f0=angle(TF(1,id));

else
    warning('Unable to find f0 and phase_at_f0!');    
    fc=0;
    phase_at_f0=0;
    
end

mx=max(abs(TF));
ind= abs(TF)==mx;
id2=find(abs(TF)>mx/sqrt(2));
deltaf=fTF(max(id2))-fTF(min(id2));
if (deltaf)
    Q=fTF(ind)/deltaf ;
else
    Q=0 ;
end

return;