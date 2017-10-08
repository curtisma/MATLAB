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
% file : extract_analp.m
% authors  : P.BENABES & C.TUGUI 
% Copyright (c) 2011 SUPELEC
% Revision: 3.0  Date: 24/03/2011
%
%---------------------------------------------------
% Modifications history
% 24 AVR 2011 	: version 3.0
%---------------------------------------------------
%
% DESCRIPTION DU MODULE :
%   extraction après analyse paramétrique
%
% MODULES UTILISES :
%---------------------------------------------------




function varres=extract_analp(varres, k, model_par, rep, dc_an, par_an, ac_an, ac_in_an, ac_out_an, trans_an, name, valvar )
%Function extract_param() -> Extracts AC, DC and transient response for a schematic    

        varres.nam=name ;
        varres.val(k)=valvar(k);
        if (par_an.enabled)
            varres.offsout(k)=rep(3).dir_dc{1}.nl.c0 ;
            if ~isempty(rep(3).inv_dc{1})
                varres.offsin(k) =rep(3).inv_dc{1}.nl{1}.c0 ;
                varres.gaini(k)  =rep(3).inv_dc{1}.nl{1}.cy1 ;
                nli=rep(3).inv_dc{1}.nl{1} ;
                varres.nlin(k,:)   =[nli.cxyn  nli.cx2n nli.cx3n nli.cy2n nli.cy3n nli.ct ];
            elseif ~isempty(rep(3).simple_dc{1})
                varres.offsin(k) = rep(3).simple_dc{1}.incomp_offset{1} ;       
            end
            varres.ze(k)     = rep(3).simple_dc{1}.Zin{1} ;
            varres.zs(k)     = rep(3).imp_dc.Zout{1} ;
            nlo=rep(3).dir_dc{1}.nl ; 
            varres.nlout(k,:)  =[nlo.cxyn  nlo.cx2n nlo.cx3n nlo.cy2n nlo.cy3n nlo.ct ];
            if (model_par.mode_diff_enabled_out)
                if (model_par.mode_diff_enabled)
                    varres.gaind1(k)  =(rep(3).dir_dc{1}.nl.cx1-rep(4).dir_dc{1}.nl.cx1)/2 ;             
                    varres.gaind3(k)  =(rep(3).dir_dc{1}.nl.cx1+rep(4).dir_dc{1}.nl.cx1)/2 ;
                    varres.gaind2(k)  =(rep(3).dir_dc{2}.nl.cx1-rep(4).dir_dc{2}.nl.cx1)/2 ;             
                    varres.gaind4(k)  =(rep(3).dir_dc{2}.nl.cx1+rep(4).dir_dc{2}.nl.cx1)/2 ;
                else
                    varres.gaind1(k)  =(rep(3).dir_dc{1}.nl.cx1-rep(4).dir_dc{1}.nl.cx1)/2 ;             
                    varres.gaind3(k)  =(rep(3).dir_dc{1}.nl.cx1+rep(4).dir_dc{1}.nl.cx1)/2 ;             
                end
            else
                if (model_par.mode_diff_enabled)
                    varres.gaind1(k)  =rep(3).dir_dc{1}.nl.cx1 ;
                    varres.gaind2(k)  =rep(3).dir_dc{2}.nl.cx1 ;
                else
                    varres.gaind1(k)  =rep(3).dir_dc{1}.nl.cx1 ;             
                end                
            end
        elseif dc_an.enabled
            varres.offsout(k)=rep(3).simple_dc{1}.out_offset ;
            varres.offsin(k) =rep(3).simple_dc{1}.incomp_offset{1} ;
            varres.ze(k)     = rep(3).simple_dc{1}.Zin{1} ;
            if (model_par.mode_diff_enabled_out)
                if (model_par.mode_diff_enabled)
                    varres.gaind1(k)  =(rep(3).simple_dc{1}.gain-rep(4).simple_dc{1}.gain)/2 ;             
                    varres.gaind3(k)  =(rep(3).simple_dc{1}.gain+rep(4).simple_dc{1}.gain)/2 ;
                    varres.gaind2(k)  =(rep(3).simple_dc{2}.gain-rep(4).simple_dc{2}.gain)/2 ;             
                    varres.gaind4(k)  =(rep(3).simple_dc{2}.gain+rep(4).simple_dc{2}.gain)/2 ;
                else
                    varres.gaind1(k)  =(rep(3).dir_dc{1}.gain-rep(4).dir_dc{1}.gain)/2 ;             
                    varres.gaind3(k)  =(rep(3).dir_dc{1}.gain+rep(4).dir_dc{1}.gain)/2 ;             
                end
            else
                if (model_par.mode_diff_enabled)
                    varres.gaind1(k)  =rep(3).simple_dc{1}.gain ;
                    varres.gaind2(k)  =rep(3).simple_dc{2}.gain ;
                else
                    varres.gaind1(k)  =rep(3).simple_dc{1}.gain ;             
                end                
            end  
        end
        if dc_an.enabled
            varres.Vname=rep(3).simple_dc{1}.Vname ;
            varres.Vval{k}=rep(3).simple_dc{1}.Vval ;
            varres.Iname=rep(3).simple_dc{1}.Iname ;
            varres.Ival{k}=rep(3).simple_dc{1}.Ival ;
            varres.idc=rep(3).simple_dc{1}.idc ;
        end
        if (ac_in_an.enabled)
            varres.zef0(k)     =rep(1).rep_ac.Zf0 ;
            if (ac_out_an.enabled)
                varres.zsf0(k)     =rep(3).rep_ac.Zf0 ;
                varres.fac(k,:)    =[rep(1).rep_ac.f rep(1).rep_ac.f rep(1).rep_ac.f];
                varres.repac(k,:)    =[rep(1).rep_ac.TF{1} rep(1).rep_ac.Z{1} rep(3).rep_ac.Z{1}];
            else
                varres.fac(k,:)    =[rep(1).rep_ac.f rep(1).rep_ac.f];
                varres.repac(k,:)    =[rep(1).rep_ac.TF{1} rep(1).rep_ac.Z{1}];
            end
            if (model_par.mode_diff_enabled)
                varres.fac_comm(k,:)    =[rep(1).rep_ac.f rep(1).rep_ac.f];
                varres.repac_comm(k,:)    =[rep(2).rep_ac.TF{1} rep(2).rep_ac.Z{1}];
            end
            varres.delayf0(k) = rep(1).par_rlc_fc{1}.phase_at_f0/2/pi/ac_an.f0*1e9 ;
            varres.Q(k) = rep(1).par_rlc_fc{1}.Q ;
        end
        if (trans_an.enabled)
            varres.trans{k}   = rep(3).par_rep_trans.mag;
            varres.time{k}    = rep(3).par_rep_trans.time;
        end
