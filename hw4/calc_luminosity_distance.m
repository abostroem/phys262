function luminosity_distance = calc_luminosity_distance(z, k, today)
    a = 1./(1.+z);
    chi = calculate_chi(a, today);
    %Calculate the luminosity distance based on a and k in energy units
    if k < 0 
        luminosity_distance= 1./sqrt(abs(k)) * sinh(sqrt(abs(k)) * chi);
    elseif k == 0
        luminosity_distance = chi;
    else
        luminosity_distance = 1./sqrt(abs(k)) * sin(sqrt(abs(k)) * chi);
    end
    
