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
% file : find_trans.m
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
%   gets a transient simulation
%
% MODULES UTILISES :
%
%---------------------------------------------------


function [rep_trans] = find_trans(model_par, trans_an, nr)
%Function find_trans extracts the transient response of a circuit

if trans_an.enabled
    %Open simulation results
    s=[model_par.workdir '/trans/trans' num2str(nr) '.txt'];

    fid=fopen(s);
    %Scan file
    [data nof_data] = textscan(fid,' %f64 %f64 ','Headerlines',3);
    rep_trans.time=data{1,1};
    rep_trans.mag=data{1,2};

    fclose(fid);
else   
    rep_trans=[];
end

return;

