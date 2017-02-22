function [phidot, rho_m0] = find_initial_parameters(a, phi, params)
    V = calc_v(phi, params);
    phidot = sqrt(2. * V);

end