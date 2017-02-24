params = load_fixed_params();
a_initial = 1.;
phi_initial = 33.95;
phidot_in = 1E-61;
rho_m0_in = find_rho_m0(a_initial, phi_initial, phidot_in, params)
a0 = 'default';
tspan = logspace(57,60.3,100);
npts_return = 10;

[t phi phidot V a params] = evolve_phi(a_initial, phi_initial, phidot_in, a0, rho_m0_in, tspan, npts_return);

energy_density = 0.5 .* phidot .^2 + V;

%From HW2 in reduced plank units
H_0 = 2.22E-52;
rho_0c = 3 * H_0^2; %8piG = 1 in problem 5 units
energy_density_hw2 = 0.72 * rho_0c;

sprintf('dark energy density = %e from this code, = %e from HW2', energy_density(5), energy_density_hw2) 