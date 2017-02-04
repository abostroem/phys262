function chisq = calc_chisq(muoff, data, today)
    lum_dist = calc_luminosity_distance(data.z, 0, today);
    lum_dist_mpc = convert_lum_dist_to_mpc(lum_dist);
    dist_mod_model = calc_dist_mod(lum_dist_mpc);
    chisq = sum(((data.mu - dist_mod_model + muoff) ./ data.sigma) .^2);