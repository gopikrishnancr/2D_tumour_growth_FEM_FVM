function [Coord,Elem]=redrefine(Coord,Elem,n2ed,ed2el)

nt=size(Elem,1); 
ne=size(ed2el,1);
marker=sparse(ne,1);

for i=1:ne,
    inode=ed2el(i,1); enode=ed2el(i,2);
    coord1=Coord(inode,:); coord2=Coord(enode,:);
    nCoord=(coord1+coord2)/2;
    marker(i)=size(Coord,1)+1; 
    Coord(size(Coord,1)+1,:)=[nCoord(1) nCoord(2)];
end


for i=1:nt,
    ct=Elem(i,:);
    ce=diag(n2ed(ct([2 3 1]),ct([3 1 2])));
    m1=marker(ce(1));  m2=marker(ce(2)); m3=marker(ce(3));
    Elem(i,:)=[m1 m2 m3];
    nt1=size(Elem,1); 
    Elem(nt1+1,:)=[ct(1) m3 m2];  
    Elem(nt1+2,:)=[ct(2) m1 m3];  
    Elem(nt1+3,:)=[ct(3) m2 m1];  
end

            
end
