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
% file : get_gains.m
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
%   extraction des offsets en entree et en sortie
%
% MODULES UTILISES :
%
%---------------------------------------------------

function     model_in_out=get_gains(model_par,multi_in_out,model_in_out,numout)

    %Input 1 offset
    model_in_out.OffIn11=multi_in_out(2*numout+1).simple_dc{model_par.mode_diff_enabled+1}.in_offset{1};      % on prend la simulation en mode commun pour l'entree 1
    model_in_out.OffIn12=multi_in_out(2*numout+1).simple_dc{model_par.mode_diff_enabled+1}.incomp_offset{1};  % si elle existe

    if model_par.mode_diff_enabled                                                      % si on est en differentiel en entree
        %Input 2 offset
        model_in_out.OffIn21=multi_in_out(2*numout+1).simple_dc{2}.in_offset{2};        % on prend la simulation en mode commun pour l'entree 2
        model_in_out.OffIn22=multi_in_out(2*numout+1).simple_dc{2}.incomp_offset{2};    %

    end

    %Output 1 offset 
    model_in_out.OffOut11=multi_in_out(2*numout+1).simple_dc{1}.out_offset;             % on prend la simulation en mode differentiel pour les sorties
    model_in_out.OffOut12=multi_in_out(2*numout+1).simple_dc{1}.outcomp_offset;

    if model_par.mode_diff_enabled_out
        %Output 2 offset 
        model_in_out.OffOut21=multi_in_out(2*numout+2).simple_dc{1}.out_offset;         % si on est en differentiel en sortie
        model_in_out.OffOut22=multi_in_out(2*numout+2).simple_dc{1}.outcomp_offset;
    end

   for k=1:model_par.mode_diff_enabled+1
       if (isempty(multi_in_out(3).inv_dc{k}))                      % modele inverse non calcule
           model_in_out.nlin{k}=[] ;
       else
          model_in_out.nlin{k}=multi_in_out(3).inv_dc{k}.nl{1} ;
       end
   end
   
   for k=1:model_par.mode_diff_enabled_out+1
       if isfield(multi_in_out(numout*2+k).dir_dc{1},'nl')
         model_in_out.nlout{k}=multi_in_out(numout*2+k).dir_dc{1}.nl ;
       end
   end

end

