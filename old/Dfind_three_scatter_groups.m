function params = Dfind_three_scatter_groups(params,thresh_scatter,plotting)
%   three groups are:
% ect:          ectopics
% long_fields:  scatter fields in which at least one of the standard
%               deviations along a principal axis exceeds a threshold
% short_fields: scatter fields in which either of the standard
%               deviations along a principal axis exceeds a threshold 
    xmean_coll = params.ellipse.x0;
    ymean_coll = params.ellipse.y0;
    pos = params.FTOC.points_in_subgraph;

    num_points = params.FTOC.numpoints;
    field_points = params.FTOC.field_points;
    ect = find(params.FTOC.minor_projection(:,1));
    from_coords = params.full_field;
    to_coords = params.full_coll;
    radius = params.field_radius;

    if plotting ==1
        figure(33)
        clf
    end

    %FTOC
    
    num_points = params.FTOC.numpoints;
    full_field_coords = params.full_field;
    full_coll_coords = params.full_coll;
    radius = params.field_radius;
    field_centred_points = [];
    coll_centred_points = [];

    long_fields=[];
    short_fields=[];

    for point = 1:num_points
        centre = params.FTOC.field_points(point,:);
        [from_points,projection_points] =find_projection(centre,radius,full_field_coords,full_coll_coords);
%   For single projections neglect small projections 
%   when one of the two (surely not both??)  have 4 points or fewer
	num_projection = length(projection_points);
	if ~ismember(point,ect)
	    [IDX2, C2] = kmeans(projection_points,2, 'replicates',5);
	    I1=find(IDX2==1);
	    I2=find(IDX2==2);
	    if length(I1)<= 4 
	       IPROJ = setdiff([1:num_projection],I1);
	        projection_points=projection_points(IPROJ,:);
	    end
	    if length(I2)<=4 
	        IPROJ = setdiff([1:num_projection],I2);
        	 projection_points=projection_points(IPROJ,:);
	    end
	end
        num_projection = length(projection_points);
        [angle_f,x_radius_f,y_radius_f] = plot_error_ellipse(from_points);
        [angle_c,x_radius_c,y_radius_c] = plot_error_ellipse(projection_points);
%D now computing standard errors of the mean
        x_radius_f(point) = x_radius_f/sqrt(num_points);
        y_radius_f(point) = y_radius_f/sqrt(num_points);
        radius_c(point,1) = x_radius_c/sqrt(num_points);
        radius_c(point,2) = y_radius_c/sqrt(num_points);
        centred_points = projection_points - repmat(mean(projection_points),num_projection,1);
        coll_centred_points = [coll_centred_points; centred_points];

%	max_radius = max(radius_c(point,1),radius_c(point,2));
	max_radius = sqrt(radius_c(point,1)^2+radius_c(point,2)^2);

        if max_radius > thresh_scatter &&  ~ismember(point,ect)
	       long_fields=union(long_fields,point);
	end
	if max_radius <= thresh_scatter  && ~ismember(point,ect)
	       short_fields=union(short_fields,point);
	end

    end

        if plotting ==1
	   subplot(2,2,1)
           plot(radius_c(ect,1),radius_c(ect,2),'+r');
%	   legend('Ectopics');
           hold on

	   plot(radius_c(short_fields,1),radius_c(short_fields,2),'+b');
%	   legend('Small fields');
	   plot(radius_c(long_fields,1),radius_c(long_fields,2),'+g');
%	   legend('Long fields');
           set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16);
%	   legend('Ectopics', 'Small fields','Long fields','Location','SouthEast','Fontsize',12);

	   title('Plotting out STDs along principal axes');
	   xlabel('Pixels');
	   ylabel('Pixels');

	hold on
	theta=[0.01:0.01:pi/2];
	plot(thresh_scatter*sin(theta),thresh_scatter*cos(theta),'-b');
	hold off

        v=axis;

	ect1 = intersect(ect,pos)
	short_fields1 = intersect(short_fields,pos);
	long_fields1=intersect(long_fields,pos);

	 subplot(2,2,3)
	   plot(radius_c(ect1,1),radius_c(ect1,2),'+r');
	   hold on
	   plot(radius_c(short_fields1,1),radius_c(short_fields1,2),'+b');
	   plot(radius_c(long_fields1,1),radius_c(long_fields1,2),'+g');

           set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16);
	   title('Points in largest ordered subgraph only');
	   xlabel('Pixels');
	   ylabel('Pixels');

	hold on
	theta=[0.01:0.01:pi/2];
	plot(thresh_scatter*sin(theta),thresh_scatter*cos(theta),'-b');
	hold off

	axis(v);

    end
params.FTOC.stats.ectopics = ect;

params.FTOC.stats.long_fields = long_fields;

params.FTOC.stats.short_fields= short_fields;


numbers_in_three_groups = [length(ect) length(long_fields) length(short_fields)]

figure(33)
filename = [num2str(params.id),'_fig33.pdf'];
print(33,'-dpdf',filename)
    
