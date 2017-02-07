function luminosity_distance = calc_luminosity_distance(z, today)
    a = 1./(1.+z);
    chi = calculate_chi(a, today);
    k = calc_k(a, today);
    luminosity_distance = zeros(1, length(k));
    if all(k>0)
        %'all +'
        luminosity_distance = 1./sqrt(abs(k)) .* sin(sqrt(abs(k)) .* chi);
    elseif all(k == 0)
        %'all 0'
        luminosity_distance = chi;
    elseif all(k<0)
        %'all -'
        luminosity_distance= 1./sqrt(abs(k)) .* sinh(sqrt(abs(k)) .* chi);
    
    else
        %'mixed'
        for k_indx = 1:length(k)
            %Calculate the luminosity distance based on a and k in energy units
            if k(k_indx) < 0 
                luminosity_distance(k_indx)= 1./sqrt(abs(k(k_indx))) * sinh(sqrt(abs(k(k_indx))) * chi(k_indx));
            elseif k(k_indx) == 0
                  luminosity_distance(k_indx) = chi(k_indx);
            else
                luminosity_distance(k_indx) = 1./sqrt(abs(k(k_indx))) * sin(sqrt(abs(k(k_indx))) * chi(k_indx));
            end
        end
    end
    
    luminosity_distance = 1 ./ a .* luminosity_distance;
    
