h = figure;
t = 0:pi/20:2*pi;
plot('v6',t,sin(t).*2)
saveas(h,'myFigFile','jpg')
