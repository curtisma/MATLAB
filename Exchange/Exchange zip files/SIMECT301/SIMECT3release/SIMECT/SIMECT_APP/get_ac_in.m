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
% file : get_ac_in.m
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
%   extracts the AC parameters from inputs
%
% MODULES UTILISES :
%       * find_ac_par
%
%---------------------------------------------------


function [mod rep ]=get_ac_in(ac_an,ord_Z,ord_trf,extract,model_par,namin,numin,err_param)

%Delete previous simulation files
delete exp_*.txt;

mod=[]; 
rep=[]; 

    rempoles=model_par.rempoles ;

    %Extract TF and Z IN
    s1=[model_par.workdir '/' namin '/psf'];

    kind1=model_par.out_kind ;

    for k=1:model_par.numout
      for l=0:model_par.mode_diff_enabled_out
        if (model_par.out_kind=='V')
            nam1=model_par.out_Vname{k*2+l-1};
        else
            nam1=[model_par.out_Iname{k*2+l-1} ':n'];
        end
        [mod.B_TF{k*2+l-1} mod.A_TF{k*2+l-1} rep.f{k*2+l-1} rep.TF{k*2+l-1}]=find_ac_par(s1,nam1,kind1,1,ac_an.f0,ac_an.stop,ord_trf,rempoles,err_param,extract,0,ac_an.enable_ac_norm);   
      end
    end
    
    if (model_par.in_kind=='V')
        nam2=[model_par.in_Iname{numin} ':n'];
    else
        nam2=model_par.in_Vname{numin};
    end
    kind2=invIV(model_par.in_kind);    
    [mod.B_Z{1}  mod.A_Z{1}  rep.f  rep.Z{1}] =find_ac_par(s1,nam2,kind2,0,ac_an.f0,ac_an.stop,ord_Z,rempoles,err_param,extract,model_par.extr_in_adm,ac_an.enable_ac_norm);
    
    if (model_par.mode_diff_enabled)
        if (model_par.in_kind=='V')
            nam4=[model_par.in_Iname{3-numin} ':n'];
        else
            nam4=model_par.in_Vname{3-numin};
        end
        kind4=invIV(model_par.in_kind);
        [mod.B_Z{2}  mod.A_Z{2}  rep.f  rep.Z{2}] =find_ac_par(s1,nam4,kind4,0,ac_an.f0,ac_an.stop,ord_Z,rempoles,err_param,extract,model_par.extr_in_adm,ac_an.enable_ac_norm);
    end
    
    
    % get the real part of input impedance for null frequency
    P = POLYFIT(rep.f(1:5),rep.Z{1}(1:5),2);
    rep.Z0 = abs(P(end)) ;
    if (ac_an.enable_ac_norm==1)
        id=find(rep.f<=1,1,'last') ;
    else
        id=find(rep.f<=ac_an.f0,1,'last') ;
    end
    rep.Zf0 = abs(rep.Z{1}(id)) ;        

return;