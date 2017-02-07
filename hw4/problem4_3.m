load RiessGold
today = load_today();
muoff = fminsearch(@(x) calc_chisq(x,RiessGold, today), 0)
chisqfinal = calc_chisq(muoff, RiessGold, today)