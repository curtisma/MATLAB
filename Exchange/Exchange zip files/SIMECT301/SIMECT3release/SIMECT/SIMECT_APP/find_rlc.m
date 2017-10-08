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
% file : find_rlc.m
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
%   extracts the RLC model of an input impedance
%
% MODULES UTILISES :
%
%---------------------------------------------------



function [R L C]=find_rlc(Rs,ZRAW,fr,err_param)
%Finds RLC components of the impedance of type RLC/RC given in ZRAW

if isinf(mean(ZRAW))
    R=NaN;
    L=NaN;
    C=0;
end

j=sqrt(-1);

%RLC or RC circuit
initial_val=abs(ZRAW(1));
is_rlc=0;
for i=2:size(ZRAW,2)
    if abs(ZRAW(i))>err_param.perc_rlc*initial_val
        is_rlc=1;
    end
end

%%%%%%%%%% Model for Z %%%%%%%%%%%%%%
%             |                     %
%             [] Rs                 %
%             |                     %
%     ----------------     \        %    
%     |       |      |     |        %
%     []      @      =     | ZP     %
%     |R      |L     |C    |        %
%     ----------------     /        %
%             |                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%For RLC find R, L and C
if is_rlc
    
    ZP = ZRAW - Rs;

    YP = 1./ZP;

    R=max(abs(ZP));
    
    for i=1:size(ZP,2)
        if (abs(ZP(i))==max(abs((ZP))))
            idx_freq_res=i;
        end
    end

    freq_res=fr(idx_freq_res);

    for i=1:size(fr,2)
        L_var(i)=((fr(i)/freq_res)^2-1)/(imag(YP(i))*2*pi*fr(i));
        C_var(i)=1/(L_var(i)*(2*pi*freq_res)^2);
        if L_var(i)*C_var(i)<0
            error('Error on computing L and C for RLC model!');
        else
           L_temp(i)=abs(L_var(i));
           C_temp(i)=abs(C_var(i));
        end
    end   

    err=err_param.max;
    
    for i=1:size(fr,2)
        z_calc=1./(1./R+j*2*pi*fr*C_temp(i)+1./(j*2*pi*fr*L_temp(i)));
        [new_err err_mod err_ph]=fit_err(z_calc,ZP,err_param.w);
        if (new_err<=err) && (L_temp(i)~=0) && (C_temp(i)~=0)
            err=new_err;
            z_calc_opt=z_calc;
            L=L_temp(i);
            C=C_temp(i);
            %figure(80);loglog(fr,mag(z_calc_opt),'r');hold on;
        end
    end

%%%%%%%%%% Model for Z %%%%%%%
%             |-------       %
%             |      |       %
%             |      |       %
%             []R    =C      %
%             |      |       %    
%             |      |       %
%             |-------       %
%             |              %
%             |              %
%             |              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%For RC find R and C    
else
    
    ZP = ZRAW;

    YP = 1./ZP;

    R=NaN;
    
    %Try to fit using the impedance value
    for i=1:size(fr,2)
        C_temp(i)=abs(imag(YP(i)-1/Rs)/(2*pi*fr(i)));
    end

    %Try to fit using the cut-off frequency
    %Find first cut-off frequency - LP Filter
    passb_mag=db(mean(ZP(1,1:5)));
    found_fc=0;

    for i=1:size(ZP,2)
    if ((db(ZP(1,i))<=(passb_mag-3))&&~found_fc)
        found_fc=1;
        fc=fr(i);
    end;
    end;
    
    for i=size(fr,2):2*size(fr,2)-1
        C_temp(i)=abs(1./(real(ZP(i-size(fr,2)+1))*2*pi*fr(i-size(fr,2)+1)));
    end
    
    %Find the best fit
    err=err_param.max;
    
    for i=1:(2*size(fr,2))-1
        z_calc=1./(1./Rs+j*2*pi*fr*C_temp(i));
        [new_err err_mod err_ph]=fit_err(z_calc,ZP,err_param.w);
        if (new_err<=err) && (C_temp(i)~=0)
            err=new_err;
            z_calc_opt=z_calc;
            C=C_temp(i);
        end
    end
   
    L=NaN;
end
 
return;