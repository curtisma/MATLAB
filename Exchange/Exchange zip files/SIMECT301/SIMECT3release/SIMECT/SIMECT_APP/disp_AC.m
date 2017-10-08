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
% file : disp_ac.m
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
%   affiche les r�sultats de simulation en mode AC
%
% MODULES UTILISES :
%
%---------------------------------------------------

function []=disp_AC(multi_in_out,model_in_out,ac_an,ac_in_an,ac_out_an,model_par,numout,disprlc,fig_title)

if isfield(multi_in_out,'mod_ac')  
    mod_in1=multi_in_out(1).mod_ac;
    mod_out1=multi_in_out(1+numout*2).mod_ac;
    if model_par.mode_diff_enabled
        mod_in2=multi_in_out(2).mod_ac;
    end
    if model_par.mode_diff_enabled_out 
        mod_out2=multi_in_out(2+numout*2).mod_ac;
    end
else
    mod_in1=[];
    mod_out1=[];
end

if isfield(multi_in_out,'rep_ac')
    rep_in1=multi_in_out(1).rep_ac;
    rep_out1=multi_in_out(1+numout*2).rep_ac;
    if model_par.mode_diff_enabled
        rep_in2=multi_in_out(2).rep_ac;
    end
    if model_par.mode_diff_enabled_out 
        rep_out2=multi_in_out(2+numout*2).rep_ac;
    end
else
    rep_in1=[];
    rep_out1=[];
end
   

if isfield(multi_in_out,'par_rlc_fc')
    if ac_in_an.enabled
        rlc_fc_in1=multi_in_out(1).par_rlc_fc{numout*2-1};
        if model_par.mode_diff_enabled
            rlc_fc_in2=multi_in_out(2).par_rlc_fc{numout*2};
        end
    else
        rlc_fc_in1=[];
    end
    if ac_out_an.enabled
        rlc_fc_out1=multi_in_out(1+numout*2).par_rlc_fc{1};
        if model_par.mode_diff_enabled_out
            rlc_fc_out2=multi_in_out(2+numout*2).par_rlc_fc{1};
        end
    else
        rlc_fc_out1=[] ;
    end
else
    rlc_fc_in1=[];
end

if isfield(multi_in_out,'par_rep_trans')
    rep_trans=multi_in_out(1+numout*2).par_rep_trans;
    if model_par.mode_diff_enabled_out
        rep_trans2=multi_in_out(2+numout*2).par_rep_trans;
    else
        rep_trans2=[];        
    end
else
    rep_trans=[];
end

if ac_in_an.enabled
    f=rep_in1.f;
    if ac_an.enable_ac_norm
        f=f*ac_an.f0 ;
    end
elseif ac_out_an.enabled
    f=rep_out1.f;
    if ac_an.enable_ac_norm
        f=f*ac_an.f0 ;
    end
end

if ac_in_an.enabled  
    if model_par.mode_diff_enabled
        if model_par.mode_diff_enabled_out
            TF_diff_in_comm_out=model_in_out.TF_diff_in_comm_out;
            TF_diff_in_diff_out=model_in_out.TF_diff_in_diff_out;
            TF_comm_in_comm_out=model_in_out.TF_comm_in_comm_out;
            TF_comm_in_diff_out=model_in_out.TF_comm_in_diff_out;
            if ac_in_an.extract_pz
                B_TF_diff_in_comm_out=model_in_out.B_TF_diff_in_comm_out;
                A_TF_diff_in_comm_out=model_in_out.A_TF_diff_in_comm_out;
                B_TF_diff_in_diff_out=model_in_out.B_TF_diff_in_diff_out;
                A_TF_diff_in_diff_out=model_in_out.A_TF_diff_in_diff_out;
                B_TF_comm_in_comm_out=model_in_out.B_TF_comm_in_comm_out;
                A_TF_comm_in_comm_out=model_in_out.A_TF_comm_in_comm_out;
                B_TF_comm_in_diff_out=model_in_out.B_TF_comm_in_diff_out;
                A_TF_comm_in_diff_out=model_in_out.A_TF_comm_in_diff_out;
            end
        end
    else
        if model_par.mode_diff_enabled_out
            TF_comm_out=model_in_out.TF_comm_out;
            TF_diff_out=model_in_out.TF_diff_out;
            if ac_in_an.extract_pz
                B_TF_comm_out=model_in_out.B_TF_comm_out;
                A_TF_comm_out=model_in_out.A_TF_comm_out;
                B_TF_diff_out=model_in_out.B_TF_diff_out;
                A_TF_diff_out=model_in_out.A_TF_diff_out;
            end
        end
    end

