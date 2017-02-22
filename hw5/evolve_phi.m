function [t phi phidot V a] = evolve_phi(a_initial, phi_initial, phidot_in, a0, rho_m0_in, tspan, npts_return)

    params = load_fixed_params();
    phidot_initial = find_phidot(phi_initial, params);
    sprintf('calculated phidot_initial=%e',phidot_initial)
    rho_m0 = find_rho_m0(a_initial, phi_initial, phidot_initial, params);
    sprintf('calculated rho_m0 =  %e', rho_m0)
    params.rho_m0 = rho_m0;

    if phidot_in ~= 'default';
        phidot_initial = phidot_in;
        disp('Setting default phidot')
    end;
    if rho_m0_in ~= 'default';
        params.rho_m0 = rho_m0_in;
    end
    if a0 ~= 'default';
        params.a0 = a0;
    end
    
    input_array_start = [phi_initial; a_initial; phidot_initial];
    
    [t phi solution] = find_phi(input_array_start, tspan, params);

    phidot = solution.y(3, :);

    if length(tspan) > 2
        t = tspan;
    else
        t = linspace(tspan(1), tspan(2), npts_return);
    end
    y = deval(solution, t);
    phi = y(1, :);
    a = y(2, :);
    phidot = y(3, :);
    V = calc_v(phi, params);
