function params =  Dseed_the_lattice(params, direction, SEEDS)

%Dseed_the_lattice: form  a perfect submap from an orginal set of points in the lattice

%               Just for FTOC so far

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Adapted from ~willshaw/Computing/Matlab/MapPrecision08/Cang/
% seed_the_lattice_from_field.m

%        This was developed from projected_lattice.m   130409

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%if strcmp(direction, 'CTOF')
%     sets_of_intersections = params.CTOF.sets_of_intersections;
%     list_of_neighbours = params.CTOF.list_of_neighbours;
%     takeout = params.CTOF.takeout;
%     num_points = params.CTOF.numpoints;
%end

if strcmp(direction, 'FTOC')
     sets_of_intersections = params.FTOC.sets_of_intersections;
     list_of_neighbours = params.FTOC.list_of_neighbours;
     takeout = params.FTOC.takeout;
     num_points = params.FTOC.numpoints;
end
    


%                   Now set up the original map of points from the seed


candidates = SEEDS;

params.FTOC.takeout = setdiff([1:numpoints],SEEDS)
params = triangulation(params,'FTOC');

return

active_sets_of_intersections = remove_links_including_nodes(sets_of_intersections,takeout)

active_list_of_neighbours = remove_links_including_nodes(list_of_neighbours,takeout);
return

%          TRIANGULATION - ON FIELD (whole set of points) 

[rtriangles, rneighbours] = triangulation(RET,ACC)
numb_rtriangles = size(rtriangles,1);
numb_total_points = size(RET,1)
numb_points = size(RETINA,1)

%   FIND NEIGHBOURS 

labels = NODE_LABELS;

neighbours = find_neighbours(rneighbours,labels)
len_labels= length(labels);
len_neighbours = length(neighbours)

labels

[nodes flinklength]=define_links(RET,rneighbours,labels);


if is_there_a_crossing(CORT,nodes)==1

   disp(['Neighbourhood relations violated']);

   return

end


i=1;

while len_neighbours > 0

      disp(['Loop ',num2str(i)]);
      labels
      len_labels = length(labels)
      len_neighbours=length(neighbours)
      neighbours

      labels(len_labels+1)=neighbours(1)

      [nodes tlinklength]=define_links(RET,rneighbours,labels)

      nodes

      neighbours(1)


       if one_more_crossing(CORT,nodes,neighbours(1)) ==1
	 disp(['A CROSSING']);
	 labels = labels([1:len_labels]);
         neighbours= neighbours([2:len_neighbours]);

	 if length(neighbours)== 0
	    FINAL_LABELS = labels
           [nodes flinklength]=define_links(RET,rneighbours,labels);
	    len_neighbours =0;
	 end
         len_neighbours=max(len_neighbours-1,0);
       else
	 disp(['NO CROSSING']);
%         subplot(4,4,i)
         [nodes flinklength] =define_links(RET,rneighbours,labels);
         nodes
	 neighbours = find_neighbours(rneighbours,labels)
	 len_neighbours =  length(neighbours);
      end

      i=i+1;

end

NRECORD = length(FINAL_LABELS)



%     ***  REDO CALCULATION OF AVE RECEPTIVE FIELD FOR JUST THIS
%          SELECTION OF NODES:


CCA = Azim_phase;
CCE = Elev_phase;

for nn = 1: NRECORD

    NX= CORT(FINAL_LABELS(nn),1);
    NY= CORT(FINAL_LABELS(nn),2);

    minNX = max(NX-HALFRANGE,1);
    maxNX = min(NX+HALFRANGE,250);
    minNY = max(NY-HALFRANGE,1);
    maxNY = min(NY+HALFRANGE,250);

    norm=0;
    sumx=0;
    sumy=0;
    sumsqx=0;
    sumsqy=0;
    for x= minNX: maxNX
        for y= minNY: maxNY
	    if ACTIVITY(y,x)==1
	       expon = ((NX-x)^2 + (NY-y)^2)/SIGMA2;
	       norm = norm+exp(-expon);
	       sumx = sumx + exp(-expon)*CCA(y,x);
	       sumsqx = sumsqx + exp(-expon)*CCA(y,x)^2;
	       sumy = sumy + exp(-expon)*CCE(y,x);
	       sumsqy = sumsqy + exp(-expon)*CCE(y,x)^2;
	    end
	end
     end
     MEANRET(FINAL_LABELS(nn),1) = sumx/norm;
     MEANRET(FINAL_LABELS(nn),2) = sumy/norm;

     RETXSQ = sumsqx/norm;
     RETYSQ = sumsqy/norm;
     
     SPREADXSQ(FINAL_LABELS(nn)) = RETXSQ - MEANRET(FINAL_LABELS(nn),1)^2;
     SPREADYSQ(FINAL_LABELS(nn)) = RETYSQ - MEANRET(FINAL_LABELS(nn),2)^2;

end

SPREADX = sqrt(mean(SPREADXSQ));
SPREADY = sqrt(mean(SPREADYSQ));


