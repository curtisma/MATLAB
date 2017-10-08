%---------------------------------------------------
% Ce programme est la propriete exclusive de SUPELEC
% Tout  usage  non  authorise  ou reproduction de ce
% programme est strictement defendu. 
% Copyright  (c) 2010  SUPELEC  Departement SSE
% Tous droits reserves
%---------------------------------------------------
%
% fichier : tf_decomp_real.m
% auteur  : P.BENABES & C.TUGUI 
% Copyright (c) 2010 SUPELEC
%
%---------------------------------------------------
%
% DESCRIPTION DU MODULE :
%   
%
% MODULES UTILISES :
%
%---------------------------------------------------


function sub_fct_str=tf_decomp_real(Num, Den)

% Find the decomposition of a transfer functions of type
%                         nb-1         nb-2
%             B(s)   b(1)s     +  b(2)s     + ... +  b(nb)
%      H(s) = ---- = -------------------------------------
%                         na-1         na-2
%             A(s)   a(1)s     +  a(2)s     + ... +  a(na)
%
% into a product of real transfer functions of orders 1 and 2:

%                                           2 
%              (s-z1) (s-z2)     (s-zn)  a1s + b1s + c1   
%      H(s) =  ------*------*...*------* --------------*...
%              (s-p1) (s-p2)     (s-pn)     2
%                                        d1s + e1s + f1  

sub_fct_str=[];

% Find the poles, zeros and gain of TF

%[z,p,gn] = tf2zp(Num,Den);
z=roots(Num);
p=roots(Den);

if isempty(z)&&isempty(p)
    sub_fct_str.Num=Num;
    sub_fct_str.Den=Den;
