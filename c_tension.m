function [c_cur,np] = c_tension(ot,elem_ar,v_al,pr_grad,mat_mass,Elem,Db,PElem,Q,Q1_hat,re_nodes,dt)

np = size(unique(Elem(:,1:3)),1);

p_nodes = setdiff(unique(Elem(:,1:3)),unique(Db))';
assembly_rows_g = reshape(repmat(Elem(:,1:3),1,3)',1,[]);
assembly_cols_g = reshape(repmat(reshape(Elem(:,1:3)',1,[]),3,1),1,[]);

[Ax,Mx,Dx] = c_tension_opt(elem_ar,v_al,pr_grad,mat_mass,ot,PElem,Q,Q1_hat);

A = sparse(assembly_rows_g,assembly_cols_g,Ax,np,np);
M = sparse(assembly_rows_g,assembly_cols_g,Mx,np,np);
D = sparse(assembly_rows_g,assembly_cols_g,Dx,np,np);

cp = ot(re_nodes(1:np),:);
coeff_mat = M + dt*(D-A);
load = M*cp;

c_cur = zeros(np,1);
db_nodes = unique(Db);
c_cur(db_nodes,1) = ones(length(db_nodes),1);
load = load - coeff_mat*c_cur;

c_cur(p_nodes) = coeff_mat(p_nodes,p_nodes)\load(p_nodes);



