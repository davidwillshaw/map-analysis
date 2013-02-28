function summary_stats = Dget_summary_stats(datasets)
%NEED TO CHECK ALL UNITS
% for example, link_lengths not in right units

    if isempty(datasets)
        datasets = [6, 10, 15, 73, 80, 155, 156, 163, 165, 262, ... 
            82, 84, 94, 161, 162, 4, 54, 55, 56, 58];
    end
    
    num_datasets = length(datasets);
    summary_stats = zeros(num_datasets,40);

    degs=360/(2*pi);
    
    for i = 1:num_datasets
        clear params
        id = datasets(i);
        disp(id);
        params = Drun_data(id, 0);
        summary_stats(i,1) = id;

        coll.scale  = params.coll.scale;
        field.scale = params.field.scale;        

        %FTOC
        
        % Note 

        summary_stats(i,2) = params.FTOC.numpoints; 
	percent_mult=100/summary_stats(i,2);
        summary_stats(i,3) = params.percent_hi_scatter_removed;

        %mag factor
        summary_stats(i,4) = params.stats.FTOC.field_area;
        summary_stats(i,5) = params.stats.FTOC.coll_area;
        summary_stats(i,6) = sqrt(params.stats.FTOC.field_area/params.stats.FTOC.coll_area);
        summary_stats(i,7) = params.stats.FTOC.link_length_mean_field;
        summary_stats(i,8) = params.stats.FTOC.link_length_std_field;
        summary_stats(i,9) = params.stats.FTOC.min_link_length_mean_field;
        summary_stats(i,10) = params.stats.FTOC.min_link_length_std_field;
        summary_stats(i,11) = params.stats.FTOC.link_length_mean_coll;
        summary_stats(i,12) = params.stats.FTOC.link_length_std_coll;
        summary_stats(i,13) = params.stats.FTOC.min_link_length_mean_coll;
        summary_stats(i,14) = params.stats.FTOC.min_link_length_std_coll;
        summary_stats(i,15) = params.stats.FTOC.num_crossings;
        summary_stats(i,16) = params.stats.FTOC.num_nodes_crossing*percent_mult;

        %full map orientation in degrees
        summary_stats(i,17) = params.stats.FTOC.map_orientation_mean*degs;
        summary_stats(i,18) = params.stats.FTOC.map_orientation_std*degs;;
        summary_stats(i,19) = params.stats.FTOC.overall_dispersion_angle*degs;
        summary_stats(i,20) = params.stats.FTOC.overall_dispersion_xrad*coll.scale;
        summary_stats(i,21) = params.stats.FTOC.overall_dispersion_yrad*coll.scale;
        summary_stats(i,22) = params.stats.FTOC.dispersion_xrad*coll.scale;
        summary_stats(i,23) = params.stats.FTOC.dispersion_yrad*coll.scale;
        summary_stats(i,24)= params.stats.FTOC.SEM_xrad*coll.scale;
        summary_stats(i,25)= params.stats.FTOC.SEM_yrad*coll.scale;
        summary_stats(i,26) = params.stats.FTOC.scatter_mean_in*field.scale;
        summary_stats(i,27) = params.stats.FTOC.scatter_mean_out*coll.scale;

	% ordered subgraph 
        summary_stats(i,28) = params.stats.FTOC.num_nodes_in_subgraph*percent_mult;
        summary_stats(i,29) = params.stats.FTOC.mean_subgraph_angles*degs;
        summary_stats(i,30) = params.stats.FTOC.std_subgraph_angles*degs;
        summary_stats(i,31) = params.stats.FTOC.subgraph_overall_dispersion_angle*degs;
        summary_stats(i,32) = params.stats.FTOC.subgraph_dispersion_xrad*coll.scale;
        summary_stats(i,33) = params.stats.FTOC.subgraph_dispersion_yrad*coll.scale;
        summary_stats(i,34) = params.stats.FTOC.subgraph_SEM_xrad*coll.scale;
        summary_stats(i,35) = params.stats.FTOC.subgraph_SEM_yrad*coll.scale;

  
    	%baseline maps
        summary_stats(i,36) = mean(params.stats.FTOC.baseline.num_crosses);
        summary_stats(i,37) = mean(params.stats.FTOC.baseline.num_nodes_crossing)*percent_mult;        
        summary_stats(i,38) = mean(params.stats.FTOC.baseline.num_nodes_in_submap)*percent_mult;
        summary_stats(i,39) = params.stats.FTOC.lower_bound*percent_mult;

        % ectopics
        summary_stats(i,40) = params.stats.num_ectopics*percent_mult;
        summary_stats(i,41) = params.stats.ect_dist_mean*coll.scale;
        summary_stats(i,42) = params.stats.ect_dist_std*coll.scale;
