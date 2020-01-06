function out = heav(x)
a_min = 0.8;
a_star = 0.8;
out = x.*[x >= a_min].*(x-a_star)./((1-x).^2);