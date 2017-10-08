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
% file : extract_smod.m
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
%   extraction du modele en S d'une fonction analogiaue
%
% MODULES UTILISES :
%
%---------------------------------------------------


function [B_Trans_Fct A_Trans_Fct]=extract_smod(cu, fr, ord_max, err_param, extr_adm)


%Find the best aproximation for the transfer function -> Modulus/phase weighted


%Parameters
err=err_param.max;

for ord_num=ord_max:-1:0
    for ord_den=ord_max:-1:0
               
        if ord_den>=ord_num
        
            if extr_adm
                if ~err_param.trace %Simple algorithm
                    if (var(cu)<=err_param.var_min)
                      B=1 ; A=1/mean(cu);
                    elseif (var(1./cu)==0)
                      B=1 ; A=1/mean(cu);
                    else  
                      [A,B] = invfreqs(1./cu,2*pi*fr,ord_num,ord_den) ;
                    end
                else %Complex algorithm assuring stability
                    if (var(cu)<=err_param.var_min)
                      B=1 ; A=1/mean(cu);
                    elseif (var(1./cu)==0)
                      B=1 ; A=1/mean(cu);
                    else
                      [A,B] = invfreqs_local(1./cu,2*pi*fr,ord_num,ord_den,err_param.freq_w,err_param.iter,err_param.tol) ;
                    end
                end
            else
                if ~err_param.trace %Simple algorithm
                    if (var(cu)<=err_param.var_min)
                      B=mean(cu) ; A=1;
                    elseif (var(1./cu)==0)
                      B=mean(cu) ; A=1;
                    else
                      [B,A] = invfreqs(cu,2*pi*fr,ord_num,ord_den) ;
                    end
                else %Complex algorithm assuring stability
                    if (sqrt(var(cu))/abs(mean(cu))<=err_param.var_min)
                      B=mean(cu) ; A=1;
                    elseif (var(1./cu)==0)
                      B=mean(cu) ; A=1;
                    else    
                      [B,A] = invfreqs_local(cu,2*pi*fr,ord_num,ord_den,err_param.freq_w,err_param.iter,err_param.tol) ;
                    end
                end
            end
            
        else
            
            continue;
            
        end

        %%% Normalization of the s-function components
        [B_norm, A_norm]=norm_sfunct_max(B,A);
        
        r=freqs(B_norm,A_norm,2*pi*fr) ;
        [new_err err_mod err_ph]=fit_err(cu,r,err_param.w);
        if new_err<=err
            err=new_err;
            ord_num_optimal=ord_num;
            ord_den_optimal=ord_den;
            B_Trans_Fct=B_norm;
            A_Trans_Fct=A_norm;
        end
    end
end

% err/size(cu,2)



r=freqs(B_Trans_Fct,A_Trans_Fct,2*pi*fr) ;
