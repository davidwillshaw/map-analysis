function params = Dremove_high_scatter(params,thresh_scatter,minclustersize)
% Takes in a list of all active pixels
% Looks at each pixel and its surrounding pixels

% (1) Finds the associated scatter in the field

% (2) Using KMEANS look for two clusters
%     and in a similar way to ectopics check whether these are real

% (3) If there is a single cluster then
%     If scatter is greater than thresh_scatter
%     delete chosen pixel only

%  looks like first argument in active_pixels relates to 
%  second argument in coordinate lists

%                          SERIAL/PARALLEL UPDATE OF ACTIVITY MATRIX?

%                                     PARALLEL

percent_change =0;
if thresh_scatter < 999
    minclustersize2=2*minclustersize;
      
    active_pixels = params.active_pixels;
    new_active_pixels = params.active_pixels;
    I_start = find(active_pixels==1);
    length(I_start);
    numb_pixels_examined =0;
  
    from_coords = params.full_coll;
    to_coords = params.full_field;
    radius = params.coll_radius;
    num_pixels = length(params.full_coll);
    for nn = 1:num_pixels

    coll_pos = params.full_coll(nn,:);
    if round(active_pixels(from_coords(nn,2),from_coords(nn,1)))
        centre = from_coords(nn,:);

%             find collicular points near to chosen pixel
        distance_from_centre = sqrt((from_coords(:,1) - centre(1)).^2 + ...
       (from_coords(:,2) - centre(2)).^2);

        within_radius = distance_from_centre <= radius;
        from_points = from_coords(within_radius,:);
        to_points = to_coords(within_radius,:);

        [IDX2, C2] = kmeans(to_points,2, 'replicates',5);
        I1=find(IDX2==1);
        I2=find(IDX2==2);
	ddist =0;

	ll = length(to_points(:,1));
%              measuring two clusters if there are enough points
	if ll >= minclustersize2
	    to_points(I1,:);
            to_points(I2,:);
            len1=length(I1);
            len2=length(I2);
	    x_radius1=0;
	    y_radius1=0;
	    x_radius2=0;
	    y_radius2=0;
	    sd_1=100;
            sd_2=100;

	   if len1>=minclustersize
	      [dummy,x_radius1,y_radius1] = plot_error_ellipse(to_points(I1,:));
	   end
		
           if len2>=minclustersize
	      [dummy,x_radius2,y_radius2] = plot_error_ellipse(to_points(I2,:));
           end

           sd_1=max(x_radius1,y_radius1);
           sd_2=max(x_radius2,y_radius2);
           C2(1,:);
           C2(2,:);

           ddist= sqrt((C2(1,1)-C2(2,1))^2 + (C2(1,2)-C2(2,2))^2);
        end

%        criteria for double collicular projection
%        (i) have at least <minclustersize> points in each cluster
%        (ii)  distance between means  > summed standard deviations 
%        (iii) distance between means greater than 10 degrees

	two_clusters = 0;
%        if length(I1)>= minclustersize & length(I2) >= minclustersize & ddist >= 1.1*(sd_1+sd_2)
        if length(I1)>= minclustersize & length(I2) >= minclustersize & ddist >= 1.1*(sd_1+sd_2) &  ddist  >= 10
	   two_clusters = 1;
	end
	if two_clusters == 0
	   num_to_points = size(to_points,1);
%                  looking at one cluster now if large enough
	   if num_to_points >=minclustersize
	     numb_pixels_examined = numb_pixels_examined +num_to_points;
	
	     figure(9999)
	     [angle,x_radius,y_radius] = plot_error_ellipse(to_points);

	     if max(x_radius,y_radius) > thresh_scatter

%            For Serial: active_pixels updated
%            For Parallel: new_active_pixels updated
%           active_pixels(from_coords(nn,2),from_coords(nn,1))=0;

           new_active_pixels(from_coords(nn,2),from_coords(nn,1))=0;
	     end
         end
      end
    end    
end
	numb_pixels_originally_active = length(I_start)

%              For Serial: next but one line commented out
%              For Parallel: next line activated
	active_pixels = new_active_pixels;

       I = find(active_pixels==1);
        numb_pixels_finally_active=length(I) 
        percent_change = 100*(1-numb_pixels_finally_active/numb_pixels_originally_active)     
	numb_pixels_examined

	params.active_pixels = active_pixels;

	
        params.num_active_pixels = length(find(active_pixels == 1));
        params.stats.num_active_pixels = length(find(active_pixels == 1));
end     
        params.percent_hi_scatter_removed = percent_change;
