function n_gh = get_neigh(cur_elem,Elem,ed2el,n2ed)

n_gh = zeros(3,1);
ct_int = Elem(cur_elem,1:3);       
ct_ed = diag(n2ed(ct_int([1 2 3]),ct_int([2 3 1])));
for j = 1:3
        n_gh(j) = setdiff(ed2el(ct_ed(j),3:4),cur_elem);
end