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
% file : disp_all_DC.m
% authors  : P.BENABES & C.TUGUI 
% Copyright (c) 2011 SUPELEC
% Revision: 3.0  Date: 24/03/2011
%
%---------------------------------------------------
% Modifications history
% 24 JAN 2010 	: version 1.0
% 24 MAR 2011 	: version 3.0
%---------------------------------------------------
%
% DESCRIPTION DU MODULE :
%   affiche les simulations DC pour toutes les sorties
%
% MODULES UTILISES :
%       * disp_DC
%
%---------------------------------------------------
function disp_all_DC(model_par,multi_in_out,disp_res_diffcomm,outdisp)


  if model_par.mode_diff_enabled_out %if out diff
    if outdisp
        if (disp_res_diffcomm==0)
            disp_DC(model_par,multi_in_out(2*outdisp+1).dir_dc{1},multi_in_out(2*outdisp+1).dir_dc{2},multi_in_out(2*outdisp+1).inv_dc{1},multi_in_out(2*outdisp+1).imp_dc,multi_in_out(2*outdisp+1).simple_dc{1},multi_in_out(2*outdisp+1).simple_dc{2},outdisp*2-1,disp_res_diffcomm,['DC: Out' '1'+outdisp*2-2]);
            disp_DC(model_par,multi_in_out(2*outdisp+2).dir_dc{1},multi_in_out(2*outdisp+2).dir_dc{2},multi_in_out(2*outdisp+2).inv_dc{1},multi_in_out(2*outdisp+2).imp_dc,multi_in_out(2*outdisp+2).simple_dc{1},multi_in_out(2*outdisp+2).simple_dc{2},outdisp*2,disp_res_diffcomm,['DC: Out' '2'+outdisp*2-2]);
        else
            [simple_dc1,simple_dc2,simple_dc1_comm,simple_dc2_comm,dir_dc1,dir_dc2,comm_dc1,comm_dc2]=unitodiff(multi_in_out(2*outdisp+1),multi_in_out(2*outdisp+2)) ;       
            disp_DC(model_par,dir_dc1,comm_dc1,multi_in_out(2*outdisp+1).inv_dc{1},multi_in_out(2*outdisp+1).imp_dc,simple_dc1,simple_dc1_comm,outdisp*2-1,disp_res_diffcomm,'DC: Out differential mode');
            disp_DC(model_par,dir_dc2,comm_dc2,multi_in_out(2*outdisp+2).inv_dc{1},multi_in_out(2*outdisp+2).imp_dc,simple_dc2,simple_dc2_comm,outdisp*2,disp_res_diffcomm,'DC: Out common mode');
        end
    else
        for k=1:model_par.numout
            if (disp_res_diffcomm==0)
                disp_DC(model_par,multi_in_out(2*k+1).dir_dc{1},multi_in_out(2*k+1).dir_dc{2},multi_in_out(2*k+1).inv_dc{1},multi_in_out(2*k+1).imp_dc,multi_in_out(2*k+1).simple_dc{1},multi_in_out(2*k+1).simple_dc{2},k*2-1,disp_res_diffcomm,['DC: Out' '1'+k*2-2]);
                disp_DC(model_par,multi_in_out(2*k+2).dir_dc{1},multi_in_out(2*k+2).dir_dc{2},multi_in_out(2*k+2).inv_dc{1},multi_in_out(2*k+2).imp_dc,multi_in_out(2*k+2).simple_dc{1},multi_in_out(2*k+2).simple_dc{2},k*2,disp_res_diffcomm,['DC: Out' '2'+k*2-2]);
            else
                [simple_dc1,simple_dc2,simple_dc1_comm,simple_dc2_comm,dir_dc1,dir_dc2,comm_dc1,comm_dc2]=unitodiff(multi_in_out(2*k+1),multi_in_out(2*k+2)) ;       
                disp_DC(model_par,dir_dc1,comm_dc1,multi_in_out(2*k+1).inv_dc{1},multi_in_out(2*k+1).imp_dc,simple_dc1,simple_dc1_comm,k*2-1,disp_res_diffcomm,'DC: Out differential mode');
                disp_DC(model_par,dir_dc2,comm_dc2,multi_in_out(2*k+2).inv_dc{1},multi_in_out(2*k+2).imp_dc,simple_dc2,simple_dc2_comm,k*2,disp_res_diffcomm,'DC: Out common mode');
            end
        end
    end
  else
    if outdisp
        disp_DC(model_par,multi_in_out(2*outdisp+1).dir_dc{1},multi_in_out(2*outdisp+1).dir_dc{2},multi_in_out(2*outdisp+1).inv_dc{1},multi_in_out(2*outdisp+1).imp_dc,multi_in_out(2*outdisp+1).simple_dc{1},multi_in_out(2*outdisp+1).simple_dc{2},outdisp,0,['DC: Out' '1'+outdisp-1]);
    else
        for k=1:model_par.numout
            disp_DC(model_par,multi_in_out(2*k+1).dir_dc{1},multi_in_out(2*k+1).dir_dc{2},multi_in_out(2*k+1).inv_dc{1},multi_in_out(2*k+1).imp_dc,multi_in_out(2*k+1).simple_dc{1},multi_in_out(2*k+1).simple_dc{2},k,0,['DC: Out' '1'+k-1]);
        end
    end
  end
end