spr_dum=SPREADY;
SPREADY = SPREADX;
SPREADX = spr_dum;
clear spr_dum;


%-------------------------------------------------------------------------------------------

NEIGHBOURS = rneighbours;

%                          2. CHOOSING THE COLOURED NODES IN THE MAPS


done_anchors = zeros(numb_total_points,1);
na=1;
HILITE(1) = FINAL_LABELS(ceil(NRECORD*rand))

while na <=ANCHORS
      hl= FINAL_LABELS(ceil(NRECORD*rand))
      if done_anchors(hl)==0
         HILITE(na) =hl;
         done_anchors(hl) = 1;
         na=na+1;
      end
end


figure(1);

subplot(2,2,4)

[nodes flinklength] = define_and_print_links(RET,rneighbours,FINAL_LABELS,PRINT_LINKS,PRINT_LABELS,LINKSTR)

hold on
mtlength = mean(flinklength);
stdrlength = std(flinklength);

title(['Graph of field points showing NN links']);

xlabel('<--Inferior---Superior-->');
ylabel('<--Temporal---Nasal-->');

%  Rectangle showing original extent of wild type field

%rectangle('Position',[-25 -35 50 60],'EdgeColor',[0 0 0],'LineStyle','--');

%for nn=1:NRECORD

%indiv_spreadx=sqrt(SPREADYSQ(FINAL_LABELS(nn)));
%indiv_spready=sqrt(SPREADXSQ(FINAL_LABELS(nn)));

%indiv_meanx =  MEANRET(FINAL_LABELS(nn),2);
%indiv_meany =  MEANRET(FINAL_LABELS(nn),1);

%ellipse(indiv_spreadx,indiv_spready,0,indiv_meanx,indiv_meany,'m');

%end

%                    PLOTTING OUT MEAN RETINAL RECEPTIVE FIELD
field_centre = RET(HILITE(1),:);
ellipse(SPREADX,SPREADY,0,field_centre(1),field_centre(2),'m');

rectangle('Position',[F1  F3  F2-F1 F4-F3],'EdgeColor',[0 0 0]);

mark_reference_points(RET,HILITE)
%----------------------------------------------------------------------------------------
%


xmax = max(RET(:,1));
xmin = min(RET(:,1));

ymax = max(RET(:,2));
ymin = min(RET(:,2));

axis image
axis([xmin xmax ymin ymax]);

axis ij

hold off

%-------------------------------------------------------------------------------------------

%                           3. SET UP COLLICULAR MAP AND PLOT OUT


subplot(2,2,3)


[nodes tlinklength] = define_and_print_links(CORT,rneighbours,FINAL_LABELS,PRINT_LINKS,PRINT_LABELS,LINKSTR)
hold on

xmax = W2;
xmin = W1;

ymax = W4;
ymin = W3;

xlabel('<--Lateral---Medial-->');
ylabel('<--Caudal---Rostral-->');


[h X_ELL Y_ELL] = ellipse(RA,RB,ANG,X0,Y0,'k');

rectangle('Position',[xmin ymin  (xmax-xmin) (ymax-ymin)],'EdgeColor',[0 0 0]);

title(['Projection onto colliculus']);

mark_reference_points(CORT,HILITE)


%                    SHOWING VALUE OF SIGMA

cortex_centre = CORT(HILITE(1),:);
cortex_radius = SIGMA;
theta = [0:0.01:2*pi];
coords(:,1) = cortex_centre(1) + cortex_radius*cos(theta);
coords(:,2) = cortex_centre(2) + cortex_radius*sin(theta);
plot(coords(:,1),coords(:,2),'m-');


hold off

axis image
axis([xmin xmax ymin ymax]);
axis ij


%--------------------------------------------------------------------------------
% Normalise link lengths to sqrt of area covered


%[K CORTEX_AREA]= convhull(CORTEX(:,1),CORTEX(:,2));
[K CORT_AREA]= convhull(CORT(FINAL_LABELS,1),CORT(FINAL_LABELS,2));
tec_scale = 10^(round(log10(sqrt(CORT_AREA/NRECORD))));

%[K RETINAL_AREA]= convhull(RETINA(:,1),RETINA(:,2),{'QJ'});
[K RET_AREA]= convhull(RET(FINAL_LABELS,1),RET(FINAL_LABELS,2),{'QJ'});
field_scale = 10^(round(log10(sqrt(RET_AREA/NRECORD))));

tlinklength = tlinklength/sqrt(CORT_AREA);
flinklength = flinklength/sqrt(RET_AREA);


%   Count the number of link crossings (if any)

[nodescross linkscross crossings total] = doescross(CORT,nodes);


%is_there_a_crossing(RET,nodes)

IC = find(nodescross>0);
numnodes=length(IC);


%-------------------------------------------------------------------------------------


rel_length = flinklength./tlinklength;


figure(2)
clf
subplot(2,2,4)

mlen= mean(rel_length);
stlen =std(rel_length);
hist(rel_length,20);

h = findobj(gca,'Type','patch');
set(h,'FaceColor','b');

