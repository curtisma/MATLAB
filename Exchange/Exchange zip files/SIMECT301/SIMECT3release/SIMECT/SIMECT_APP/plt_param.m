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
% file : plt_param.m
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
%   plot the parametric analysys results
%
% MODULES UTILISES :
%---------------------------------------------------


function  plt_param( res, fig, dc_an, par_an, ac_in_an, ac_out_an, model_par )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here

col='bgrcmykbgrcmyk' ;

figure(60+fig) ; clf ; 
ps=get(60+fig,'position'); ps(3:4)=[1000 800]; set(60+fig,'position',ps);

if (par_an.enabled || dc_an.enabled)
    if isfield(res,'offsin')
        subplot(4,5,1) ;
        plot(res.val,res.offsin) ;
        xlabel(res.nam) ; title('input offset') ; grid on ;
        ax=axis ; ax(1)=min(res.val) ; ax(2)=max(res.val) ; axis(ax);
    end

    subplot(4,5,2) ;
    plot(res.val,res.offsout) ;
    xlabel(res.nam) ; title('output offset') ; grid on ;
    ax=axis ; ax(1)=min(res.val) ; ax(2)=max(res.val) ; axis(ax);

    subplot(4,5,11) ;
    plot(res.val,res.gaind1) ; hold on;
    xlabel(res.nam) ; title('direct gain') ; grid on ;
    ax=axis ; ax(1)=min(res.val) ; ax(2)=max(res.val) ; axis(ax);

    if isfield(res,'gaind2')
      subplot(4,5,12) ;
      plot(res.val,res.gaind2,'r') ; hold on
    end    
    if isfield(res,'gaind3')
      subplot(4,5,12) ;
      plot(res.val,res.gaind3,'g') ; hold on
    end    
    if isfield(res,'gaind4')
      subplot(4,5,12) ;
      plot(res.val,res.gaind4,'b') ; hold on
    end    
    if isfield(res,'gaind2') || isfield(res,'gaind3') || isfield(res,'gaind4')
        xlabel(res.nam) ; title('common mode') ; grid on ; hold on
        ax=axis ; ax(1)=min(res.val) ; ax(2)=max(res.val) ; axis(ax);
    end


    subplot(4,5,6) ;
    plot(res.val,res.ze) ;
    xlabel(res.nam) ; title('input impedance') ; grid on ;
    ax=axis ; ax(1)=min(res.val) ; ax(2)=max(res.val) ; axis(ax);


end

if (par_an.enabled)
    
    if isfield(res,'gaini')
        subplot(4,5,13) ;
        plot(res.val,res.gaini) ;
        xlabel(res.nam) ; title('inverse gain') ; grid on ; hold on
        ax=axis ; ax(1)=min(res.val) ; ax(2)=max(res.val) ; axis(ax);
    end
    
    subplot(4,5,7) ;
    plot(res.val,res.zs) ;
    xlabel(res.nam) ; title('output impedance') ; grid on ;
    ax=axis ; ax(1)=min(res.val) ; ax(2)=max(res.val) ; axis(ax);
    
    if (isfield(res,'nlin'))
        subplot(4,5,3) ;
        plot(res.val,res.nlin,'k') ; hold on
        plot(res.val,res.nlin(:,6),'r') ;
        xlabel(res.nam) ; title('input non linearity') ; grid on ;
        ax=axis ; ax(1)=min(res.val) ; ax(2)=max(res.val) ; axis(ax);
    end

    subplot(4,5,4) ;
    plot(res.val,res.nlout,'k') ; hold on
    plot(res.val,res.nlout(:,6),'r') ;
    xlabel(res.nam) ; title('output non linearity') ; grid on ;
    ax=axis ; ax(1)=min(res.val) ; ax(2)=max(res.val) ; axis(ax);
 
end

if (ac_in_an.enabled)

    nbcurv=size(res.fac,1);
    if (ac_out_an.enabled)
      lvect=size(res.fac,2)/3;
    else
      lvect=size(res.fac,2)/2;
    end
    for k=1:2+ac_out_an.enabled
        subplot(4,5,15+k); 
        for l=1:nbcurv
            loglog(res.fac(l,(1:lvect)+(k-1)*lvect),abs(res.repac(l,(1:lvect)+(k-1)*lvect)),col(l)) ;
            grid on; hold on;
        end
    end
    
    if (model_par.mode_diff_enabled)
        nbcurv_comm=size(res.fac_comm,1);
        lvect_comm=size(res.fac_comm,2)/2;
        for k=1:2
            subplot(4,5,15+k); 
            for l=1:nbcurv_comm
                loglog(res.fac_comm(l,(1:lvect_comm)+(k-1)*lvect_comm),abs(res.repac_comm(l,(1:lvect_comm)+(k-1)*lvect_comm)),col(l)) ;
                grid on; hold on;
            end
        end
    end
    
    subplot(4,5,16); xlabel('reduced frequency'); title('transfer function');
    subplot(4,5,17); xlabel('reduced frequency'); title('Zin');
    if (ac_out_an.enabled)    
        subplot(4,5,18); xlabel('reduced frequency'); title('Zout') ;
    end
    
    subplot(4,5,8) ;
    plot(res.val,res.zef0) ;
    xlabel(res.nam) ; title('input impedance at f0') ; grid on ;
    ax=axis ; ax(1)=min(res.val) ; ax(2)=max(res.val) ; axis(ax);

    if (isfield(res,'zsf0'))
        subplot(4,5,9) ;
        plot(res.val,res.zsf0) ;
        xlabel(res.nam) ; title('output impedance at f0') ; grid on ;
        ax=axis ; ax(1)=min(res.val) ; ax(2)=max(res.val) ; axis(ax);
    end
    
    subplot(4,5,14) ;
    plot(res.val,res.delayf0) ;
    xlabel(res.nam) ; title('delay') ; grid on ;
    ax=axis ; ax(1)=min(res.val) ; ax(2)=max(res.val) ; axis(ax);

    subplot(4,5,15) ;
    plot(res.val,res.Q) ;
    xlabel(res.nam) ; title('quality factor') ; grid on ;
    ax=axis ; ax(1)=min(res.val) ; ax(2)=max(res.val) ; axis(ax);
    
end

if (isfield(res,'trans'));
  if ~isempty(res.trans)
  subplot(4,5,20) ;
  for l=1:size(res.time,2)
    plot(res.time{l},res.trans{l},col(l)) ; grid on ; hold on;
  end
  xlabel(res.nam) ; title('transient') 
  end
end