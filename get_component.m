function [el_re,coord_re,nb_re,db_re,re_nodes,new_domain,btr] = get_component(vol_frac,Elem,Coord,a_thr,ind_t,n2ed,np,elem_face_mid,all_neigh)
Elem_pos = find(vol_frac(:,ind_t+1) > 0);        % eliminates all zero valued cells
TR = triangulation(Elem(Elem_pos,1:3),Coord);
b_edges = freeBoundary(TR);                 % The boundary edges of the extended domain
b_TR = edgeAttachments(TR,b_edges);
b_TR = unique(cell2mat(b_TR));
v_temp = vol_frac(Elem_pos(b_TR),ind_t+1);
growthless_boundary  = b_TR(v_temp < a_thr);
new_domain  = setdiff(Elem_pos,Elem_pos(growthless_boundary));


TR = triangulation(Elem(new_domain,1:3),Coord);
b_edges = freeBoundary(TR);
b_TR = cell2mat(edgeAttachments(TR,b_edges));
mid_nodes = diag(n2ed(b_edges(:,1)',b_edges(:,2)'));
Nb = unique([b_edges(:,1) mid_nodes + np b_edges(:,2) new_domain(b_TR)],'rows');
btr = Nb(:,4);
%c_ngh = all_neigh(btr,:);
%c_ind = elem_face_mid(btr,:) == repmat(Nb(:,2),1,3);
%c_a = reshape(c_ngh',1,[]);
%c_b = reshape(c_ind',1,[]);


re_nodes = unique(Elem(new_domain,:));
coord_re = Coord(re_nodes,:);
el_re = zeros(size(new_domain,1),6);   
nb_re = zeros(size(Nb,1),4);

for i = 1:6
    [~,el_re(:,i)] = ismember(Elem(new_domain,i),re_nodes);
end


for i = 1:3
    [~,nb_re(:,i)] = ismember(Nb(:,i),re_nodes);
end

nb_re(:,4) = Nb(:,4);
%nb_re(:,5) = c_a(c_b)';
db_re = unique(union(nb_re(:,1),nb_re(:,3)));


%     triplot(TR);
% axis square;
% hold on;
% 
% for i = 1:length(b_TR)
%    
%     x1 = elem_centroid(b_new(i,4),:);
%     x2 = Coord(b_new(i,1),:);
%     x3 = Coord(b_new(i,2),:);
%     x4 = Coord(b_new(i,3),:);
%     labelstr = sprintf('%2i',i);
%     text(x1(1),x1(2),labelstr);
%     plot(x1(1),x1(2),'*')
%      plot(x2(1),x2(2),'r o')
%      plot(x3(1),x3(2),'g o')
%      plot(x4(1),x4(2),'b o')
%      pause
% end
