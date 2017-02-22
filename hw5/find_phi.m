function [t phi solution] = find_phi(initial_values, tspan, params)
    solution = ode45(@(t, input_array) EOM_def(t, input_array, params), tspan, initial_values)
    t = solution.x;
    phi = solution.y(1, :);
    a = solution.y(2, :);
    phidot = solution.y(3, :);
end