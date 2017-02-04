load RiessGold
muoff = fminsearch(@(x) calc_chisq(x,RiessGold), 0);
chisqfinal = calc_chisq(muoff, RiessGold);