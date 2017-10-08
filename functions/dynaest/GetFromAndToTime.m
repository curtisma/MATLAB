%%% DynaEst 3.032 10/22/2000
% Copyright (c) 2000 Yaakov Bar-Shalom
%
% GetFromAndToTime


str = get(h_Edit1,'string');
FromTime(1) = str2num(str);
str = get(h_Edit3,'string');
FromTime(2) = str2num(str);
str = get(h_Edit5,'string');
FromTime(3) = str2num(str);
str = get(h_Edit7,'string');
FromTime(4) = str2num(str);
str = get(h_Edit9,'string');
FromTime(5) = str2num(str);

str = get(h_Edit2,'string');
ToTime(1) = str2num(str);
str = get(h_Edit4,'string');
ToTime(2) = str2num(str);
str = get(h_Edit6,'string');
ToTime(3) = str2num(str);
str = get(h_Edit8,'string');
ToTime(4) = str2num(str);
str = get(h_Edit10,'string');
ToTime(5) = str2num(str);

