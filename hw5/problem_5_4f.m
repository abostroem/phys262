a_initial = 1.;
phi_initial = 33.9999;
phidot_in = 'default';
rho_m0_in = 'default';
a0 = 'default';
tspan = [0 100];
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