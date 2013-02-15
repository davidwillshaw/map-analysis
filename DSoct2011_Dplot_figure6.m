function [] = DSoct2011_Dplot_figure6(params,direction,ectoptions,anclabels,ancsize)
%  similar to plot_figure6.m except that
%  for RTOC ONLY
%  (i) ectopics marked in the subgraph plot in blue crosses
%  (ii) options shown by value of ectoptions:
%  ectoptions = 0: no options shown; ectopics shown in red
%  ectoptions = 1: mean positions of ectopics shown in blue
%  ectoptions = 2: as (1) and major and minor extents of ectopics also shown
%  ectoptions = 3: as (1) and extents of ectopics shown as a line only
%  ectoptions = 4: (2) and (3) combined

%  (iii) also anchors can be any specified numbered points (anclabels)

%   (iv) size of anchors can be specified


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
%D      inserted details of the ectopics
	ectopics=params.RTOC.stats.ectopics;
%
        major_projection = params.RTOC.major_projection;
        minor_projection = params.RTOC.minor_projection;
	mean_projection = params.RTOC.mean_projection;

        coll_coords = params.RTOC.coll_points;
        ret_coords = params.RTOC.ret_points;
        points_in_subgraph = params.RTOC.points_in_subgraph;
        list_of_neighbours = params.RTOC.list_of_neighbours;
        num_points = params.RTOC.numpoints;
        color = 'k';
        sets_of_intersections = params.RTOC.sets_of_intersections;
        points_not_in_subgraph = params.RTOC.points_not_in_subgraph;
    end


%    anclabels = intersect(anclabels, points_in_subgraph);
    ancnums=length(anclabels);

    figure(6)  
   clf
  %Retina  
   subplot(2,2,1)

   print_links(1:num_points, ret_coords, list_of_neighbours, color);
   hold on
   [cross_points,list_of_crossings] = make_cross_list(1:num_points,sets_of_intersections);
   print_links(cross_points, ret_coords, list_of_crossings, 'r');
   anchors = Dplot_anchors(ret_coords,ancnums,anclabels,ancsize);


   axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'});
   axis([0 1 0 1]);

   
   %Coll
   subplot(2,2,2)
   print_links(1:num_points, coll_coords, list_of_neighbours, color);
   hold on
   [cross_points,list_of_crossings] = make_cross_list(1:num_points,sets_of_intersections);
   print_links(cross_points, coll_coords, list_of_crossings, 'r');
   Dplot_anchors(coll_coords,ancnums,anclabels,ancsize);

    axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'});
   axis([0 1 0 1]);

 
   %submap
   subplot(2,2,3)

   print_links(points_in_subgraph, ret_coords, list_of_neighbours, color);
   hold on
%   plot(ret_coords(points_not_in_subgraph,1),ret_coords(points_not_in_subgraph,2),'or','MarkerFaceColor', 'r', 'MarkerSize',1);

if ectoptions ==0
   plot(ret_coords(points_not_in_subgraph,1),ret_coords(points_not_in_subgraph,2),'xr');
end

   [cross_points,list_of_crossings] = make_cross_list(points_in_subgraph,sets_of_intersections);
   print_links(cross_points, ret_coords, list_of_crossings, 'r');
   Dplot_anchors(ret_coords,ancnums,anclabels,ancsize);
%  plot(ret_coords(ectopics,1),ret_coords(ectopics,2),'xg','MarkerFaceColor','B', 'MarkerSize',1);

if ectoptions ==1 |ectoptions ==2 |ectoptions ==3 | ectoptions ==4
  sd = setdiff(points_not_in_subgraph,ectopics);
  plot(ret_coords(sd,1),ret_coords(sd,2),'xr');
  plot(ret_coords(ectopics,1),ret_coords(ectopics,2),'o','Color',[0 0 1]);
end


   axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'});
   axis([0 1 0 1]);

    
   subplot(2,2,4)
   print_links(points_in_subgraph, coll_coords, list_of_neighbours, color);
   hold on

%   plot(coll_coords(setdiff(points_not_in_subgraph,ectopics),1),coll_coords(setdiff(points_not_in_subgraph,ectopics),2),'or','MarkerFaceColor', 'r')

   plot(coll_coords(setdiff(points_not_in_subgraph,ectopics),1),coll_coords(setdiff(points_not_in_subgraph,ectopics),2),'xr');

if ectoptions ==1 |ectoptions == 2 |ectoptions == 3 | ectoptions ==4
  plot(coll_coords(ectopics,1),coll_coords(ectopics,2),'ob');
end

if ectoptions == 2 | ectoptions ==4
    for i = 1:size(major_projection)
        if ismember(i,ectopics)
           plot(major_projection(i,1),major_projection(i,2),'bo','MarkerSize',6,'MarkerFaceColor','b');
           hold on
           plot(minor_projection(i,1),minor_projection(i,2),'bo', 'MarkerSize',3,'MarkerFaceColor','b');
        end
    end
end

    if ectoptions==3 | ectoptions ==4   
%line([minor_projection(ectopics,1)';major_projection(ectopics,1)'],[minor_projection(ectopics,2)';major_projection(ectopics,2)'],'Color','b','LineWidth',1);
    line([minor_projection(ectopics,1)';major_projection(ectopics,1)'],[minor_projection(ectopics,2)'; major_projection(ectopics,2)'],'Color','b','LineWidth',0.5);
    end
%D-----------------------------------------------------------------------------------------------------------------------------------------------------

   [cross_points,list_of_crossings] = make_cross_list(points_in_subgraph,sets_of_intersections);
   print_links(cross_points, coll_coords, list_of_crossings, 'r');
   Dplot_anchors(coll_coords,ancnums,anclabels,ancsize);
   
   axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'});
   axis([0 1 0 1]);

    
     figure(6)
     orient tall
    filename = [num2str(params.id),'_fig6.pdf'];
    print(6,'-dpdf',filename)
