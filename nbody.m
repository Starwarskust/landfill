close all
clear

G = 6.674e-11;							% gravitational constant [m^3 kg^-1 s^-2]
dt = 0.01*86400;						% time step for computations [s]
t_max = 1.5*365*86400;					% finish time for computations and draw [s]

t_plot = 0;								% initial time for draw [s]
dt_plot = 2*86400;						% time step for draw [s]

point = struct;
point.mass = [];						% mass of point [kg]
point.position = [];					% position of point [m]
point.velosity = [];					% velosity of point [m/s]

%---------------------------------------

% Solar system
k = 0;

% Sun
k = k + 1;
point(k).mass = 1.989e30;
point(k).position = [0 0 0];
point(k).velosity = [0 0 0];

% Mercury
k = k + 1;
point(k).mass = 3.301e24;
point(k).position = [0 -46.00e9 0];
% point(k).velosity = [47.36e3  0 0];
point(k).velosity = [47.36e3*cosd(15)  0 47.36e3*sind(15)]; % with inclination

% Venis
k = k + 1;
point(k).mass = 4.868e24;
point(k).position = [ 0 107.8e9 0];
% point(k).velosity = [-35.02e3 0 0];
point(k).velosity = [-35.02e3*cosd(10) 0 35.02e3*sind(10)]; % with inclination

% Earth
k = k + 1;
point(k).mass = 5.973e24;
point(k).position = [147.1e9 0 0];
point(k).velosity = [0 29.78e3 0];

% Asteroid
k = k + 1;
point(k).mass = 5.973e20;
point(k).position = [-15.00e9 0 -60.00e9];
point(k).velosity = [0 50.00e3 0];

%---------------------------------------

% % Binary star
% k = 0;

% % Star 1
% k = k + 1;
% point(k).mass = 1.989e30;
% point(k).position = [ 50e9 0 0];
% point(k).velosity = [ 0 24e3 0];

% % Star 2
% k = k + 1;
% point(k).mass = 1.5*1.989e30;
% point(k).position = [-50e9 0 0];
% point(k).velosity = [0 -16e3 0];

%---------------------------------------

figure('Units','Normalized','Outerposition',[0 0 1 1]);
hold on
boxsize = 200e9;
xlim([-boxsize boxsize])
ylim([-boxsize boxsize])
zlim([-boxsize boxsize])
grid on

for t = 0:dt:t_max

	for i = 1:length(point)
		acceleration = [0 0 0];
		for j = 1:length(point)
			if j == i
				continue
			end
			direction = [point(j).position] - [point(i).position];
			r = norm(direction);
			direction = direction/r;
			acceleration = acceleration + G * point(j).mass / r^2 * direction;
		end
		point(i).position = [point(i).position] + [point(i).velosity] * dt + acceleration * dt^2 / 2;
		point(i).velosity = [point(i).velosity] + acceleration * dt;
	end

	if t+dt > t_plot
		plot_points(point)
		title(['time = ' num2str(t/86400) ' days'])
		ch = get(gca,'Children');
		pause(0.4)						% time lag for draw in seconds
		t_plot = t_plot + dt_plot;
	end

	if t+2*dt > t_plot
		for i = 1:length(point)
			ch(i).MarkerSize = 0.5;
			% delete(ch(i))
		end
	end

end

function plot_points(point)
	for i = 1:length(point)
		vector = [point(i).position];
		plot3(vector(1),vector(2),vector(3),'.k','MarkerSize',10);
	end
end
