function out = get_grad(C,elem_st,Elem)

grad_vector = zeros(size(Elem,1),1);
for i = 1:size(Elem,1)
    vertices = elem_st(i).vcs;
    L1=[ones(1,3);vertices']'\[1;0;0];                 % barycentic coordinates 
    L2=[ones(1,3);vertices']'\[0;1;0];                 %     of current element
    L3=[ones(1,3);vertices']'\[0;0;1];
    
    c_cur = C(elem_st(i).nds);
    grad_c =  (L1(2)*c_cur(1) + L2(2)*c_cur(2) + L3(2)*c_cur(3))^2 +...
              (L1(3)*c_cur(1) + L2(3)*c_cur(2) + L3(3)*c_cur(3))^2;
    grad_c = sqrt(grad_c);
    grad_vector(i) = grad_c;
end
out = grad_vector;