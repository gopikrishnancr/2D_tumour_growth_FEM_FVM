function [grad_xx,grad_yy,grad_xy,grad_yx,source_x,source_y,pr_x,pr_y,pr_grad,mat_mass] = assembly_matrices(Elem,elem_st)

grad_xx = zeros(6,6,size(Elem,1));
grad_yy = zeros(6,6,size(Elem,1));
grad_xy = zeros(6,6,size(Elem,1));
grad_yx = zeros(6,6,size(Elem,1));
source_x = zeros(6,size(Elem,1));
source_y = zeros(6,size(Elem,1));
pr_x = zeros(6,3,size(Elem,1));
pr_y = zeros(6,3,size(Elem,1));
pr_grad = zeros(3,3,size(Elem,1));
mat_mass = zeros(3,3,size(Elem,1));
N = [1/6 1/12 1/12;1/12 1/6 1/12;1/12 1/12 1/6]; 


for j = 1:size(Elem,1)
    
    mk = elem_st(j).area;
    vertices = elem_st(j).vcs;
    L1=[ones(1,3);vertices']'\[1;0;0];                 % barycentic coordinates 
    L2=[ones(1,3);vertices']'\[0;1;0];                 % of current element
    L3=[ones(1,3);vertices']'\[0;0;1];
    
  Mx = [(L1(2)^2)/2 -(L1(2)*L2(2))/6 -(L1(2)*L3(2))/6 (2*L1(2)*L2(2))/3 0 (2*L1(2)*L3(2))/3;
     0 (L2(2)^2)/2 -((L2(2)*L3(2))/6) (2*L1(2)*L2(2))/3 (2*L2(2)*L3(2))/3 0;
     0 0 (L3(2)^2)/2 0 (2*L2(2)*L3(2))/3 (2*L1(2)*L3(2))/3;
     0 0 0 4*(L1(2)^2 + L1(2)*L2(2) + L2(2)^2)/3 ...
      2*(L1(2)*L2(2) + L2(2)^2 + L2(2)*L3(2))/3 + (4*L1(2)*L3(2))/3 ...
      2*(L1(2)*L2(2) + L1(2)^2 + L1(2)*L3(2))/3 + (4*L2(2)*L3(2))/3;
      0 0 0 0 4*(L2(2)^2 + L3(2)*L2(2) + L3(2)^2)/3 ...
      2*(L2(2)*L3(2) + L3(2)^2 + L1(2)*L3(2))/3 + (4*L2(2)*L1(2))/3;
      0 0 0 0 0 4*(L1(2)^2 + L1(2)*L3(2) + L3(2)^2)/3];
  
  My = [(L1(3)^2)/2 -(L1(3)*L2(3))/6 -(L1(3)*L3(3))/6 (2*L1(3)*L2(3))/3 0 (2*L1(3)*L3(3))/3;
     0 (L2(3)^2)/2 -((L2(3)*L3(3))/6) (2*L1(3)*L2(3))/3 (2*L2(3)*L3(3))/3 0;
     0 0 (L3(3)^2)/2 0 (2*L2(3)*L3(3))/3 (2*L1(3)*L3(3))/3;
     0 0 0 4*(L1(3)^2 + L1(3)*L2(3) + L2(3)^2)/3 ...
      2*(L1(3)*L2(3) + L2(3)^2 + L2(3)*L3(3))/3 + (4*L1(3)*L3(3))/3 ...
      2*(L1(3)*L2(3) + L1(3)^2 + L1(3)*L3(3))/3 + (4*L2(3)*L3(3))/3;
      0 0 0 0 4*(L2(3)^2 + L3(3)*L2(3) + L3(3)^2)/3 ...
      2*(L2(3)*L3(3) + L3(3)^2 + L1(3)*L3(3))/3 + (4*L2(3)*L1(3))/3;
      0 0 0 0 0 4*(L1(3)^2 + L1(3)*L3(3) + L3(3)^2)/3];
  
  L12 = L1(2); L13 = L1(3); L22 = L2(2); L23 = L2(3); L32 = L3(2); L33 =L3(3);

Mxy = 2*mk*[(L12*L13)/2, -((L13*L22)/6), -((L13*L32)/6), (2*L13*L22)/3, 0, (2*L13*L32)/3; 
 -((L12*L23)/6), (L22*L23)/2, -((L23*L32)/6), (2*L12*L23)/3, (2*L23*L32)/3, 0; 
 -((L12*L33)/6), -((L22*L33)/6), (L32*L33)/2, 0, (2*L22*L33)/3, (2*L12*L33)/3; 
 (2*L12*L23)/3, (2*L13*L22)/3, 0, (4*L12*L13)/3 + (2*L13*L22)/3 + (2*L12*L23)/3 + (4*L22*L23)/3,...
 (2*L13*L22)/3 + (2*L22*L23)/3 + (4*L13*L32)/3 + (2*L23*L32)/3,...
 (2*L12*L13)/3 + (2*L12*L23)/3 + (2*L13*L32)/3 + (4*L23*L32)/3; 
 0, (2*L22*L33)/3, (2*L23*L32)/3, (2*L12*L23)/3 + (2*L22*L23)/3 + (4*L12*L33)/3 + (2*L22*L33)/3,...
 (4*L22*L23)/3 + (2*L23*L32)/3 + (2*L22*L33)/3 + (4*L32*L33)/3,...
 (4*L12*L23)/3 + (2*L23*L32)/3 + (2*L12*L33)/3 + (2*L32*L33)/3; 
 (2*L12*L33)/3, 0, (2*L13*L32)/3, (2*L12*L13)/3 + (2*L13*L22)/3 + (2*L12*L33)/3 + (4*L22*L33)/3,...
 (4*L13*L22)/3 + (2*L13*L32)/3 + (2*L22*L33)/3 + (2*L32*L33)/3, ...
 (4*L12*L13)/3 + (2*L13*L32)/3 + (2*L12*L33)/3 + (4*L32*L33)/3];

Pgrad = 2*mk*[(L12^2 + L13^2)/2	(L12*L22 + L13*L23)/2	(L12*L32 + L13*L33)/2;
    (L12*L22 + L13*L23)/2	(L22^2 + L23^2)/2	(L22*L32 + L23*L33)/2;
    (L12*L32 + L13*L33)/2	(L22*L32 + L23*L33)/2	(L32^2 + L33^2)/2];

x1=vertices(1,1);
y1=vertices(1,2);
x2=vertices(2,1);
y2=vertices(2,2);
x3=vertices(3,1);
y3=vertices(3,2);
y23=y2-y3;
y31=y3-y1;
y12=y1-y2;
x32=x3-x2;
x13=x1-x3;
x21=x2-x1;

  Px = [-y23/6, 0, 0;
    0, -y31/6,0;
    0,0,-y12/6;
    (-y23/6)+(-y31/3), (-y23/3)+(-y31/6), (-y23/6)+(-y31/6);
    (-y31/6)+(-y12/6), (-y31/6)+(-y12/3),(-y31/3)+(-y12/6);
     (-y23/6)+(-y12/3),(-y23/6)+(-y12/6),(-y23/3)+(-y12/6)];
  
  Py = [-x32/6, 0, 0;
    0, -x13/6,0;
    0,0,-x21/6;
    (-x32/6)+(-x13/3), (-x32/3)+(-x13/6), (-x32/6)+(-x13/6);
    (-x13/6)+(-x21/6), (-x13/6)+(-x21/3),(-x13/3)+(-x21/6);
     (-x32/6)+(-x21/3),(-x32/6)+(-x21/6),(-x32/3)+(-x21/6)];

  
grad_xx(:,:,j) = 2*mk*(Mx+triu(Mx,1).');
grad_yy(:,:,j) = 2*mk*(My+triu(My,1).');
grad_xy(:,:,j) = Mxy;
grad_yx(:,:,j) = Mxy';
source_x(:,j) = 2*mk*[L12/6 L22/6 L32/6 (2*(L12 + L22))/3 (2*(L22 + L32))/3 (2*(L12 + L32))/3]';
source_y(:,j) = 2*mk*[L13/6 L23/6 L33/6 (2*(L13 + L23))/3 (2*(L23 + L33))/3 (2*(L13 + L33))/3]';
pr_x(:,:,j) =  Px;
pr_y(:,:,j) =  Py;
pr_grad(:,:,j) = Pgrad;
mat_mass(:,:,j) = mk*N; 
end
  



  
 