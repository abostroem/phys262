function chi = calculate_chi(a)
    %calculate chi for luminosity distance at a
    today = load_today();
    constants = load_constants();
    rho = calc_energy_density(a);
    
    H = sqrt(8.*pi*constants.G/3. .* (rho.m+rho.r+rho.L - rho.k));
    norm_H = H ./ today.H;
    chi = linspace(-999, -999, length(a))
    for n=1:length(a)
        chi(n) = quad(@(int_a) chi_integrand(int_a,norm_H(n)),a(n),today.a);
    end
    chi = chi ./ today.H;