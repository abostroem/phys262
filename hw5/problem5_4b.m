params = load_fixed_params();
a_initial = 1.;
phi_initial =params.beta *10^-3;
phidot_in = 'default';

tspan = logspace(-10, 3, 100000);
a0 = 'default';
rho_m0_in = 'default';
npts_return = 100;

V0_5_3 = params.beta^2
[t phi phidot V a params] = evolve_phi(a_initial, phi_initial, phidot_in, a0, rho_m0_in, tspan, npts_return);

phi_5_3a = 2./params.lambda * log(params.lambda/2 * (sqrt(2. .* V0_5_3).*t) +  exp(params.lambda * phi_initial./2.));
f=figure();
plot(t, phi, 'b');
hold on
plot(t, phi_5_3a, 'r--');
l = legend('Numerical phi (5.4b)', 'Analytic phi (5.3a)');
l.Location='Best';
title(strcat('\phi for \phi << \beta ;  \phi_{start}=', num2str(phi_initial), ';  \phidot_{start} = ', num2str(phidot_in)));
xlabel('Time');
ylabel('\phi');
saveas(f, 'comp_numerical_analytical.pdf');