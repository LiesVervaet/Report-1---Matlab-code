%Skeleton of an NPZD model in a water column

param.v = 0.042*24;                               %m*d^-1, transform from m*h^-1
param.D = 5*3600*24*10^-4;                        %m²*d^-1, transform from cm²*s^-1
param.dz = 2;
param.H_I = 20*3600*24;                           %µmol photons*m^-2*d^-1
param.H_N = 0.0425;
param.I0 = 600*3600*12;                           %µmol photons*m^-2*d^-1, multiply with 12, assumption half a day of light.
param.kw = 0.045;                                 %m^-1
param.kp = 6*10^-12;                              %m²*cell, adapt this to get better solutions!!
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
surface(t,grid_P, (P'))
title('surfaceplot of phytoplankton (cells/m^3)')
xlabel("Time (d)")
ylabel("Depth (m)")
set(gca,'YDir','reverse')
colorbar
shading flat
subplot(2,1,2)
surface(t,grid_P, N')
title('surfaceplot of nutrients (mmol/m^3)')
xlabel("Time (d)")
ylabel("Depth (m)")
set(gca,'YDir','reverse')
colorbar
shading flat
hold off

shading flat
%Put on 'shading flat' to see the right figure! 
