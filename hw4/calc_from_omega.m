function today = calc_from_omega(omega_m0, omega_L0)
    %define parameters for today
    constants = load_constants();
    %fixed
    today.rho_c100 =5.33E-86;
    today.a = 1.;
    today.H = 2.22E-52; %J, 65 km/s/Mpc
    today.T = 3.13E-23; %J, 2.73K
    today.rho_r = 4.60E-90; %including nuetrinos
    
    %calculate based on inputs
    today.rho_m = omega_m0*today.rho_c100;
    today.rho_L = omega_L0*today.rho_c100;
    
    today.rho_k = ((today.H^2*3.)/(8. * pi * constants.G)) - today.rho_m-today.rho_L-today.rho_r;
    
    
