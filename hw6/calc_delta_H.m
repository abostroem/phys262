function delta_H = calc_delta_H(y, params)
    phi = y(1, :);
    phidot = y(2, :);
    V = calc_v(phi, params);
    rho_phi = phidot.^2./2. + V;
    Vprime = calc_vprime(phi, params);
    H = sqrt((8 * pi * params.G_E)/3 .* rho_phi);
    delta_H =  H .* Vprime ./ (2*pi .* phidot.^2);

end