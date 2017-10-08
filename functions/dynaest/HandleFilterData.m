%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
%HandleFilterData , handle the filter data struct read from external file


FilterAlgorithmFlag = FilterData.FilterAlgorithmFlag;
ipwcfghif = FilterData.ipwcfghif;
itvfghif = FilterData.itvfghif;

% define F(t) matrix for filter
Ffstr = FilterData.Ffstr;
Gfstr = FilterData.Gfstr;
Hfstr = FilterData.Hfstr;
Ifstr = FilterData.Ifstr;

% NOISE STATISTICS used in the FILTER:
ipwcqrvwf=FilterData.ipwcqrvwf;
itvqrvwf=FilterData.itvqrvwf;

Qfstr = FilterData.Qfstr;        
Rfstr = FilterData.Rfstr;

vmf = FilterData.vmf;            % bias of process noise 
wmf = FilterData.wmf;            % bias of measurement noise 
 
% INITIAL CONDITIONS:
irandomx0p0 = FilterData.irandomx0p0;           % index for initial conditions
xt0 = FilterData.xt0;  % initial true state vector
x0 = FilterData.x0;  % initial estimate vector   
P0= FilterData.P0;