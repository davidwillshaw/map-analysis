function [] = plot_figure2(params)

    xmean_coll = params.ellipse.x0;
    ymean_coll = params.ellipse.y0;

%FTOC
        field_coords = params.FTOC.field_points;
        coll_coords = params.FTOC.coll_points;
        list_of_neighbours = params.FTOC.list_of_neighbours;
        color = 'k';
        num_points = params.FTOC.numpoints;
        takeout = params.FTOC.takeout;
        list_of_points = setdiff(1:num_points,takeout);
        sets_of_intersections = params.FTOC.sets_of_intersections;
    
    figure(2)
 
   %FTOC Field
   subplot(2,3,1)
   print_links(list_of_points, field_coords, list_of_neighbours, color);
   hold on
   [cross_points,list_of_crossings] = make_cross_list(list_of_points,sets_of_intersections);
   print_links(cross_points, field_coords, list_of_crossings, 'r');
   anchors = plot_anchors(field_coords,params.anchors,[]);
   axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[-50,0,50] ,'XTickLabel',{'-50','0','50'}, 'YTick',[-50,0,50] ,'YTickLabel',{'-50','0','50'})
   axis([-50 50 -50 50]);
   title('Field');
   
   %FTOC Coll
   subplot(2,3,2)
   print_links(list_of_points, coll_coords, list_of_neighbours, color);
   hold on
   [cross_points,list_of_crossings] = make_cross_list(list_of_points,sets_of_intersections);
   print_links(cross_points, coll_coords, list_of_crossings, 'r');
   plot_anchors(coll_coords,params.anchors,anchors);
   axis ij
   axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[xmean_coll-70,xmean_coll-70+56,xmean_coll-70+112] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[ymean_coll-70,ymean_coll-70+56,ymean_coll-70+112] ,'YTickLabel',{'0','0.5','1'})
    title('Colliculus');
   
   
   %FTOC circ_plot
   subplot(2,3,3)
   angles = params.FTOC.angles;
   norm_links = params.FTOC.norm_links;
   flipped_links = params.FTOC.flipped_links;
   circ_plot(angles(norm_links>0),'hist',color,40,false,true,'linewidth',2,'color',color)
   hold on
   circ_plot(angles(flipped_links>0),'hist','r',40,false,true,'linewidth',2,'color','r')
    title(params.datalabel);    
   
   %CTOF
        coll_coords = params.CTOF.coll_points;
        field_coords = params.CTOF.field_points;
        list_of_neighbours = params.CTOF.list_of_neighbours;
        color = 'b';
        num_points = params.CTOF.numpoints;
        takeout = params.CTOF.takeout;
        list_of_points = setdiff(1:num_points,takeout);
        sets_of_intersections = params.CTOF.sets_of_intersections;
        
        
   %CTOF Field
   subplot(2,3,4)
   print_links(list_of_points, field_coords, list_of_neighbours, color);
   hold on
   [cross_points,list_of_crossings] = make_cross_list(list_of_points,sets_of_intersections);
   print_links(cross_points, field_coords, list_of_crossings, 'r');
   anchors = plot_anchors(field_coords,params.anchors,[]);
   axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[-50,0,50] ,'XTickLabel',{'-50','0','50'}, 'YTick',[-50,0,50] ,'YTickLabel',{'-50','0','50'})
   axis([-50 50 -50 50]);

   
   %CTOF Coll
   subplot(2,3,5)
   print_links(list_of_points, coll_coords, list_of_neighbours, color);
   hold on
   [cross_points,list_of_crossings] = make_cross_list(list_of_points,sets_of_intersections);
   print_links(cross_points, coll_coords, list_of_crossings, 'r');
   plot_anchors(coll_coords,params.anchors,anchors);
   axis ij
   axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[xmean_coll-70,xmean_coll-70+56,xmean_coll-70+112] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[ymean_coll-70,ymean_coll-70+56,ymean_coll-70+112] ,'YTickLabel',{'0','0.5','1'})

   
   %CTOF circ_plot
   subplot(2,3,6)
   angles = params.CTOF.angles;
   norm_links = params.CTOF.norm_links;
   flipped_links = params.CTOF.flipped_links;
   circ_plot(angles(norm_links>0),'hist',color,40,false,true,'linewidth',2,'color',color)
   hold on
   circ_plot(angles(flipped_links>0),'hist','r',40,false,true,'linewidth',2,'color','r')
   

   
         
   
   
