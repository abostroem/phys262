function chi = calculate_chi(a, today)
    %calculate chi for luminosity distance at a  

    chi = zeros(1, length(a));
    for n=1:length(a)
        chi(n) = quad(@(int_a) chi_integrand(int_a,today),a(n),today.a);
    end
    chi = chi ./ today.H;
