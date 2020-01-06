function  [soln,nvel,np] = vpth_opt(Elem,Coord,Nb,Db,v_al,tr_int,m,k,l,grad_xx,grad_yy,grad_xy,grad_yx,source_x,source_y,pr_x,pr_y,pr_grad)

nvel = size(Coord,1);                % #(velocity nodes) in the current domain
np =  size(unique(Elem(:,1:3)),1);   % %(pressure nodes) in the current domain
                             
p_nodes = setdiff(unique(Elem(:,1:3)),unique(Db))';
NT = get_normtan_opt(Nb,Coord,nvel,np);

assembly_rows = reshape(repmat(Elem,1,6)',1,[]);
assembly_cols = reshape(repmat(reshape(Elem',1,[]),6,1),1,[]);
assembly_prows = reshape(repmat(Elem,1,3)',1,[]);
assembly_pcols = reshape(repmat(reshape(Elem(:,1:3)',1,[]),6,1),1,[]);

assembly_rows_g = reshape(repmat(Elem(:,1:3),1,3)',1,[]);
assembly_cols_g = reshape(repmat(reshape(Elem(:,1:3)',1,[]),3,1),1,[]);
f_cols = reshape(Elem',1,[]); l_s = length(f_cols);

[MV,NV,MP,NP] = stima_velp_opt(tr_int,v_al,k,grad_xx,grad_yy,grad_xy,grad_yx,source_x,source_y,pr_x,pr_y,pr_grad);

A1 = sparse(assembly_rows,assembly_cols,(2*m + l)*MV(1,:) + m*MV(2,:),nvel,nvel);
B1 = sparse(assembly_rows,assembly_cols,m*MV(3,:) + l*MV(4,:),nvel,nvel);
D1 = sparse(assembly_rows,assembly_cols,(2*m + l)*MV(2,:) + m*MV(1,:),nvel,nvel);
E1 = sparse(assembly_rows,assembly_cols,l*MV(3,:) + m*MV(4,:),nvel,nvel);

C1 = sparse(assembly_prows,assembly_pcols,MP(1,:),nvel,np);
F1 = sparse(assembly_prows,assembly_pcols,MP(2,:),nvel,np);
H1 = sparse(assembly_rows_g,assembly_cols_g,NP,np,np);

FA1 = sparse(ones(l_s,1),f_cols,NV(1,:),1,nvel);
FA2 = sparse(ones(l_s,1),f_cols,NV(2,:),1,nvel);  

coeff_mat= [A1,B1,C1;E1,D1,F1;-C1',-F1',H1];
load = [FA1';FA2';zeros(np,1)];
                  
C_NT = NT*coeff_mat/NT;
soln = zeros(2*nvel+np,1);
F_NT = NT*load;

Nbm = Nb(:,2);

%soln(Nbm+nvel,1) = ud;
FreeNodes = setdiff(1:nvel,Nbm);
F_NT = F_NT - C_NT*soln;
s_nodes = [1:nvel,FreeNodes+nvel,p_nodes + 2*nvel];
soln(s_nodes,1) = C_NT(s_nodes,s_nodes)\F_NT(s_nodes);
soln = NT\soln;
