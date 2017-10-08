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
% file : addinfogene.m
% authors  : P.BENABES & C.TUGUI 
% Copyright (c) 2011 SUPELEC
% Revision: 3.0  Date: 24/03/2011
%
%---------------------------------------------------
% Modifications history
% 24 MAR 2011 	: version 3.0
%---------------------------------------------------
%
% DESCRIPTION DU MODULE :
%   rajoute à la netlist les informations sur les générateurs de test
%
% MODULES UTILISES :
%
%---------------------------------------------------

function [ model_par,trans_an,dc_an,par_an,design_var ] = addinfogene( model_par,trans_an,dc_an,par_an,design_var )
%ADDINFOGENE Summary of this function goes here
%   Detailed explanation goes here

model_par.in_Iname{1} ='V8980';
model_par.in_Iname{2} ='V8981';
model_par.mode_var_I{1} ='g8980';
model_par.mode_var_I{2} ='g8981';

for k=1:model_par.numout
    model_par.out_Iname{2*k-1}=['V89' num2str(2*k-2,'%02d') ];
    model_par.out_Iname{2*k}=['V89' num2str(2*k-1,'%02d') ];
    model_par.mode_var_O{2*k-1} =['g89' num2str(2*k-2,'%02d') ];
    model_par.mode_var_O{2*k} =['g89' num2str(2*k-1,'%02d')  ];
end

model_par.DcInNam     ='DcIn899';
for l=1:model_par.numout*2
  model_par.DcOutNam{l}    =['DcOut89' num2str(l-1,'%02d')];
end

model_par.alim_Iname  ='V8999';
model_par.InNam       ='In899';
model_par.OutNam      ='Out899';
model_par.SuppNam      ='Vsupp899';

trans_an.naminmax     ='TranMax899' ;
trans_an.naminmin     ='TranMin899' ;
trans_an.nam_per_tr   ='TranPer899' ; 

dc_an.par_name        = model_par.InNam ;
par_an.var_name       = model_par.OutNam ;

k=length(design_var)+1 ;
  design_var(k).name=model_par.mode_var_I{1} ;
  design_var(k).value=0 ; k=k+1 ;
  design_var(k).name=model_par.mode_var_I{2} ;
  design_var(k).value=0 ; k=k+1 ;
  
  for l=1:model_par.numout*2
      design_var(k).name=model_par.mode_var_O{l} ;
      design_var(k).value=0 ; k=k+1 ;
  end
  design_var(k).name=dc_an.par_name ;
  design_var(k).value=0 ; k=k+1;
  design_var(k).name=par_an.var_name ;
  design_var(k).value=0 ; k=k+1;
  
  %  Only when transient is enabled
  if trans_an.enabled
      %   If square
      if strcmp(trans_an.type,'Square')
          design_var(k).name=trans_an.naminmax ;
          design_var(k).value=trans_an.valinmax ; k=k+1;
          design_var(k).name=trans_an.naminmin ;
          design_var(k).value=trans_an.valinmin ; k=k+1;
          
          design_var(k).name='TranDcSin899' ;
          design_var(k).value=0 ; k=k+1;
          design_var(k).name='TranAmpSin899' ;
          design_var(k).value=0 ; k=k+1;
          
          %   If Sine
      elseif strcmp(trans_an.type,'Sine')
          design_var(k).name='TranDcSin899' ;
          design_var(k).value=(trans_an.valinmax+trans_an.valinmin)/2 ; k=k+1;
          design_var(k).name='TranAmpSin899' ;
          design_var(k).value=(trans_an.valinmax-trans_an.valinmin)/2  ; k=k+1;
          
          design_var(k).name=trans_an.naminmax ;
          design_var(k).value=0 ; k=k+1;
          design_var(k).name=trans_an.naminmin ;
          design_var(k).value=0 ; k=k+1;
          
          % Important
          trans_an.valinmax=0;
          trans_an.valinmin=0;
          
          %   Else const
      else
          design_var(k).name=trans_an.naminmax ;
          design_var(k).value=0 ; k=k+1;
          design_var(k).name=trans_an.naminmin ;
          design_var(k).value=0 ; k=k+1;
          design_var(k).name='TranDcSin899' ;
          design_var(k).value=0 ; k=k+1;
          design_var(k).name='TranAmpSin899' ;
          design_var(k).value=0 ; k=k+1;
          % Important
          trans_an.valinmax=0;
          trans_an.valinmin=0;
      end
  
  
  design_var(k).name=trans_an.nam_per_tr ;
  design_var(k).value=trans_an.per_tr ; k=k+1;
  
  else
      
      %  When transient is disabled still DC the source parameters
      design_var(k).name=trans_an.naminmax ;
      design_var(k).value=0 ; k=k+1;
      design_var(k).name=trans_an.naminmin ;
      design_var(k).value=0 ; k=k+1;
      design_var(k).name='TranDcSin899' ;
      design_var(k).value=0 ; k=k+1;
      design_var(k).name='TranAmpSin899' ;
      design_var(k).value=0 ; k=k+1;
      % Important
      trans_an.valinmax=0;
      trans_an.valinmin=0;
      
      design_var(k).name=trans_an.nam_per_tr ;
      design_var(k).value=1 ; k=k+1;
  
  end
  
  design_var(k).name=model_par.DcInNam ;
  design_var(k).value=model_par.inoffset ; k=k+1;
  
  for l=1:model_par.numout
      for m=0:model_par.mode_diff_enabled_out
          design_var(k).name=model_par.DcOutNam{l*2+m-1} ;
          if length(model_par.outoffset)==1
            design_var(k).value=model_par.outoffset ; k=k+1;
          elseif length(model_par.outoffset)==model_par.numout
            design_var(k).value=model_par.outoffset(l) ; k=k+1;
          else
            design_var(k).value=model_par.outoffset(l*2-1+m) ; k=k+1;             
          end
      end
  end
  
  design_var(k).name=model_par.InNam ;
  design_var(k).value=0 ; k=k+1 ;
  design_var(k).name=model_par.OutNam ;
  design_var(k).value=0 ; k=k+1 ;
  if (model_par.gen_supply==1)
      design_var(k).name=model_par.SuppNam ;
      design_var(k).value=model_par.supply_value ; k=k+1;     
  end

end

