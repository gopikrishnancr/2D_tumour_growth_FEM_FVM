function [Coord,Elem,ed2el,n2ed,Elem1,Coord_P1] =...
        red_mesh(mesh_index,mesh_side_length,ref_index,geom_type,g_index)

% mesh_index -> The index for choosing initial mesh
% mesh_side_length -> side length of the extended domain
% red_index -> #( refinements )

  
if geom_type  == 1
    switch g_index
        case 1
        load('elems_circ','Elem');
        load('coord_circ','Coord');
        case 2
        load('elems_cross','Elem');
        load('coord_cross','Coord');
        case 3
        load('elems_bullet','Elem');
        load('coord_bullet','Coord');
        case 4
        load('elems_donut_2','Elem');
        load('coord_donut_2','Coord');
        case 5
        load('elems_irr','Elem');
        load('coord_irr','Coord');
    end
    Elem_P1 = Elem;
        for i = 1:size(Elem,1)
    if ispolycw(Coord(Elem(i,:),1),Coord(Elem(i,:),2)) == 1
        Elem(i,:) = Elem(i,[1 3 2]);
    end
        end

for i = 1:ref_index
    
Elem = Elem_P1;
[n2ed,ed2el]=edge(Elem,Coord);             % Node-Edge,Edge-Element connection matrix (for p1)
Coord_P1 = Coord;
coord_in = size(Coord,1);         
Elem1 = Elem;                              % Elem1 stores the P_1 elements before red-refinement.

[Coord,Elem] = redrefine(Coord,Elem,n2ed,ed2el);    % Red-refinement for P_1 functions.

Elem_P1 = Elem;                                                 % Elem_P1 stores the P_1 elements after red-refinment.
Elem_temp = Elem_P1;                                      

Elem2 = zeros(size(Elem1,1),6);                                 % Elem2 declared to store P_2 elements.
Nodes_Register = zeros(size(Elem1,1),3);

for j = 1:size(Elem1,1)
    curNodes = Elem1(j,:);                                      
    curEdges = diag(n2ed(curNodes([2 3 1]),curNodes([3 1 2])));
    Nodes_Register(j,:) = curEdges([3 1 2])';
    Elem2(j,:) = [Elem1(j,:),curEdges([3 1 2])' + coord_in];
end
Elem = Elem2;    % Element for P_2
end
% end of unstructured triangulation
else 
[Coord,Elem] = InitialMesh(mesh_index,mesh_side_length);
Elem_P1 = Elem;
        for i = 1:size(Elem,1)
    if ispolycw(Coord(Elem(i,:),1),Coord(Elem(i,:),2)) == 1
        Elem(i,:) = Elem(i,[1 3 2]);
    end
        end

for i = 1:ref_index
    
Elem = Elem_P1;
[n2ed,ed2el]=edge(Elem,Coord);             % Node-Edge,Edge-Element connection matrix (for p1)
Coord_P1 = Coord;
coord_in = size(Coord,1);         
Elem1 = Elem;                              % Elem1 stores the P_1 elements before red-refinement.

[Coord,Elem] = redrefine(Coord,Elem,n2ed,ed2el);    % Red-refinement for P_1 functions.

Elem_P1 = Elem;                                                 % Elem_P1 stores the P_1 elements after red-refinment.
Elem_temp = Elem_P1;                                      

Elem2 = zeros(size(Elem1,1),6);                                 % Elem2 declared to store P_2 elements.
Nodes_Register = zeros(size(Elem1,1),3);

for j = 1:size(Elem1,1)
    curNodes = Elem1(j,:);                                      
    curEdges = diag(n2ed(curNodes([2 3 1]),curNodes([3 1 2])));
    Nodes_Register(j,:) = curEdges([3 1 2])';
    Elem2(j,:) = [Elem1(j,:),curEdges([3 1 2])' + coord_in];
end
Elem = Elem2;    % Element for P_2
end
end

