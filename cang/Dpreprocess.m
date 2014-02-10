function params = Dpreprocess(params)
% DPREPROCESS - preprocess Cang's experimental data
%   

disp(['Loading data ',num2str(params.id), '...'])
params = load_data(params);

params = find_active_pixels(params);
params = make_list_of_points(params); 
params = Dfind_map_quality(params)
params.stats.old_azim_dev=params.stats.azim_dev;
params.stats.old_elev_dev=params.stats.elev_dev;

%            HIGH SCATTER POINTS REMOVED
params = Dremove_high_scatter(params);

%params.prefiltered_active_pixels = params.active_pixels;
%params.num_active_pixels = length(find(params.active_pixels == 1));
%params.stats.num_active_pixels = length(find(params.active_pixels == 1));
%params.percent_hi_scatter_removed = 0;


params = make_list_of_points(params); 
params = Dfind_map_quality(params)
