function [] = Dplot_figure201(params,direction,takeout,anclabels)

%   Problems of colour reversal using PDF ********************
% Based on Adrianna's oct2011_plot_figure2.m
% Cut down version to show how to form lattice
% With the added facility of specifying which nodes to leave out
% Also supply a list of nodes for anchors

    xmean_coll = params.ellipse.x0;
    ymean_coll = params.ellipse.y0;

    ancnums=length(anclabels);

if direction == 'CTOF' 
    coll_coords = params.CTOF.coll_points;
    field_coords = params.CTOF.field_points;
    list_of_neighbours = params.CTOF.list_of_neighbours;
    color = 'b';
    num_points = params.CTOF.numpoints;
    takeout = params.CTOF.takeout;
    list_of_points = setdiff(1:num_points,takeout);
    sets_of_intersections = params.CTOF.sets_of_intersections;
    
   figure(201)
   set(gcf,'Color',[1 1 1]);
   set(gcf,'InvertHardCopy','off');
   clf



   %CTOF Coll
   subplot(3,2,1)
%  plot(coll_coords(:,1),coll_coords(:,2),'o','Color',[0.2 0.2 0.2],'MarkerFaceColor',[0.2 0.2 0.2],'MarkerSize',10);
   plot(coll_coords(:,1),coll_coords(:,2),'o','Color','b','MarkerFaceColor','b','MarkerSize',10);
   hold on

   text(coll_coords(:,1),coll_coords(:,2),num2str(list_of_points(:)),'Color',[1 1 1],'HorizontalAlignment','Center','FontSize',8,'FontWeight','bold');



   hold on
   plot(xmean_coll-65:xmean_coll-38,ones(28,1).*ymean_coll+65,'k', 'LineWidth',3)%scale bar
   axis ij
   axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
   set(gca,'PlotBoxAspectRatio',[1 1 1]);
   axis off

   %CTOF Field       
   subplot(3,2,2)
   plot(zeros(101,1),-50:50,'Color',[0.7 0.7 0.7], 'Linewidth',1)
   hold on
   plot(-50:50,zeros(101,1),'Color',[0.7 0.7 0.7], 'Linewidth',1)

%   plot(field_coords(:,1),field_coords(:,2),'o','Color',[0.2 0.2 0.2],'MarkerFaceColor',[0.2 0.2 0.2],'MarkerSize',10); 
   plot(field_coords(:,1),field_coords(:,2),'o','Color','b','MarkerFaceColor','b','MarkerSize',10); 
   text(field_coords(:,1),field_coords(:,2),num2str(list_of_points(:)),'Color',[1 1 1],'HorizontalAlignment','Center','FontSize',8,'FontWeight','bold');

   plot(-45:-26,ones(20,1).*45,'k', 'LineWidth',3)%scale bar
   hold off

   axis ij
   axis([-50 50 -50 50]);
   set(gca,'PlotBoxAspectRatio',[1 1 1]);
   axis off

 
   
   %CTOF Coll
   subplot(3,2,3)
   print_links(list_of_points, coll_coords, list_of_neighbours, 'b');
   hold on

   plot(coll_coords(:,1),coll_coords(:,2),'o','Color','b','MarkerFaceColor','b','MarkerSize',10);
   text(coll_coords(:,1),coll_coords(:,2),num2str(list_of_points(:)),'Color',[1 1 1],'HorizontalAlignment','Center','FontSize',8,'FontWeight','bold');

   hold off
   axis ij
   axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
   set(gca,'PlotBoxAspectRatio',[1 1 1]);
   axis off


   %CTOF Field
   subplot(3,2,4)
   plot(zeros(101,1),-50:50,'Color',[0.7 0.7 0.7], 'Linewidth',1)
   hold on
   plot(-50:50,zeros(101,1),'Color',[0.7 0.7 0.7], 'Linewidth',1)

