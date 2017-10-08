%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%IMMKF   Interacting Multiple Model algorithm with Kalman filters

function [x,P,modex,modeP,modePr,modexp,modePP,modeS,modeW,modezp,modenu,...
likelihood]=ImmKf(modex,modeP,z,...
modeQ,modeR,modevm,modewm,modeF,modeG,modeH,modeI,TransPr,modePr)

[nx,nm]=size(modex);[nv,nm]=size(modevm);[nw,nm]=size(modewm);nz=length(z);
Fk1=zeros(nx); Gk1=zeros(nx,nv); H=zeros(nz,nx); I=zeros(nz,nw);
P=Fk1; Qk1=zeros(nv); R=zeros(nw); PP=P;

% interaction:
pred_modePr = TransPr'*modePr;
MixPr = TransPr.*(modePr*(pred_modePr.^(-1))');
modex0 = modex*MixPr; modePP = modeP;
for j=1:nm
  xk1=modex(:,j)-modex0(:,j); PP=xk1*xk1'; modePP(:,j)=PP(:);
end
modeP = (modeP+modePP)*MixPr;

% filtering:
for j=1:nm
  x=modex0(:,j);  P(:)=modeP(:,j);
  Qk1(:)=modeQ(:,j); R(:)=modeR(:,j); vmk1=modevm(:,j); wm=modewm(:,j);
  Fk1(:)=modeF(:,j);   Gk1(:)=modeG(:,j); H(:)=modeH(:,j);  I(:)=modeI(:,j);
  [x,P,xk1,Pk1,S,W,zk1,nu]=Kalman(x,P,z,Qk1,R,vmk1,wm,Fk1,Gk1,H,I);
  modex(:,j)=x;      modeP(:,j)=P(:);
  modexp(:,j)=xk1;   modePP(:,j)=Pk1(:);
  modeS(:,j)=S(:);   modeW(:,j)=W(:);
  modezp(:,j)=zk1;   modenu(:,j)=nu;
%  numean=zeros(size(nu));
%  likelihood(j)=gausspdf(nu,numean,S);
  c(1,j)=pred_modePr(j)/sqrt(det(2*pi*S));
  c(2,j)=nu'*inv(S)*nu;
end

% mode probability calculation:
%modePr=pred_modePr.*likelihood';
% The following likelihood-ratio implementation is better numerically, which 
% alleviates the underflow problem when the measurement residual is large:
for i=1:nm, dummy=0;
  for j=1:nm
    if j~=i, dummy=dummy+c(1,j)*exp(-0.5*(c(2,j)-c(2,i))); end
  end
  modePr(i)=1/(1+dummy/c(1,i));
end
modePr=modePr/sum(modePr);

% combination:
x = modex*modePr;
for j=1:nm
  xk1=modex(:,j)-x; PP=xk1*xk1'; modePP(:,j)=PP(:);
end
P(:) = (modeP+modePP)*modePr;

likelihood = 1; % nothing, but to delete the warning

return
