function [] = Dplot_figure202(params, direction)

%plots out the numbers of each node
% So that anchors can be chosen easily

    figure(202)
    clf

    xmean_coll = params.ellipse.x0;
    ymean_coll = params.ellipse.y0;

%FTOC
if direction == 'FTOC'
    field_coords = params.FTOC.field_points;
    coll_coords = params.FTOC.coll_points;
    list_of_neighbours = params.FTOC.list_of_neighbours;
    color = 'k';
    num_points = params.FTOC.numpoints;
    takeout = params.FTOC.takeout;
    list_of_points = setdiff(1:num_points,takeout);
    sets_of_intersections = params.FTOC.sets_of_intersections;
    
   %FTOC Field

   subplot(2,1,1)
   plot(zeros(101,1),-50:50,'Color',[0.7 0.7 0.7], 'Linewidth',1)
   hold on
   plot(-50:50,zeros(101,1),'Color',[0.7 0.7 0.7], 'Linewidth',1)
   for lop=1:length(list_of_points)
      text(field_coords(lop,1),field_coords(lop,2),num2str(list_of_points(lop)),'FontSize',6);
   end
   hold off
   axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1])
   axis([-50 50 -50 50]);
   axis off
   title(['#',num2str(params.id),'. ',direction,'. Field - node labels']);

   
   %FTOC Coll
   subplot(2,1,2)
   hold on
   for lop=1:length(list_of_points)
      text(coll_coords(lop,1),coll_coords(lop,2),num2str(list_of_points(lop)),'FontSize',6);
   end
   hold off
   axis ij
   axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
   set(gca,'PlotBoxAspectRatio',[1 1 1])
     axis off
   title([direction,'. Colliculus - node labels']);

end
   
   %CTOF
if direction == 'CTOF'
   coll_coords = params.CTOF.coll_points;
   field_coords = params.CTOF.field_points;
   list_of_neighbours = params.CTOF.list_of_neighbours;
   color = 'b';
   num_points = params.CTOF.numpoints;
   takeout = params.CTOF.takeout;
   list_of_points = setdiff(1:num_points,takeout);
   sets_of_intersections = params.CTOF.sets_of_intersections;
        
  %FTOC Field

   subplot(2,1,1)
   hold on
   for lop=1:length(list_of_points)
      text(field_coords(lop,1),field_coords(lop,2),num2str(list_of_points(lop)),'FontSize',6,'Color','b');
   end
   hold off
   axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1])
   axis([-50 50 -50 50]);
   axis off
   title(['#',num2str(params.id),'. ',direction,'. Field - node labels']);

   
   %FTOC Coll
   subplot(2,1,2)
   hold on
   for lop=1:length(list_of_points)
      text(coll_coords(lop,1),coll_coords(lop,2),num2str(list_of_points(lop)),'FontSize',6,'Color','b');
   end
   hold off
   axis ij
   axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
   set(gca,'PlotBoxAspectRatio',[1 1 1])
     axis off
   title([direction,'. Colliculus - node labels']);

end   

   figure(202)
   orient tall
   filename = [num2str(params.id),'_fig202.pdf'];
   print(202,'-dpdf',filename)
   
         
   
   
