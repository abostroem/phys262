function EOM_pieces = EOM_def(t,input_array, params) 
    %input: [phi, a, phidot]
    %output: [phidot, adot, phidoubledot]

    phi = input_array(1);
    a = input_array(2);
    phidot = input_array(3);
    
    V = calc_v(phi, params);
    Vprime = calc_vprime(phi, params);
    
    H = sqrt(1./3. .* (params.rho_m0 .*(a/params.a0).^(-3) + 0.5 .* phidot.^2 + V));
    
    phidoubledot = -3. .* H .* phidot + Vprime;
    
    EOM_pieces = [phidot; H.*a; phidoubledot]; %For some reason we want this to be a column vector
    
end