%   plot(field_coords(:,1),field_coords(:,2),'o','Color',[0.2 0.2 0.2],'MarkerFaceColor',[0.2 0.2 0.2],'MarkerSize',10); 
   plot(field_coords(:,1),field_coords(:,2),'o','Color','b','MarkerFaceColor','b','MarkerSize',10); 
   numpoints= length(list_of_points);

   print_links(list_of_points, field_coords, list_of_neighbours, 'b');
   [cross_points,list_of_crossings] = make_cross_list(list_of_points,sets_of_intersections);
   text(field_coords(:,1),field_coords(:,2),num2str(list_of_points(:)),'Color',[1 1 1],'HorizontalAlignment','Center','FontSize',8,'FontWeight','bold');


   hold off

   axis ij
   axis([-50 50 -50 50]);
   set(gca,'PlotBoxAspectRatio',[1 1 1]);
   axis off

   %CTOF Coll
   subplot(3,2,5)
   print_links(list_of_points, coll_coords, list_of_neighbours, 'b');
   hold on

  [cross_points,list_of_crossings] = make_cross_list(list_of_points,sets_of_intersections);
   print_links(cross_points, coll_coords, list_of_crossings, 'r');

   plot(coll_coords(:,1),coll_coords(:,2),'o','Color','b','MarkerFaceColor','b','MarkerSize',10);
   plot_anchors10(coll_coords,ancnums,anclabels);

   text(coll_coords(:,1),coll_coords(:,2),num2str(list_of_points(:)),'Color',[1 1 1],'HorizontalAlignment','Center','FontSize',8,'FontWeight','bold');

   hold off
   axis ij
   axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
   set(gca,'PlotBoxAspectRatio',[1 1 1]);
   axis off  

  %CTOF Field
   subplot(3,2,6)
   plot(zeros(101,1),-50:50,'Color',[0.7 0.7 0.7], 'Linewidth',1)
   hold on
   plot(-50:50,zeros(101,1),'Color',[0.7 0.7 0.7], 'Linewidth',1)

   print_links(list_of_points, field_coords, list_of_neighbours, 'b');
   [cross_points,list_of_crossings] = make_cross_list(list_of_points,sets_of_intersections);
   print_links(cross_points, field_coords, list_of_crossings, 'r');

%   plot(field_coords(:,1),field_coords(:,2),'o','Color',[0.2 0.2 0.2],'MarkerFaceColor',[0.2 0.2 0.2],'MarkerSize',10); 
   plot(field_coords(:,1),field_coords(:,2),'o','Color','b','MarkerFaceColor','b','MarkerSize',10); 
   anchors = plot_anchors10(field_coords,ancnums,anclabels);

   text(field_coords(:,1),field_coords(:,2),num2str(list_of_points(:)),'Color',[1 1 1],'HorizontalAlignment','Center','FontSize',8,'FontWeight','bold');

   hold off

   axis ij
   axis([-50 50 -50 50]);
   set(gca,'PlotBoxAspectRatio',[1 1 1]);
   axis off

end

if direction == 'FTOC'

    coll_coords = params.FTOC.coll_points;
    field_coords = params.FTOC.field_points;
    list_of_neighbours = params.FTOC.list_of_neighbours;
    color = 'b';
    num_points = params.FTOC.numpoints;
    takeout = params.FTOC.takeout;
    list_of_points = setdiff(1:num_points,takeout);
    sets_of_intersections = params.FTOC.sets_of_intersections;
    
    figure(201)
    set(gcf,'Color',[1 1 1]);
    set(gcf,'InvertHardCopy','off');
    clf

  %FTOC Field       
   subplot(4,2,1)
   plot(zeros(101,1),-50:50,'Color',[0.7 0.7 0.7], 'Linewidth',1)
   hold on
   plot(-50:50,zeros(101,1),'Color',[0.7 0.7 0.7], 'Linewidth',1)

%   plot(field_coords(:,1),field_coords(:,2),'o','Color',[0.2 0.2 0.2],'MarkerFaceColor',[0.2 0.2 0.2],'MarkerSize',10); 
   plot(field_coords(:,1),field_coords(:,2),'o','Color','k','MarkerFaceColor','k','MarkerSize',10); 
   text(field_coords(:,1),field_coords(:,2),num2str(list_of_points(:)),'Color',[1 1 1],'HorizontalAlignment','Center','FontSize',8,'FontWeight','bold');

   plot(-45:-26,ones(20,1).*45,'k', 'LineWidth',3)%scale bar
   hold off

   axis ij
   axis([-50 50 -50 50]);
   set(gca,'PlotBoxAspectRatio',[1 1 1]);
   axis off

   %FTOC Coll
   subplot(4,2,2)
