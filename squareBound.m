function [V, S] = squareBound(V, S, k)
%SQUAREBOUND Summary of this function goes here
%   Detailed explanation goes here

% Find the extremes.

X = V(1, :);
Y = V(2, :);

xmin=min(X);
xmax=max(X);
xmid = (xmax + xmin) / 2;
ymin=min(Y); ymax=max(Y); ymid = (ymax + ymin) / 2;

width = xmax-xmin;
height = ymax-ymin;

span = k * max(width, height) / 2;

%  Bxmin = xmid - span; 
%  Bxmax = xmid + span;
%  Bymin = ymid - span;
%  Bymax = ymid + span;
Bymin = -10; Bymax = 10;
Bxmin = -10; Bxmax = 10;
sn = 200;

bxline = linspace(Bxmin,Bxmax,sn);
byline = linspace(Bymin,Bymax,sn);

BX = [Bxmin*ones(1,sn) bxline(2:end) Bxmax*ones(1,sn-1) bxline(end-1:-1:2)];
BY = [byline  Bymax*ones(1,sn-1) byline(end-1:-1:1) Bymin*ones(1,sn-2)];

BS = [[1:4*sn-4];[[2:4*sn-4] 1]] + size(V,2);


%BX = [Bxmin Bxmax Bxmin Bxmax];
%BY = [Bymin Bymin Bymax Bymax];
%BS = [1 1 2 3; 2 3 4 4] + size(V, 2);

V = [V [BX;BY]];
S = [S BS];

end
