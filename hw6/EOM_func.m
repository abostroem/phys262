function f = EOM_func(t, z, params)
    phi = z(1);
    phidot = z(2);
    loga = z(3);
    a = 10.^loga;
    V = calc_v(phi, params);
    Vprime = calc_vprime(phi, params);
    rho_phi = phidot .^ 2 ./ 2. + V;
    H = sqrt(8.*pi*params.G_E/3. .* rho_phi);
    adot = H .* a;
    phidoubledot = -(3 .* H .* phidot + Vprime);
    loga_dot = 1/(a .* log(10)).*adot;
    f = [phidot; phidoubledot; loga_dot];
end