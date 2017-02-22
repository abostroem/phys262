function V = calc_v(phi, params)
    V = params.V_0 .* (params.chi .* (phi - params.beta) .^ 2 + params.delta) .* exp(-params.lambda .* phi);
end
    