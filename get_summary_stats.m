function summary_stats = get_summary_stats()

    datasets = [6, 10, 15, 73, 80, 155, 156, 163, 165, 262, ... 
        82, 84, 94, 161, 162, 4, 54, 55, 56, 58];
    
    num_datasets = length(datasets);
    summary_stats = zeros(num_datasets,40);
    
    for i = 1:num_datasets
        clear params
        id = datasets(i);
        params = run_data(id);
        summary_stats(i,1) = id;
        %FTOC
        summary_stats(i,2) = params.FTOC.numpoints; 
        %mag factor
        summary_stats(i,3) = sqrt(params.stats.FTOC.field_area/params.stats.FTOC.coll_area);
        summary_stats(i,4) = params.stats.FTOC.link_length_mean_field;
        summary_stats(i,5) = params.stats.FTOC.link_length_std_field;
        summary_stats(i,6) = params.stats.FTOC.num_crossings/mean(params.stats.FTOC.baseline.num_crosses);
        summary_stats(i,7) = params.stats.FTOC.num_nodes_crossing/mean(params.stats.FTOC.baseline.num_nodes_crossing);
        %ordered submap
        summary_stats(i,8) = (params.stats.FTOC.num_nodes_in_subgraph - mean(params.stats.FTOC.baseline.num_nodes_in_submap))/(params.FTOC.numpoints - mean(params.stats.FTOC.baseline.num_nodes_in_submap));
        %full map orientation in degrees
        summary_stats(i,9) = params.stats.FTOC.map_orientation_mean*360/(2*pi);
        summary_stats(i,10) = params.stats.FTOC.map_orientation_std*360/(2*pi);
        summary_stats(i,11) = params.stats.FTOC.dispersion_angle*360/(2*pi);
        summary_stats(i,12) = params.stats.FTOC.dispersion_xrad;
        summary_stats(i,13) = params.stats.FTOC.dispersion_yrad;
        summary_stats(i,14) = params.stats.FTOC.scatter_mean_in;
        summary_stats(i,15) = params.stats.FTOC.scatter_mean_out;
        
        
        % ectopics
        summary_stats(i,16) = params.stats.num_ectopics;
        summary_stats(i,17) = params.stats.ect_dist_mean;
        summary_stats(i,18) = params.stats.ect_dist_std;
        
        if params.stats.num_ectopics >= 5
            summary_stats(i,19) = (params.stats.nodes_in_subgraph_major - mean(params.stats.FTOC.baseline.num_nodes_in_submap))/(params.FTOC.numpoints - mean(params.stats.FTOC.baseline.num_nodes_in_submap));
            summary_stats(i,20) = (params.stats.nodes_in_subgraph_minor - mean(params.stats.FTOC.baseline.num_nodes_in_submap))/(params.FTOC.numpoints - mean(params.stats.FTOC.baseline.num_nodes_in_submap));
            %major
            summary_stats(i,21) = params.stats.nodes_in_major/params.stats.num_ectopics;
            summary_stats(i,22) = params.stats.map_orientation_mean_major*360/(2*pi);
            summary_stats(i,23) = params.stats.map_orientation_std_major*360/(2*pi);
            %minor
            summary_stats(i,24) = params.stats.nodes_in_minor/params.stats.num_ectopics;
            summary_stats(i,25) = params.stats.map_orientation_mean_minor*360/(2*pi);
            summary_stats(i,26) = params.stats.map_orientation_std_minor*360/(2*pi);
        end
        %CTOF
        summary_stats(i,27) = params.CTOF.numpoints; 
        %mag factor
        summary_stats(i,28) = sqrt(params.stats.CTOF.field_area/params.stats.CTOF.coll_area);
        summary_stats(i,29) = params.stats.CTOF.link_length_mean_coll;
        summary_stats(i,30) = params.stats.CTOF.link_length_std_coll;
        summary_stats(i,31) = params.stats.CTOF.num_crossings/mean(params.stats.CTOF.baseline.num_crosses);
        summary_stats(i,32) = params.stats.CTOF.num_nodes_crossing/mean(params.stats.CTOF.baseline.num_nodes_crossing);
        %ordered submap
        summary_stats(i,33) = (params.stats.CTOF.num_nodes_in_subgraph - mean(params.stats.CTOF.baseline.num_nodes_in_submap))/(params.CTOF.numpoints - mean(params.stats.CTOF.baseline.num_nodes_in_submap));
        %full map orientation in degrees
        summary_stats(i,34) = params.stats.CTOF.map_orientation_mean*360/(2*pi);
        summary_stats(i,35) = params.stats.CTOF.map_orientation_std*360/(2*pi);
        summary_stats(i,36) = params.stats.CTOF.dispersion_angle*360/(2*pi);
        summary_stats(i,37) = params.stats.CTOF.dispersion_xrad;
        summary_stats(i,38) = params.stats.CTOF.dispersion_yrad;
        summary_stats(i,39) = params.stats.CTOF.scatter_mean_in;
        summary_stats(i,40) = params.stats.CTOF.scatter_mean_out;
    end
        
    csvwrite('summary_stats',summary_stats);