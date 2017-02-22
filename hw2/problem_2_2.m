%Plot different energy densities vs a on log-log plot

%define parameters for today
today.rho_c = 2.25E-86
today.rho_m = 6.31E-87
today.rho_L = 1.62E-86
today.rho_r = 1.27E-90

%initialize a
a = linspace(10E-6, 1, 1000);
rho_m = today.rho_m ./ a .^ 3
rho_r = today.rho_r ./ a .^ 4
rho_L = today.rho_L .* linspace(1, 1, 1000);

f = figure()
loglog(a, rho_m, 'b')
hold on
loglog(a, rho_r, 'g')
loglog(a, rho_L, 'r')


a_eq = 2.01E-4
a_L = 0.73
y = gca
plot([a_eq, a_eq], y.YLim, 'c--')
plot([a_L, a_L,], y.YLim, 'm--')
l = legend('Matter', 'Radiation', 'Lambda', 'a_{eq}', 'a_L')
l.Location='north'

title('Energy Density as a function of a')
xlabel('Scale Factor (a)')
ylabel('Energy Density (J^4)')
saveas(f, 'problem2_2.pdf')
