function out = get_edgemp(Nb,Coord)

perms = [1,2;2,3;3,1];
out = zeros(3,2);

for j = 1:3
    
ed_cur = Nb(perms(j,:));
P1 = Coord(ed_cur(1),:);
P2 = Coord(ed_cur(2),:);

out(j,:) = 0.5*(P1 + P2);
end
