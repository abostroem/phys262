function dist_mod = calc_dist_mod(lum_dist_mpc)
    %calculate the distance modulus from the luminosity distance
    dist_mod = 5. .* log10(lum_dist_mpc) + 25.