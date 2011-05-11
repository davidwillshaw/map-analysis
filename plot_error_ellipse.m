function [angle,x_radius,y_radius] = plot_error_ellipse(coords)

    covariance_mat = cov(coords);
    %conf set at 1 standard deviation (68.2%)
    [~,~,k,~,~] = error_ellipse(covariance_mat,mean(coords),'conf',0.682,'style','k');
    tan_2angle = 2*covariance_mat(1,2)/(covariance_mat(2,2)-covariance_mat(1,1));
    angle = atan(tan_2angle)/2;
    
    p = [0,pi/2];
    [eigvec,eigval] = eig(covariance_mat); % Compute eigen-stuff
    xy = [cos(p'),sin(p')] * sqrt(eigval) * eigvec'; % Transformation
    x = xy(:,1);
    y = xy(:,2);
    x_displacement = k*x;
    y_displacement = k*y;
    r = sqrt(x_displacement.^2+y_displacement.^2);
    x_radius = r(1);
    y_radius = r(2);