%  43,44 already in degrees
        summary_stats(i,43) = params.FTOC.mean_ectopic_angles
        summary_stats(i,44) = params.FTOC.std_ectopic_angles

	number_of_ectopics(i) = params.stats.num_ectopics;
        if params.stats.num_ectopics >= 6
	% changed this number from 5 to fix an error in #73
            summary_stats(i,45) = params.stats.nodes_in_subgraph_major*percent_mult;
            summary_stats(i,46) = params.stats.nodes_in_subgraph_minor*percent_mult;
            %major
            summary_stats(i,47) = params.stats.nodes_in_major*percent_mult;
            summary_stats(i,48) = params.stats.map_orientation_mean_major;
            summary_stats(i,49) = params.stats.map_orientation_std_major;
            %minor
            summary_stats(i,50) = params.stats.nodes_in_minor*percent_mult;
            summary_stats(i,51) = params.stats.map_orientation_mean_minor;
            summary_stats(i,52) = params.stats.map_orientation_std_minor;
        end


        %CTOF

        summary_stats(i,53) = params.CTOF.numpoints; 
	percent_mult=100/summary_stats(i,53);
        summary_stats(i,54) = params.percent_hi_scatter_removed;

        %mag factor
        summary_stats(i,55) = params.stats.CTOF.field_area;
        summary_stats(i,56) = params.stats.CTOF.coll_area;
        summary_stats(i,57) = sqrt(params.stats.CTOF.field_area/params.stats.CTOF.coll_area);
        summary_stats(i,58) = params.stats.CTOF.link_length_mean_field;
        summary_stats(i,59) = params.stats.CTOF.link_length_std_field;
        summary_stats(i,60) = params.stats.CTOF.min_link_length_mean_field;
        summary_stats(i,61) = params.stats.CTOF.min_link_length_std_field;
        summary_stats(i,62) = params.stats.CTOF.link_length_mean_coll;
        summary_stats(i,63) = params.stats.CTOF.link_length_std_coll;
        summary_stats(i,64) = params.stats.CTOF.min_link_length_mean_coll;
        summary_stats(i,65) = params.stats.CTOF.min_link_length_std_coll;
        summary_stats(i,66) = params.stats.CTOF.num_crossings;
        summary_stats(i,67) = params.stats.CTOF.num_nodes_crossing*percent_mult;

        %full map orientation in degrees
        summary_stats(i,68) = params.stats.CTOF.map_orientation_mean*degs;
        summary_stats(i,69) = params.stats.CTOF.map_orientation_std*degs;
        summary_stats(i,70) = params.stats.CTOF.overall_dispersion_angle*degs;
        summary_stats(i,71) = params.stats.CTOF.overall_dispersion_xrad*field.scale;
        summary_stats(i,72) = params.stats.CTOF.overall_dispersion_yrad*field.scale;
        summary_stats(i,73) = params.stats.CTOF.dispersion_xrad*field.scale;
        summary_stats(i,74) = params.stats.CTOF.dispersion_yrad*field.scale;
        summary_stats(i,75) = params.stats.CTOF.SEM_xrad*field.scale;
        summary_stats(i,76) = params.stats.CTOF.SEM_yrad*field.scale;
        summary_stats(i,77) = params.stats.CTOF.scatter_mean_in*coll.scale;
        summary_stats(i,78) = params.stats.CTOF.scatter_mean_out*field.scale;

	% ordered subgraph & orientation
        summary_stats(i,79) = params.stats.CTOF.num_nodes_in_subgraph*percent_mult;
        summary_stats(i,80) = params.stats.CTOF.mean_subgraph_angles*degs;
        summary_stats(i,81) = params.stats.CTOF.std_subgraph_angles*degs;
        summary_stats(i,82) = params.stats.CTOF.subgraph_dispersion_xrad*field.scale;
        summary_stats(i,83) = params.stats.CTOF.subgraph_dispersion_yrad*field.scale;
        summary_stats(i,84) = params.stats.CTOF.subgraph_SEM_xrad*field.scale;
        summary_stats(i,85) = params.stats.CTOF.subgraph_SEM_yrad*field.scale;

	%baseline maps
        summary_stats(i,86) = mean(params.stats.CTOF.baseline.num_crosses);
        summary_stats(i,87) = mean(params.stats.CTOF.baseline.num_nodes_crossing)*percent_mult;        
        summary_stats(i,88) = mean(params.stats.CTOF.baseline.num_nodes_in_submap)*percent_mult;
        summary_stats(i,89) = params.stats.CTOF.lower_bound*percent_mult;
 
% Area of colliculus
        summary_stats(i,90) = params.ellipse.ra*params.ellipse.rb*pi*(8.9/1000)^2;
     end

% Means, STDs for full set of data
if num_datasets==20
       
        summary_stats(21,:) = mean(summary_stats([1:5],:));
        summary_stats(22,:) = std(summary_stats([1:5],:),1);
        summary_stats(23,:) = sqrt(mean(summary_stats([1:5],:).^2));

        summary_stats(24,:) = mean(summary_stats([6:10],:));
        summary_stats(25,:) = std(summary_stats([6:10],:),1);
        summary_stats(26,:) = sqrt(mean(summary_stats([6:10],:).^2));

        summary_stats(27,:) = mean(summary_stats([11:15],:),1);
        summary_stats(28,:) = std(summary_stats([11:15],:),1);
        summary_stats(29,:) = sqrt(mean(summary_stats([11:15],:).^2));

        summary_stats(30,:) = mean(summary_stats([16:20],:),1);
        summary_stats(31,:) = std(summary_stats([16:20],:),1);
        summary_stats(32,:) = sqrt(mean(summary_stats([16:20],:).^2));
end     
      
        csvwrite('summary_statsFTOC.csv',summary_stats(:,[1:52]));
        csvwrite('summary_statsCTOF.csv',summary_stats(:,[1,53:90]));
	csvwrite('number_of_ectopics.csv',number_of_ectopics(:));

% Local Variables:
% matlab-indent-level: 4
% End:
  