function [] = plot_figure1(id)

    params = getparams(id);
    params.CTOF.numpoints = 12;
    disp('Loading data...')
    params = load_data(params);
    params = find_active_pixels(params);
    params = make_list_of_points(params);
    disp('Selecting point positions...')
    params = select_point_positions(params,'CTOF');
    disp('Creating projection...')
    params = create_projection(params, 'CTOF');
    params = triangulation(params,'CTOF');
    disp('Finding crossings...')
    params = find_crossings(params, 'CTOF');
    [~, X_ELL, Y_ELL] = ellipse(params.ellipse.ra,params.ellipse.rb,params.ellipse.ang,params.ellipse.x0,params.ellipse.y0);
    list_of_points = 1:params.CTOF.numpoints;
    coll_points = params.CTOF.coll_points;
    field_points = params.CTOF.field_points;
    list_of_neighbours = params.CTOF.list_of_neighbours;
    
    figure(1)
    clf
    subplot(2,2,1)
    clrmap = 1-colormap(gray);
    colormap(clrmap)
    imagesc(params.elev_amp)
    hold on
    scatter(coll_points(:,1),coll_points(:,2),'w','filled','SizeData', 20)
    plot(X_ELL,Y_ELL,'w','LineWidth',1)
    plot(70:125,ones(56,1).*220,'k', 'LineWidth',3)%scale bar
    print_links(list_of_points, coll_points, list_of_neighbours, 'w')
    xlabel('<---Lateral------Medial (mm)--->','FontSize', 16)
    ylabel('<---Caudal------Rostral (mm)--->','FontSize', 16)
    axis ij
    set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[] ,'XTickLabel',{}, 'YTick',[] ,'YTickLabel',{},'clim', [0,2])
    axis([60, 230, 60, 230])
    
    subplot(2,2,2)
    clrmap = 1-colormap(gray);
    colormap(clrmap)
    imagesc(params.azim_amp)
    hold on
    plot(X_ELL,Y_ELL,'w','LineWidth',1)
    plot(70:125,ones(56,1).*220,'k', 'LineWidth',3)
    xlabel('<---Lateral------Medial (mm)--->','FontSize', 16)
    ylabel('<---Caudal------Rostral (mm)--->','FontSize', 16)
    axis ij
    set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[] ,'XTickLabel',{}, 'YTick',[] ,'YTickLabel',{},'clim', [0,2])
    axis([60, 230, 60, 230])
    
    subplot(2,2,4)
    new_map(:,:,2) = (params.elev_phase./100)+0.5;
    new_map(:,:,1) = (params.azim_phase./100)+0.5;
    new_map(:,:,3) = (-params.azim_phase./100)+0.5;
    new_map(new_map<0) = 0;
    new_map(new_map>1) = 1;
    image(new_map)
    hold on
    scatter(coll_points(:,1),coll_points(:,2),'w','filled','SizeData', 20)
    plot(X_ELL,Y_ELL,'w','LineWidth',1)
    print_links(list_of_points, coll_points, list_of_neighbours, 'w')
    [cross_points,list_of_crossings] = make_cross_list(list_of_points,params.CTOF.sets_of_intersections);
    print_links(cross_points, coll_points, list_of_crossings, 'r');
   
    xlabel('<--------Lateral--------Medial (mm)-------->','FontSize', 16);
    ylabel('<--------Caudal--------Rostral (mm)-------->','FontSize', 16);
    xlim([1 250]);
    ylim([1 250]);
    title('Elevation activity', 'FontSize',16)
    set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[] ,'XTickLabel',{}, 'YTick',[] ,'YTickLabel',{})
    axis([60, 230, 60, 230])
    plot(70:125,ones(56,1).*220,'w', 'LineWidth',3)
    
    axis ij
    
    subplot(2,2,3)
    print_links(list_of_points, field_points, list_of_neighbours, 'k')
    hold on
    [cross_points,list_of_crossings] = make_cross_list(list_of_points,params.CTOF.sets_of_intersections);
    print_links(cross_points, field_points, list_of_crossings, 'r');
  
    for i = 1:size(field_points)
        plot(field_points(i,1),field_points(i,2),'ko','MarkerFaceColor', get_colour(field_points(i,1),field_points(i,2)), 'MarkerSize',6)
        hold on
    end
    xlim([-30, 26])
    ylim([-35, 21])
    axis ij
    xlabel('<----Inferior----Superior (Degrees)---->','FontSize', 16);
    ylabel('<----Temporal----Nasal (Degrees)---->','FontSize', 16);
    set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[-20, 0, 20], 'YTick', [-20,0,20])

    figure(1)
    orient tall
    filename = [num2str(id),'_fig1.pdf'];
    print(1,'-dpdf',filename)