end
    

if model_par.mode_diff_enabled
    m=3;
else
    m=2;
end

ftsiz=14 ; %Text
ftsiz2=9 ; %Plot axes
ftsiz3=13 ; %Plot titles

numfig=40+numout ;

figure(numfig) ; clf ;
set(numfig,'Name', fig_title);

scrsz = get(0,'ScreenSize');
if (scrsz(3)>1600)  % double screen
    ps=[(numout-1)*scrsz(3)/16+10 20 scrsz(3)/4-50+(m-2)*400 scrsz(4)-100]; set(numfig,'position',ps);
else
    ps=[(numout-1)*scrsz(3)/8+10 20 scrsz(3)/2-50+(m-2)*400 scrsz(4)-100]; set(numfig,'position',ps);
end

uicontrol('style','pushbutton','units','pixels','fontsize',12,'fontunit','pixels','fontname','Helvetica', ...
  'position',[0,0,100,40],'string','Close','callback',['close(' num2str(numfig) ');']) ;

subplot(3,m,2) ; axis('off') ;
horiz_init=1;
horiz=horiz_init;

if disprlc
    if isfield(rlc_fc_in1,'Rs')
      if (~isnan(rlc_fc_in1.Rs))
        text(-0.2,horiz,'Rs in :','fontsize',ftsiz);
        text(0.15,horiz,num2str(rlc_fc_in1.Rs),'fontsize',ftsiz) ;
        if model_par.mode_diff_enabled
            text(0.7,horiz,num2str(rlc_fc_in2.Rs),'fontsize',ftsiz) ;            
        end
        horiz=horiz-0.15; 
      end
    end
    if isfield(rlc_fc_in1,'R')
      if (~isnan(rlc_fc_in1.R))
        text(-0.2,horiz,'R in :','fontsize',ftsiz);
        text(0.15,horiz,num2str(rlc_fc_in1.R),'fontsize',ftsiz) ;
        if model_par.mode_diff_enabled
            text(0.7,horiz,num2str(rlc_fc_in2.R),'fontsize',ftsiz) ;            
        end
        horiz=horiz-0.15;
      end
    end
    if isfield(rlc_fc_in1,'L')
      if (~isnan(rlc_fc_in1.L))
        text(-0.2,horiz,'L in :','fontsize',ftsiz);
        text(0.15,horiz,num2str(rlc_fc_in1.L),'fontsize',ftsiz) ;
        if model_par.mode_diff_enabled
            text(0.7,horiz,num2str(rlc_fc_in2.L),'fontsize',ftsiz) ;            
        end
        horiz=horiz-0.15;
      end
    end
    if isfield(rlc_fc_in1,'C')
      if (~isnan(rlc_fc_in1.C))
        text(-0.2,horiz,'C in :','fontsize',ftsiz);
        text(0.15,horiz,num2str(rlc_fc_in1.C),'fontsize',ftsiz) ;
        if model_par.mode_diff_enabled
            text(0.7,horiz,num2str(rlc_fc_in2.C),'fontsize',ftsiz) ;            
        end
        horiz=horiz-0.15;
      end
    end
    
    
    if isfield(rlc_fc_out1,'Rs')
      if (~isnan(rlc_fc_out1.Rs))
        text(-0.2,horiz,'Rs out :','fontsize',ftsiz);
        text(0.15,horiz,num2str(rlc_fc_out1.Rs),'fontsize',ftsiz) ;
        if model_par.mode_diff_enabled_out
            text(0.7,horiz,num2str(rlc_fc_out2.Rs),'fontsize',ftsiz) ;
        end
        horiz=horiz-0.15;
      end
    end
    if isfield(rlc_fc_out1,'R')
      if (~isnan(rlc_fc_out1.R))
        text(-0.2,horiz,'R out :','fontsize',ftsiz);
        text(0.15,horiz,num2str(rlc_fc_out1.R),'fontsize',ftsiz) ;
        if model_par.mode_diff_enabled_out
            text(0.7,horiz,num2str(rlc_fc_out2.R),'fontsize',ftsiz) ;
        end
        horiz=horiz-0.15;
      end
    end
    if isfield(rlc_fc_out1,'L')
      if (~isnan(rlc_fc_out1.L))
        text(-0.2,horiz,'L out :','fontsize',ftsiz);
        text(0.15,horiz,num2str(rlc_fc_out1.L),'fontsize',ftsiz) ;
        if model_par.mode_diff_enabled_out
            text(0.7,horiz,num2str(rlc_fc_out2.L),'fontsize',ftsiz) ;
        end
        horiz=horiz-0.15;
      end
    end
    if isfield(rlc_fc_out1,'C')
      if (~isnan(rlc_fc_out1.C))
        text(-0.2,horiz,'C out :','fontsize',ftsiz);
        text(0.15,horiz,num2str(rlc_fc_out1.C),'fontsize',ftsiz) ;
        if model_par.mode_diff_enabled_out
           text(0.7,horiz,num2str(rlc_fc_out2.C),'fontsize',ftsiz) ;
        end
        horiz=horiz-0.15;
      end
    end
