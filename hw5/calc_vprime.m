function vprime = calc_vprime(phi, params)
    vprime = params.V_0 .* exp(-params.lambda .* phi) .* ((2.*params.chi .* (phi-params.beta))...
             - params.lambda .* (params.chi .* (phi-params.beta).^ 2 + params.delta));
end