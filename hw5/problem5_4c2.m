params = load_fixed_params();
a_initial = 1.;
phi_initial = 34.0 - 1E-30
phidot_initial = find_phidot(phi_initial, params);
phidot_initial
rho_m0 = find_rho_m0(a_initial, phi_initial, phidot_initial, params)
params.rho_m0 = rho_m0;

phidot_initial = 1E-30;
input_array_start = [phi_initial; a_initial; phidot_initial];
%tspan = logspace(-100, 1);
tspan = [0 2000000];


[t phi solution] = find_phi(input_array_start, tspan, params);

phidot = solution.y(3, :);

t = linspace(tspan(1), tspan(2), 10000);
y = deval(solution, t);
phi = y(1, :);
phidot = y(3, :);
V = calc_v(phi, params);

energy_density = 0.5 .* phidot .^2 + V;
pressure = 0.5 .* phidot .^2 - V;
eqn_of_state = pressure ./ energy_density;

f=figure();
plot(t, -1.*ones(1,length(t)), 'k:');
hold on
plot(t, eqn_of_state);
title('Equation of State');
ylim([-1.1, 1.1]);
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