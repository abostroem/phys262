params = load_fixed_params();
params.V_0 = 1.0E120
a_initial = 1.;
phi_initial = 33.8
phidot_initial = find_phidot(phi_initial, params);
phidot_initial
rho_m0 = find_rho_m0(a_initial, phi_initial, phidot_initial, params)
params.rho_m0 = rho_m0;

phidot_initial = 10;
input_array_start = [phi_initial; a_initial; phidot_initial];
tspan = [0 6];


[t phi solution] = find_phi(input_array_start, tspan, params);

phidot = solution.y(3, :);

t = linspace(0, 6, 10);
y = deval(solution, t);
phi = y(1, :);
phidot = y(3, :);
V = calc_v(phi, params);

energy_density = 0.5 .* phidot .^2 + V;

%From HW2 in reduced plank units
rho_0c = 3 * H_0^2