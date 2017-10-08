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
% file : get_ac_out.m
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
%   extracts the AC parameters from outputs
%
% MODULES UTILISES :
%       * find_ac_par
%
%---------------------------------------------------


function [model rep ]=get_ac_out(ac_an,ord_Z,ord_trf,extract,model_par,namin,nammc,numin,err_param)

%Delete previous simulation files
delete exp_*.txt;

model=[]; 
rep=[]; 

    rempoles=model_par.rempoles; 
    
    %Extract TF and Z IN
    s1=[model_par.workdir '/' namin '/psf'];    % nom du repertoire pour l'analyse diferentielle
    s2=[model_par.workdir '/' nammc '/psf'];    % nom du répertoire pour l'analyse en mode commun

    if (model_par.rev_trfunction)
        if (model_par.in_kind=='V')
            nam1=[model_par.in_Iname{1} ':n'];
        else
            nam1=model_par.in_Vname{1};
        end
        kind1=invIV(model_par.in_kind);

        [model.B_TF{1} model.A_TF{1} rep.f rep.TF{1}]=find_ac_par(s1,nam1,kind1,1,ac_an.f0,ac_an.stop,ord_trf,rempoles,err_param,extract,0,ac_an.enable_ac_norm);   


        if (model_par.mode_diff_enabled)
            if (model_par.in_kind=='V')
                nam3=[model_par.in_Iname{2} ':n'];
            else
                nam3=model_par.in_Vname{2};
            end
            kind3=invIV(model_par.in_kind);
            [model.B_TF{2} model.A_TF{2} rep.f rep.TF{2}]=find_ac_par(s1,nam3,kind3,1,ac_an.f0,ac_an.stop,ord_trf,rempoles,err_param,extract,0,ac_an.enable_ac_norm);      
        end
    end
    
    
    if (model_par.out_kind=='V')
        nam2=model_par.out_Vname{numin};
    else
        nam2=[model_par.out_Iname{numin} ':n'];
    end
    kind2=model_par.out_kind ;    
    [model.B_Z{1}  model.A_Z{1}  rep.f  rep.Z{1}] =find_ac_par(s2,nam2,kind2,0,ac_an.f0,ac_an.stop,ord_Z,rempoles,err_param,extract,model_par.extr_out_adm,ac_an.enable_ac_norm);
    
    if (model_par.mode_diff_enabled_out )
%        if (model_par.out_kind=='V')
%            nam4=model_par.out_Vname{numin+mod(numin,2)*2-1};
%        else
%            nam4=[model_par.out_Iname{numin+mod(numin,2)*2-1} ':n'];
%        end
%        kind4=model_par.out_kind ;
%        [model.B_Z{2}  model.A_Z{2}  rep.f  rep.Z{2}] =find_ac_par(s2,nam4,kind4,0,ac_an.f0,ac_an.stop,ord_Z,err_param,extract,model_par.extr_in_adm,ac_an.enable_ac_norm);
        [Bz    Az                      f          Zd] =find_ac_par(s1,nam2,kind2,0,ac_an.f0,ac_an.stop,ord_Z,rempoles,err_param,extract,model_par.extr_out_adm,ac_an.enable_ac_norm);

        rep.Z{2} = 1./(1./Zd - 1./rep.Z{1}) ;
        if min(Zd==rep.Z{1})
            model.B_Z{2} =1 ;
            model.A_Z{2} =0 ;
        else
        [model.B_Z{2}  model.A_Z{2}]=extract_smod(rep.Z{2}, f, ord_Z, err_param, model_par.extr_in_adm);
        %model.B_Z{2} =supzmax(model.B_Z{2},ac_an.stop);
        %model.A_Z{2} =supzmax(model.A_Z{2},ac_an.stop);
        end

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