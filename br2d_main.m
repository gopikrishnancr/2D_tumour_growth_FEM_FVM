clc;                  
clearvars; 

% SEE  read_me.txt for general information

% The warning is suppressed to avoid its display that makes the code
% slower. Basically, it tries to tell that some triangles are not
% considered while constructing intermediate triangulations. This is
% because not all triangles have an active tumour cell volume fraction, and
% such triangles are eliminated from the triangulations, while the initial
% coordinate list is maintained. The user may ignore this or read more
% about it in :
% URL:: https://in.mathworks.com/help/matlab/ref/triangulation.html
warning('off','MATLAB:triangulation:PtsNotInTriWarnId')     


%-------------------------- Mesh Description ----------------------------%
%     intial time     final time         #(steps)
    t_initial  = 0;  t_final = 20;   T_STEPS = 200;  
    
% dt  = (t_final - t_initial)/T_STEPS
t = linspace(t_initial,t_final,T_STEPS+1); % temporal domain
dt = t(2) - t(1);                          % time discretisation factor


% spatial mesh %
% See the file geom_readme.txt for the user information
square_side  = 5;    % side length of the extended domain 
mesh_index   = 1;    % Geometry for structured triangulation
ref_index    = 1;    % Refinement index for structured triangulation.
geom_type = 1;       % Unstructured triangulation
g_index  = 4;        % Choose initial domain in Unstr. triang. 


%red_mesh is the red refinement sub_routine

[Coord,Elem,ed2el,n2ed,Elem_P1,Coord_P1] =....
             red_mesh(mesh_index,square_side,ref_index,geom_type,g_index);

disp('Spatial_Mesh -> generated succesfully');
% Uncomment next three lines to view the mesh structure. 
% TR = triangulation(Elem(:,1:3),Coord);
% triplot(TR);
% axis square

nv = size(Coord,1);               % #(velocity nodes) in the ext. domain 
np = size(Coord_P1,1); % #(presuure nodes) in the ext. domain
%------------------------end of mesh description--------------------------%


% parameters %
s1 = 10; s2 = 0.5; s3 = 0.5; s4 = 10;     % birth and death rate
Q = 0.5; Q1_hat = 0;                      % oxygen consumption rate
m = 1; l = -2*m/3; k = 1;                 % viscosity and traction
a_thr = 0.01;

element_structure;     % contains area, centroid, normals, edge-length etc.

% construction of local gradient and mass matrices for sparse assembly
[grad_xx,grad_yy,grad_xy,grad_yx,source_x,source_y,pr_x,pr_y,pr_grad,mat_mass] =...
                         assembly_matrices(Elem,elem_st);

% storage matrices %
vol_frac = zeros(size(Elem,1),T_STEPS+1);    % volume fraction
ox_ten   = ones(np,T_STEPS+1);               % oxygen tension
vp       = zeros(2*nv + np,T_STEPS+1);       % velocity pressure

%---- Initial pressure-velocity calculation - [u(:,0) v(:,0) p(:,0)] -----%

ind_t = 0;
assign_vfrac;

% RElem and RCoord correspond tumour domain at time t_n, \Omega(t_n)
[RElem,RCoord,RNb,RDb,re_nodes,new_domain,btr] =...
           get_component(vol_frac,Elem,Coord,a_thr,ind_t,n2ed,np,elem_face_mid,all_neigh);
vol_frac(setdiff(1:size(Elem,1),new_domain),ind_t+1) = 0;


[ucp,nvel,npel] = vpth_opt(RElem,RCoord,RNb,RDb,vol_frac(:,ind_t+1),...
                 new_domain,m,k,l,grad_xx,grad_yy,grad_xy,grad_yx,source_x,source_y,pr_x,pr_y,pr_grad); 
            
             
cur_nd = re_nodes(1:nvel);
vp(:,1) = sparse([cur_nd;cur_nd+nv;re_nodes(1:npel)+2*nv],ones(2*nvel+npel,1),ucp,2*nv + np,1);

rad = zeros(T_STEPS+1,1); rad(1)= 1;

simps = zeros(3,1,size(Elem,1));
tic

for ind_t = 1:T_STEPS
    
vol_frac(:,ind_t+1) = volume_frac(vp(1:2*nv,ind_t),vol_frac(:,ind_t),ox_ten(:,ind_t),dt,all_face_nodes,...
                               all_face_normals,all_neigh,all_face_elen,Elem,nv,elem_area,...
                             s1,s2,s3,s4);
                      
                         
[RElem,RCoord,RNb,RDb,re_nodes,new_domain,btr] =...
          get_component(vol_frac,Elem,Coord,a_thr,ind_t,n2ed,np,elem_face_mid,all_neigh);
vol_frac(setdiff(1:size(Elem,1),new_domain),ind_t+1) = 0;

[ucp,nvel,npel] = vpth_opt(RElem,RCoord,RNb,RDb,vol_frac(:,ind_t+1),...
                 new_domain,m,k,l,grad_xx,grad_yy,grad_xy,grad_yx,source_x,source_y,pr_x,pr_y,pr_grad);
             
cur_nd = re_nodes(1:nvel);
vp(:,ind_t+1) = sparse([cur_nd;cur_nd+nv;re_nodes(1:npel)+2*nv],ones(2*nvel+npel,1),ucp,2*nv + np,1);

[c_cur,npc] = c_tension(ox_ten(:,ind_t),new_domain,vol_frac(:,ind_t+1),...
                        pr_grad,mat_mass,RElem,RDb,Elem,Q,Q1_hat,re_nodes,dt);

ox_ten(re_nodes(1:npc),ind_t+1) = c_cur(1:npc);


 %---------------- calculation of maximum radius ----------------------%
   %dvec = zeros(size(RElem,1),1);
   cent  = elem_centroid(new_domain  (1:size(RElem,1)),:);
   dvec = sqrt(cent(:,1).^2 + cent(:,2).^2);


% Comment following two lines if instant results are not needed.
rad(ind_t+1) = max(dvec);
[ind_t*dt rad(ind_t+1)]
                         
end

plot_general;

toc