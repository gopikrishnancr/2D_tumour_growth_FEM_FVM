function [Coord,Elem,Db,Nb]=InitialMesh(N,a) 

th = linspace(0,2*pi,100)';
circoords = [cos(th) sin(th)];
% a  - side of the square %

%%%%%%%%%%% Diagonal structures mesh %%%%%%%%%%%%
if N==1
    Coord=[-a -a;a -a;-a a;a a;0 0];
    Elem = [5 1 2;5 2 4;5 4 3;5 3 1];
    Nb = [];
    Db = [];
end

%%%%% Lexicographic structered mesh %%%%%%%%%%%%
if N ==3
     Coord = [-a -a;0 -a;a -a;-a 0;0 0;a 0;-a a;0 a;a a];
     Elem =[4 1 2;2 5 4;5 2 3;3 6 5;7 4 5;5 8 7;8 5 6;6 9 8];
     Db = [1 2;2 3;3 6;6 9;9 8;8 7;7 4;4 1];
     Nb = [];
end

if N ==4
     Coord = [-a -a;0 -a;a -a;-a 0;0 0;a 0;-a a;0 a;a a];
     Elem =[1 2 5;2 3 5;1 5 4;3 6 5;4 5 7;5 8 7;6 9 5;5 9 8];
     Db = [];
     Nb = [];
end

if N == 5
     Coord = [-a -a;0 -a;a -a;-a/2 -a/2;a/2 -a/2;-a 0;0 0;a 0;-a/2 a/2; a/2 a/2;-a a;0 a;a a];
     Elem =[1 2 4;2 7 4;4 7 6;1 4 6;2 3 5;5 3 8;5 8 7;5 7 2;6 7 9;9 7 12;9 12 11;9 11 6;7 8 10;10 8 13;10 13 12;10 12 7];
     Db = [];
     Nb = [];
end


