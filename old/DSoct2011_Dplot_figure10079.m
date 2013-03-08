function fig = DSoct2011_Dplot_figure10079(params,direction,ectoptions,anclabels,ancsize,obj)

%  similar to plot_figure10006.m except that
%  for FTOC ONLY
%  (i) ectopics marked in the subgraph plot in blue crosses
%  (ii) options shown by value of ectoptions:
%  ectoptions = 0: no options shown; ectopics shown in red
%  ectoptions = 1: mean positions of ectopics shown in blue
%  ectoptions = 2: as (1) and major and minor extents of ectopics also shown
%  ectoptions = 3: as (1) and extents of ectopics shown as a line only
%  ectoptions = 4: (2) and (3) combined

% JH: First row commented out.
  
%  (iii) also anchors can be any specified numbered points (anclabels)

%   (iv) size of anchors can be specified
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
    %D      inserted details of the ectopics  FUDGED here
    %	ectopics=params.FTOC.stats.ectopics;
    ectopics =[];
    %        major_projection = params.FTOC.major_projection;
    %        minor_projection = params.FTOC.minor_projection;
    %	mean_projection = params.FTOC.mean_projection;
    
    coll_coords = params.FTOC.coll_points;
    field_coords = params.FTOC.field_points;
    points_in_subgraph = params.FTOC.points_in_subgraph;
    list_of_neighbours = params.FTOC.list_of_neighbours;
    num_points = params.FTOC.numpoints;
    color = 'k';
    sets_of_intersections = params.FTOC.sets_of_intersections;
    points_not_in_subgraph = params.FTOC.points_not_in_subgraph;
    
    % !!! Why are there minus before angles?
    angles = -params.FTOC.angles; 
    norm_links = params.FTOC.norm_links;
    flipped_links = params.FTOC.flipped_links;
    subgraph_angles = -params.FTOC.subgraph_angles;
    
  end
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  %    anclabels = intersect(anclabels, points_in_subgraph);
  ancnums=length(anclabels);
  
  fig = figure('visible','off');
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  % Non-used old figures...
  
  %Retina  
  
  if(0)
    subplot(2,2,1)
    
    print_links(1:num_points, field_coords, list_of_neighbours, color);
    hold on
    [cross_points,list_of_crossings] = make_cross_list(1:num_points,sets_of_intersections);
    print_links(cross_points, field_coords, list_of_crossings, 'r');
    anchors = Dplot_anchors(field_coords,ancnums,anclabels,ancsize);
    
    
    %   axis ij
    set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'});
    axis([0 1 0 1]);
    
    
    %Coll
    subplot(2,2,2)
    print_links(1:num_points, coll_coords, list_of_neighbours, color);
    hold on
    [cross_points,list_of_crossings] = make_cross_list(1:num_points,sets_of_intersections);
    print_links(cross_points, coll_coords, list_of_crossings, 'r');
    Dplot_anchors(coll_coords,ancnums,anclabels,ancsize);
    
    %    axis ij
    set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'});
    axis([0 1 0 1]);
  end
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  % Plotted figures
  
  %submap
  subplot(1,3,1)
  hold on
  v = linspace(0,2*pi,100);
  plot(0.5*cos(v)+0.5,0.5*sin(v)+0.5,'-','color',[1 1 1]*0.6);

  print_links(points_in_subgraph, field_coords, list_of_neighbours, color);
  hold on
  %   plot(field_coords(points_not_in_subgraph,1),field_coords(points_not_in_subgraph,2),'or','MarkerFaceColor', 'r', 'MarkerSize',1);
  
  if ectoptions ==0
    plot(field_coords(points_not_in_subgraph,1),field_coords(points_not_in_subgraph,2),'xr');
  end
  
  [cross_points,list_of_crossings] = make_cross_list(points_in_subgraph,sets_of_intersections);
  print_links(cross_points, field_coords, list_of_crossings, 'r');
  Dplot_anchors(field_coords,ancnums,anclabels,ancsize);
  %  plot(field_coords(ectopics,1),field_coords(ectopics,2),'xg','MarkerFaceColor','B', 'MarkerSize',1);
  
  if ectoptions ==1 |ectoptions ==2 |ectoptions ==3 | ectoptions ==4
    sd = setdiff(points_not_in_subgraph,ectopics);
    plot(field_coords(sd,1),field_coords(sd,2),'xr');
    plot(field_coords(ectopics,1),field_coords(ectopics,2),'o','Color',[0 0 1]);
  end
  
  
  %   axis ij
  set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'});
  axis([0 1 0 1]);
  set(gca,'xdir','reverse','ydir','reverse');
  %xlabel('Temporal - Nasal','fontsize',24)
  %ylabel('Ventral - Dorsal','fontsize',24)
  set(gca,'xtick',[0.1 0.9],'xticklabel',{'N','T'});
  set(gca,'ytick',[0.1 0.9],'yticklabel',{'D','V'});
  set(gca,'ticklength', [0 0]);
  
  set(gca,'fontsize',30);
  
  box off

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  subplot(1,3,2)
  hold on
  idxS = convhull(obj.SCap,obj.SCml);
  plot(obj.SCap(idxS),obj.SCml(idxS),'-','color',[1 1 1]*0.6);
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
  
  %   axis ij
  set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'});
  axis([0 1 0 1]);
  %xlabel('Anterior - Posterior','fontsize',24)
  %ylabel('Medial - Lateral','fontsize',24)
  set(gca,'xtick',[0.1 0.9],'xticklabel',{'A','P'});
  set(gca,'ytick',[0.1 0.9],'yticklabel',{'M','L'});
  set(gca,'ticklength', [0 0]);        
  set(gca,'fontsize',30)
  
  box off
  % There is overlap between norm links and flipped links!
  subplot(1,3,3)
  circ_plot(angles(norm_links>0),'hist','k',40,false,true,'linewidth',2,'color','k');
  hold on
  circ_plot(angles(flipped_links>0),'hist','r',40,false,true,'linewidth',2,'color','r');

  title(params.datalabel); 
  
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  filename = [num2str(params.id),'_fig10079.pdf'];
  print(fig,'-dpdf',filename)
  
  
end