%Sensitivity analysis

mortality_vector= [0.24 0.5 0.7 1];
figure()
legende = strings(length(mortality_vector),1);
colors = [0,0,1;0,0.4470,0.7410;0.3010,0.7450,0.9330;0,1,1];
for i = 1:length(mortality_vector)
    m = mortality_vector(i);
    AdvectionDiffusion_sensitivity_m;
    subplot(2,1,1)
    plot(P(801,:),grid_P, col=colors(i,:))
    title('Sensitivity analysis of mortality at day 800')
    xlabel('Phytoplankton concentration (cells/m³)')
    ylabel('Depth watercolumn (m)')
    set(gca,'YDir','reverse')
    legende(i) = (strcat('m =', num2str(mortality_vector(i)),'d^{-1}'))
    hold on

    subplot(2,1,2)
    plot(N(801,:),grid_P,col=colors(i,:))
    title('Sensitivity analysis of mortality at day 800')
    xlabel('Nutrient concentration (mmol/m³)')
    ylabel('Depth watercolumn (m)')
    set(gca,'YDir','reverse')
    legende(i) = (strcat('m =', num2str(mortality_vector(i)),'d^{-1}'))
    hold on
end
legend(legende)