function out = volume_frac(vel,vf,ot,dt,all_face_nodes,all_face_normals,all_neigh,all_face_elen,Elem,nv,elem_area,s1,s2,s3,s4)

u = vel(1:nv);
v = vel(1+nv:2*nv);
u_fac = u(all_face_nodes);
v_fac = v(all_face_nodes);

u_fac(:,2,:) = 4*u_fac(:,2,:);
v_fac(:,2,:) = 4*v_fac(:,2,:);

u_fac = sum(u_fac,2);
v_fac = sum(v_fac,2);

vel_faces = [u_fac v_fac];

normal_vel = sum(vel_faces.*all_face_normals,2).*all_face_elen/6;

v_f = [0;vf];
volf_share = v_f(all_neigh+1);
volf_cur = zeros(1,1,size(Elem,1));
volf_cur(1,1,:) = vf;

flux_final = dt*reshape(sum(bsxfun(@times,max(normal_vel,0),volf_cur) +...
                          reshape(volf_share',3,1,size(Elem,1)).*min(normal_vel,0),1),1,size(Elem,1))'./elem_area;
 
 c_mean  = sum(ot(Elem(:,1:3)),2)/3;

 bd_rate = (1 + s1)*(1 - vf).*c_mean./(1 + s1*c_mean) -...
                 (s2 + s3*c_mean)./(1 + s4*c_mean);
 out = (vf.*(1 + dt*max(bd_rate,0)) - flux_final)./...
                                     (1 - dt*min(bd_rate,0));