%  plot(coll_coords(:,1),coll_coords(:,2),'o','Color',[0.2 0.2 0.2],'MarkerFaceColor',[0.2 0.2 0.2],'MarkerSize',10);
   plot(coll_coords(:,1),coll_coords(:,2),'o','Color','k','MarkerFaceColor','k','MarkerSize',10);
   hold on

  ellipse(params.ellipse.ra,params.ellipse.rb,params.ellipse.ang,params.ellipse.x0,params.ellipse.y0,'k');

   text(coll_coords(:,1),coll_coords(:,2),num2str(list_of_points(:)),'Color',[1 1 1],'HorizontalAlignment','Center','FontSize',8,'FontWeight','bold');

   hold on
   plot(xmean_coll-65:xmean_coll-38,ones(28,1).*ymean_coll+65,'k', 'LineWidth',3)%scale bar
   axis ij
   axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
   set(gca,'PlotBoxAspectRatio',[1 1 1]);
   axis off

 

   %FTOC Field
   subplot(4,2,3)
   plot(zeros(101,1),-50:50,'Color',[0.7 0.7 0.7], 'Linewidth',1)
   hold on
   plot(-50:50,zeros(101,1),'Color',[0.7 0.7 0.7], 'Linewidth',1)

%   plot(field_coords(:,1),field_coords(:,2),'o','Color',[0.2 0.2 0.2],'MarkerFaceColor',[0.2 0.2 0.2],'MarkerSize',10); 
   plot(field_coords(:,1),field_coords(:,2),'o','Color','k','MarkerFaceColor','k','MarkerSize',10); 
   numpoints= length(list_of_points);

   print_links(list_of_points, field_coords, list_of_neighbours, 'k');
   [cross_points,list_of_crossings] = make_cross_list(list_of_points,sets_of_intersections);
   text(field_coords(:,1),field_coords(:,2),num2str(list_of_points(:)),'Color',[1 1 1],'HorizontalAlignment','Center','FontSize',8,'FontWeight','bold');

   hold off
   axis ij
   axis([-50 50 -50 50]);
   set(gca,'PlotBoxAspectRatio',[1 1 1]);
   axis off

   %FTOC Coll
   subplot(4,2,4)
   print_links(list_of_points, coll_coords, list_of_neighbours, 'k');
   hold on

  ellipse(params.ellipse.ra,params.ellipse.rb,params.ellipse.ang,params.ellipse.x0,params.ellipse.y0,'k');
   plot(coll_coords(:,1),coll_coords(:,2),'o','Color','k','MarkerFaceColor','k','MarkerSize',10);
   text(coll_coords(:,1),coll_coords(:,2),num2str(list_of_points(:)),'Color',[1 1 1],'HorizontalAlignment','Center','FontSize',8,'FontWeight','bold');

   hold off
   axis ij
   axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
   set(gca,'PlotBoxAspectRatio',[1 1 1]);
   axis off

  %FTOC Field
   subplot(4,2,5)
   plot(zeros(101,1),-50:50,'Color',[0.7 0.7 0.7], 'Linewidth',1)
   hold on
   plot(-50:50,zeros(101,1),'Color',[0.7 0.7 0.7], 'Linewidth',1)

   print_links(list_of_points, field_coords, list_of_neighbours, 'k');
   [cross_points,list_of_crossings] = make_cross_list(list_of_points,sets_of_intersections);
   print_links(cross_points, field_coords, list_of_crossings, 'r');

