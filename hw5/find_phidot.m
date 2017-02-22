function phidot = find_phidot(phi, params)
    V = calc_v(phi, params);
    phidot = sqrt(2. .* V);

end