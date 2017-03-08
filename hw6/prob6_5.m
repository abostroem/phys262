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
t_reheat = 1.3E-10;
%part ii
y = deval(solution, t_reheat);
phi_reheat = y(1);
phidot_reheat = y(2);
loga_reheat_infl = y(3);
a_reheat_infl = 10^loga_reheat_infl;
V_reheat = calc_v(phi_reheat, params);
rho_reheat = phidot_reheat^2/2 + V_reheat;
%part iii
rho_rel0 = 1.928E-51; %GeV^4, assume g*=2
a_reheat_friedman = params.a0*(rho_reheat/rho_rel0)^(-0.25); %assume a_0 = 1.0
%part iv
T = (params.a0/a_reheat_friedman)*params.T0_E;  %assume a_0 = 1.0
%part v
d0_E = [1.563E38,   1.563E40,  1.5637E41]; %1 / GeV; 1, 100, 1000 Mpc
d_comoving = d0_E/1.0; %assume a0 = 1
d_reheating = d_comoving*a_reheat_friedman; %1/GeV

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot w
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f3 = figure();
semilogx(t, w);
title('Equation of State');
ylabel('w');
xlabel('time');
xlim([1E-11, 3E-10])
hold on;
plot([t_reheat, t_reheat], get(gca, 'ylim'), 'r');
l = legend('w', 't_{reheating}');
l.Location='Best';
saveas(f3, 'w_prob5.pdf');




