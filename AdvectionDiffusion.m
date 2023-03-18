%Skeleton of an NPZD model in a water column

param.v = 0.042*24;                               %m*d^-1, transform from m*h^-1
param.D = 5*3600*24*10^-4;                        %m²*d^-1, transform from cm²*s^-1
param.dz = 2;
param.H_I = 20*3600*24;                           %µmol photons*m^-2*d^-1
param.H_N = 0.0425;
param.I0 = 600*3600*12;                           %µmol photons*m^-2*d^-1, multiply with 12, assumption half a day of light.
param.kw = 0.045;                                 %m^-1
param.kp = 6*10^-12;                            %m²*cell, adapt this to get better solutions!!
param.m = 0.01*24;                                %d^-1
param.gmax = 0.04*24;                             %d^-1
param.z = 100;
param.Nb = 100;                                   %m
param.alpha = 1*10^-9;                            %mmol nutrients/cel
param.eta = 0.5;
param.n = param.z/param.dz;
n = param.n;

grid = param.dz*0.5:param.dz:2*param.z-param.dz*0.5;
grid_P = param.dz*0.5:param.dz:param.z-param.dz*0.5;
initial_Y = zeros(1,2*n);
initial_Y(1:n)=14*10^6;                                   %10³ cell/m³, initial population density at every depth.
initial_Y(end) = 100;
time = 0:1:800;

[t,y] = ode45(@odefun_ex3, time, initial_Y, [], param);   %ode45(odefun, tspan, y0, options) -> options is not filled in here, so brackets and then parameters.


P = y(:,1:n);
N = y(:,n+1:2*n);

%% Surface plots
figure()
subplot(2,1,1)
surface(t,(grid_P), (P'))
title('surfaceplot of phytoplankton (10^3 cells/m³)')
set(gca, 'YDir','reverse')
xlabel("Time (d)")
ylabel("Depth (m)")
colorbar
shading flat
subplot(2,1,2)
surface(t,grid_P, N')
title('surfaceplot of nutrients (mmol/m³)')
xlabel("Time (d)")
ylabel("Depth (m)")
set(gca, 'YDir','reverse')
colorbar
shading flat
hold off

shading flat
%Put on 'shading flat' to see the right figure! 
%% Line plots: phytoplankton
subplot(3,2,1)
plot(P(1,:),grid_P)
ylim([0 100])
xlim([1.3*10^7 1.5*10^7])
ylabel("Depth (m)")
xlabel("0 days")
set(gca, 'XAxisLocation', 'top')
set(gca, 'YDir','reverse')

subplot(3,2,2)
plot(P(21,:),grid_P)
ylim([0 100])
xlabel("20 days")
set(gca, 'XAxisLocation', 'top')
set(gca, 'YDir','reverse')


subplot(3,2,3)
plot(P(51,:),grid_P)
ylim([0 100])
ylabel("Depth (m)")
xlabel('50 days')
set(gca, 'XAxisLocation', 'top')
set(gca, 'YDir','reverse')


subplot(3,2,4)
plot(P(101,:),grid_P)
ylim([0 100])
set(gca, 'XAxisLocation', 'top')
set(gca, 'YDir','reverse')
xlabel("100 days")

subplot(3,2,5)
plot(P(401,:),grid_P)
ylim([0 100])
ylabel("Depth (m)")
set(gca, 'XAxisLocation', 'top')
set(gca, 'YDir','reverse')
xlabel("400 days")


subplot(3,2,6)
plot(P(801,:),grid_P)
ylim([0 100])
set(gca, 'XAxisLocation', 'top')
set(gca, 'YDir','reverse')
xlabel("800 days")

sgtitle("Phytoplankton density (cells/m³)")

%% Line plots: nutrients
subplot(3,2,1)
plot(N(1,:),grid_P)
ylim([0 100])
ylabel("Depth (m)")
xlabel("0 days")
set(gca, 'XAxisLocation', 'top')
set(gca, 'YDir','reverse')

subplot(3,2,2)
plot(N(21,:),grid_P)
ylim([0 100])
xlabel("20 days")
set(gca, 'XAxisLocation', 'top')
set(gca, 'YDir','reverse')


subplot(3,2,3)
plot(N(51,:),grid_P)
ylim([0 100])
ylabel("Depth (m)")
xlabel('50 days')
set(gca, 'XAxisLocation', 'top')
set(gca, 'YDir','reverse')


subplot(3,2,4)
plot(N(101,:),grid_P)
ylim([0 100])
set(gca, 'XAxisLocation', 'top')
set(gca, 'YDir','reverse')
xlabel("100 days")

subplot(3,2,5)
plot(N(401,:),grid_P)
ylim([0 100])
ylabel("Depth (m)")
set(gca, 'XAxisLocation', 'top')
set(gca, 'YDir','reverse')
xlabel("400 days")


subplot(3,2,6)
plot(N(801,:),grid_P)
ylim([0 100])
set(gca, 'XAxisLocation', 'top')
set(gca, 'YDir','reverse')
xlabel("800 days")

sgtitle("Nutrient concentration (mmol/m³)")

%% Line plots: nutrients and light

I1 = LightFunction_2(P(801,:), param);           %Use of LightFunction_2 instead of LightFunction!

I = I1./(I1 + param.H_I);
N1 = N(801,:)./(N(801,:)+param.H_N);

legend('$\frac{I}{H_I+I}$','$\frac{N}{H_N+N}$');

figure()
plot(I, grid_P')
hold on
plot(N1,grid_P', 'g')
set(gca, 'YDir','reverse')
legend('$\frac{I}{H_I+I}$','$\frac{N}{H_N+N}$','interpreter','latex','Fontsize',14);
title('Limiting factors: light and nutrients')
ylabel('depth(m)')
%%
plot(I1,grid_P)
set(gca, 'YDir','reverse')
title("Light through watercolumn at day 800")
ylabel('depth(m)')
xlabel('Light intensity (µmol photons*m^{-2}*d^{-1})')