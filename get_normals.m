function out = get_normals(Nb,Coord)

perms = [1,2,3;2,3,1;3,1,2];
out = zeros(3,2);

for j = 1:3
    
ed_cur = Nb(perms(j,:));
P1 = Coord(ed_cur(1),:);
P2 = Coord(ed_cur(2),:);
P3 = Coord(ed_cur(3),:);

AB = P2 - P1;
AC = P3 - P1;
N = [-AB(2),AB(1)];

if dot(N,AC) > 0
    N = -N;
end

out(j,:) = N/norm(N);
end