end


subplot(3,m,1) ; axis('off') ;
if (nargin<=15)&&(horiz<=horiz_init-0.8) 
    n=2;
else
    n=1;
end
horiz=horiz_init;
if isfield(rep_out1,'Zf0')
    text(-0.3,horiz,'Zout at f0:','fontsize',ftsiz);
    text(0.2,horiz,num2str(rep_out1.Zf0),'fontsize',ftsiz) ;
    
    if model_par.mode_diff_enabled_out
        text(0.6,horiz,num2str(rep_out2.Zf0),'fontsize',ftsiz) ;
    end
    
end
if isfield(rep_in1,'Zf0')
    text(-0.3,horiz-0.15*n,'Zin at f0:','fontsize',ftsiz);
    text(0.2,horiz-0.15*n,num2str(rep_in1.Zf0),'fontsize',ftsiz) ;
    if model_par.mode_diff_enabled
        text(0.6,horiz-0.15*n,num2str(rep_in2.Zf0),'fontsize',ftsiz) ;
    end 
end
if isfield(rlc_fc_in1,'fc')
  if (~isnan(rlc_fc_in1.fc))
    text(-0.3,horiz-0.3*n,'FC trans :','fontsize',ftsiz);
    text( 0.2,horiz-0.3*n,num2str(rlc_fc_in1.fc,'%1.4g'),'fontsize',ftsiz) ;
    
    if model_par.mode_diff_enabled
        if isfield(rlc_fc_in2,'fc')
        text(0.6,horiz-0.3*n,num2str(rlc_fc_in2.fc,'%1.4g'),'fontsize',ftsiz) ;
        end
    end
        
  end
end
if (isfield(rlc_fc_in1,'phase_at_f0'))
    text(-0.3,horiz-0.45*n,'Delay @ f0 (ns): ','fontsize',ftsiz) ;
     text(0.2,horiz-0.45*n,num2str(rlc_fc_in1.phase_at_f0/2/pi/ac_an.f0*1e9),'fontsize',ftsiz) ;
   
    if model_par.mode_diff_enabled
        if isfield(rlc_fc_in2,'phase_at_f0')
            text(0.6,horiz-0.45*n,num2str(rlc_fc_in2.phase_at_f0/2/pi/ac_an.f0*1e9),'fontsize',ftsiz) ;
        end
    end
        
