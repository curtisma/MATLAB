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
% file : get_dc.m
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
%   extracts the DC parameters
%
% MODULES UTILISES :
%       * find_dc_par
%
%---------------------------------------------------


function simple_dc=get_dc(model_par,dc_an,numout)

    %Delete previous simulation files
    delete exp_*.txt;

    simple_dc{1}=[]; 
    simple_dc{2}=[];

    if model_par.mode_diff_enabled
    end
    
    if dc_an.enabled                                    %Extract DC


        for k=1:model_par.mode_diff_enabled+1           % k=1 entree differentielle  k=2 entree mode commun
            if (k==1)
              s1=[model_par.workdir '/dc/psf'];
            else
              s1=[model_par.workdir '/dc_com/psf'];   
            end
            if (numout==1)                              % for the first output get all intermediary signals
                [simple_dc{k}.Vname simple_dc{k}.Vval simple_dc{k}.Iname simple_dc{k}.Ival]=find_dc_all(s1);
            end
            if (model_par.out_kind=='V')
                [simple_dc{k}.idc simple_dc{k}.out]      =find_dc_par(s1,model_par.out_Vname{numout},              model_par.out_kind,dc_an.par_name);
                [simple_dc{k}.idc simple_dc{k}.outcomp]  =find_dc_par(s1,[model_par.out_Iname{numout} ':n'],invIV(model_par.out_kind),dc_an.par_name);
            else
                [simple_dc{k}.idc simple_dc{k}.out]      =find_dc_par(s1,[model_par.out_Iname{numout} ':n'],model_par.out_kind,dc_an.par_name);
                [simple_dc{k}.idc simple_dc{k}.outcomp]  =find_dc_par(s1,model_par.out_Vname{numout},invIV(model_par.out_kind),dc_an.par_name);
            end

            for l=1:model_par.mode_diff_enabled+1           % l= N° entree 
                if (model_par.in_kind=='V')
                    [simple_dc{k}.idc simple_dc{k}.incomp{l}]   =find_dc_par(s1,[model_par.in_Iname{l} ':n'],invIV(model_par.in_kind),dc_an.par_name);
                    [simple_dc{k}.idc simple_dc{k}.in{l}]       =find_dc_par(s1,model_par.in_Vname{l},       model_par.in_kind,       dc_an.par_name);
                else
                    [simple_dc{k}.idc simple_dc{k}.incomp{l}]   =find_dc_par(s1,model_par.in_Vname{l}, invIV(model_par.in_kind),dc_an.par_name);
                    [simple_dc{k}.idc simple_dc{k}.in{l}]       =find_dc_par(s1,[model_par.in_Iname{l} ':n'] ,model_par.in_kind,dc_an.par_name);
                end
            end

            if (~isempty(model_par.alim_Iname))&&(~((model_par.gen_sources==1)&&(model_par.gen_supply==0)))
                [simple_dc{k}.idc simple_dc{k}.suppdc]=find_dc_par(s1,[model_par.alim_Iname ':n'],model_par.alim_kind,dc_an.par_name);
            else
                simple_dc{k}.suppdc=[];
            end
            if isfield(model_par,'inter_name')
               for l=1:length(model_par.inter_name)
                 [simple_dc{k}.idc simple_dc{k}.inter(l,:)]=find_dc_par(s1,model_par.inter_name{l},model_par.inter_kind{l},dc_an.par_name);
               end
            end

            %Extract offset for the actual schematic output (V on output/I on output)

            pos_offset=solvev(simple_dc{k}.idc) ;  % get the position for which idc=0 ;

            simple_dc{k}.out_offset=valv(simple_dc{k}.out,pos_offset);
            simple_dc{k}.outcomp_offset=valv(simple_dc{k}.outcomp,pos_offset);
            reg=[ones(size(simple_dc{k}.idc))',simple_dc{k}.idc']\simple_dc{k}.out' ;   % get the mean square regression function for gain and offset
            simple_dc{k}.gain =reg(2);
           
            
            for l=1:model_par.mode_diff_enabled+1           % l= N° entree 
               simple_dc{k}.in_offset{l} =valv(simple_dc{k}.in{l},pos_offset);
               simple_dc{k}.incomp_offset{l}=valv(simple_dc{k}.incomp{l},pos_offset);

               reg=[ones(size(simple_dc{k}.idc))',simple_dc{k}.idc']\simple_dc{k}.incomp{l}' ;   % get the mean square regression function for input impedance
               if model_par.in_kind=='I'
                 simple_dc{k}.Zin{l} = reg(2);
               else
                 simple_dc{k}.Zin{l} = 1/reg(2);
               end
               
            end
        end
    end

end