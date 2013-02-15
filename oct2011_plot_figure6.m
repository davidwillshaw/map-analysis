function [] = plot_figure6(params,direction)
    
    
    xmean_coll = params.ellipse.x0;
    ymean_coll = params.ellipse.y0;
    if strcmp(direction,'CTOF')
        coll_coords = params.CTOF.coll_points;
        field_coords = params.CTOF.field_points;
        points_in_subgraph = params.CTOF.points_in_subgraph;
        list_of_neighbours = params.CTOF.list_of_neighbours;
        num_points = params.CTOF.numpoints;
        color = 'b';
        sets_of_intersections = params.CTOF.sets_of_intersections;
        points_not_in_subgraph = params.CTOF.points_not_in_subgraph;
    end
    
    if strcmp(direction,'FTOC')
        coll_coords = params.FTOC.coll_points;
        field_coords = params.FTOC.field_points;
        points_in_subgraph = params.FTOC.points_in_subgraph;
        list_of_neighbours = params.FTOC.list_of_neighbours;
        num_points = params.FTOC.numpoints;
        color = 'k';
        sets_of_intersections = params.FTOC.sets_of_intersections;
        points_not_in_subgraph = params.FTOC.points_not_in_subgraph;
    end

    figure(6) 
  %Field  
   subplot(2,2,1)
   plot(zeros(101,1),-50:50,'Color',[0.7 0.7 0.7], 'Linewidth',1)
   hold on
   plot(-50:50,zeros(101,1),'Color',[0.7 0.7 0.7], 'Linewidth',1)
   print_links(1:num_points, field_coords, list_of_neighbours, color);
   hold on
   [cross_points,list_of_crossings] = make_cross_list(1:num_points,sets_of_intersections);
   print_links(cross_points, field_coords, list_of_crossings, 'r');
   anchors = plot_anchors(field_coords,params.anchors,50:58);
   plot(-45:-26,ones(20,1).*45,'k', 'LineWidth',3)%scale bar
   axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1]);
   axis([-50 50 -50 50]);
   axis off
   title('Field');
   
   %Coll
   subplot(2,2,2)
   print_links(1:num_points, coll_coords, list_of_neighbours, color);
   hold on
   [cross_points,list_of_crossings] = make_cross_list(1:num_points,sets_of_intersections);
   print_links(cross_points, coll_coords, list_of_crossings, 'r');
   plot_anchors(coll_coords,params.anchors,anchors);
   plot(xmean_coll-65:xmean_coll-38,ones(28,1).*ymean_coll+65,'k', 'LineWidth',3)%scale bar
   axis ij
   axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
   set(gca,'PlotBoxAspectRatio',[1 1 1])
   axis off
   title('Colliculus');
    
    %submap
    
   subplot(2,2,3)
   plot(zeros(101,1),-50:50,'Color',[0.7 0.7 0.7], 'Linewidth',1)
   hold on
   plot(-50:50,zeros(101,1),'Color',[0.7 0.7 0.7], 'Linewidth',1)
   print_links(points_in_subgraph, field_coords, list_of_neighbours, color);
   hold on

   plot(field_coords(points_not_in_subgraph,1),field_coords(points_not_in_subgraph,2),'or','MarkerFaceColor',
'r', 'MarkerSize',1)

   
   [cross_points,list_of_crossings] = make_cross_list(points_in_subgraph,sets_of_intersections);
   print_links(cross_points, field_coords, list_of_crossings, 'r');
   plot_anchors(field_coords,params.anchors,anchors);
   axis ij
   axis([-50 50 -50 50]);
   set(gca,'PlotBoxAspectRatio',[1 1 1])
   axis off
    
    
    subplot(2,2,4)
    print_links(points_in_subgraph, coll_coords, list_of_neighbours, color);
   hold on
   plot(coll_coords(points_not_in_subgraph,1),coll_coords(points_not_in_subgraph,2),'or','MarkerFaceColor', 'r', 'MarkerSize',1)
   [cross_points,list_of_crossings] = make_cross_list(points_in_subgraph,sets_of_intersections);
   print_links(cross_points, coll_coords, list_of_crossings, 'r');
   plot_anchors(coll_coords,params.anchors,anchors);
   axis ij
    axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
   set(gca,'PlotBoxAspectRatio',[1 1 1])
   axis off
    
     figure(6)
    filename = [num2str(params.id),'_fig6.pdf'];
    print(6,'-dpdf',filename)
