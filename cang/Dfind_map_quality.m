function params = Dfind_map_quality(params)


% I've put the y argument first in active_pixels, azim_phase and elev_phase

full_coll = params.full_coll;
full_field= params.full_field;
npixels = params.num_active_pixels;

active_pixels=params.active_pixels;

azim_phase = params.azim_phase;
elev_phase = params.elev_phase;

for np = 1:npixels
    full_coll_x= full_coll(np,1);
    full_coll_y= full_coll(np,2);

%    azim_phase(full_coll_y,full_coll_x)
%    elev_phase(full_coll_y,full_coll_x)
%    full_field(np,:)
%    active_pixels(full_coll_y,full_coll_x)

    azim_field=0;
    elev_field=0;
    count=0;
    for nx = full_coll_x-2:full_coll_x+2
	for ny = full_coll_y-2:full_coll_y+2
	    if active_pixels(ny,nx)==1
	       azim_field=azim_field+azim_phase(ny,nx);
               elev_field=elev_field+elev_phase(ny,nx);
	       count=count+1;
            end
        end
    end

    azim_field = azim_field-azim_phase(full_coll_y,full_coll_x);
    elev_field = elev_field-azim_phase(full_coll_y,full_coll_x);

    if count > 1    
        azim_dev(np)= abs(azim_field/(count-1) -azim_phase(full_coll_y,full_coll_x));
        elev_dev(np)= abs(elev_field/(count-1) -elev_phase(full_coll_y,full_coll_x));
    end
    if count == 1
	azim_dev(np)=0;
	elev_dev(np)=0;
    end

end

params.stats.azim_dev=std(azim_dev,1);
params.stats.elev_dev=std(elev_dev,1);

    
   
