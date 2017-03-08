%Solve differential equation
t_i =0.0;
phi_i = 1E20;
phidot_i = 0.0;
loga_ai = 0.0001;
z_i = [phi_i; phidot_i; loga_ai];

t_f = 2E-10;
tspan =[t_i t_f];
params = load_params();
params.m = 3E11;
solution = ode45(@(t,z) EOM_func(t, z, params), tspan, z_i);

%Calculate reheating time and scale factor
phi = solution.y(1, :);
phidot = solution.y(2, :);
loga = solution.y(3, :);
t = solution.x;

t_reheat = 1.3E-10;
y = deval(solution, t_reheat);
phi_reheat = y(1);
phidot_reheat = y(2);
loga_reheat_infl = y(3);
a_reheat_infl = 10^loga_reheat_infl;
V_reheat = calc_v(phi_reheat, params);
rho_reheat = phidot_reheat^2/2 + V_reheat;
rho_rel0 = 1.928E-51; %GeV^4, assume g*=2

%Create inflation part of graph
t_infl = logspace(-70, log10(t_reheat), 1000);
y_infl = deval(solution, t_infl);
phi_infl = y_infl(1,:);
phidot_infl = y_infl(2,:);
loga_infl = y_infl(3,:);
V_infl = calc_v(phi_infl, params);
rho_phi_infl = phidot_infl.^2 ./2 + V_infl;
R_H_infl = 1./sqrt(8*pi*params.G_E/3 .* rho_phi_infl);

a_reheat_friedman = params.a0*(rho_reheat/rho_rel0)^(-0.25); %assume a_0 = 1.0
rho_rel_reheat = rho_phi_infl(length(rho_phi_infl));


%Create Friedman part of graph
rho_m0 = 9.578E-48; %GeV^4
rho_L0 = 2.463E-47; %GeV^4
a_friedman = logspace(log10(a_reheat_friedman),30);
rho_friedman = rho_rel_reheat .* (a_friedman./a_reheat_friedman).^-4 + rho_m0 .* (a_friedman./params.a0).^-3 + rho_L0;
R_H_friedman = 1./sqrt(8*pi*params.G_E/3 .* rho_friedman);

d0_E = [1.563E38,   1.563E40,  1.5637E41]; %1 / GeV; 1, 100, 1000 Mpc
d_comoving = d0_E/1.0; %assume a0 = 1
d_reheating = d_comoving*a_reheat_friedman; %1/GeV

a_infl_rescale = 10 .^ loga_infl * a_reheat_friedman/a_reheat_infl;

all_a = [a_infl_rescale, a_friedman];
fit1 = polyfit([params.a0, a_reheat_friedman],[d_comoving(1), d_reheating(1)], 1);
yfit1 = polyval(fit1, all_a);
fit2 = polyfit([params.a0, a_reheat_friedman],[d_comoving(2), d_reheating(2)], 1);
yfit2 = polyval(fit2, all_a);
fit3 = polyfit([params.a0, a_reheat_friedman],[d_comoving(3), d_reheating(3)], 1);
yfit3 = polyval(fit3, all_a);


figure();
loglog(a_infl_rescale, R_H_infl, 'r');
hold on
loglog(a_friedman, R_H_friedman, 'm');
loglog(all_a, yfit1, 'b');
loglog(all_a, yfit2, 'g');
loglog(all_a, yfit3, 'c');
ylim([10E-20, 10E45]);
xlim([10E-60, 5]);
l = legend('Inflation', 'Friedman', '1Mpc', '10Mpc', '1000Mpc');
l.Location='Best';
xlabel('Scale Factor (a)')
ylabel('R_H')
% figure();
% loglog(a_infl_rescale, rho_phi_infl, 'b');
% hold on
% loglog(a_friedman, rho_friedman, 'r:');




