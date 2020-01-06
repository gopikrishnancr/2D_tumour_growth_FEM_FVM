function C = get_normtan_opt_2(Nb,Coord,nvel,np)

all_tangents = Coord(Nb(:,3),:) - Coord(Nb(:,1),:);
tan_norms = sqrt(all_tangents(:,1).^2 + all_tangents(:,2).^2);
all_tangents = [all_tangents(:,1)./tan_norms ...
                    all_tangents(:,2)./tan_norms];
                
Nb_mid = Nb(:,2);
Nb_all = unique(Nb(:,1:3));
tangent_full = zeros(size(Nb_all,1),2);

for i = 1:size(Nb,1)
    cur_tangent = Coord(Nb(i,3),:) - Coord(Nb(i,1),:);
    cur_tangent = cur_tangent/norm(cur_tangent,2);
   
        a1 = find(Nb(i,1)==Nb_all);
        a2 = find(Nb(i,2)==Nb_all);
        a3 = find(Nb(i,3)==Nb_all);
 
    tangent_full(a1,:) = tangent_full(a1,:) + cur_tangent; 
    tangent_full(a3,:)  = tangent_full(a3,:) + cur_tangent; 
    tangent_full(a2,:) = tangent_full(a2,:) + 2*cur_tangent;  
end

tangent_full = tangent_full/2;
all_norms = sqrt(tangent_full(:,1).^2 + tangent_full(:,2).^2);
tangent_full = [tangent_full(:,1)./all_norms ...
                    tangent_full(:,2)./all_norms];

i_en = setdiff(1:2*nvel+np,union(Nb_all,Nb_all+nvel))';
c_rows = [i_en;Nb_all;Nb_all;Nb_all+nvel;Nb_all+nvel];
c_cols = [i_en;Nb_all;Nb_all+nvel;Nb_all;Nb_all+nvel];
c_entries = [ones(length(i_en),1);tangent_full(:,2);-tangent_full(:,1);...
                tangent_full(:,1);tangent_full(:,2)];
            
C = sparse(c_rows,c_cols,c_entries,2*nvel+np,2*nvel+np);  