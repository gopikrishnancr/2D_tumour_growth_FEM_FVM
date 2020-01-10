function [  ] = quiverC2D_new(x,y,u,v,maxNumArrows)
%quiverC2D creates a 2D quiver plot and adds a color coding. The color coding is
%given by the absolut values of the component vectors. Large values result in colors 
%from the upper end of the used colormap. Plotting parameters have to be changed within 
%the function in this version. Values equal to NaN or inf are set to zero.
%In case of complex arrays the absolute value is used.
% 
%   INPUT:
%       x - 2D matrix, x components of initial points
%       y - 2D matrix, y components of initial points
%       u - 2D matrix, x components of arrows
%       v - 2D matrix, y components of arrows
%       maxNumArrows - a positive integer (non-integer should work as well)
%           number limiting the maximum number of plotted arrows. Since vectors
%           of length zero aren't plotted and the matrices are sampled
%           uniformly, it's possible that fewer arrows will be visible in the
%           end. If maxNumArrows is not given its value is set to 1000.
% 
%   OUTPUT:
%       none
% 
%   WARNING!: Using large datasets in combination with choosing maxNumArrows 
%       very large might result in this script running forever.
% 
% --------------------------------------------------------------------------------------
% 
%   EXAMPLE: 
%       [x,y] = meshgrid(linspace(0,10,100),linspace(0,10,100));
%       u = exp(-0.2*(x-5).^2 - 0.2*(y-5).^2);
%       v = -u;
%       quiverC2D(x,y,u,v,1000);
%   
% --------------------------------------------------------------------------------------
% 
%   See also: QUIVER, LINESPEC, COLORMAP.
% 
% 
%% prearrangements
%narginchk(4,5);
%n_in = nargin;
%if ~isequal(size(x),size(y),size(u),size(v))
%    error('X,Y,U,V have to be matrices of the same size.');
%end
%% assignments
% maximum number of arrows if necessary
%if n_in == 4
    %maxNumArrows = 1000;
%end
% Line width
lw = 0.7;
% Maximum of arrow head size
hs = 65;
% Colormap
colormap summer;
%% initialization

%% colormap definition
I = sqrt(u.^2 + v.^2);
Ic = round(1000*(I/max(max(I))));
Ic(Ic == 0) = 1;
C = colormap(summer(1000));
%% plotting
hold on;
for n = 1:length(I)
            mag = ((u(n)^2 + v(n)^2)^0.5);
            h1  = quiver(x(n),y(n),u(n)/mag,v(n)/mag,'Color',C(Ic(n),:),'LineWidth',lw,'maxheadsize',hs);
end
set(gca,'TickLabelInterpreter','latex');
set(gca,'FontSize',11);
axis square;
axis([-5 5 -5 5]);
hold on;
box on;
   set(gcf, 'PaperUnits', 'centimeters');
  set(gcf, 'PaperSize',[4.9 5.0],'PaperPosition', [-0.9 0 6.9 5.1]); %
 saveas(gcf,'folder_plot/vt_end_circle.pdf');
 hold off;
