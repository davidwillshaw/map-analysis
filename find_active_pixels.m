function params = find_active_pixels(params)
%Active pixels must be within the ellipse and their Elev and Azim
%activities must be above params.thresh.elev and params.thresh.azim
%respectively. It returns a matrix the same size as the data (250x250) with
%ones for active pixels and zeros for inactive pixels. Adds
%params.active_pixels to the structure

    [size_i,size_j] = size(params.elev_amp);
    [x_coord, y_coord] = meshgrid(1:size_j,1:size_i);
    dist = ((x_coord - params.ellipse.x0).^2)./params.ellipse.ra + ...
         ((y_coord - params.ellipse.y0).^2)./params.ellipse.rb;
     active_pixels = ones(size_i,size_j);
     
     %check it's in the ellipse
     active_pixels = active_pixels.*(dist<=1);
     %check activity is above Elev & Azim threshold
     active_pixels = active_pixels.*(params.elev_amp>params.thresh.elev);
     active_pixels = active_pixels.*(params.azim_amp>params.thresh.azim);
     
     params.active_pixels = active_pixels;
     %%find focus, find distance of points from focus, sum distances, if
     %%bigger than ra ->outside ellipse, if smaller then inside.
     
     
    