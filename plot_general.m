figure(1)
x = cent_tab(:,1);
y = cent_tab(:,2);
z = vol_frac(:,end);
xlin = linspace(min(x),max(x),100);
ylin = linspace(min(y),max(y),100);
[X,Y] = meshgrid(xlin,ylin);
f = scatteredInterpolant(x,y,z);
Z = f(X,Y);
lim = caxis;
caxis([0 1]);
contourf(X,Y,Z,100,'LineStyle','none','Fill','on') %interpolated
%set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1.01, 0.96]);
shading interp;
axis([-5 5 -5 5])
hold on;
TR = triangulation(Elem(:,1:3),Coord);
ss = triplot(TR,'color','blue'); 
ss.LineWidth = 0.001;
axis square;
mycolormap = customcolormap([0 1], [0 0.8 0;1  1 0.8]);
colormap(mycolormap);
%colormap(flipud(summer));
%set(gca,'YTickLabel',[]);
%set(gca,'XTickLabel',[]);
%set(gca,'FontSize',16);
set(gca,'TickLabelInterpreter','latex');
set(gca,'FontSize',11);
% lim = caxis;
% c = colorbar('eastoutside');
% c.Label.String = '$\textrm{NR} \rightarrow \textrm{PR}$';
% c.Label.Interpreter = 'latex';
% c.Label.FontSize = 11;
%  set(gca, 'units', 'centimeters');
%  c.Position = [0.84 0.15   0.05    0.75];
% set(c,'TickLabelInterpreter','latex');
  set(gcf, 'PaperUnits', 'centimeters');
  set(gcf, 'PaperSize',[5.0 5.0],'PaperPosition', [-0.9 0 6.9 5.1]); %
 saveas(gcf,'folder_plot/vfrac_end_circle.pdf');
 hold off;
 
 figure(2)
trisurf(Elem(:,1:3),Coord(1:np,1),Coord(1:np,2),ox_ten(1:np,end),'LineWidth',0.001,...
                                                   'facecolor','interp','LineStyle','-','EdgeColor','blue')
                                 box on;
%zlabel('$p(T,x)$','Interpreter','latex','FontSize',11);
%title('$\textrm{pressure}$','Interpreter','latex','FontSize',14);
%xlim([-7 7]);
%ylim([-7 7]);
 %zlim([0 0.5]
 axis([-5 5 -5 5]);
 view(2)
hold on;
axis square;
 mycolormap = customcolormap([0 1], [0 0.9 0;1  1 0.8]);
colormap(flipud(cool));
set(gca,'TickLabelInterpreter','latex');
set(gca,'FontSize',11);
% lim = caxis;
% c = colorbar('eastoutside');
% c.Label.String = '$\textrm{NR} \rightarrow \textrm{PR}$';
% c.Label.Interpreter = 'latex';
% c.Label.FontSize = 11;
%  set(gca, 'units', 'centimeters');
%  c.Position = [0.84 0.15   0.05    0.75];
% set(c,'TickLabelInterpreter','latex');
  set(gcf, 'PaperUnits', 'centimeters');
  set(gcf, 'PaperSize',[5.0 5.0],'PaperPosition', [-0.9 0 6.9 5.1]); %
 saveas(gcf,'folder_plot/ot_end_circle.pdf');
 hold off;
 
figure(3)
trisurf(Elem(:,1:3),Coord(1:np,1),Coord(1:np,2),-vp(2*nv+1:2*nv+np,end),'LineWidth',0.001,...
                                                   'facecolor','interp','LineStyle','-','EdgeColor','blue');
                                                box on;
%zlabel('$p(T,x)$','Interpreter','latex','FontSize',11);
%title('$\textrm{pressure}$','Interpreter','latex','FontSize',14);
%xlim([-7 7]);
%ylim([-7 7]);
 %zlim([0 0.5])
  axis([-5 5 -5 5]);
 view(2)
hold on;
axis square;
 mycolormap = customcolormap([0 1], [0 0.8 0;1  1 0.8]);
colormap(flipud(spring));
set(gca,'TickLabelInterpreter','latex');
set(gca,'FontSize',11);
% lim = caxis;
% c = colorbar('eastoutside');
% c.Label.String = '$\textrm{NR} \rightarrow \textrm{PR}$';
% c.Label.Interpreter = 'latex';
% c.Label.FontSize = 11;
%  set(gca, 'units', 'centimeters');
%  c.Position = [0.84 0.15   0.05    0.75];
 %set(c,'TickLabelInterpreter','latex');
  set(gcf, 'PaperUnits', 'centimeters');
  set(gcf, 'PaperSize',[5.0 5.0],'PaperPosition', [-0.5 -0.5 5.5 5.5]); %
 saveas(gcf,'folder_plot/pres_end_circle.pdf');
 hold off;
 
 figure(4)
uvf = [vp(1:nv,end)';vp(nv+1:2*nv,end)']';
%uvf(:,1) = uvf(:,1)./sqrt((uvf(:,1).^2 + uvf(:,2).^2));
%uvf(:,2) = uvf(:,2)./sqrt((uvf(:,1).^2 + uvf(:,2).^2));

%TR = triangulation(Elem(:,1:3),Coord);
%ss = triplot(TR,'color','blue','LineWidth',0.05); 
hold on;
quiverC2D_new(Coord(:,1),Coord(:,2),uvf(:,1),uvf(:,2),5000);
 box on;
 
 