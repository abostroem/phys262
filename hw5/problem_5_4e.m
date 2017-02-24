params = load_fixed_params();
a_initial = 1.;
phi_initial = 33.95;
phidot_in = 1E-61;
rho_m0_in = find_rho_m0(a_initial, phi_initial, phidot_in, params)
a0 = 'default';
tspan = logspace(57,60.3,100000);
npts_return = 10;
params.rho_m0 = rho_m0_in

[t phi phidot V a params] = evolve_phi(a_initial, phi_initial, phidot_in, a0, rho_m0_in, tspan, npts_return);
rho_phi = 0.5 .* phidot.^2 + V;
rho_m = params.rho_m0 .* (a./params.a0).^-3;
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
params = load_fixed_params();
a_initial = 1.;
phi_initial =params.beta *10^-3;
phidot_in = 'default';

tspan = logspace(1, 60.3, 10000);
a0 = 'default';
rho_m0_in = 'default';
npts_return = 100;

[t phi phidot V a params] = evolve_phi(a_initial, phi_initial, phidot_in, a0, rho_m0_in, tspan, npts_return);

rho_phi = 0.5 .* phidot.^2 + V;
rho_m = params.rho_m0 .* (a./params.a0).^-3;
rho_c = rho_phi + rho_m;

f2 = figure();
semilogx(t, rho_phi./rho_c);
hold on
semilogx(t, rho_m./rho_c);
xlabel('Time');
ylabel('Energy Density');
title('Normalized Energy Density \Omega for \phi near 2');
l=legend('\Omega_{\phi}', '\Omega_{matter}');
l.Location='Best';
ylim([-0.1, 1.1]);
xlim([10^57, 10^60.3])
saveas(f2, 'norm_energy_density_2.pdf');

