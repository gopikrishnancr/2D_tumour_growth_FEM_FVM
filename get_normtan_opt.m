function C = get_normtan_opt(Nb,Coord,nvel,np)

all_tangents = Coord(Nb(:,3),:) - Coord(Nb(:,1),:);
tan_norms = sqrt(all_tangents(:,1).^2 + all_tangents(:,2).^2);
all_tangents = [all_tangents(:,1)./tan_norms ...
                    all_tangents(:,2)./tan_norms];
                
Nb_mid = Nb(:,2);
i_en = setdiff(1:2*nvel+np,union(Nb_mid,Nb_mid+nvel))';
c_rows = [i_en;Nb_mid;Nb_mid;Nb_mid+nvel;Nb_mid+nvel];
c_cols = [i_en;Nb_mid;Nb_mid+nvel;Nb_mid;Nb_mid+nvel];
c_entries = [ones(length(i_en),1);all_tangents(:,2);-all_tangents(:,1);...
                all_tangents(:,1);all_tangents(:,2)];
            
C = sparse(c_rows,c_cols,c_entries,2*nvel+np,2*nvel+np);  