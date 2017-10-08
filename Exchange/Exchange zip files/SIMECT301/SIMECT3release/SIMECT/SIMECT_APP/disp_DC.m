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
% file : disp_DC.m
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
%   affiche les r�sultats de simulation DC 
%
% MODULES UTILISES :
%       * disp_ac
%
%---------------------------------------------------
function []=disp_DC(model_par,dir_dc,comm_dc,inv_dc,imp_dc,simple_dc,simple_dc_comm,idx,disp_res_diffcomm,fig_title)

%display DC results

ftsiz=14 ; %Text
ftsiz2=11 ; %Plot axes
ftsiz3=13 ; %Plot titles

numfig=20+idx ;
figure(numfig) ; clf ;
set(numfig,'Name', fig_title);



scrsz = get(0,'ScreenSize');
if (scrsz(3)>1600)  % double screen
    ps=[(idx-1)*(scrsz(3)/16-30) 10 scrsz(3)/4-50 scrsz(4)-100]; set(numfig,'position',ps);    
else
    ps=[(idx-1)*(scrsz(3)/8-30) 10 scrsz(3)/2-50 scrsz(4)-100]; set(numfig,'position',ps);
end

    %Extract AC parameters or simple DC response
if isfield(simple_dc,'out')
      subplot(4,2,3); 
      xf=1; yf=1 ;
      if (model_par.in_kind=='I')         % input is a voltage and we caracterize the input current
        xf=1000 ;
      end
      if (model_par.out_kind=='I')         % input is a voltage and we caracterize the input current
        yf=1000 ;
      end
      plot( simple_dc.idc*xf, simple_dc.out'*yf);
      grid on ;
      if isfield(simple_dc_comm,'out')
         hold on ;
         plot( simple_dc_comm.idc*xf, simple_dc_comm.out'*yf,'r');
      end   
     
      if (model_par.in_kind=='V')         % input is a voltage and we caracterize the input current
        xlabel('input voltage (V)','fontsize',ftsiz2);
      else                                  % input is a current and we caracterize the input voltage
        xlabel('input current (mA)','fontsize',ftsiz2);
      end
      if (model_par.out_kind=='I')         % input is a voltage and we caracterize the input current
        title('output current (mA)','fontsize',ftsiz3);
      else                                  % input is a current and we caracterize the input voltage
        title('output voltage (V)','fontsize',ftsiz3);
      end
end

if isfield(simple_dc,'in')
      subplot(4,2,4); 
      if (model_par.in_kind=='I')         % input is a voltage and we caracterize the input current
        xf=1000 ; yf=1 ;
      else
        xf=1 ; yf=1000 ;
      end
      hold on ;
      for k=1:model_par.mode_diff_enabled+1
          plot( simple_dc.idc*xf, simple_dc.incomp{k}'*yf);
          grid on ;
          if isfield(simple_dc_comm,'in1')
             plot( simple_dc_comm.idc*xf, simple_dc_comm.incomp{k}'*yf,'r');
          end   
      end
      
      if (model_par.in_kind=='V')         % input is a voltage and we caracterize the input current
        xlabel('input voltage (V)','fontsize',ftsiz2);
        title('input current (mA)','fontsize',ftsiz3);
      else                                  % input is a current and we caracterize the input voltage
        xlabel('input current (mA)','fontsize',ftsiz2);
        title('input voltage (V) ','fontsize',ftsiz3);
      end
end

if isfield(dir_dc,'out')
      subplot(4,2,5);
      xf=1; yf=1 ; zf=1 ;
      if (model_par.in_kind=='I')         % input is a voltage and we caracterize the input current
        xf=1000 ;
      end
      if (model_par.out_kind=='I')         % input is a voltage and we caracterize the input current
        zf=1000 ;
      else
        yf=1000 ;
      end
      mesh(dir_dc.idc*xf,dir_dc.par*yf,dir_dc.out*zf);
      if (model_par.in_kind=='V')         % input is a voltage and we caracterize the input current
        xlabel('input voltage (V)','fontsize',ftsiz2);
      else                                  % input is a current and we caracterize the input voltage
        xlabel('input current (mA)','fontsize',ftsiz2);
      end
      if (model_par.out_kind=='I')         % input is a voltage and we caracterize the input current
        title('output current (mA)','fontsize',ftsiz3);
        ylabel('output voltage (V) ','fontsize',ftsiz2);
     else                                  % input is a current and we caracterize the input voltage
        ylabel('output current (mA)','fontsize',ftsiz2);
        title('output voltage (V) ','fontsize',ftsiz3);
      end
      if ( max(max(dir_dc.out)))>(min(min(dir_dc.out)) )
        axis([dir_dc.idc(1)*xf dir_dc.idc(end)*xf dir_dc.par(1)*yf dir_dc.par(end)*yf min(min(dir_dc.out))*zf max(max(dir_dc.out))*zf ]);
      end
end

if isfield(inv_dc,'in')   

      subplot(4,2,6);
      xf=1; yf=1 ; zf=1 ;
      if (model_par.in_kind=='I')         % input is a voltage and we caracterize the input current
        xf=1000 ;
      else
        zf=1000 ;
      end
      if (model_par.out_kind=='V')         % input is a voltage and we caracterize the input current
        yf=1000 ;
      end
      mesh(inv_dc.idc*xf,inv_dc.par*yf,inv_dc.in{1}*zf);
      if (model_par.in_kind=='V')         % input is a voltage and we caracterize the input current
        xlabel('input voltage (V)','fontsize',ftsiz2);
        title('input current (mA)','fontsize',ftsiz3);
      else                                  % input is a current and we caracterize the input voltage
        xlabel('input current (mA)','fontsize',ftsiz2);
        title('input voltage (V) ','fontsize',ftsiz3);
      end
      if (model_par.out_kind=='I')         % input is a voltage and we caracterize the input current
        ylabel('output voltage (V) ','fontsize',ftsiz2);
     else                                  % input is a current and we caracterize the input voltage
        ylabel('output current (mA)','fontsize',ftsiz2);
      end
      if ( max(max(inv_dc.in{1})))>(min(min(inv_dc.in{1})) )
        axis([inv_dc.idc(1)*xf inv_dc.idc(end)*xf inv_dc.par(1)*yf inv_dc.par(end)*yf min(min(inv_dc.in{1}))*zf max(max(inv_dc.in{1}))*zf ]);
      elseif (max(max(abs(inv_dc.in{1})))>0) 
        axis([inv_dc.idc(1)*xf inv_dc.idc(end)*xf inv_dc.par(1)*yf inv_dc.par(end)*yf min(min(inv_dc.in{1}))*zf*0.9 max(max(inv_dc.in{1}))*zf*1.1 ]); 
      else
         axis([inv_dc.idc(1)*xf inv_dc.idc(end)*xf inv_dc.par(1)*yf inv_dc.par(end)*yf -1 1 ]);        
      end
end

if isfield(simple_dc,'inter')
    subplot(4,2,7);
    plot( simple_dc.idc, simple_dc.inter');grid on;axis tight;
    xlabel('input value','fontsize',ftsiz2);
    ylabel('intermediary voltages','fontsize',ftsiz2);
elseif isfield(comm_dc,'out')
    subplot(4,2,7);
    xf=1; yf=1 ; zf=1 ;
    if (model_par.in_kind=='I')         % input is a voltage and we caracterize the input current
        xf=1000 ;
    end
    if (model_par.out_kind=='I')         % input is a voltage and we caracterize the input current
        zf=1000 ;
    else
        yf=1000 ;
    end
    mesh(comm_dc.idc*xf,comm_dc.par*yf,comm_dc.out*zf);

    if (model_par.in_kind=='V')         % input is a voltage and we caracterize the input current
        xlabel('input voltage (V)','fontsize',ftsiz2);
    else                                  % input is a current and we caracterize the input voltage
        xlabel('input current (mA)','fontsize',ftsiz2);
    end
    if (model_par.out_kind=='I')         % input is a voltage and we caracterize the input current
        title('output current (mA) (CM input)','fontsize',ftsiz3);
        ylabel('output voltage (V) (CM input)','fontsize',ftsiz2);
    else                                  % input is a current and we caracterize the input voltage
        ylabel('output current (mA)','fontsize',ftsiz2);
        title('output voltage (V) ','fontsize',ftsiz3);
    end
    if ( max(max(comm_dc.out)))>(min(min(comm_dc.out)) )
        axis([comm_dc.idc(1)*xf comm_dc.idc(end)*xf comm_dc.par(1)*yf comm_dc.par(end)*yf min(min(comm_dc.out))*zf max(max(comm_dc.out))*zf ]);
    end
end

if isfield(simple_dc,'suppdc')
    if ~isempty(simple_dc.suppdc)
      subplot(4,2,8);
      xf=1; 
      if (model_par.in_kind=='I')         % input is a voltage and we caracterize the input current
        xf=1000 ;
      end
      plot( simple_dc.idc*xf, -simple_dc.suppdc*1e3);
      if (model_par.in_kind=='V')         % input is a voltage and we caracterize the input current
        xlabel('input voltage (V)','fontsize',ftsiz2);
      else                                  % input is a current and we caracterize the input voltage
        xlabel('input current (mA)','fontsize',ftsiz2);
      end
      title('Supply current (mA)','fontsize',ftsiz3);
      grid on ; 
    end
end

subplot(4,1,1) ; axis('off') ;

x1=-0.15 ;
x2=0.2 ;
x3=0.6 ;

if ~isempty(simple_dc)
    text(x1+0.1,1.3  ,'DC SIM','fontsize',ftsiz) ;
    text(x1,1  ,['direct gain : ' num2str(simple_dc.gain) ],'fontsize',ftsiz) ;
    if (~isempty(simple_dc_comm))
        text(x1,1.15 ,['C.M. gain : ' num2str(simple_dc_comm.gain) ],'fontsize',ftsiz) ;
    end
    if (model_par.out_kind=='V')
      text(x1,0.8,['V out dc    : ' num2str(simple_dc.out_offset) ' V' ],'fontsize',ftsiz) ;
      text(x1,0.65,['I out dc    : ' num2str(simple_dc.outcomp_offset*1000) ' mA' ],'fontsize',ftsiz) ;        
    else
      text(x1,0.8,['I out dc    : ' num2str(simple_dc.out_offset*1000) ' mA' ],'fontsize',ftsiz) ;        
      text(x1,0.65,['V out dc    : ' num2str(simple_dc.outcomp_offset) ' V' ],'fontsize',ftsiz) ;
    end
    if (model_par.in_kind=='I')
      text(x1,0.5,['V in dc     : ' num2str(simple_dc.incomp_offset{1}) ' V' ],'fontsize',ftsiz) ;
      text(x1,0.35,['I in dc     : ' num2str(simple_dc.in_offset{1}*1000) ' mA' ],'fontsize',ftsiz) ;
    else
      text(x1,0.5,['I in dc     : ' num2str(simple_dc.incomp_offset{1}*1000) ' mA' ],'fontsize',ftsiz) ;
      text(x1,0.35,['V in dc     : ' num2str(simple_dc.in_offset{1}) ' V' ],'fontsize',ftsiz) ;
    end
    if model_par.mode_diff_enabled
        if (model_par.in_kind=='I')
          text(x1,0.2,['V in2 dc     : ' num2str(simple_dc.incomp_offset{2}) ' V' ],'fontsize',ftsiz) ;
          text(x1,0.05,['I in2 dc     : ' num2str(simple_dc.in_offset{2}*1000) ' mA' ],'fontsize',ftsiz) ;
        else
          text(x1,0.2,['I in2 dc     : ' num2str(simple_dc.incomp_offset{2}*1000) ' mA' ],'fontsize',ftsiz) ;
          text(x1,0.05,['V in2 dc     : ' num2str(simple_dc.in_offset{2}) ' V' ],'fontsize',ftsiz) ;
        end
    end
    
    text(x1,-0.1,['Z in : ' num2str(simple_dc.Zin{1})  ],'fontsize',ftsiz) ;

end


if (~isempty(dir_dc))
    text(x2+0.1,1.3  ,'PARAM SIM','fontsize',ftsiz) ;
    text(x2,1  ,['direct gain : ' num2str(dir_dc.Gn_dir) ],'fontsize',ftsiz) ;
    if (~isempty(comm_dc))
        text(x2,1.15 ,['C.M. gain : ' num2str(comm_dc.Gn_dir) ],'fontsize',ftsiz) ;
    end
    text(x2,0.85,['Z out : ' num2str(imp_dc.Zout{1}) ],'fontsize',ftsiz) ;
    if (model_par.out_kind=='V')
      text(x2,0.7,['V out dc    : ' num2str(dir_dc.nl.c0) ' V' ],'fontsize',ftsiz) ;
    else
      text(x2,0.7,['I out dc    : ' num2str(dir_dc.nl.c0*1000) ' mA' ],'fontsize',ftsiz) ;        
    end
end

if (~isempty(inv_dc))
    text(x2,0.5,['Z in : ' num2str(imp_dc.Zin{1})  ],'fontsize',ftsiz) ;
    text(x2,0.35,['inverse gain : ' num2str(imp_dc.Gn_inv{1}) ],'fontsize',ftsiz) ;
    if (model_par.in_kind=='I')
      text(x2,0.2,['V in dc     : ' num2str(inv_dc.nl{1}.c0) ' V' ],'fontsize',ftsiz) ;
    else
      text(x2,0.2,['I in dc     : ' num2str(inv_dc.nl{1}.c0*1000) ' mA' ],'fontsize',ftsiz) ;
    end
end




%subplot(4,2,2) ; axis('off') ;

if (disp_res_diffcomm==0)
    text(x3,1.3  ,'NON LINEARITIES','fontsize',ftsiz) ;
    if (~isempty(dir_dc))
        text(x3,1.0,['NLX : ' num2str(dir_dc.nl.cx2n) '  ' num2str(dir_dc.nl.cx3n)],'fontsize',ftsiz) ;
        text(x3,0.9,['NLY : ' num2str(dir_dc.nl.cy2n) '  ' num2str(dir_dc.nl.cy3n)],'fontsize',ftsiz) ;
        text(x3,0.8,['IMOD : ' num2str(dir_dc.nl.cxyn) ],'fontsize',ftsiz) ;
        text(x3,0.7,['NLTOT : ' num2str(dir_dc.nl.ct) ],'fontsize',ftsiz) ;
    end

    if (~isempty(inv_dc))
        text(x3,0.5,['NLX : ' num2str(inv_dc.nl{1}.cx2n) '  ' num2str(inv_dc.nl{1}.cx3n)],'fontsize',ftsiz) ;
        text(x3,0.4,['NLY : ' num2str(inv_dc.nl{1}.cy2n) '  ' num2str(inv_dc.nl{1}.cy3n)],'fontsize',ftsiz) ;
        text(x3,0.3,['IMOD : ' num2str(inv_dc.nl{1}.cxyn) ],'fontsize',ftsiz) ;
        text(x3,0.2,['NLTOT : ' num2str(inv_dc.nl{1}.ct) ],'fontsize',ftsiz) ;
    end
end