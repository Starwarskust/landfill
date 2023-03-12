close all
clear
clc

a = 1;
T1 = 3;
T2 = 5;
t = 0;
x = -6:0.02:6;
y = T2/2*( 1 - erf(x/(2*a*sqrt(t))) ) + T1/2*( 1 + erf(x/(2*a*sqrt(t))) );

maxtime = 10;
dt = 0.2;
n = floor(maxtime/dt);

h = figure('units','normalized','outerposition',[0 0 0.6 0.6]);
hold on
g = plot(x,y,'k');
l = legend('0 sec');
xlim([-6 6])
ylim([ 0 8])
title(['Time from 0 to ' num2str(n*dt) ' sec'])
grid on
box on

for i = 1:n
    pause(dt)
    delete(g)
    delete(l)
    t = t + dt;
    y = T2/2*( 1 - erf(x/(2*a*sqrt(t))) ) + T1/2*( 1 + erf(x/(2*a*sqrt(t))) );
    g = plot(x,y,'k');
    l = legend([num2str(t,'%.2f') ' sec']);
end
