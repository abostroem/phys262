omega_m0 = linspace(0.01,0.35, 20)
omega_L0 = linspace(0.25,0.5, 20)
muoff = zeros(20, 20)
chisqfinal = zeros(20, 20)
for m_indx = 1:20
    for L_indx = 1:20
        today = calc_from_omega(omega_m0(m_indx), omega_L0(L_indx));
        muoff(m_indx, L_indx) = fminsearch(@(x) calc_chisq(x,RiessGold, today), 0);
        chisqfinal(m_indx, L_indx) = calc_chisq(muoff(m_indx, L_indx), RiessGold, today); 
    end
end
f = figure()
surf(omega_m0, omega_L0, chisqfinal)
xlabel('\omega_m')
ylabel('\omega_{\Lambda}')
zlabel('\chi^2_{off}')
saveas(f, 'parameter_grid_chisq.pdf')

f = figure()
P = exp(-chisqfinal ./ 2.)
norm_P = P ./ max(max(P))
surf(omega_m0, omega_L0, norm_P)
xlabel('\omega_m')
ylabel('\omega_{\Lambda}')
zlabel('relative probability')
saveas(f, 'parameter_grid_probability.pdf')