v= axis;
v(1) = 0;
axis(v);
vv = 0.8*v(4);
hold on

line([mlen mlen],[vv+0.5 vv-0.5],'Color','r');
line([mlen-stlen mlen+stlen],[vv vv],'Color','r');
title(['Distribution of link length ratios; ', ' \mu', ' \sigma:',num2str(mlen,3),',',num2str(stlen,3)],'Color','k');
xlabel('LINK LENGTH RATIO');
ylabel('NUMBER OF LINKS');
hold off


figure(1)

subplot(2,2,2)

text(-0.1,1.1,[date, ' SEED\_THE\_LATTICE\_FROM\_FIELD.M'],'Color','k');

hold on

MAX_NODES =  round(CORT_AREA/(SIGMA^2));



text(-0.1,1,[ss,' ',num2str(NRECORD), ' points; max poss: ',num2str(MAX_NODES)],'Color','r');
text(-0.1,0.92,['Ellipse contains ', num2str(ceil(pi*RA*RB)),' points, ',num2str(active_pixels),' active'],'Color','r');

text(-0.1,0.84,['Sampling radius: ',num2str(SIGMA,3)],'Color','r');


text(-0.1,0.74,['ELL\_PARAMS, LINE\_PARAMS']);

text(-0.1,0.66,['[',num2str(RA),' ',num2str(RB),' ',num2str(ANG),' ',num2str(X0),' ',num2str(Y0),'],[',num2str(L1),',',num2str(L2),',',num2str(L3),']']);


text(-0.1,0.56,['MEANDIST[\muM],SIGMA,RANGE,.....']);
text(-0.1,0.50,['ANCHORS,THRESHL,THRESHS,RANSTART']);

text(-0.1,0.42,[num2str(MEANDIST,3),'[',num2str(8.9*MEANDIST,3),']',num2str(SIGMA),',',num2str(RANGE),',',num2str(ANCHORS),',',num2str(THRESHL),',',num2str(THRESHS),',',num2str(RANSTART)]);

text(-0.1,0.32,['Elliptical mean receptive fields; two axes: ',num2str(mean(SPREADX),3),',',num2str(mean(SPREADY),3),' degrees'],'Color','b');

text(-0.1,0.22,['ERRORS WHEN PROJECTING LATTICE FROM FIELD:'],'Color','b');


text(-0.1,0.12,['# Nodes crossing, # Links crossings: ',num2str(length(IC)),',',num2str(crossings)],'Color','b');

hold off
axis off


figure(2)

subplot(2,2,2)

text(-0.1,1.1,[date, ' SEED\_THE\_LATTICE\_FROM\_FIELD.M'],'Color','k');

hold on

if DATA ==1
   ss = 'WILD TYPE. ';
end

if DATA ==2
   ss = 'BETA2 MUTANT. ';
end

if DATA == 3
   ss = 'ephrin Knock Out. ';
end


if DATA == 55
   ss = 'ephrin Knock Out 55. ';
end


hold on


MAX_NODES =  round(CORT_AREA/(SIGMA^2));

text(-0.1,1,[ss,num2str(NRECORD), ' points; max poss: ',num2str(MAX_NODES)],'Color','r');
text(-0.1,0.92,['Ellipse contains ', num2str(ceil(pi*RA*RB)),' points, ',num2str(active_pixels),' active'],'Color','r');

text(-0.1,0.84,['Sampling radius: ',num2str(SIGMA,3)],'Color','r');


text(-0.1,0.74,['ELL\_PARAMS, LINE\_PARAMS']);

text(-0.1,0.66,['[',num2str(RA),' ',num2str(RB),' ',num2str(ANG),' ',num2str(X0),' ',num2str(Y0),'],[',num2str(L1),',',num2str(L2),',',num2str(L3),']']);


text(-0.1,0.56,['MEANDIST[\muM],SIGMA,RANGE,.....']);
text(-0.1,0.50,['ANCHORS,THRESHL,THRESHS,RANSTART']);

text(-0.1,0.42,[num2str(MEANDIST,3),'[',num2str(8.9*MEANDIST,3),']',num2str(SIGMA),',',num2str(RANGE),',',num2str(ANCHORS),',',num2str(THRESHL),',',num2str(THRESHS),',',num2str(RANSTART)]);

text(-0.1,0.32,['Two semiaxes of elliptical receptive fields: ',num2str(mean(SPREADX),3),',',num2str(mean(SPREADY),3),' degrees'],'Color','b');

text(-0.1,0.22,['ERRORS WHEN PROJECTING LATTICE FROM COLLICULUS:'],'Color','b');


text(-0.1,0.12,['# Nodes crossing, # Links crossings: ',num2str(length(IC)),',',num2str(crossings)],'Color','b');

hold off
axis off

%                       COMMENTED OUT
orientation_stats(CORTEX,RETINA,LINE_PARAMS);


%--------------------------------------------------------------------------------
%---------------------------------------------------------------------------------




figure(2);

orient tall


figure(1);

orient tall
print -depsc2 fred1.eps

figure(2);
print -depsc2 fred2.eps




