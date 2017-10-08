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
function disp_int_DC(model_par,sig,k,numpar)

if (nargin<4)
    numpar=0;
end
col='bgrcmykw';

ftsiz2=11 ; %Plot axes

%for k=0:model_par.mode_diff_enabled %if out diff
    %sig=multi_in_out(3).simple_dc{k+1};
    
    figure(16+k);
    scrsz = get(0,'ScreenSize');
    if (scrsz(3)>1600)  % double screen
        ps=[(k)*(scrsz(3)/16-30) 10 scrsz(3)/4-50 scrsz(4)-100]; set(16+k,'position',ps);    
    else
        ps=[(k)*(scrsz(3)/8-30) 10 scrsz(3)/2-50 scrsz(4)-100]; set(16+k,'position',ps);
    end

    xf=1; 
    if (model_par.in_kind=='I')         % input is a voltage and we caracterize the input current
        xf=1000 ;
    end

    
    nfig=size(sig.Vname,2) ;
    lfig=-floor(-sqrt(nfig));
    for l=1:nfig
        subplot(lfig,lfig,l)
        if numpar
            for m=1:numpar
                plot(sig.idc*xf,sig.Vval{m}{l},col(mod(m-1,8)+1));
                hold on ;
            end
        else
          plot(sig.idc*xf,sig.Vval{l});
        end
        grid on ;
        ax=axis ; ax(1)=min(sig.idc*xf) ; ax(2)=max(sig.idc*xf); axis(ax);
        title(sig.Vname{l});
        if (model_par.in_kind=='V')         % input is a voltage and we caracterize the input current
            xlabel('input voltage (V)','fontsize',ftsiz2);
        else                                  % input is a current and we caracterize the input voltage
            xlabel('input current (mA)','fontsize',ftsiz2);
        end
    end
    
    figure(18+k);
    if (scrsz(3)>1600)  % double screen
        ps=[(k+2)*(scrsz(3)/16-30) 10 scrsz(3)/4-50 scrsz(4)-100]; set(18+k,'position',ps);    
    else
        ps=[(k+2)*(scrsz(3)/8-30) 10 scrsz(3)/2-50 scrsz(4)-100]; set(18+k,'position',ps);
    end
    nfig=size(sig.Iname,2) ;
    lfig=-floor(-sqrt(nfig));
    for l=1:nfig
        subplot(lfig,lfig,l)
        if numpar
            for m=1:numpar
                plot(sig.idc*xf,sig.Ival{m}{l},col(mod(m-1,8)+1));
                hold on ;
            end
        else
            plot(sig.idc*xf,sig.Ival{l});
        end
        grid on ;
        ax=axis ; ax(1)=min(sig.idc*xf) ; ax(2)=max(sig.idc*xf); axis(ax);
        title(sig.Iname{l});
        if (model_par.in_kind=='V')         % input is a voltage and we caracterize the input current
            xlabel('input voltage (V)','fontsize',ftsiz2);
        else                                  % input is a current and we caracterize the input voltage
            xlabel('input current (mA)','fontsize',ftsiz2);
        end
    end
   
%end