end
if (isfield(rlc_fc_in1,'Q'))
    text(-0.3,horiz-0.6*n,'Quality factor: ','fontsize',ftsiz) ;
     text(0.2,horiz-0.6*n,num2str(rlc_fc_in1.Q),'fontsize',ftsiz) ;
   
    if model_par.mode_diff_enabled
        if isfield(rlc_fc_in2,'Q')
            text(0.6,horiz-0.6*n,num2str(rlc_fc_in2.Q),'fontsize',ftsiz) ;
        end
    end
        
end
if (nargin>17)
    text(-0.2,horiz-0.6*n,[nam ' = ' num2str(val) ],'fontsize',ftsiz) ;
end




if (~isempty(mod_in1) || ~isempty(mod_out1))
    
    if ac_an.enable_ac_norm
        fr=logspace(log10(ac_an.start/ac_an.f0),log10(ac_an.stop/ac_an.f0),1000);
    else
        fr=logspace(log10(ac_an.start),log10(ac_an.stop),1000);
    end
      
    if (isfield(mod_in1,'B_TF'))
        if (~isempty(mod_in1.B_TF))

          %If DIFF input
          if model_par.mode_diff_enabled
            %Select output type: diff/comm
            if model_par.mode_diff_enabled_out
                r1_diff_in_diff_out=freqs(B_TF_diff_in_diff_out,A_TF_diff_in_diff_out,2*pi*f) ;
                r1_diff_in_comm_out=freqs(B_TF_diff_in_comm_out,A_TF_diff_in_comm_out,2*pi*f) ;
                r1_comm_in_diff_out=freqs(B_TF_comm_in_diff_out,A_TF_comm_in_diff_out,2*pi*f) ;
                r1_comm_in_comm_out=freqs(B_TF_comm_in_comm_out,A_TF_comm_in_comm_out,2*pi*f) ; 
            else %if out comm
                r1=freqs(mod_in1.B_TF{numout*2-1},mod_in1.A_TF{numout*2-1},2*pi*fr)- freqs(mod_in2.B_TF{numout*2-1},mod_in2.A_TF{numout*2-1},2*pi*fr);   
            end

          else %If COMM input
            %Select output type: diff/comm
            if model_par.mode_diff_enabled_out
                r1_diff_out=freqs(B_TF_diff_out,A_TF_diff_out,2*pi*f) ;
                r1_comm_out=freqs(B_TF_comm_out,A_TF_comm_out,2*pi*f) ;
            else %if out comm
                r1=freqs(mod_in1.B_TF{numout*2-1},mod_in1.A_TF{numout*2-1},2*pi*fr) ;
            end
          end

        end
    end
    
    if (~isempty(mod_in1) && (model_par.mode_diff_enabled))
      if (~isempty(mod_out1))
          if isfield(mod_out1,'A_TF')
            r1_comm=freqs(mod_in1.B_TF{numout*2-1},mod_in1.A_TF{numout*2-1},2*pi*fr)+freqs(mod_in2.B_TF{numout*2-1},mod_in2.A_TF{numout*2-1},2*pi*fr) ;
          end
      end
    else
      r1_comm=[] ;
    end

    r_Zin1=[] ;
    if (isfield(mod_in1,'B_Z'))
        if (~isempty(mod_in1.B_Z))
          r_Zin1=freqs(mod_in1.B_Z{1},mod_in1.A_Z{1},2*pi*fr) ;
        end
    end
    
    r_Zin2=[] ;
    r_ZinDiff=[] ;
    if model_par.mode_diff_enabled %        differentiel input
        if (isfield(mod_in2,'B_Z'))
            if (~isempty(mod_in2.B_Z))
              r_Zin2=freqs(mod_in2.B_Z{1},mod_in2.A_Z{1},2*pi*fr) ;
              r_ZinDiff=freqs(mod_in2.B_Z{2},mod_in2.A_Z{2},2*pi*fr) ;
            end
        end       
    end
    
    if (isfield(mod_out1,'B_Z'))
        if (~isempty(mod_out1.B_Z))
          r_Zout1=freqs(mod_out1.B_Z{1},mod_out1.A_Z{1},2*pi*fr) ;
        end
    end
    
    if model_par.mode_diff_enabled_out %        differentiel input
        if (isfield(mod_out1,'B_Z'))
            if (~isempty(mod_out1.B_Z))
              r_ZoutDiff=freqs(mod_out1.B_Z{2},mod_out1.A_Z{2},2*pi*fr) ;
            end
        end
    end
    
    if ~isempty(rlc_fc_in1)
      if isnan(rlc_fc_in1.L)
        r_Zin_rlc=1./(1./rlc_fc_in1.Rs+1i*2*pi*f*rlc_fc_in1.C);
      else
        r_Zin_rlc=rlc_fc_in1.Rs+1./(1./rlc_fc_in1.R+1i*2*pi*f*rlc_fc_in1.C+1./(1i*2*pi*f*rlc_fc_in1.L));
      end
    end
    if ~isempty(rlc_fc_out1)
        if isnan(rlc_fc_out1.Rs)
            r_Zout_rlc=[] ;
        else
            if isnan(rlc_fc_out1.L)
                r_Zout_rlc=1./(1./rlc_fc_out1.Rs+1i*2*pi*f*rlc_fc_out1.C);
            else
                r_Zout_rlc=rlc_fc_out1.Rs+1./(1./rlc_fc_out1.R+1i*2*pi*f*rlc_fc_out1.C+1./(1i*2*pi*f*rlc_fc_out1.L));
            end
        end
        else        
        r_Zout_rlc=[] ;
    end

    if (isfield(rep_in1,'TF'))
    
      subplot(3,m,3+(m-2));
      
      %If DIFF input
      if model_par.mode_diff_enabled
        %Select output type: diff/comm

        if model_par.mode_diff_enabled_out
        
            loglog(f,abs(TF_diff_in_diff_out),'r'); grid on ; hold on;
            loglog(f,abs(TF_diff_in_comm_out),'k');
            
            if exist('r1_diff_in_diff_out','var')
                loglog(f,abs(r1_diff_in_diff_out),'b'); 
                amp=sqrt(max(abs(r1_diff_in_diff_out))/min(abs(r1_diff_in_diff_out))) ;
                text(min(f),abs(r1_diff_in_diff_out(1))*amp^0.4,'red=measure DIFF OUT' ,'fontsize',ftsiz2,'color','r') ;
                text(min(f),abs(r1_diff_in_diff_out(1))*amp^0.05,'blue=model DIFF OUT' ,'fontsize',ftsiz2,'color','b') ;
                loglog(f,abs(r1_diff_in_comm_out),'k--'); 
                text(min(f),abs(r1_diff_in_comm_out(1))*amp^0.05,'black=COMM OUT','fontsize',ftsiz2,'color','k') ;
            end

            ax=axis ; ax(1)=min(f) ; ax(2)=max(f) ; axis(ax) ;
            title('Transfer function for IN DIFF','fontsize',ftsiz3);
            xlabel('freq','fontsize',ftsiz2);

            subplot(3,m,6);

            loglog(f,abs(TF_comm_in_diff_out),'r'); grid on ; hold on;
            loglog(f,abs(TF_comm_in_comm_out),'k');
            
            
            if exist('r1_comm_in_diff_out','var')
                loglog(f,abs(r1_comm_in_diff_out),'b'); 
                amp=sqrt(max(abs(r1_comm_in_diff_out))/min(abs(r1_comm_in_diff_out))) ;
                text(min(f),abs(r1_comm_in_diff_out(1))*amp^(-0.8),'red=measure DIFF OUT' ,'fontsize',ftsiz2,'color','r') ;
                text(min(f),abs(r1_comm_in_diff_out(1))*amp^(-0.4),'blue=model DIFF OUT' ,'fontsize',ftsiz2,'color','b') ;
                loglog(f,abs(r1_comm_in_comm_out),'k--'); 
                text(min(f),abs(r1_comm_in_comm_out(1))*amp^(0.05),'black=COMM OUT','fontsize',ftsiz2,'color','k') ;
            end

            ax=axis ; ax(1)=min(f) ; ax(2)=max(f) ; axis(ax) ;
            title('Transfer function for IN COMM','fontsize',ftsiz3);
        
        else %if diff in out comm
       
            loglog(f,abs(rep_in1.TF{numout*2-1}-rep_in2.TF{numout*2-1}),'r'); grid on ; hold on;
            
            if exist('r1','var')
                loglog(fr,abs(r1),'b'); 
                amp=sqrt(max(abs(r1))/min(abs(r1))) ;
                text(min(fr),min(abs(r1))*amp^1.2,'red=measure','fontsize',ftsiz2,'color','r') ;
                text(min(fr),min(abs(r1))*amp,'blue=model','fontsize',ftsiz2,'color','b') ;
            end

            if (~isempty([rlc_fc_in1.fc]))
                loglog([1 1]*rlc_fc_in1.fc,[min(abs(rep_in1.TF{numout*2-1})) max(abs(rep_in1.TF{numout*2-1}))]);
            end

            ax=axis ; ax(1)=min(f) ; ax(2)=max(f) ; axis(ax) ;
            title('Transfer function for IN DIFF','fontsize',ftsiz3);



            if (~isempty(r1_comm))
               subplot(3,m,6);

               loglog(f,abs(rep_in1.TF{numout*2-1}+rep_in2.TF{numout*2-1}),'r');
               hold on ;
               
               if exist('r1_comm','var')
                   loglog(fr,abs(r1_comm),'b');  grid on ; hold on;
                   amp=sqrt(max(abs(r1_comm))/min(abs(r1_comm))) ;
                   text(min(fr),min(abs(r1_comm))*amp^1.2,'red=measure','fontsize',ftsiz2,'color','r') ;
                   text(min(fr),min(abs(r1_comm))*amp,'blue=model','fontsize',ftsiz2,'color','b') ;
               end

               ax=axis ; ax(1)=min(f) ; ax(2)=max(f) ; axis(ax) ;
               title('Transfer function for IN COMM','fontsize',ftsiz3);

            end
       
        end
    
      else %If COMM input
        %Select output type: diff/comm
        if model_par.mode_diff_enabled_out
            
            loglog(f,abs(TF_diff_out),'r'); grid on ; hold on;
            loglog(f,abs(TF_comm_out),'k');
            
            if exist('r1_diff_out','var')
                loglog(f,abs(r1_diff_out),'b'); 
                amp=sqrt(max(abs(r1_diff_out))/min(abs(r1_diff_out))) ;
                text(min(f),min(abs(r1_diff_out))*amp^5,'red=measure DIFF OUT' ,'fontsize',ftsiz2,'color','r') ;
                text(min(f),min(abs(r1_diff_out))*amp^3,'blue=model DIFF OUT' ,'fontsize',ftsiz2,'color','b') ; 
                loglog(f,abs(r1_comm_out),'k--'); 
                text(min(f),min(abs(r1_comm_out))*amp,'black=COMM OUT' ,'fontsize',ftsiz2,'color','k') ;
            end
            
            ax=axis ; ax(1)=min(f) ; ax(2)=max(f) ; axis(ax) ;
            title('Transfer function','fontsize',ftsiz3);
        
        else %if out comm
    
            loglog(f,abs(rep_in1.TF{numout*2-1}),'r'); grid on ; hold on
            
            if exist('r1','var')
                loglog(fr,abs(r1),'b'); 
                amp=sqrt(max(abs(r1))/min(abs(r1))) ;
                text(min(fr),min(abs(r1))*amp^1.2,'red=measure' ,'fontsize',ftsiz2,'color','r') ;
                text(min(fr),min(abs(r1))*amp,'blue=model' ,'fontsize',ftsiz2,'color','b') ;
            end
    
            if (~isempty([rlc_fc_in1.fc]))
                loglog([1 1]*rlc_fc_in1.fc,[min(abs(rep_in1.TF{numout*2-1})) max(abs(rep_in1.TF{numout*2-1}))]);
            end
            
            ax=axis ; ax(1)=min(f) ; ax(2)=max(f) ; axis(ax) ;
            title('Transfer function','fontsize',ftsiz3);
            
         end
      end  
      
      xlabel('freq','fontsize',ftsiz2);
      

      subplot(3,m,4+(m-2)); 
      
      loglog(f,abs(rep_in1.Z{1}),'r'); grid on ; hold on ;
      if exist('r_Zin1','var')
          loglog(fr,abs(r_Zin1),'b'); 
          ax=axis ; ax(1)=min(f) ; ax(2)=max(f) ; axis(ax) ;
      end
      if exist('r_Zin_rlc','var') && disprlc
        loglog(f,abs(r_Zin_rlc),'m');
      end
       if (~isempty(r_ZinDiff))
        loglog(fr,abs(r_ZinDiff),'k');
