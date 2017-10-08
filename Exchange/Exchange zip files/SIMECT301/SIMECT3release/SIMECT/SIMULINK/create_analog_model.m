%---------------------------------------------------
% Ce programme est la propriete exclusive de SUPELEC
% Tout  usage  non  authorise  ou reproduction de ce
% programme est strictement defendu.
% Copyright  (c) 2010  SUPELEC  Departement SSE
% Tous droits reserves
%---------------------------------------------------
%
% fichier : create_analog_model.m
% auteur  : P.BENABES & C.TUGUI
% Copyright (c) 2010 SUPELEC
% Revision: 2.0  Date: 29/10/2010
%
%---------------------------------------------------
%
% DESCRIPTION DU MODULE :
%
%
% MODULES UTILISES :
%
%---------------------------------------------------

function []=create_analog_model(subcell,sub_string,sc_idx,model_in_out)
%Create Simulink model starting from extracted characteristics

%Init parameters for diff in/out

%Verify model integrity
corrupt_par=0;


p = get_param([subcell sub_string subcell num2str(sc_idx)], 'DialogParameters');

if isfield(p,'Num_TF_dir1')
    set_param([subcell sub_string subcell num2str(sc_idx)],'Num_TF_dir1',['[' num2str(model_in_out.Num_TF_dir1) ']']);
else
    corrupt_par=1;
end

if isfield(p,'Den_TF_dir1')
    set_param([subcell sub_string subcell num2str(sc_idx)],'Den_TF_dir1',['[' num2str(model_in_out.Den_TF_dir1) ']']);
else
    corrupt_par=1;
end

if isfield(p,'Num_TF_inv1') && isfield(model_in_out,'Num_TF_inv1')
    set_param([subcell sub_string subcell num2str(sc_idx)],'Num_TF_inv1',['[' num2str(model_in_out.Num_TF_inv1) ']']);
else
    corrupt_par=1;
end

if isfield(p,'Den_TF_inv1') && isfield(model_in_out,'Den_TF_inv1')
    set_param([subcell sub_string subcell num2str(sc_idx)],'Den_TF_inv1',['[' num2str(model_in_out.Den_TF_inv1) ']']);
else
    corrupt_par=1;
end        %TFD1

if isfield(p,'Num_Zin1')
    set_param([subcell sub_string subcell num2str(sc_idx)],'Num_Zin1',['[' num2str(model_in_out.Num_Zin1) ']']);
else
    corrupt_par=1;
end

if isfield(p,'Den_Zin1')
    set_param([subcell sub_string subcell num2str(sc_idx)],'Den_Zin1',['[' num2str(model_in_out.Den_Zin1) ']']);
else
    corrupt_par=1;
end

if isfield(p,'Num_Zout1')
    set_param([subcell sub_string subcell num2str(sc_idx)],'Num_Zout1',['[' num2str(model_in_out.Num_Zout1) ']']);
else
    corrupt_par=1;
end

if isfield(p,'Den_Zout1')
    set_param([subcell sub_string subcell num2str(sc_idx)],'Den_Zout1',['[' num2str(model_in_out.Den_Zout1) ']']);
else
    corrupt_par=1;
end

if isfield(p,'OffIn11')
    set_param([subcell sub_string subcell num2str(sc_idx)],'OffIn11',num2str(model_in_out.OffIn11));
else
    corrupt_par=1;
end

if isfield(p,'OffIn12')
    set_param([subcell sub_string subcell num2str(sc_idx)],'OffIn12',num2str(model_in_out.OffIn12));
else
    corrupt_par=1;
end

if isfield(p,'OffOut11')
    set_param([subcell sub_string subcell num2str(sc_idx)],'OffOut11',num2str(model_in_out.OffOut11));
else
    corrupt_par=1;
end

if isfield(p,'OffOut12')
    set_param([subcell sub_string subcell num2str(sc_idx)],'OffOut12',num2str(model_in_out.OffOut12));
else
    corrupt_par=1;
end

