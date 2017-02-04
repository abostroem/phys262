load RiessGold
lum_dist = calc_luminosity_distance(RiessGold.z, 0);
lum_dist_mpc = convert_lum_dist_to_mpc(lum_dist);
dist_mod = calc_dist_mod(lum_dist_mpc)