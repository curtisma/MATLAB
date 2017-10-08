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
% file : get_model.m
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
%   extraction des fonctions de transfert endifferentiel
%
% MODULES UTILISES :
%
%---------------------------------------------------


function     model_in_out=get_model(model_par,multi_in_out,model_in_out,numout)

    model_in_out.mode_diff_enabled=model_par.mode_diff_enabled;
    model_in_out.mode_diff_enabled_out=model_par.mode_diff_enabled_out;

    f=multi_in_out(1).rep_ac.f;
    model_in_out.f=f;

    %If DIFF input

        %Extract normal functions starting from diff/comm


    %TFD1
    model_in_out.Num_TF_dir1=multi_in_out(1).mod_ac.B_TF{2*numout-1};
    model_in_out.Den_TF_dir1=multi_in_out(1).mod_ac.A_TF{2*numout-1};

    %TFR1
    if (model_par.rev_trfunction)
        model_in_out.Num_TF_inv1=multi_in_out(2*numout+1).mod_ac.B_TF{1};
        model_in_out.Den_TF_inv1=multi_in_out(2*numout+1).mod_ac.A_TF{1};
    end

    %Zin1/Yin1
    model_in_out.Num_Zin1=multi_in_out(1).mod_ac.B_Z{1};
    model_in_out.Den_Zin1=multi_in_out(1).mod_ac.A_Z{1};

    %Zout1/Yout1
    model_in_out.Num_Zout1=multi_in_out(2*numout+1).mod_ac.B_Z{1};
    model_in_out.Den_Zout1=multi_in_out(2*numout+1).mod_ac.A_Z{1};

    if model_par.mode_diff_enabled
    %TFD3
        model_in_out.Num_TF_dir3=multi_in_out(2).mod_ac.B_TF{2*numout-1};
        model_in_out.Den_TF_dir3=multi_in_out(2).mod_ac.A_TF{2*numout-1};

        %TFR3
        if (model_par.rev_trfunction)
            model_in_out.Num_TF_inv3=multi_in_out(2*numout+1).mod_ac.B_TF{2};
            model_in_out.Den_TF_inv3=multi_in_out(2*numout+1).mod_ac.A_TF{2};
        end
        
        %Zin2/Yin2
        model_in_out.Num_Zin2=multi_in_out(2).mod_ac.B_Z{1};
        model_in_out.Den_Zin2=multi_in_out(2).mod_ac.A_Z{1};

        %Zin_diff1/Yin_diff1
        model_in_out.Num_Zin_diff1=multi_in_out(1).mod_ac.B_Z{2};
        model_in_out.Den_Zin_diff1=multi_in_out(1).mod_ac.A_Z{2};

        %Zin_diff2/Yin_diff2
        model_in_out.Num_Zin_diff2=multi_in_out(1).mod_ac.B_Z{2};
        model_in_out.Den_Zin_diff2=multi_in_out(1).mod_ac.A_Z{2};

    end

    if model_par.mode_diff_enabled_out
            
        %TFD2
        model_in_out.Num_TF_dir2=multi_in_out(1).mod_ac.B_TF{2*numout};
        model_in_out.Den_TF_dir2=multi_in_out(1).mod_ac.A_TF{2*numout};

        %TFR2
        if (model_par.rev_trfunction)
            model_in_out.Num_TF_inv2=multi_in_out(2*numout+2).mod_ac.B_TF{1};
            model_in_out.Den_TF_inv2=multi_in_out(2*numout+2).mod_ac.A_TF{1};
        end
        
        %Zout2/Yout2
        model_in_out.Num_Zout2=multi_in_out(2*numout+2).mod_ac.B_Z{1};
        model_in_out.Den_Zout2=multi_in_out(2*numout+2).mod_ac.A_Z{1};

        %Zout_diff1/Yout_diff1
        model_in_out.Num_Zout_diff1=multi_in_out(2*numout+1).mod_ac.B_Z{2};
        model_in_out.Den_Zout_diff1=multi_in_out(2*numout+1).mod_ac.A_Z{2};

        %Zout_diff2/Yout_diff2
        model_in_out.Num_Zout_diff2=multi_in_out(2*numout+2).mod_ac.B_Z{2};
        model_in_out.Den_Zout_diff2=multi_in_out(2*numout+2).mod_ac.A_Z{2};

        if model_par.mode_diff_enabled
            %TFD4
            model_in_out.Num_TF_dir4=multi_in_out(2).mod_ac.B_TF{2*numout};
            model_in_out.Den_TF_dir4=multi_in_out(2).mod_ac.A_TF{2*numout};

            %TFR4
            if (model_par.rev_trfunction)
                model_in_out.Num_TF_inv4=multi_in_out(2*numout+2).mod_ac.B_TF{2};
                model_in_out.Den_TF_inv4=multi_in_out(2*numout+2).mod_ac.A_TF{2};
            end
       end

    end        


end

