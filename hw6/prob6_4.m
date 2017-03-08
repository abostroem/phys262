t_i = 0.0;
phi_i =1E20;
phidot_i = 0.0;
loga_ai = 0.0001;
z_i = [phi_i; phidot_i; loga_ai];
t_f = 2.2E-10
npts = 10;
tspan =[t_i t_f];
params = load_params();
params.m = 3E11
solution = ode45(@(t,z) EOM_func(t, z, params), tspan, z_i);

phi = solution.y(1, :);
phidot = solution.y(2, :);
loga = solution.y(3, :);
t = solution.x;

V = calc_v(phi, params);
rho_phi = phidot.^2./2. + V;
pressure_phi = phidot.^2./2 - V;
w = pressure_phi ./ rho_phi;
delta_H = calc_delta_H(solution.y, params);

indx = find(delta_H < 10^-5);
if length(indx) > 0
    new_t = linspace(t(indx(1)-1), t(indx(1)), 100);
    new_y = deval(solution, new_t);

    new_phi = new_y(1, :);
    new_phidot = new_y(2, :);
    new_loga = new_y(3, :);

    new_V = calc_v(new_phi, params);
    new_rho_phi = new_phidot.^2./2. + new_V;
    new_pressure_phi = new_phidot.^2./2 - new_V;
    new_w = new_pressure_phi ./ new_rho_phi;

    new_delta_H = calc_delta_H(new_y, params);



    large_indx = find(new_delta_H < 10^-5);
    final_indx = large_indx(1);

    if final_indx > 2
        X = sprintf('t = %e, w = %f, delta_H = %e', new_t(final_indx-1), new_w(final_indx-1), new_delta_H(final_indx-1));
    else
        X = sprintf('t = %e, w = %f, delta_H = %e', new_t(1), new_w(1), new_delta_H(1))
    end
    disp(X)
else
    X = sprintf('delta_H is never less than 10^-5. The smallest value of delta_H is %e', delta_H(length(delta_H)))
    disp(X)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot phi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f1 = figure();
plot(t, phi);
title('Scalar Field');
ylabel('\phi');
xlabel('time');
saveas(f1, 'phi_prob4.pdf');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot loga
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f2 = figure();
plot(t, loga);
title('Scale Factor');
ylabel('log(a)');
xlabel('time');
saveas(f2, 'loga_prob4.pdf');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot w
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f3 = figure();
plot(t, w);
if length(indx) > 0 
    hold on;
    plot([new_t(final_indx-2), new_t(final_indx-2)], get(gca, 'ylim'), 'r');
end
title('Equation of State');
ylabel('w');
xlabel('time');
%xlim([0, 3E-15])
saveas(f3, 'w_prob4.pdf');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot density Funcuations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f4 = figure();
semilogx(t, delta_H);
title('Density Flucuations');
ylabel('\delta \rho \\ \rho');
xlabel('time');
%xlim([10^-20, 3E-15])
saveas(f4, 'density_fluxuations_prob4.pdf');
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot rho_phi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f5 = figure();
loglog(t, rho_phi*1.602E-10); %plot in joules not GeV
title('phi energy density');
ylabel('\rho_{\phi}');
xlabel('time');
saveas(f5, 'energy_density_prob4.pdf');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot V
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f6 = figure();
subplot(2,1,1)
plot(phi, V);
title('Potential');
xlabel('\phi');
ylabel('V');
subplot(2,1,2);
plot(phi, t);
title('Time')
xlabel('\phi')
ylabel('time')
saveas(f6, 'potential_prob4.pdf')

% if length(indx) > 0
%     f7 = figure();
%     subplot(3,1,1);
%     semilogx(t, w);
%     hold on;
%     plot([new_t(final_indx-1), new_t(final_indx-1)], get(gca, 'ylim'), 'r');
%     xlim([10^-20, t(length(t))]);
%     xlabel('time');
%     ylabel('w');
%     subplot(3,1,2);
%     semilogx(t, delta_H);
%     hold on;
%     plot([new_t(final_indx-1), new_t(final_indx-1)],get(gca, 'ylim'), 'r');
%     xlim([10^-20, t(length(t))]);
%     xlabel('time');
%     ylabel('\delta_{H}');
%     subplot(3,1,3);
%     semilogx(new_t, new_delta_H);
%     hold on;
%     xlim([new_t(1), new_t(length(new_t))]);
%     plot([new_t(final_indx-1), new_t(final_indx-1)], get(gca, 'ylim'), 'r');
%     plot(get(gca, 'xlim'), [10^-5, 10^-5], 'c--');
%     xlabel('time');
%     ylabel('\delta_{H}');
%     legend('\delta_H', 'measure \delta_H', '10^{-5}')
%     saveas(f7, 'delta_H_realistic_time.pdf')
% end