%Solve differential equation
t_i =0.0;
phi_i = 1E19;
phidot_i = 0.0;
loga_ai = 0.001;
z_i = [phi_i; phidot_i; loga_ai];
t_f = 65 * 10^-16;
t_f = 2E-10
npts = 10;
tspan =[t_i t_f];
params = load_params();
params.m = 1E11
solution = ode45(@(t,z) EOM_func(t, z, params), tspan, z_i);

%Calculate reheating time and scale factor
phi = solution.y(1, :);
phidot = solution.y(2, :);
loga = solution.y(3, :);
t = solution.x;

t_reheat = 1E-11
y = deval(solution, t_reheat);
phi_reheat = y(1)
phidot_reheat = y(2)
V_reheat = calc_v(phi_reheat, params)
rho_phi_reheat = phidot_reheat^2/2 + V_reheat
rho_r0 = 1.928E-51; %GeV^4, assume g*=2
a_reheating = (rho_r0/rho_reheat)^(0.25) %assume a_0 = 1.0

%rescale a
loga_model = y(3);
a_model = 10^loga_model;
scale_a = a_reheating/a_model;
rescale_loga = log10(10 .^ loga .* scale_a);

%Create inflation part of graph
t_infla = logspace(-70, log10(t_reheat));
y_infl = deval(solution, t_infla);
phi_infl = y_infl(1,:);
phidot_infl = y_infl(2,:);
V_infl = calc_v(phi_infl, params);
rho_phi_infl = phidot_infl.^2 ./2 + V_infl;
loga_infl = y_infl(3,:);
loga_infl_rescale = log10(10 .^ loga_infl .* scale_a);
R_H_infl = 1./sqrt(8*pi*params.G_E/3 .* rho_phi_infl);

%Create Friedman part of graph
rho_m0 = 9.578E-48; %GeV^4
rho_L0 = 2.463E-47; %GeV^4
a_friedman = logspace(log10(a_reheating), log10(params.a0));
rho_friedman = rho_r0 .* (a_friedman./params.a0).^-4 %+ rho_m0 .* (a_friedman./params.a0).^-3 + rho_L0;
R_H_friedman = 1./sqrt(8*pi*params.G_E/3 .* rho_friedman);

figure()
plot(loga_infl_rescale, R_H_infl, 'bo')
hold on
plot(log10(a_friedman), R_H_friedman, 'ro')

figure()
plot(loga_infl_rescale, rho_phi_infl, 'b')
hold on
plot(log10(a_friedman), rho_friedman, 'r:')
%plot(rescale_loga, rho_phi, 'g--')




