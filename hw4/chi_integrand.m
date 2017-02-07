function deta = chi_integrand(a, today)
    %function representing the integrand of the luminosity distance chi
    constants = load_constants();
    rho = calc_energy_density(a, today);
    
    H = sqrt(8.*pi*constants.G/3. .* (rho.m+rho.r+rho.L+rho.k));
    deta = 1. ./ (a .^ 2 .* (H/today.H));
