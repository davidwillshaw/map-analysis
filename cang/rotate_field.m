function new_field_positions =rotate_field(params)

angle = -20;

neighbours = params.FTOC.list_of_neighbours;

fp = params.FTOC.field_points;



nnlength = size(neighbours,1);

for nn=1:nnlength

  X0(nn,:) = [fp(neighbours(nn,1),1) fp(neighbours(nn,2),1)];
  Y0(nn,:) = [fp(neighbours(nn,1),2) fp(neighbours(nn,2),2)];

  X=X0(nn,:);
  Y=Y0(nn,:);

  X1=X-mean(X);
  Y1=Y-mean(Y);

  X2 = X1*cosd(angle)-Y1*sind(angle);
  Y2 = X1*sind(angle)+Y1*cosd(angle);

  X3=X2+mean(X);
  Y3=Y2+mean(Y);

%  plotting just to check
% Note that rotation is done before any putative randomisation of axes
%figure(1234)
%clf
%  line(X0(nn,:),Y0(nn,:),'color', 'r');
%  hold on
%  line(X3,Y3,'color', 'b');

newfp(neighbours(nn,1),:) = [X3(1) Y3(1)];
newfp(neighbours(nn,2),:) = [X3(2) Y3(2)];
end

%  title(['#',num2str(params.id),'. Field positions rotated 20 degrees counterclockwise (red->blue)']);
%axis equal
%axis ij
%hold off

new_field_positions = newfp;


