function params = find_active_pixels(params)
%Active pixels must be within the ellipse and their Elev and Azim
%activities must be above params.thresh.elev and params.thresh.azim
%respectively. It returns a matrix the same size as the data (250x250) with
%ones for active pixels and zeros for inactive pixels. 
%
%Needs: params.ellipse, params.elev_amp, params.azim_amp, params.thresh
%Adds: params.pixels_in_ellipse, params.active_pixels and num_active_pixels

    [size_i,size_j] = size(params.elev_amp);
    [x_coord, y_coord] = meshgrid(1:size_j,1:size_i);
    
    %find foci f1 and f2 of ellipse
    major_axis = max(params.ellipse.ra,params.ellipse.rb);
    minor_axis = min(params.ellipse.ra,params.ellipse.rb);
    f1 = sqrt(major_axis^2 - minor_axis^2);
    f2 = -f1;
    if params.ellipse.ra>params.ellipse.rb
        focus1_x = cos(params.ellipse.ang)*f1;
        focus1_y = sin(params.ellipse.ang)*f1;
        focus2_x = cos(params.ellipse.ang)*f2;
        focus2_y = sin(params.ellipse.ang)*f2;
    else
        focus1_x = cos(params.ellipse.ang+pi/2)*f1;
        focus1_y = sin(params.ellipse.ang+pi/2)*f1;
        focus2_x = cos(params.ellipse.ang+pi/2)*f2;
        focus2_y = sin(params.ellipse.ang+pi/2)*f2;
    end
    focus1_x = focus1_x + params.ellipse.x0;
    focus1_y = focus1_y + params.ellipse.y0;
    focus2_x = focus2_x + params.ellipse.x0;
    focus2_y = focus2_y + params.ellipse.y0;
    
    %Find the summed distances of each point from the two foci
    distance = sqrt((x_coord - focus1_x).^2+(y_coord - focus1_y).^2) + ...
        sqrt((x_coord - focus2_x).^2+(y_coord - focus2_y).^2);
    pixels_in_ellipse = (distance<=2*major_axis);
    
    %Find active pixels
     active_pixels = ones(size_i,size_j);
     
     %check it's in the ellipse
     active_pixels = active_pixels.*pixels_in_ellipse;
     
     %check activity is above Elev & Azim threshold
     elev_in_ellipse = params.elev_amp.*active_pixels;
     elev_mean_activity = mean(elev_in_ellipse(elev_in_ellipse>0));
     elev_min_activity = min(elev_in_ellipse(elev_in_ellipse>0));
     elev_max_activity = max(elev_in_ellipse(elev_in_ellipse>0));
     elev_thresh = elev_mean_activity.*params.thresh.elev;
%D130213     elev_thresh = 0.38*elev_max_activity.*params.thresh.elev;
     
     azim_in_ellipse = params.azim_amp.*active_pixels;
     azim_mean_activity = mean(azim_in_ellipse(azim_in_ellipse>0));
     azim_min_activity = min(azim_in_ellipse(azim_in_ellipse>0));
     azim_max_activity = max(azim_in_ellipse(azim_in_ellipse>0));
     azim_thresh = azim_mean_activity.*params.thresh.azim;
%130213     azim_thresh = 0.38*azim_max_activity.*params.thresh.azim;
     
     active_pixels = active_pixels.*(params.elev_amp>elev_thresh);
     active_pixels = active_pixels.*(params.azim_amp>azim_thresh);
     
     params.pixels_in_ellipse = pixels_in_ellipse;
     params.active_pixels = active_pixels;
     params.original_active_pixels = active_pixels;
     params.num_active_pixels = length(find(active_pixels == 1));
     params.stats.num_active_pixels = length(find(active_pixels == 1));
     
     
    