%   plot(field_coords(:,1),field_coords(:,2),'o','Color',[0.2 0.2 0.2],'MarkerFaceColor',[0.2 0.2 0.2],'MarkerSize',10); 
   plot(field_coords(:,1),field_coords(:,2),'o','Color','k','MarkerFaceColor','k','MarkerSize',10); 
   anchors = plot_anchors10(field_coords,ancnums,anclabels);

   text(field_coords(:,1),field_coords(:,2),num2str(list_of_points(:)),'Color',[1 1 1],'HorizontalAlignment','Center','FontSize',8,'FontWeight','bold');

   hold off
   axis ij
   axis([-50 50 -50 50]);
   set(gca,'PlotBoxAspectRatio',[1 1 1]);
   axis off


   %FTOC Coll
   subplot(4,2,6)
   print_links(list_of_points, coll_coords, list_of_neighbours, 'k');
   hold on

  ellipse(params.ellipse.ra,params.ellipse.rb,params.ellipse.ang,params.ellipse.x0,params.ellipse.y0,'k');
  [cross_points,list_of_crossings] = make_cross_list(list_of_points,sets_of_intersections);
   print_links(cross_points, coll_coords, list_of_crossings, 'r');

   plot(coll_coords(:,1),coll_coords(:,2),'o','Color','k','MarkerFaceColor','k','MarkerSize',10);
   plot_anchors10(coll_coords,ancnums,anclabels);

   text(coll_coords(:,1),coll_coords(:,2),num2str(list_of_points(:)),'Color',[1 1 1],'HorizontalAlignment','Center','FontSize',8,'FontWeight','bold');

   hold off
   axis ij
   axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
   set(gca,'PlotBoxAspectRatio',[1 1 1]);
   axis off  

 %FTOC Field - largest ordered subgraph
   list_of_points = params.FTOC.points_in_subgraph;
   absent_points = params.FTOC.points_not_in_subgraph;

   subplot(4,2,7)
   plot(zeros(101,1),-50:50,'Color',[0.7 0.7 0.7], 'Linewidth',1)
   hold on
   plot(-50:50,zeros(101,1),'Color',[0.7 0.7 0.7], 'Linewidth',1)

   print_links(list_of_points, field_coords, list_of_neighbours, 'k');
   [cross_points,list_of_crossings] = make_cross_list(list_of_points,sets_of_intersections);
   print_links(cross_points, field_coords, list_of_crossings, 'r');

%   plot(field_coords(:,1),field_coords(:,2),'o','Color',[0.2 0.2 0.2],'MarkerFaceColor',[0.2 0.2 0.2],'MarkerSize',10); 

   plot(field_coords(list_of_points(:),1),field_coords(list_of_points(:),2),'o','Color','k','MarkerFaceColor','k','MarkerSize',10); 

   plot(field_coords(absent_points(:),1),field_coords(absent_points(:),2),'x','Color','r','MarkerFaceColor','r','MarkerSize',10); 
   anchors = plot_anchors10(field_coords,ancnums,anclabels);

   text(field_coords(list_of_points(:),1),field_coords(list_of_points(:),2),num2str(list_of_points(:)),'Color',[1 1 1],'HorizontalAlignment','Center','FontSize',8,'FontWeight','bold');

   hold off
   axis ij
   axis([-50 50 -50 50]);
   set(gca,'PlotBoxAspectRatio',[1 1 1]);
   axis off


   %FTOC Coll
   subplot(4,2,8)
   print_links(list_of_points, coll_coords, list_of_neighbours, 'k');
   hold on

  ellipse(params.ellipse.ra,params.ellipse.rb,params.ellipse.ang,params.ellipse.x0,params.ellipse.y0,'k');
  [cross_points,list_of_crossings] = make_cross_list(list_of_points,sets_of_intersections);
   print_links(cross_points, coll_coords, list_of_crossings, 'r');

%   plot(coll_coords(:,1),coll_coords(:,2),'o','Color','k','MarkerFaceColor','k','MarkerSize',10);
   plot(coll_coords(list_of_points(:),1),coll_coords(list_of_points(:),2),'o','Color','k','MarkerFaceColor','k','MarkerSize',10);
   plot(coll_coords(absent_points(:),1),coll_coords(absent_points(:),2),'x','Color','r','MarkerFaceColor','r','MarkerSize',10);
   plot_anchors10(coll_coords,ancnums,anclabels);

   text(coll_coords(list_of_points(:),1),coll_coords(list_of_points(:),2),num2str(list_of_points(:)),'Color',[1 1 1],'HorizontalAlignment','Center','FontSize',8,'FontWeight','bold');

   hold off
   axis ij
   axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
   set(gca,'PlotBoxAspectRatio',[1 1 1]);
   axis off  
end

   figure(201)
   orient tall
   filename = [num2str(params.id),'_fig201.pdf'];
   print(201,'-dpdf',filename)
   
         
   
   