%        loglog(f,abs(rep_in1.Z{1}),'k');
       end
      
      ax=axis ;
      fc=sqrt(ax(1)*ax(2));
      amp=ax(4)/ax(3) ;
      
      if exist('r_Zin1','var')
          text(fc,ax(4)/amp^0.05,'red=measure','fontsize',ftsiz2,'color','r') ;
          text(fc,ax(4)/amp^0.1,'blue=model s','fontsize',ftsiz2,'color','b') ;
      end
      if exist('r_Zin_rlc','var') && disprlc
        text(fc,ax(4)/amp^0.15,'magenta=model RLC','fontsize',ftsiz2,'color','m') ;
      end     
       if (~isempty(r_ZinDiff))
        text(fc,ax(4)/amp^0.2,'black=differentiel','fontsize',ftsiz2,'color','k') ;
      end

      xlabel('freq','fontsize',ftsiz2);
      title('Z in','fontsize',ftsiz3);
    end

    if (isfield(rep_out1,'Z'))
        subplot(3,m,6+2*(m-2)); 
        
       loglog(f,abs(rep_out1.Z{1}),'r'); grid on ; hold on ;
       ax=axis ; ax(1)=min(f) ; ax(2)=max(f) ; axis(ax) ;
       if exist('r_Zout1','var')
            loglog(fr,abs(r_Zout1),'b');
        end
        if ~isempty(r_Zout_rlc) && disprlc
            loglog(f,abs(r_Zout_rlc),'m');
        end
        
        if model_par.mode_diff_enabled_out
           loglog(f,abs(rep_out1.Z{2}),'g'); grid on ; hold on ;
           if exist('r_ZoutDiff','var')
                loglog(fr,abs(r_ZoutDiff),'y');
           end            
        end
        
        
        ax=axis ;
        fc=sqrt(ax(1)*ax(2));
        amp=ax(4)/ax(3) ;
        
        text(fc,ax(4)/amp^0.05,'red=measure','fontsize',ftsiz2,'color','r') ;
        text(fc,ax(4)/amp^0.1,'blue=model s','fontsize',ftsiz2,'color','b') ;
        if disprlc && ~isempty(r_Zout_rlc)
          text(fc,ax(4)/amp^0.15,'magenta=model RLC','fontsize',ftsiz2,'color','m') ;
        end

        if model_par.mode_diff_enabled_out
            text(fc,ax(4)/amp^0.20,'green=measure diff','fontsize',ftsiz2,'color','g') ;
            text(fc,ax(4)/amp^0.25,'yellow=model s diff','fontsize',ftsiz2,'color','y') ;
        end
        
        xlabel('freq','fontsize',ftsiz2);
        title('Z out','fontsize',ftsiz3);
    end
end

if (~isempty(rep_trans))
    subplot(3,m,5+2*(m-2)); 
    plot(rep_trans.time, rep_trans.mag,'r'); grid on;
    xlabel('time','fontsize',ftsiz2); ylabel('out','fontsize',ftsiz2);
    title('Transient response','fontsize',ftsiz3);
    if (~isempty(rep_trans2))
        hold on
        plot(rep_trans2.time, rep_trans2.mag,'g'); grid on;
    end
end