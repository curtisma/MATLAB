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
% file : extract_tran.m
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
%   extraction du macro-modele d'une fonction analogiaue
%
% MODULES UTILISES :
%       * find_trans
%
%---------------------------------------------------




function rep_trans=extract_tran(model_par, trans_an, nr)
%Function extract_param() -> Extracts AC, DC and transient response for a schematic    



if (trans_an.enabled)
    %Extract transient response
    rep_trans = find_trans(model_par,trans_an, nr); 
else
    rep_trans=[] ;  
end
