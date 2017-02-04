function lum_dist_mpc = convert_lum_dist_to_mpc(lum_dist)
    %converts luminosity distance from energy units to Mpc
    constants = load_constants();
    lum_dist_mpc = lum_dist .* constants.c .* constants.hbar ./ 3.086E22;