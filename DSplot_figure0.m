function [] = DSplot_figure0(params,direction)

% Shows examples  all the  projections from single nodes
% RTOC or CTOR


 
%                  Setting random number
s = RandStream('mt19937ar');
RandStream.setDefaultStream(s);


%defaultStream = RandStream.getDefaultStream;
%savedState = defaultStream.State;


if direction=='RTOC'
   num_nodes = params.RTOC.numpoints;
   ret_points = params.RTOC.ret_points;
   from_coords = params.full_ret;
   to_coords = params.full_coll;
   radius = params.ret_radius;

num_figs = ceil(num_nodes/10);
point = 0;

for nf=1:num_figs
      fig_num = 8000+nf;
      figure(fig_num);
      clf
      
      for nplot =1:2:19
	  point = point+1;
	  if point > num_nodes
	     orient tall
             filename = [num2str(params.id),'_fig',num2str(fig_num),'.pdf'];
             print(fig_num,'-dpdf',filename)
	     return
          end

	 randomise =randperm(num_nodes);
         subplot(5,4,nplot)
	 
	 node1=point;
         centre = ret_points(node1,:);
	 [from_points,projection_points1] = find_projection(centre,radius,from_coords,to_coords);
%	  scatter = sqrt(sum(var(projection_points)));
          plot(from_points(:,1),from_points(:,2),'.','Color','b');
          hold on
%	  node2=randomise(1);
%	  centre = ret_points(node2,:);
%	 [from_points,projection_points2] = find_projection(centre,radius,from_coords,to_coords);

%          plot(from_points(:,1),from_points(:,2),'.','Color','r');

	
   axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'});
   axis([0 1 0 1]);

%	  title(['#',num2str(params.id),',',num2str(nep),',',num2str(ep),' RETINA']);
	  hold off


          subplot(5,4,nplot+1)
	  plot(projection_points1(:,1),projection_points1(:,2),'.','Color','b');
	  hold on

%	  plot(projection_points2(:,1),projection_points2(:,2),'.','Color','r');

 set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'});
   axis([0 1 0 1]);
   axis ij
 
          end

   orient tall 
   filename = [num2str(params.id),'_fig',num2str(fig_num),'.pdf'];
   print(fig_num,'-dpdf',filename)
         
      end

end
%CTOR

if direction=='CTOR'
   num_nodes = params.CTOR.numpoints;
   coll_points = params.CTOR.coll_points;
   from_coords = params.full_coll;
   to_coords = params.full_ret;
   radius = params.coll_radius;


num_figs = ceil(num_nodes/10);
point = 0;

for nf=1:num_figs
      fig_num = 9000+nf;
      figure(fig_num);
      clf
      
      for nplot =1:2:19
	  point = point+1;
	  if point > num_nodes
	     orient tall
             filename = [num2str(params.id),'_fig',num2str(fig_num),'.pdf'];
             print(fig_num,'-dpdf',filename)
	     return
          end

%	 randomise =randperm(num_nodes);
         subplot(5,4,nplot)
	
	 node1=point;
         centre = coll_points(node1,:);
	 [from_points1,projection_points1] = find_projection(centre,radius,from_coords,to_coords);
	 hold on
%	  node2=randomise(2);
%	  centre = coll_points(node2,:);
%	 [from_points2,projection_points2] = find_projection(centre,radius,from_coords,to_coords);

%          plot(projection_points2(:,1),projection_points2(:,2),'.','Color','r');

   axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'});
   axis([0 1 0 1]);
	  hold off


          subplot(5,4,nplot+1)

	  plot(from_points1(:,1),from_points1(:,2),'.','Color','b');
	  hold on

%	  plot(from_points2(:,1),from_points2(:,2),'.','Color','r');

	axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'});
   axis([0 1 0 1]);


%	  title(['COLLICULUS']);
%      set(gca,'XTick',[],'YTick',[]);

          end

   orient tall 
   filename = [num2str(params.id),'_fig',num2str(fig_num),'.pdf'];
   print(fig_num,'-dpdf',filename)
         
      end

end
