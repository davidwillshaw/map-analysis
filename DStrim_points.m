function params = DStrim_points(params, direction)
% For DIRECTION 'CTOR', removes points from PARAMS.FULL_COLL that lie
% withing PARAMS.COLL_RADIUS of the perimeter of the colliculus, as
% defined by the convex hull, and remove the corresponding points from
% PARAMS.FULL_RET. Adds TRIMMED_COLL and TRIMMED_RET to the output
% PARAMS. For DIRECTION 'RTOC' does the corresponding operation,
% based on the perimeter of the retina.

  disp('here')
  if strcmp(direction, 'CTOR')
    keep_inds = find_central_points(params.full_coll, params.coll_radius);
    params.trimmed_coll = params.full_coll(keep_inds, :);
    params.trimmed_ret  = params.full_ret(keep_inds , :);
  end

  if strcmp(direction, 'RTOC')
    keep_inds = find_central_points(params.full_ret, params.ret_radius);
    params.trimmed_coll = params.full_coll(keep_inds, :);
    params.trimmed_ret  = params.full_ret(keep_inds , :);
  end
end

% Remove points from set of points P within RADIUS of convex hull
% of P
function keep_inds = find_central_points(P, radius)    
% Remove points within radius of convex hull
  
% Find indicies of convex hull
  K = convhull(P);
  
  % Find coordinates p of points of convex hull
  p = P(K,:);
  
  % Find normalised vectors e of edges
  e = p(2:end,:) - p(1:(end-1),:);
  le = sqrt(sum(e.^2, 2));
  e = e./[le le];
  
  % Remove the final point, which is a repeat of the first
  p = p(1:(end-1),:);
  
  % Create a matrix of distances of every point to every edge. The
  % logic of this for each vertex p on the convex hull, determine the
  % perpendicular to the edge e just couterclockwise to it 
  % ([0 -1; 1 0] * e) and the vector P - p. 
  d = zeros(size(P, 1), size(e, 1));
  for i=1:size(e, 1)
    d(:,i) = (P - repmat(p(i,:), size(P, 1), 1)) * [0 -1; 1 0] ...
             * transpose(e(i,:));
  end

  keep_inds = find(min(d, [], 2) > radius);

  % Some bits of code for plotting to verify code is working
  % plot(P(:,1), P(:,2), 'b.')
  % hold on
  % plot(p(:,1), p(:,2), 'g.')
  
  % for i=1:size(p, 1) 
  %   plot([p(i,1) ; p(i,1) + e(i,1)], ...
  %        [p(i,2) ; p(i,2) + e(i,2)], 'k-')
  % end 
end