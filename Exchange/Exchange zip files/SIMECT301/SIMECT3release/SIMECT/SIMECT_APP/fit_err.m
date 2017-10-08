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
% file : fit_err.m
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
%  calcule l'erreur relative 
%


function [err err_mod err_phase]=fit_err(real_data,fitted_data,percent_modulus)
%SQR Relative error betweeen real data and fitted data
%percent_modulus defines the weight of modulus fitting error in the total
%error

if nargin==2
    percent_modulus=0.75;
end

err_mod=sum(abs((abs(real_data).^2-abs(fitted_data).^2))/(abs(real_data).^2));
err_phase=sum(abs((angle(real_data).^2-angle(fitted_data).^2))/(angle(real_data).^2));
err=percent_modulus*err_mod+(1-percent_modulus)*err_phase;
err=err/size(real_data,2);
return;