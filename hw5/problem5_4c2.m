params = load_fixed_params();
a_initial = 1.;
phi_initial = 33.95;
phidot_in = 1E-61;
rho_m0_in = find_rho_m0(a_initial, phi_initial, phidot_in, params);
a0 = 'default';
tspan = logspace(57,60.3,1000000);
npts_return = 10;

[t phi phidot V a params] = evolve_phi(a_initial, phi_initial, phidot_in, a0, rho_m0_in, tspan, npts_return);

energy_density = 0.5 .* phidot.^2 + V;
pressure = 0.5 .* phidot.^2 - V;
eqn_of_state = pressure ./ energy_density;

sprintf('initial phidot squared = %e',phidot(1)^2)
sprintf('initial V = %e',V(1))
f=figure();
plot(t, -1.*ones(1,length(t)), 'k:');
hold on
plot(t, eqn_of_state);
title('Equation of State');
ylim([-1.1, 0]);
xlabel('time');
ylabel('w_{\phi}');
saveas(f, 'eqn_of_state.pdf');

f2 = figure();
plot(t, phi);
title('\phi');
xlabel('time');
ylabel('\phi');
saveas(f2, 'phi.pdf');

f3 = figure();
plot(phi, V);
title('Potential');
xlabel('\phi');
ylabel('V');
saveas(f3, 'potential_vs_phi.pdf');