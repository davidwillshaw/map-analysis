function params = DSfind_ectopics(params)
% Hopefully principled criteria for finding ectopics
%  corrected a possible bug in determination of angles
%  ie  for angle like -170 add 180
% as these should be around +10 or so
    
    numpoints = params.RTOC.numpoints;
    ret_points = params.RTOC.ret_points;
    full_ret_coords = params.full_ret;
    full_coll_coords = params.full_coll;
    takeout = params.RTOC.takeout;
    radius = params.ret_radius;
    major_projection = params.RTOC.coll_points;
    minor_projection = zeros(numpoints,2);
    
    for point = 1:numpoints
        centre = ret_points(point,:);
        [~,projection_points] = find_projection(centre,radius,full_ret_coords,full_coll_coords);
        [IDX2, C2] = kmeans(projection_points,2, 'replicates',5);
        I1=find(IDX2==1);
        I2=find(IDX2==2);

        projection_points(I1,:);
        projection_points(I2,:);
        len1=length(I1);
        len2=length(I2);
	x_radius1=0;
	y_radius1=0;
	x_radius2=0;
	y_radius2=0;
	if len1>5
	   [dummy,x_radius1,y_radius1] = plot_error_ellipse(projection_points(I1,:));
	end
		
        if len2>5
	   [dummy,x_radius2,y_radius2] = plot_error_ellipse(projection_points(I2,:));
        end
        sd_1=max(x_radius1,y_radius1);
        sd_2=max(x_radius2,y_radius2);
        C2(1,:);
        C2(2,:);

       ddist= sqrt((C2(1,1)-C2(2,1))^2 + (C2(1,2)-C2(2,2))^2);


%        sd_1 = sqrt(sum(std(projection_points(I1,:)).^2));
%        sd_2 = sqrt(sum(std(projection_points(I2,:)).^2));

%        criteria for ectopics:
%        (i) have at least 6 points in each cluster
%        (ii)  distance between means  > summed standard deviations 
%        (iii) distance between means greater than 50 microns
%         if length(I1)>5 && length(I2)>5 && ddist > 1.1*(sd_1+sd_2) && ddist >6
         if length(I1)>5 && length(I2)>5 && ddist > 1.1*(sd_1+sd_2)
 	disp(['ectopic!']);
%        pause
         

            if length(I1)>=length(I2)
                major_projection(point,:) = C2(1,:);
                minor_projection(point,:) = C2(2,:);
            else
                major_projection(point,:) = C2(2,:);
                minor_projection(point,:) = C2(1,:);
            end
        end
    end
    
    [major_projection minor_projection, optimal_position] = find_best_position(ret_points,major_projection, minor_projection, takeout );

    II = find(minor_projection(:,1) > 0.01);
    tangents =(major_projection(II,2)-minor_projection(II,2))./(major_projection(II,1)-minor_projection(II,1));

%    adjust because of how axes are drawn

     ect_angles = -(90- atand(tangents));
      IA = find(ect_angles < -90);
	 ect_angles(IA) = ect_angles(IA) +180;

     ect_angles;
    params.RTOC.mean_ectopic_angles=mean(ect_angles);
    params.RTOC.std_ectopic_angles=std(ect_angles,1);

    params.RTOC.major_projection = major_projection;
    params.RTOC.minor_projection = minor_projection;
    params.RTOC.optimal_position = optimal_position;

    ect = find(minor_projection(:,1));
    params.stats.num_ectopics = length(ect);
    ect_dists = diag(dist(major_projection(ect,:),minor_projection(ect,:)'));
    params.stats.ect_dist_mean = mean(ect_dists);
    params.stats.ect_dist_std = std(ect_dists);
%D   added by David
    params.RTOC.stats.ectopics=ect;

            
            
       
    
