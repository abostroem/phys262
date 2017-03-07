t_i =0.0;
phi_i = 1E19;
phidot_i = 0.0;
loga_ai = 0.0001;
z_i = [phi_i; phidot_i; loga_ai];
t_f = 65 * 10^-16;
t_f = 2E-10
npts = 10;
tspan =[t_i t_f];
params = load_params();
params.m = 1E11
solution = ode45(@(t,z) EOM_func(t, z, params), tspan, z_i);

phi = solution.y(1, :);
phidot = solution.y(2, :);
loga = solution.y(3, :);
t = solution.x;

V = calc_v(phi, params);
rho_phi = phidot.^2./2. + V;
pressure_phi = phidot.^2./2 - V;
w = pressure_phi ./ rho_phi;
delta_H = calc_delta_H(solution.y, params);

%part i
t_reheat = 1E-11
%part ii
y = deval(solution, t_reheat);
rho_phi_reheat = y(1)
%part iii
rho_r0 = 1.928E-51; %GeV^4, assume g*=2
a_reheating = (rho_r0/rho_reheat)^(0.25) %assume a_0 = 1.0
%part iv
T = (1.0/a_reheating)*params.T0_E  %assume a_0 = 1.0
%part v
d0_E = [1.563E38,   1.563E40,  1.5637E41]; %1 / GeV; 1, 100, 1000 Mpc
d_comoving = d0_E/1.0; %assume a0 = 1
d_reheating = d_comoving*a_reheating %1/GeV

%rescale a
loga_model = y(3);
a_model = 10^loga_model;
scale_a = a_reheating/a_model;
rescale_loga = log10(10 .^ loga .* scale_a);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot w
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f3 = figure();
semilogx(t, w);
title('Equation of State');
ylabel('w');
xlabel('time');
xlim([1E-14, 5E-11])
hold on;
plot([t_reheat, t_reheat], get(gca, 'ylim'), 'r');
l = legend('w', 't_{reheating}');
l.Location='Best';
saveas(f3, 'w_prob5.pdf');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot loga
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f2 = figure();
semilogy(t, 10.^rescale_loga);
hold on;
plot(get(gca, 'xlim'), [a_reheating, a_reheating], 'r');
title('Scale Factor');
ylabel('log(a)');
xlabel('time');
l =legend('a', 'a_{reheating}')
l.Location='Best'
saveas(f2, 'loga_prob5.pdf');



