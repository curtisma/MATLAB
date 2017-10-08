%---------------------------------------------------
% Ce programme est la propriete exclusive de SUPELEC
% Tout  usage  non  authorise  ou reproduction de ce
% programme est strictement defendu. 
% Copyright  (c) 2010  SUPELEC  Departement SSE
% Tous droits reserves
%---------------------------------------------------
%
% fichier : strcmpc.m
% auteur  : P.BENABES & C.TUGUI 
% Copyright (c) 2010 SUPELEC
% Revision: 2.0  Date: 29/10/2010
%
%---------------------------------------------------
%
% DESCRIPTION DU MODULE :
%   
%
% MODULES UTILISES :
%
%---------------------------------------------------
%Compare two strings
function c = strcmpc(s1,s2)

%lowercase in order to compare
s1=lower(s1);
s2=lower(s2);

l=min(length(s1), length(s2));
if l==0
	if ~isempty(s1)
		c=1;
	else
		c=-1;
	end
	return
end
i=find(s1(1:l)~=s2(1:l));
if isempty(i)
	if length(s1)<length(s2)
		c=-1;
	elseif length(s1)==length(s2)
		c=0;
	else
		c=1;
	end
	return
end
i=i(1);
if s1(i)<s2(i)
	c=-1;
else
	c=1;
end
