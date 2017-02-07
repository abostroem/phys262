function k = calc_k(a, today)
    %calculate k from curvature 
    rho = calc_energy_density(a, today);
    constants = load_constants();
    Hsq =  rho.m + rho.r + rho.L + rho.k;
    rho_c = 3./ ( 8 * pi * constants.G) .* Hsq;
    k = today.H^2 .* rho.k ./ rho_c;