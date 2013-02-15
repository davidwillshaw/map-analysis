function [] = Dplot_figure0(params,direction)

% Shows examples of single and double projections
% FTOC or CTOF
%   two projections from different nodes
%   shown in each sub figure.
%   the blue ones cover all the nodes
%   each red one is randomly chosen

 
%                  Setting random number
s = RandStream('mt19937ar');
RandStream.setDefaultStream(s);


%defaultStream = RandStream.getDefaultStream;
%savedState = defaultStream.State;


xmean_coll = params.ellipse.x0;
ymean_coll = params.ellipse.y0;

if direction=='FTOC'
   num_nodes = params.FTOC.numpoints;
   field_points = params.FTOC.field_points;
   from_coords = params.full_field;
   to_coords = params.full_coll;
   radius = params.field_radius;

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
	 
%	 node1=randomise(1);
	 node1=point;
         centre = field_points(node1,:);
	 [from_points,projection_points1] = find_projection(centre,radius,from_coords,to_coords);
%	  scatter = sqrt(sum(var(projection_points)));
	  plot(zeros(101,1),-50:50,'Color',[0.7 0.7 0.7], 'Linewidth',1)
	  hold on
	  plot(-50:50,zeros(101,1),'Color',[0.7 0.7 0.7], 'Linewidth',1)
%          plot(from_points(:,1),from_points(:,2),'x','Color','b');
          plot(from_points(:,1),from_points(:,2),'.','Color','b');

	  node2=randomise(1);
	  centre = field_points(node2,:);
	 [from_points,projection_points2] = find_projection(centre,radius,from_coords,to_coords);

          plot(from_points(:,1),from_points(:,2),'.','Color','r');
%          plot(from_points(:,1),from_points(:,2),'.x','Color','r');

	  if params.id ~=999
%         Scale bar
          plot(-45:-26,ones(20,1).*45,'k', 'LineWidth',3)%scale bar 20degrees
          axis([-50 50 -50 50]);
	  axis ij
          set(gca,'PlotBoxAspectRatio',[1 1 1])
          axis([-50 50 -50 50]);
          axis off
	  end

	  axis ij
%	  title(['#',num2str(params.id),',',num2str(nep),',',num2str(ep),' FIELD']);
	  hold off


          subplot(5,4,nplot+1)
%	  plot(projection_points1(:,1),projection_points1(:,2),'x','Color','b');
	  plot(projection_points1(:,1),projection_points1(:,2),'.','Color','b');
	  hold on
%	  plot(projection_points2(:,1),projection_points2(:,2),'x','Color','r');
	  plot(projection_points2(:,1),projection_points2(:,2),'.','Color','r');

	  ellipse(params.ellipse.ra,params.ellipse.rb,params.ellipse.ang,params.ellipse.x0,params.ellipse.y0,'k');

         if params.id ~=999
         plot(xmean_coll-65:xmean_coll-38,ones(28,1).*ymean_coll+65,'k', 'LineWidth',3)%scale bar 250microns?
         axis ij
         axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
         set(gca,'PlotBoxAspectRatio',[1 1 1])
	 end
         axis off
         axis ij
%	  title(['COLLICULUS']);

%      set(gca,'XTick',[],'YTick',[]);


          end

   orient tall 
   filename = [num2str(params.id),'_fig',num2str(fig_num),'.pdf'];
   print(fig_num,'-dpdf',filename)
         
      end

end
%CTOF

if direction=='CTOF'
   num_nodes = params.CTOF.numpoints;
   coll_points = params.CTOF.coll_points;
   from_coords = params.full_coll;
   to_coords = params.full_field;
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

	 randomise =randperm(num_nodes);
         subplot(5,4,nplot)
	 
	 node1=randomise(1);
         centre = coll_points(node1,:);
	 [from_points1,projection_points1] = find_projection(centre,radius,from_coords,to_coords);
	  plot(zeros(101,1),-50:50,'Color',[0.7 0.7 0.7], 'Linewidth',1)
	  hold on
	  plot(-50:50,zeros(101,1),'Color',[0.7 0.7 0.7], 'Linewidth',1)
          plot(projection_points1(:,1),projection_points1(:,2),'.','Color','b');

	  node2=randomise(2);
	  centre = coll_points(node2,:);
	 [from_points2,projection_points2] = find_projection(centre,radius,from_coords,to_coords);

          plot(projection_points2(:,1),projection_points2(:,2),'.','Color','r');

          if params.id ~= 999
%          plot(-45:-26,ones(20,1).*45,'k', 'LineWidth',3)%scale bar 20degrees
          axis([-50 50 -50 50]);
	  axis ij
          set(gca,'PlotBoxAspectRatio',[1 1 1])
          axis([-50 50 -50 50]);
	  end
          axis ij 
	  axis off
%	  title(['#',num2str(params.id),',',num2str(nep),',',num2str(ep),' FIELD']);
	  hold off


          subplot(5,4,nplot+1)

	  plot(from_points1(:,1),from_points1(:,2),'.','Color','b');
	  hold on

	  plot(from_points2(:,1),from_points2(:,2),'.','Color','r');

	  ellipse(params.ellipse.ra,params.ellipse.rb,params.ellipse.ang,params.ellipse.x0,params.ellipse.y0,'k');

	  if params.id ~= 999
%         plot(xmean_coll-65:xmean_coll-38,ones(28,1).*ymean_coll+65,'k', 'LineWidth',3)%scale bar 250microns?
         axis ij
         axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
         set(gca,'PlotBoxAspectRatio',[1 1 1])
	 end

	 axis ij
         axis off

%	  title(['COLLICULUS']);
%      set(gca,'XTick',[],'YTick',[]);

          end

   orient tall 
   filename = [num2str(params.id),'_fig',num2str(fig_num),'.pdf'];
   print(fig_num,'-dpdf',filename)
         
      end

end
