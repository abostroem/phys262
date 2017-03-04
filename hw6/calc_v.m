function V = calc_v(phi, params)
    V = (params.m^2 .* phi .^2) ./ 2.;
end