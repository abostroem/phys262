a_initial = 1.;
phi_initial = 2.0;
phidot_in = 0.22;
tspan = logspace(-10, 3, 100);
a0 = 'default';
rho_m0_in = 'default';
npts_return = 100;

[t phi phidot V a] = evolve_phi(a_initial, phi_initial, phidot_in, a0, rho_m0_in, tspan, npts_return);

phi_5_3a = 2./params.lambda * log(params.lambda/2 * (2.*sqrt(params.V_0)*t));
f=figure();
plot(t, phi, 'b');
hold on
plot(t, phi_5_3a+2.3, 'r--');
l = legend('Numerical phi (5.4b)', 'Analytic phi (5.3a)');
l.Location='Best';
title(strcat('\phi for \phi << \beta ;  \phi_{start}=', num2str(phi_initial), ';  \phidot_{start} = ', num2str(phidot_in)));
xlabel('Time');
ylabel('\phi');
saveas(f, 'comp_numerical_analytical.pdf');