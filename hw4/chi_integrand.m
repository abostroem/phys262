function deta = chi_integrand(a, norm_H)
    %function representing the integrand of the luminosity distance chi
    deta = 1. ./ (a .^ 2 .* norm_H);