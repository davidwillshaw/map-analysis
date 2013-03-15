function params = uniquify_point_positions(params, direction)
% UNIQUIFY_POINT_POSITIONS - Ensure all point positions are unique
%   
%   If there are identical points in params.full_coll or
%   params.full_field, make sure they are non-unique by adding a
%   small random number to all points.
%

if strcmp(direction, 'CTOF')
    P = params.full_coll;
else
    P = params.full_field;
end

% Test for non-unique rows
if (size(unique(sortrows(P), 'rows'), 1) ~=  size(P, 1)) 
    % If there are non-unique rows (i.e. duplicated points), add
    % a small amount of noise to the data.

    % Find the range of the data
    xrange = max(P(:,1)) - min(P(:,1));
    yrange = max(P(:,2)) - min(P(:,2));
    % Add a small fraction of the range to each point
    k = min(xrange, yrange)*1e-6;
    P = P + k*(rand(size(P)) - 0.5);
    disp(['Uniquifying ' direction(1) ' points...']);
end

if strcmp(direction, 'CTOF')
    params.full_coll = P;
else
    params.full_field = P;
end