if model_in_out.mode_diff_enabled
    %TFD3
    if isfield(p,'Num_TF_dir3')
        set_param([subcell sub_string subcell num2str(sc_idx)],'Num_TF_dir3',['[' num2str(model_in_out.Num_TF_dir3) ']']);
    else
        corrupt_par=1;
    end
    
    if isfield(p,'Den_TF_dir3')
        set_param([subcell sub_string subcell num2str(sc_idx)],'Den_TF_dir3',['[' num2str(model_in_out.Den_TF_dir3) ']']);
    else
        corrupt_par=1;
    end
    
    %TFR3
    if isfield(p,'Num_TF_inv3') && isfield(model_in_out,'Num_TF_inv3')
        set_param([subcell sub_string subcell num2str(sc_idx)],'Num_TF_inv3',['[' num2str(model_in_out.Num_TF_inv3) ']']);
    else
        corrupt_par=1;
    end
    
    if isfield(p,'Den_TF_inv3') && isfield(model_in_out,'Den_TF_inv3')
        set_param([subcell sub_string subcell num2str(sc_idx)],'Den_TF_inv3',['[' num2str(model_in_out.Den_TF_inv3) ']']);
    else
        corrupt_par=1;
    end
    
    %Zin2/Yin2
    if isfield(p,'Num_Zin2')
        set_param([subcell sub_string subcell num2str(sc_idx)],'Num_Zin2',['[' num2str(model_in_out.Num_Zin2) ']']);
    else
        corrupt_par=1;
    end
    
    if isfield(p,'Den_Zin2')
        set_param([subcell sub_string subcell num2str(sc_idx)],'Den_Zin2',['[' num2str(model_in_out.Den_Zin2) ']']);
    else
        corrupt_par=1;
    end
    
    %Zin_diff1/Yin_diff1
    if isfield(p,'Num_Zin_diff1')
        set_param([subcell sub_string subcell num2str(sc_idx)],'Num_Zin_diff1',['[' num2str(model_in_out.Num_Zin_diff1) ']']);
    else
        corrupt_par=1;
    end
    
    if isfield(p,'Den_Zin_diff1')
        set_param([subcell sub_string subcell num2str(sc_idx)],'Den_Zin_diff1',['[' num2str(model_in_out.Den_Zin_diff1) ']']);
    else
        corrupt_par=1;
    end
    
    %Zin_diff2/Yin_diff2
    if isfield(p,'Num_Zin_diff2')
        set_param([subcell sub_string subcell num2str(sc_idx)],'Num_Zin_diff2',['[' num2str(model_in_out.Num_Zin_diff2) ']']);
    else
        corrupt_par=1;
    end
    
    if isfield(p,'Den_Zin_diff2')
        set_param([subcell sub_string subcell num2str(sc_idx)],'Den_Zin_diff2',['[' num2str(model_in_out.Den_Zin_diff2) ']']);
    else
        corrupt_par=1;
    end
    
    if isfield(p,'OffIn21')
        set_param([subcell sub_string subcell num2str(sc_idx)],'OffIn21',num2str(model_in_out.OffIn21));
    else
        corrupt_par=1;
    end
    
    if isfield(p,'OffIn22')
        set_param([subcell sub_string subcell num2str(sc_idx)],'OffIn22',num2str(model_in_out.OffIn22));
    else
        corrupt_par=1;
    end
    
end

