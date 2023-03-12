close all

U = @(r,a) -a./r;
Ueff = @(r,a,L,m) U(r,a) + L^2./(2*m*r.^2);

G = 6.674e-11;
m = 5.972e24;
M = 1.989e30;
v = 29.78e3;
R = 147.1e9;

AE = 149597870700;

L = R*m*v;
a = G*m*M;

r = linspace(30e9, 10*AE, 500);
y = Ueff(r,a,L,m);

figure
plot(r/AE, Ueff(r,a,L,m))
% ylim([-1 10])
grid on

% r(y == min(y))

r = linspace(0.1, 4, 500);
figure
plot(r, Ueff(r,3,1,1), '.-')
hold on
plot(r, -3./r)
plot(r, 1^2./(2*1*r.^2))
% ylim([-1 10])
grid on
