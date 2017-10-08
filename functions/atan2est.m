function out = atan2est(y,x)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
z = y/x;
if(y~=0)
    sy = sign(y);
else
    sy=1;
end
    
if((z <= pi/4) && (z >= -pi/4))
    out = z*(1.0584-sy*0.273*z);
elseif((z <= pi/4) && (z >= -pi/4))
    out = 
end

