params = load_fixed_params();
a_initial = 1.;
phi_initial = 2.0;
phidot_initial = find_phidot(phi_initial, params);
phidot_initial

rho_m0 = find_rho_m0(a_initial, phi_initial, phidot_initial, params)
params.rho_m0 = rho_m0;

phidot_initial = 0.22;
input_array_start = [phi_initial; a_initial; phidot_initial];
tspan = logspace(-10, 3, 100);


[t phi solution] = find_phi(input_array_start, tspan, params);

phi_5_3a = 2./params.lambda * log(params.lambda/2 * (2.*sqrt(params.V_0)*t));
f=figure()
plot(t, phi, 'b')
hold on
plot(t, phi_5_3a+2.3, 'r--')
l = legend('Numerical phi (5.4b)', 'Analytic phi (5.3a)');
l.Location='Best';
title(strcat('\phi for \phi << \beta ;  \phi_{start}=', num2str(phi_initial), ';  \phidot_{start} = ', num2str(phidot_initial)));
xlabel('Time');
ylabel('\phi');
saveas(f, 'comp_numerical_analytical.pdf');