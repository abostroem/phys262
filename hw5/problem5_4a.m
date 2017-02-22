params = load_fixed_params();
phi = logspace(log10(params.beta-3), log10(params.beta+3));
old_V = exp(-params.lambda .* phi);
new_V = calc_v(phi, params);

f=figure()
semilogy(phi, old_V, '-o')
hold on
semilogy(phi, new_V, '-o')
legend('V_{0}e^{(-\lambda \phi)}', 'V_{0}(\chi (\phi - \beta)^(2) + \delta) e^{(-\lambda \phi)}')
xlabel('\phi')
ylabel('V')
title('Potentials for 5.3 and 5.4')
plot([33.8 33.8],get(gca, 'ylim'))
plot([34.2 34.2], get(gca, 'ylim'))
saveas(f, 'potentials.pdf')