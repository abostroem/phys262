function rho = calc_energy_density(a)
    %calculate the energy density rho for parameters
    today = load_today();
    rho.m = today.rho_m ./ a .^ 3 ;
    rho.r = today.rho_r ./ a .^ 4 ;
    rho.L = today.rho_L* linspace(1,1, length(a));
    rho.k = today.rho_k ./ a .^2;
