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
% file : unitodiff.m
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
%   extracts the gains from a function in differential mode
%
% MODULES UTILISES :
%
%---------------------------------------------------


function [simple_dc1,simple_dc2,simple_dc1_comm,simple_dc2_comm,dir_dc1,dir_dc2,comm_dc1,comm_dc2]=unitodiff(rep1,rep2) 

    simple_dc1=rep1.simple_dc{1};
    simple_dc2=rep2.simple_dc{1};
    
    if ~(isempty(simple_dc1)||isempty(simple_dc2))
        simple_dc1.out=(rep1.simple_dc{1}.out-rep2.simple_dc{1}.out);
        simple_dc2.out=(rep1.simple_dc{1}.out+rep2.simple_dc{1}.out)/2;
        simple_dc1.gain=(rep1.simple_dc{1}.gain-rep2.simple_dc{1}.gain);
        simple_dc2.gain=(rep1.simple_dc{1}.gain+rep2.simple_dc{1}.gain)/2;
    else
        simple_dc1=[];
        simple_dc2=[];
    end
        
    simple_dc1_comm=rep1.simple_dc{2};
    simple_dc2_comm=rep2.simple_dc{2};
    
    if ~(isempty(simple_dc1_comm)||isempty(simple_dc2_comm))
        simple_dc1_comm.out=(rep1.simple_dc{2}.out-rep2.simple_dc{2}.out) ;
        simple_dc2_comm.out=(rep1.simple_dc{2}.out+rep2.simple_dc{2}.out)/2 ;
        simple_dc1_comm.gain=(rep1.simple_dc{2}.gain-rep2.simple_dc{2}.gain) ;
        simple_dc2_comm.gain=(rep1.simple_dc{2}.gain+rep2.simple_dc{2}.gain)/2 ;
    else
        simple_dc1_comm=[];
        simple_dc2_comm=[];
    end

    dir_dc1=rep1.dir_dc{1};
    dir_dc2=rep2.dir_dc{1};
    
    if ~(isempty(rep1.dir_dc{1})||isempty(rep2.dir_dc{1}))
        dir_dc1.out=(rep1.dir_dc{1}.out-rep2.dir_dc{1}.out)/2;
        dir_dc2.out=(rep1.dir_dc{1}.out+rep2.dir_dc{1}.out)/2;
        dir_dc1.Gn_dir=(rep1.dir_dc{1}.Gn_dir-rep2.dir_dc{1}.Gn_dir)/2;
        dir_dc2.Gn_dir=(rep1.dir_dc{1}.Gn_dir+rep2.dir_dc{1}.Gn_dir)/2;
    else
        dir_dc1=[];
        dir_dc2=[];
    end

    comm_dc1=rep1.dir_dc{2};
    comm_dc2=rep2.dir_dc{2};
    
    if ~(isempty(rep1.dir_dc{2})||isempty(rep2.dir_dc{2}))
        comm_dc1.out=(rep1.dir_dc{2}.out-rep2.dir_dc{2}.out)/2;
        comm_dc2.out=(rep1.dir_dc{2}.out+rep2.dir_dc{2}.out)/2;
        comm_dc1.Gn_dir=(rep1.dir_dc{2}.Gn_dir-rep2.dir_dc{2}.Gn_dir)/2 ;
        comm_dc2.Gn_dir=(rep1.dir_dc{2}.Gn_dir+rep2.dir_dc{2}.Gn_dir)/2 ;
    else
        comm_dc1=[];
        comm_dc2=[];
    end
    
return
    
