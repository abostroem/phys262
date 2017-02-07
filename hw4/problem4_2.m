load RiessGold
today = load_today();
lum_dist = calc_luminosity_distance(RiessGold.z, today);
lum_dist_mpc = convert_lum_dist_to_mpc(lum_dist);
dist_mod_model = calc_dist_mod(lum_dist_mpc);
chisq = sum(((RiessGold.mu - dist_mod_model) ./ RiessGold.sigma) .^2)
plot(RiessGold.z, RiessGold.mu, 's')
hold on 
plot(RiessGold.z, dist_mod_model, 'o')
xlabel('z')
ylabel('Distance Modulus')
l = legend('Riess Gold Sample', 'FRW Model')
l.Location = 'best'