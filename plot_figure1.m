function [] = plot_figure1(id)

    params = getparams(id);
    params.CTOF.numpoints = 25;
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
    
    
    figure(1)
    clf
    subplot(1,3,1)
    clrmap = 1-colormap(gray);
    colormap(clrmap)
    imagesc(params.elev_amp)
    hold on