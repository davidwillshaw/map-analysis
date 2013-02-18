function [] = plot_figure6(params,direction,ectlines)
%  Changes incorporated from Dplot_figure6.m:
%  for FTOC ONLY
%  (i) ectopics marked in the subgraph plot in green
%  (ii) extent of ectopic projections shown + line (option)

  if ~exist('ectlines')
    ectlines = 0;
  end
  
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
%D      inserted details of the ectopics
	ectopics=params.FTOC.stats.ectopics;
        major_projection = params.FTOC.major_projection;
        minor_projection = params.FTOC.minor_projection;
	mean_projection = params.FTOC.mean_projection;
        coll_coords = params.FTOC.coll_points;

        field_coords = params.FTOC.field_points;
%    FIX   20 Dec 2011
        points_in_subgraph = params.FTOC.points_in_subgraph
        points_in_subgraph = setdiff(params.FTOC.points_in_subgraph,ectopics)

        list_of_neighbours = params.FTOC.list_of_neighbours;
        num_points = params.FTOC.numpoints;
        color = 'k';
        sets_of_intersections = params.FTOC.sets_of_intersections;
        points_not_in_subgraph = params.FTOC.points_not_in_subgraph;
    end

    figure(6) 
    clf
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
   plot(field_coords(points_not_in_subgraph,1),field_coords(points_not_in_subgraph,2),'xr');

%D   plot ectopics in green
   plot(field_coords(ectopics,1),field_coords(ectopics,2),'xg');

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
%   plot(coll_coords(setdiff(points_not_in_subgraph,ectopics),1),coll_coords(setdiff(points_not_in_subgraph,ectopics),2),'xr');
   plot(coll_coords(points_not_in_subgraph,1),coll_coords(points_not_in_subgraph,2),'xr')

%D   plot ectopics in green
%D   Also show extent on colliculus

   plot(mean_projection(ectopics,1),mean_projection(ectopics,2),'xg');
    for i = 1:size(major_projection)
        if ismember(i,ectopics)
           plot(major_projection(i,1),major_projection(i,2),'go','MarkerSize',6)
           hold on
           plot(minor_projection(i,1),minor_projection(i,2),'go', 'MarkerSize',3)
        end
    end
    
    if ectlines==1   
    line([minor_projection(ectopics,1)';major_projection(ectopics,1)'],[minor_projection(ectopics,2)'; major_projection(ectopics,2)'],'Color','g','LineWidth',1);
    end
%D-----------------------------------------------------------------------------------------------------------------------------------------------------

   [cross_points,list_of_crossings] = make_cross_list(points_in_subgraph,sets_of_intersections);
   print_links(cross_points, coll_coords, list_of_crossings, 'r');
   plot_anchors(coll_coords,params.anchors,anchors);
   axis ij
   axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[xmean_coll-70,xmean_coll-70+56,xmean_coll-70+112] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[ymean_coll-70,ymean_coll-70+56,ymean_coll-70+112] ,'YTickLabel',{'0','0.5','1'})
    title('Colliculus');
    
     figure(6)
     orient tall
    filename = [num2str(params.id),'_fig6.pdf'];
    print(6,'-dpdf',filename)