else
    gn=abs(Num(end)/Den(end)) ;     %% gain
    gs=sign(Num(end)/Den(end)) ;    %% sign

    % Find real p/z
    zreal=[];
    zcmpx=[];
    zreal_n=0;
    for i=1:size(z,1)
        if isreal(z(i))
            zreal=[zreal;z(i)];
            zreal_n=zreal_n+1;
        else
            zcmpx=[zcmpx;z(i)];
        end
    end

    preal=[];
    pcmpx=[];
    preal_n=0;
    for i=1:size(p,1)
        if isreal(p(i))
            preal=[preal;p(i)];
            preal_n=preal_n+1;
        else
            pcmpx=[pcmpx;p(i)];
        end
    end

    % Maximum number of ord1 functions will be the minimum real p/z
    maxord1=min(zreal_n,preal_n);

    % Maximum number of ord2 pure complex functions will be the minimum complex p/z
    zcmpx_n=size(z,1)-zreal_n;
    pcmpx_n=size(p,1)-preal_n;
    maxord2cmpx=min(zcmpx_n,pcmpx_n);

    % Test pairs of complex p/z
    if (~mod(zcmpx_n,2))&&(~mod(pcmpx_n,2))

        ind=1;
        elim=[];
        % Now compute all ord1 functions
        for i=1:maxord1
            %Use the gain gn for the first function
            if i==1
                [Num_subf,Den_subf] = zp2tf(zreal(i),preal(i),1);
                elim=[elim i];
            else %Use gain=1 for the others
                [Num_subf,Den_subf] = zp2tf(zreal(i),preal(i),1);
                elim=[elim i];
            end

            [Num_subf_norm Den_subf_norm]=norm_sfunct_dc(Num_subf,Den_subf);

            sub_fct_str(ind).Num=Num_subf_norm;
            sub_fct_str(ind).Den=Den_subf_norm;
            ind=ind+1;
        end

        if ~isempty(zreal)
            zreal=zreal(setdiff(1:size(zreal,1),elim));
        end
        if ~isempty(preal)
            preal=preal(setdiff(1:size(preal,1),elim));
        end

        %Eliminate complex-conjugated values
        if zcmpx_n>0
            elim=[];
            for k=1:zcmpx_n-1
                for l=k+1:zcmpx_n
                    if zcmpx(l)==conj(zcmpx(k))
                        elim=[elim l];
                    end
                end
            end
            zcmpx=zcmpx(setdiff(1:size(zcmpx,1),elim));
        end

        if pcmpx_n>0
            elim=[];
            for k=1:pcmpx_n-1
                for l=k+1:pcmpx_n
                    if pcmpx(l)==conj(pcmpx(k))
                        elim=[elim l];
                    end
                end
            end
            pcmpx=pcmpx(setdiff(1:size(pcmpx,1),elim));
        end

        % Now compute all ord2 pure complex functions
        elim=[];
        for i=1:maxord2cmpx/2

            [Num_subf,Den_subf] = zp2tf([zcmpx(i); conj(zcmpx(i))] ,[pcmpx(i); conj(pcmpx(i))] ,1);
            elim=[elim i];

            [Num_subf_norm Den_subf_norm]=norm_sfunct_dc(Num_subf,Den_subf);

            sub_fct_str(ind).Num=Num_subf_norm;
            sub_fct_str(ind).Den=Den_subf_norm;

            ind=ind+1;
        end

        zcmpx=zcmpx(setdiff(1:size(zcmpx,1),elim));
        pcmpx=pcmpx(setdiff(1:size(pcmpx,1),elim));

        % Now, the remaining singularities can be found in zcmpx pcmpx zreal preal

        % Form mixed functions with all the remaining complex singularities

        while ~isempty(zcmpx)

            if size(preal,1)>=2

                [Num_subf,Den_subf] = zp2tf([zcmpx(1); conj(zcmpx(1))] ,[preal(1); preal(2)] ,1);

                [Num_subf_norm Den_subf_norm]=norm_sfunct_dc(Num_subf,Den_subf);

                sub_fct_str(ind).Num=Num_subf_norm;
                sub_fct_str(ind).Den=Den_subf_norm;

                ind=ind+1;

                zcmpx=zcmpx(setdiff(1:size(zcmpx,1),1));
                preal=preal(setdiff(1:size(preal,1),[1 2]));

            elseif size(preal,1)==1

                [Num_subf,Den_subf] = zp2tf([zcmpx(1); conj(zcmpx(1))] , preal(1) ,1);

                [Num_subf_norm Den_subf_norm]=norm_sfunct_dc(Num_subf,Den_subf);

                sub_fct_str(ind).Num=Num_subf_norm;
                sub_fct_str(ind).Den=Den_subf_norm;
                ind=ind+1;

                zcmpx=zcmpx(setdiff(1:size(zcmpx,1),1));
                preal=preal(setdiff(1:size(preal,1),1));

            else

                [Num_subf,Den_subf] = zp2tf([zcmpx(1); conj(zcmpx(1))] , 1 ,1);

                [Num_subf_norm Den_subf_norm]=norm_sfunct_dc(Num_subf,Den_subf);

                sub_fct_str(ind).Num=Num_subf_norm;
                sub_fct_str(ind).Den=Den_subf_norm;
                ind=ind+1;

                zcmpx=zcmpx(setdiff(1:size(zcmpx,1),1));

            end

        end

        while ~isempty(pcmpx)

            if size(zreal,1)>=2
                [Num_subf,Den_subf] = zp2tf([zreal(1); zreal(2)] ,[pcmpx(1); conj(pcmpx(1))] ,1);

                [Num_subf_norm Den_subf_norm]=norm_sfunct_dc(Num_subf,Den_subf);

                sub_fct_str(ind).Num=Num_subf_norm;
                sub_fct_str(ind).Den=Den_subf_norm;

                ind=ind+1;

                pcmpx=pcmpx(setdiff(1:size(pcmpx,1),1));
                zreal=zreal(setdiff(1:size(zreal,1),[1 2]));

            elseif size(zreal,1)==1

                [Num_subf,Den_subf] = zp2tf(zreal(1) ,[pcmpx(1); conj(pcmpx(1))] ,1);

                [Num_subf_norm Den_subf_norm]=norm_sfunct_dc(Num_subf,Den_subf);

                sub_fct_str(ind).Num=Num_subf_norm;
                sub_fct_str(ind).Den=Den_subf_norm;

                ind=ind+1;

                pcmpx=pcmpx(setdiff(1:size(pcmpx,1),1));
                zreal=zreal(setdiff(1:size(zreal,1),1));

            else

                [Num_subf,Den_subf] = zp2tf(1 ,[pcmpx(1); conj(pcmpx(1))]  ,1);

                [Num_subf_norm Den_subf_norm]=norm_sfunct_dc(Num_subf,Den_subf);

                sub_fct_str(ind).Num=Num_subf_norm;
                sub_fct_str(ind).Den=Den_subf_norm;

                ind=ind+1;

                pcmpx=pcmpx(setdiff(1:size(pcmpx,1),1));

            end

        end

        % Form ord1 functions with all the remaining real singularities

        while ~isempty(zreal)

            %[Num_subf,Den_subf] = zp2tf(zreal(1), 1 ,1);
            Num_subf=[1 -zreal(1)] ;
            Den_subf=[1] ;

            [Num_subf_norm Den_subf_norm]=norm_sfunct_dc(Num_subf,Den_subf);

            sub_fct_str(ind).Num=Num_subf_norm;
            sub_fct_str(ind).Den=Den_subf_norm;

            ind=ind+1;

            zreal=zreal(setdiff(1:size(zreal,1),1));

        end

        while ~isempty(preal)

            %[Num_subf,Den_subf] = zp2tf(1, preal(1) ,1);
            Num_subf=[1] ;
            Den_subf=[1 -preal(1)] ;

            [Num_subf_norm Den_subf_norm]=norm_sfunct_dc(Num_subf,Den_subf);

            sub_fct_str(ind).Num=Num_subf_norm;
            sub_fct_str(ind).Den=Den_subf_norm;

            ind=ind+1;

            preal=preal(setdiff(1:size(preal,1),1));

        end

    else

        warndlg('Badly scaled transfer function.The function was not decomposed.','TF decomposition error');

        sub_fct_str(1).Num=Num; 
        sub_fct_str(1).Den=Den;

    end

    for k=1:length(sub_fct_str)
        sub_fct_str(k).Num=sub_fct_str(k).Num*(gn^(1/length(sub_fct_str))) ;
    end
    sub_fct_str(1).Num=sub_fct_str(1).Num*gs ;
end
return;        