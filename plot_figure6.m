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
   print_links(1:num_points, field_coords, list_of_neighbours, color);
   hold on
   [cross_points,list_of_crossings] = make_cross_list(1:num_points,sets_of_intersections);
   print_links(cross_points, field_coords, list_of_crossings, 'r');
   anchors = plot_anchors(field_coords,params.anchors,[]);
   axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[-50,0,50] ,'XTickLabel',{'-50','0','50'}, 'YTick',[-50,0,50] ,'YTickLabel',{'-50','0','50'})
   axis([-50 50 -50 50]);
   title('Field');
   
    %Coll
   subplot(2,2,2)
   print_links(1:num_points, coll_coords, list_of_neighbours, color);
   hold on
   [cross_points,list_of_crossings] = make_cross_list(1:num_points,sets_of_intersections);
   print_links(cross_points, coll_coords, list_of_crossings, 'r');
   plot_anchors(coll_coords,params.anchors,anchors);
   axis ij
   axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[xmean_coll-70,xmean_coll-70+56,xmean_coll-70+112] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[ymean_coll-70,ymean_coll-70+56,ymean_coll-70+112] ,'YTickLabel',{'0','0.5','1'})
    title('Colliculus');
    
    %submap
    
    subplot(2,2,3)
     print_links(points_in_subgraph, field_coords, list_of_neighbours, color);
   hold on
   plot(field_coords(points_not_in_subgraph,1),field_coords(points_not_in_subgraph,2),'xr')
   [cross_points,list_of_crossings] = make_cross_list(points_in_subgraph,sets_of_intersections);
   print_links(cross_points, field_coords, list_of_crossings, 'r');
   plot_anchors(field_coords,params.anchors,anchors);
   axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[-50,0,50] ,'XTickLabel',{'-50','0','50'}, 'YTick',[-50,0,50] ,'YTickLabel',{'-50','0','50'})
   axis([-50 50 -50 50]);
   title('Field');
    
    
    subplot(2,2,4)
    print_links(points_in_subgraph, coll_coords, list_of_neighbours, color);
   hold on
   plot(coll_coords(points_not_in_subgraph,1),coll_coords(points_not_in_subgraph,2),'xr')
   [cross_points,list_of_crossings] = make_cross_list(points_in_subgraph,sets_of_intersections);
   print_links(cross_points, coll_coords, list_of_crossings, 'r');
   plot_anchors(coll_coords,params.anchors,anchors);
   axis ij
   axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[xmean_coll-70,xmean_coll-70+56,xmean_coll-70+112] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[ymean_coll-70,ymean_coll-70+56,ymean_coll-70+112] ,'YTickLabel',{'0','0.5','1'})
    title('Colliculus');
    
     figure(6)
    filename = [num2str(params.id),'_fig6.pdf'];
    print(6,'-dpdf',filename)