t_i = 0.0;
phi_i = 10E19;
phidot_i = 0.0;
loga_ai = 0.0001;
z_i = [phi_i; phidot_i; loga_ai];
t_f = 65 * 10^-16;
npts = 10;
tspan =[t_i t_f];
params = load_params();

solution = ode45(@(t,z) EOM_func(t, z, params), tspan, z_i);

phi = solution.y(1, :);
phidot = solution.y(2, :);
loga = solution.y(3, :);
t = solution.x;

V = calc_v(phi, params);
rho_phi = phidot.^2./2. + V;
pressure_phi = phidot.^2./2 - V;
w = pressure_phi ./ rho_phi;
Vprime = calc_vprime(phi, params);
H = sqrt((8 * pi * params.G_E)/3 .* rho_phi);

'\delta_{H} = '
indx = find(t < 10^-30)
H(indx(length(indx)))
'at t = '
t(indx(length(indx)))
'w = '
w(indx(length(indx)))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot phi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f1 = figure();
plot(t, phi);
title('Scalar Field');
ylabel('\phi');
xlabel('time');
saveas(f1, 'phi_prob3.pdf');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot loga
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f2 = figure();
plot(t, loga);
title('Scale Factor');
ylabel('log(a)');
xlabel('time');
saveas(f2, 'loga_prob3.pdf');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot w
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f3 = figure();
plot(t, w);
title('Equation of State');
ylabel('w');
xlabel('time');
%xlim([0, 3E-15])
saveas(f3, 'w_prob3.pdf');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot density Funcuations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f4 = figure();
semilogx(t, H .* Vprime ./ (2*pi .* phidot.^2));
title('Density Flucuations');
ylabel('\delta \rho \\ \rho');
xlabel('time');
xlim([0, 3E-15])
saveas(f4, 'density_fluxuations_prob3.pdf');
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot rho_phi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f5 = figure();
loglog(t, rho_phi*1.602E-10); %plot in joules not GeV
title('phi energy density');
ylabel('\rho_{\phi}');
xlabel('time');
saveas(f5, 'energy_density_prob3.pdf');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot V
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f6 = figure();
subplot(2,1,1)
plot(phi, V);
title('Potential');
xlabel('\phi');
ylabel('V');
subplot(2,1,2);
plot(phi, t);
title('Time')
xlabel('\phi')
ylabel('time')
saveas(f6, 'potential_prob3.pdf')

