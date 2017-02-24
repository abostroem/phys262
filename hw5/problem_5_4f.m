params = load_fixed_params();
a_initial = 1.;
phi_initial = 33.95;
phidot_in = 1E-61;
rho_m0_in = find_rho_m0(a_initial, phi_initial, phidot_in, params)
a0 = 'default';
tspan = logspace(57,60.3,100000);
npts_return = 10;

[t phi phidot V a] = evolve_phi(a_initial, phi_initial, phidot_in, a0, rho_m0_in, tspan, npts_return);

f = figure()
subplot(2,1,1)
plot(phi, t)
ylabel('Time')
xlabel('\phi')
title('Scalar Field \phi')

subplot(2,1,2)
plot(phi,V)
xlabel('\phi')
ylabel('V')
title('Potential')

saveas(f, 'field_potential_evolution.pdf')