%Plot different energy densities vs a on log-log plot

%define parameters for today
today.rho_c = 2.25E-86
today.rho_m = 6.31E-87
today.rho_L = 1.62E-86
today.rho_r = 1.27E-90

%initialize a
a = linspace(10E-6, 1, 100000);
rho_m = today.rho_m ./ a .^ 3
rho_r = today.rho_r ./ a .^ 4
rho_L = today.rho_L .* linspace(1, 1, 100000);

%Calc critical density
rho_c = rho_m + rho_r + rho_L


omega_m = rho_m ./ rho_c
omega_r = rho_r ./ rho_c
omega_L = rho_L ./ rho_c

f = figure();
semilogx(a, omega_m, 'bo');
hold on
semilogx(a, omega_r, 'mo');
semilogx(a, omega_L, 'ro');

l = legend('Matter', 'Radiation', 'Lambda');
l.Location='best';
xlim([0.0, 1])
%ylim([-0.01, 1])

title('Normalized Energy Density (\Omega) as a function of a');
xlabel('Scale Factor (a)');
ylabel('Energy Density (\Omega)');
saveas(f, 'problem2_4.pdf')
