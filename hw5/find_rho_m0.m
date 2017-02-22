function rho_m0 = find_rho_m0(a, phi, phidot, params)
    V = calc_v(phi, params);
    A = params.lambda.^2./3. - 1.;
    rho_m = A .* (phidot.^2/2. + V);
    rho_m0 = rho_m .* (a./params.a0).^3;
end