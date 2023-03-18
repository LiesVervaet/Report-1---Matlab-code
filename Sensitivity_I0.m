%Sensitivity analysis

surface_light= [26*10^6 50*10^6 75*10^6 100*10^6];
figure()
legende = strings(length(surface_light),1);
colors = [0,0,1;0,0.4470,0.7410;0.3010,0.7450,0.9330;0,1,1];
for i = 1:length(surface_light)
    I0 = surface_light(i);
    AdvectionDiffusion_sensitivity_I0;
    subplot(2,1,1)
    plot(P(801,:),grid_P, col=colors(i,:))
    title('Sensitivity analysis of surface light at day 800')
    xlabel('Phytoplankton concentration (cells/m³)')
    ylabel('Depth watercolumn (m)')
    set(gca,'YDir','reverse')
    legende(i) = (strcat('I0 =', num2str(surface_light(i)),' µmol photons/m²d'))
    hold on

    subplot(2,1,2)
    plot(N(801,:),grid_P,col=colors(i,:))
    xlabel('Nutrient concentration (mmol/m³)')
    ylabel('Depth watercolumn (m)')
    set(gca,'YDir','reverse')
    legende(i) = (strcat('I0 =', num2str(surface_light(i)), ' µmol photons/m²d'))
    hold on
end
legend(legende)