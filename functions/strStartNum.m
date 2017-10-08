% Checks to see if the first character in a string is a number
%  Author: Curtis Mayberry
function out = strStartNum(strIn)
out = ~isempty(str2num(strIn(1)));