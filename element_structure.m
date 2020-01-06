elem_st = repmat(struct('e_n',[],'nds',[],'vcs',[],'area',...
                [],'nml',[],'cent',[],'ngh',[],'e_mp',[],'e_len',[],'ed_n',[],'ed_nodes',[]),size(Elem,1),1);
elem_area = zeros(size(Elem,1),1);
elem_centroid = zeros(size(Elem,1),2);
all_face_nodes = zeros(3,3,size(Elem,1));
all_face_normals = zeros(3,2,size(Elem,1));
all_face_elen = zeros(3,1,size(Elem,1));
elem_face_mid = zeros(size(Elem,1),3);
all_neigh = zeros(size(Elem,1),3);     

for i = 1:size(Elem,1)
    nodes = Elem(i,1:3);                 
    elem_st(i).nds = nodes;                          % node numbers of vertices
    vert = Coord(Elem(i,1:3),:); 
    elem_st(i).vcs   = vert;                         % element node vertices
    elem_st(i).area  = 1/2*det([ones(1,3);vert']);   % element areaa
    elem_st(i).cent  = sum(vert)'/3;                 % element centroid
    %elem_st(i).nml  = get_normals(nodes,Coord);     % element normals
    elem_st(i).ngh   = get_neigh(i,Elem,ed2el,n2ed); % element neighbors
    elem_st(i).e_mp  = get_edgemp(nodes,Coord);      % element edge mid points
    elem_st(i).e_len = get_elen(nodes,Coord);        % edge length
    elem_st(i).ed_n =  Elem(i,4:6);
    %elem_st(i).ed_nodes = [Elem(i,1) Elem(i,4) Elem(i,2);    % nodes in each side
    %                       Elem(i,2) Elem(i,5) Elem(i,3);    % in anti-clock order
    %                       Elem(i,3) Elem(i,6) Elem(i,1)];
                       
    elem_area(i) = 1/2*det([ones(1,3);vert']);              
    elem_centroid(i,:) = sum(vert)/3;  
    elem_face_mid(i,:) = Elem(i,4:6)';
    all_face_nodes(:,:,i) = [Elem(i,1) Elem(i,4) Elem(i,2);    % modes in each side
                             Elem(i,2) Elem(i,5) Elem(i,3);    % in anti-clock order
                             Elem(i,3) Elem(i,6) Elem(i,1)];
    all_face_normals(:,:,i) = get_normals(nodes,Coord);
    all_face_elen(:,:,i) = get_elen(nodes,Coord);  
    all_neigh(i,:) = get_neigh(i,Elem,ed2el,n2ed)';
end


% uasge 

% elem_st(i).e_n -> element number of ith element
% elem_st(i).nds -> nodes for ith element


cent_tab = [elem_st.cent]';
