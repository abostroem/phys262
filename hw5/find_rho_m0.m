function rho_m0 = find_rho_m0(a, phi, phidot, params)
    V = calc_v(phi, params);
    B = params.lambda.^2./3. - 1;
    rho_phi = (0.5 .* phidot.^2 + V);
    rho_m = B .* rho_phi; %use scaling relation
    rho_m0 = rho_m .* (a./params.a0).^3;
end