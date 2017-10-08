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
% file : get_trf.m
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
%   extraction du macro-modele d'une fonction analogique
%
% MODULES UTILISES :
%   extract_smod
%
%---------------------------------------------------

function     model_in_out=get_trf(model_par,multi_in_out,model_in_out,numout,ac_in_an,extract_ac_in_pz,err_param)

%GET_TRF Summary of this function goes here
%   Detailed explanation goes here

%model_in_out=[] ;

%If DIFF input
if model_par.mode_diff_enabled
    %Select output type: diff/comm
    if model_par.mode_diff_enabled_out

        f=multi_in_out(1).rep_ac.f;
        TFD1=multi_in_out(2).rep_ac.TF{2*numout-1}-multi_in_out(1).rep_ac.TF{2*numout-1};   % input differential
        TFD2=multi_in_out(2).rep_ac.TF{2*numout}-multi_in_out(1).rep_ac.TF{2*numout};

        TFCM1=multi_in_out(1).rep_ac.TF{2*numout-1}+multi_in_out(2).rep_ac.TF{2*numout-1};  % input common mode
        TFCM2=multi_in_out(1).rep_ac.TF{2*numout}+multi_in_out(2).rep_ac.TF{2*numout};

        %TF comm= (TFD1+TFD2)/2
        TF_diff_in_comm_out=(TFD2+TFD1)/2;

        %TF diff= (TFD1-TFD2)/2
        TF_diff_in_diff_out=(TFD2-TFD1);


        %TF comm= (TFD1+TFD2)/2
        TF_comm_in_comm_out=(TFCM1+TFCM2)/2;

        %TF diff= (TFD1-TFD2)/2
        TF_comm_in_diff_out=(TFCM2-TFCM1);

        model_in_out.f=f;
        model_in_out.TF_diff_in_comm_out=TF_diff_in_comm_out;
        model_in_out.TF_diff_in_diff_out=TF_diff_in_diff_out;
        model_in_out.TF_comm_in_comm_out=TF_comm_in_comm_out;
        model_in_out.TF_comm_in_diff_out=TF_comm_in_diff_out;

        if extract_ac_in_pz
            %Extract s-models
            [B_TF_diff_in_comm_out A_TF_diff_in_comm_out]=extract_smod(TF_diff_in_comm_out, f, ac_in_an.ord_trf,  err_param, 0);
            [B_TF_diff_in_diff_out A_TF_diff_in_diff_out]=extract_smod(TF_diff_in_diff_out, f, ac_in_an.ord_trf,  err_param, 0);

            [B_TF_comm_in_comm_out A_TF_comm_in_comm_out]=extract_smod(TF_comm_in_comm_out, f, ac_in_an.ord_trf,  err_param, 0);
            [B_TF_comm_in_diff_out A_TF_comm_in_diff_out]=extract_smod(TF_comm_in_diff_out, f, ac_in_an.ord_trf,  err_param, 0);

            model_in_out.B_TF_diff_in_comm_out=B_TF_diff_in_comm_out;
            model_in_out.A_TF_diff_in_comm_out=A_TF_diff_in_comm_out;
            model_in_out.B_TF_diff_in_diff_out=B_TF_diff_in_diff_out;
            model_in_out.A_TF_diff_in_diff_out=A_TF_diff_in_diff_out;
            model_in_out.B_TF_comm_in_comm_out=B_TF_comm_in_comm_out;
            model_in_out.A_TF_comm_in_comm_out=A_TF_comm_in_comm_out;
            model_in_out.B_TF_comm_in_diff_out=B_TF_comm_in_diff_out;
            model_in_out.A_TF_comm_in_diff_out=A_TF_comm_in_diff_out;
        end

    end

else %If COMM input

    %Select output type: diff/comm
    if model_par.mode_diff_enabled_out

        f=multi_in_out(1).rep_ac.f;
        TFD1=multi_in_out(1).rep_ac.TF{2*numout-1};

        TFD2=multi_in_out(1).rep_ac.TF{2*numout};

        %TF comm= (TFD1+TFD2)/2
        TF_comm_out=(TFD1+TFD2)/2;

        %TF diff= (TFD1-TFD2)
        TF_diff_out=(TFD1-TFD2);

        model_in_out.f=f;
        model_in_out.TF_comm_out=TF_comm_out;
        model_in_out.TF_diff_out=TF_diff_out;

        if extract_ac_in_pz
            %Extract s-models
            [B_TF_comm_out A_TF_comm_out]=extract_smod(TF_comm_out, f, ac_in_an.ord_trf, err_param, 0);
            [B_TF_diff_out A_TF_diff_out]=extract_smod(TF_diff_out, f, ac_in_an.ord_trf, err_param, 0);

            model_in_out.B_TF_comm_out=B_TF_comm_out;
            model_in_out.A_TF_comm_out=A_TF_comm_out;
            model_in_out.B_TF_diff_out=B_TF_diff_out;
            model_in_out.A_TF_diff_out=A_TF_diff_out;
        end

    end
end



end