if model_in_out.mode_diff_enabled_out
    
    %TFD2
    if isfield(p,'Num_TF_dir2')
        set_param([subcell sub_string subcell num2str(sc_idx)],'Num_TF_dir2',['[' num2str(model_in_out.Num_TF_dir2) ']']);
    else
        corrupt_par=1;
    end
    
    if isfield(p,'Den_TF_dir2')
        set_param([subcell sub_string subcell num2str(sc_idx)],'Den_TF_dir2',['[' num2str(model_in_out.Den_TF_dir2) ']']);
    else
        corrupt_par=1;
    end
    
    %TFR2
    if isfield(p,'Num_TF_inv2') && isfield(model_in_out,'Num_TF_inv2')
        set_param([subcell sub_string subcell num2str(sc_idx)],'Num_TF_inv2',['[' num2str(model_in_out.Num_TF_inv2) ']']);
    else
        corrupt_par=1;
    end
    
    if isfield(p,'Den_TF_inv2') && isfield(model_in_out,'Den_TF_inv2')
        set_param([subcell sub_string subcell num2str(sc_idx)],'Den_TF_inv2',['[' num2str(model_in_out.Den_TF_inv2) ']']);
    else
        corrupt_par=1;
    end
    
    %Zout2/Yout2
    if isfield(p,'Num_Zout2')
        set_param([subcell sub_string subcell num2str(sc_idx)],'Num_Zout2',['[' num2str(model_in_out.Num_Zout2) ']']);
    else
        corrupt_par=1;
    end
    
    if isfield(p,'Den_Zout2')
        set_param([subcell sub_string subcell num2str(sc_idx)],'Den_Zout2',['[' num2str(model_in_out.Den_Zout2) ']']);
    else
        corrupt_par=1;
    end
    
    %Zout_diff1/Yout_diff1
    if isfield(p,'Num_Zout_diff1')
        set_param([subcell sub_string subcell num2str(sc_idx)],'Num_Zout_diff1',['[' num2str(model_in_out.Num_Zout_diff1) ']']);
    else
        corrupt_par=1;
    end
    
    if isfield(p,'Den_Zout_diff1')
        set_param([subcell sub_string subcell num2str(sc_idx)],'Den_Zout_diff1',['[' num2str(model_in_out.Den_Zout_diff1) ']']);
    else
        corrupt_par=1;
    end
    
    %Zout_diff2/Yout_diff2
    if isfield(p,'Num_Zout_diff2')
        set_param([subcell sub_string subcell num2str(sc_idx)],'Num_Zout_diff2',['[' num2str(model_in_out.Num_Zout_diff2) ']']);
    else
        corrupt_par=1;
    end
    
    if isfield(p,'Den_Zout_diff2')
        set_param([subcell sub_string subcell num2str(sc_idx)],'Den_Zout_diff2',['[' num2str(model_in_out.Den_Zout_diff2) ']']);
    else
        corrupt_par=1;
    end
    
    if isfield(p,'OffOut21')
        set_param([subcell sub_string subcell num2str(sc_idx)],'OffOut21',num2str(model_in_out.OffOut21));
    else
        corrupt_par=1;
    end
    
    if isfield(p,'OffOut22')
        set_param([subcell sub_string subcell num2str(sc_idx)],'OffOut22',num2str(model_in_out.OffOut22));
    else
        corrupt_par=1;
    end
    
    if model_in_out.mode_diff_enabled
        %TFD4
        if isfield(p,'Num_TF_dir4')
            set_param([subcell sub_string subcell num2str(sc_idx)],'Num_TF_dir4',['[' num2str(model_in_out.Num_TF_dir4) ']']);
        else
            corrupt_par=1;
        end
        
        if isfield(p,'Den_TF_dir4')
            set_param([subcell sub_string subcell num2str(sc_idx)],'Den_TF_dir4',['[' num2str(model_in_out.Den_TF_dir4) ']']);
        else
            corrupt_par=1;
        end
        
        %TFR4
        if isfield(p,'Num_TF_inv4') && isfield(model_in_out,'Num_TF_inv4')
            set_param([subcell sub_string subcell num2str(sc_idx)],'Num_TF_inv4',['[' num2str(model_in_out.Num_TF_inv4) ']']);
        else
            corrupt_par=1;
        end
        
        if isfield(p,'Den_TF_inv4') && isfield(model_in_out,'Den_TF_inv4')
            set_param([subcell sub_string subcell num2str(sc_idx)],'Den_TF_inv4',['[' num2str(model_in_out.Den_TF_inv4) ']']);
        else
            corrupt_par=1;
        end
    end
    
end


%If corrupted parameters
if corrupt_par
    errordlg('Not all parameters for Simulink Model defined! The model was extracted partially...','Warning');
end