a_initial = 1.;
phi_initial = 33.9999;
phidot_in = 'default';
rho_m0_in = 'default';
a0 = 'default';
tspan = [0 100];
npts_return = 10;

[t phi phidot V a] = evolve_phi(a_initial, phi_initial, phidot_in, a0, rho_m0_in, tspan, npts_return);
rho_phi = 0.5 .* phidot.^2 + V;
rho_m = params.rho_m0 .* (a./params.a0).^3;
rho_c = rho_phi + rho_m;

f = figure();
semilogx(t, rho_phi./rho_c);
hold on
semilogx(t, rho_m./rho_c);
xlabel('Time');
ylabel('Energy Density');
title('Normalized Energy Density \Omega for \phi near 34');
l=legend('\Omega_{\phi}', '\Omega_{matter}');
l.Location='Best';
ylim([-0.1, 1.1]);
saveas(f, 'norm_energy_density_34.pdf');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
a_initial = 1.;
phi_initial = 2.0;
phidot_in = 0.22;
tspan = logspace(-10, 4, 100);
a0 = 'default';
rho_m0_in = 'default';
npts_return = 100;

[t phi phidot V a] = evolve_phi(a_initial, phi_initial, phidot_in, a0, rho_m0_in, tspan, npts_return);

rho_phi = 0.5 .* phidot.^2 + V;
rho_m = params.rho_m0 .* (a./params.a0).^3;
rho_c = rho_phi + rho_m;

f2 = figure();
semilogx(t, rho_phi./rho_c);
hold on
semilogx(t, rho_m./rho_c);
xlabel('Time');
ylabel('Energy Density');
title('Normalized Energy Density \Omega for \phi near 2');
l=legend('\Omega_{\phi}', '\Omega_{matter}');
l.Location='Best'
ylim([-0.1, 1.1]);
saveas(f2, 'norm_energy_density_2.pdf');

