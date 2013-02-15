function [] = DSplot_figure202(params, direction)

%plots out the numbers of each node
% So that anchors can be chosen easily

    figure(202)
    clf
 
%RTOC
if direction == 'RTOC'
    ret_coords = params.RTOC.ret_points;
    coll_coords = params.RTOC.coll_points;
    list_of_neighbours = params.RTOC.list_of_neighbours;
    color = 'k';
    num_points = params.RTOC.numpoints;
    takeout = params.RTOC.takeout;
    list_of_points = setdiff(1:num_points,takeout);
    sets_of_intersections = params.RTOC.sets_of_intersections;
    
   %RTOC Ret

   subplot(2,1,1)
   for lop=1:length(list_of_points)
      text(ret_coords(lop,1),ret_coords(lop,2),num2str(list_of_points(lop)),'FontSize',6);
   end
   hold off
   axis ij

   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0, 0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'})
   axis([0 1 0 1]);
   title(['#',num2str(params.id),'. ',direction,'. Retina - node labels']);

   
   %RTOC Coll
   subplot(2,1,2)
   hold on
   for lop=1:length(list_of_points)
      text(coll_coords(lop,1),coll_coords(lop,2),num2str(list_of_points(lop)),'FontSize',6);
   end
   hold off
   axis ij

   axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'})
   axis([0 1 0 1]);

   title([direction,'. Colliculus - node labels']);

end
   
   %CTOR
if direction == 'CTOR'
   coll_coords = params.CTOR.coll_points;
   ret_coords = params.CTOR.ret_points;
   list_of_neighbours = params.CTOR.list_of_neighbours;
   color = 'b';
   num_points = params.CTOR.numpoints;
   takeout = params.CTOR.takeout;
   list_of_points = setdiff(1:num_points,takeout);
   sets_of_intersections = params.CTOR.sets_of_intersections;
        
  %RTOC Ret

   subplot(2,1,1)
   hold on
   for lop=1:length(list_of_points)
      text(ret_coords(lop,1),ret_coords(lop,2),num2str(list_of_points(lop)),'FontSize',6,'Color','b');
   end
   hold off
   axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'})
   axis([0 1 0 1]);
   title(['#',num2str(params.id),'. ',direction,'. Retina - node labels']);

   
   %RTOC Coll
   subplot(2,1,2)
   hold on
   for lop=1:length(list_of_points)
      text(coll_coords(lop,1),coll_coords(lop,2),num2str(list_of_points(lop)),'FontSize',6,'Color','b');
   end
   hold off

  set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'})
   axis([0 1 0 1]);


   title([direction,'. Colliculus - node labels']);

end   

   figure(202)
   orient tall
   filename = [num2str(params.id),'_fig202.pdf'];
   print(202,'-dpdf',filename)
   
         
   
   
