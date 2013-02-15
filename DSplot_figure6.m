function [] = DSplot_figure6(params,direction)
    

    if strcmp(direction,'CTOR')
        coll_coords = params.CTOR.coll_points;
        ret_coords = params.CTOR.ret_points;
        points_in_subgraph = params.CTOR.points_in_subgraph;
        list_of_neighbours = params.CTOR.list_of_neighbours;
        num_points = params.CTOR.numpoints;
        color = 'b';
        sets_of_intersections = params.CTOR.sets_of_intersections;
        points_not_in_subgraph = params.CTOR.points_not_in_subgraph;
    end
    
    if strcmp(direction,'RTOC')
        coll_coords = params.RTOC.coll_points;
        ret_coords = params.RTOC.ret_points;
        points_in_subgraph = params.RTOC.points_in_subgraph;
        list_of_neighbours = params.RTOC.list_of_neighbours;
        num_points = params.RTOC.numpoints;
        color = 'k';
        sets_of_intersections = params.RTOC.sets_of_intersections;
        points_not_in_subgraph = params.RTOC.points_not_in_subgraph;
    end

    figure(6) 
    clf
  %Retina
subplot(2,2,1)
   print_links(1:num_points, ret_coords, list_of_neighbours, color);
   hold on
   [cross_points,list_of_crossings] = make_cross_list(1:num_points,sets_of_intersections);
   print_links(cross_points, ret_coords, list_of_crossings, 'r');
   anchors = plot_anchors(ret_coords,params.anchors,[]);
   axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'})
   axis([0 1 0 1]);
   title('Retina');
   xlabel('Temporal-Nasal');
   ylabel('Ventral-Dorsal');
      
    %Coll
   subplot(2,2,2)
   print_links(1:num_points, coll_coords, list_of_neighbours, color);
   hold on
   [cross_points,list_of_crossings] = make_cross_list(1:num_points,sets_of_intersections);
   print_links(cross_points, coll_coords, list_of_crossings, 'r');
   plot_anchors(coll_coords,params.anchors,anchors);
   axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'})
   axis([0 1 0 1]);
    title('Colliculus');
   ylabel('Medial-Lateral');
   xlabel('Anterior-Posterior');        
    %submap
    
    subplot(2,2,3)
     print_links(points_in_subgraph, ret_coords, list_of_neighbours, color);
   hold on
   plot(ret_coords(points_not_in_subgraph,1),ret_coords(points_not_in_subgraph,2),'xr');

   [cross_points,list_of_crossings] = make_cross_list(points_in_subgraph,sets_of_intersections);
   print_links(cross_points, ret_coords, list_of_crossings, 'r');
   plot_anchors(ret_coords,params.anchors,anchors);
   axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'})
   axis([0 1 0 1]);
   title('Retina');
    xlabel('Temporal-Nasal');
    ylabel('Ventral-Dorsal');
       
    
    subplot(2,2,4)
    print_links(points_in_subgraph, coll_coords, list_of_neighbours, color);
   hold on
   plot(coll_coords(points_not_in_subgraph,1),coll_coords(points_not_in_subgraph,2),'xr')
   [cross_points,list_of_crossings] = make_cross_list(points_in_subgraph,sets_of_intersections);
   print_links(cross_points, coll_coords, list_of_crossings, 'r');
   plot_anchors(coll_coords,params.anchors,anchors);
   axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'})
   axis([0 1 0 1]);
    title('Colliculus');
   ylabel('Medial-Lateral');
   xlabel('Anterior-Posterior');    

     figure(6)
     orient tall
    filename = [num2str(params.id),'_fig6.pdf'];
    print(6,'-dpdf',filename)
