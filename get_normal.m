function nml = get_normal(Nb,Elem,Coord)

% structure of Nb 
% Nb(1)--Nb(2)---Nb(3)----Nb(4)
%   .            .
%     .   T1  .
%       .   .
%         P3
%
% Nb(4) is the triangle of which Nb edge is a part and, alpha(cg(T1)) > 0


cin  = Coord(Nb(1),:);       % P1 -- vertex 1 of triangle T1
cfin = Coord(Nb(3),:);       % P2 -- vertex 2 of triangle T1
ver_nodes = Elem(Nb(4),1:3); % vertices of the triangle T1. This includes P1
                             % and P2. 

%  vertices coordinates  %
P1 =  cin;            
P2 =  cfin;
c_vert = setdiff(ver_nodes,[Nb(1),Nb(3)]);
P3 =  Coord(c_vert,:);

AB = P2 - P1;
AC = P3 - P1;
N = [-AB(2),AB(1)];

if dot(N,AC) > 0
    N = -N;
end

nml = N/norm(N);