function new_params = replication_of_electrode_positions(DAT,REPLICATIONS,CHANGE_SEED,RANDOMISE)


params = Drun_data(DAT,1);

ectopicnodes=1;

NMEAN =  params.CTOF.numpoints;
NDEV = round(NMEAN/4);
seed = params.ranstart

rep = 1;

while rep <= REPLICATIONS

  mean_min_spacing = 0;
  trials =0;
  while abs(mean_min_spacing-6) > 0.1

   trials = trials+1;

    nlist=NMEAN-NDEV+randperm(2*NDEV+1);
    n=nlist(1);
   

    params.CTOF.numpoints =n;
    params.FTOC.numpoints =n;

   
    params.ranstart = seed;

    params = select_point_positions(params,'CTOF');
    params = select_point_positions(params,'FTOC');

    mean_min_spacing = params.CTOF.mean_min_spacing

    seed = seed+ CHANGE_SEED;
  end
 
  disp([num2str(rep),'. Trials: ',num2str(trials),'; Spacing: ',num2str(mean_min_spacing)]); 

    new_p = params;

    new_p = create_projection(new_p, 'CTOF');
    new_p = create_projection(new_p, 'FTOC');

%  Fix for randomising FTOC along RC axis 
   if RANDOMISE== 2
      NN= length(new_p.FTOC.coll_points(:,2));
      new_p.FTOC.coll_points(:,2) = new_p.FTOC.coll_points(randperm(NN),2);
%      new_p.CTOF.coll_points(:,2) = new_p.CTOF.coll_points(randperm(NN),2);
   end

%  Fix for randomising FTOC along ML axis
    if RANDOMISE == 1
     NN= length(new_p.FTOC.coll_points(:,2));
      new_p.FTOC.coll_points(:,1) = new_p.FTOC.coll_points(randperm(NN),1);
    end

%  Fix for randomising FTOC along RC and ML axis
    if RANDOMISE == 3
     NN= length(new_p.FTOC.coll_points(:,2));
      new_p.FTOC.coll_points(:,1) = new_p.FTOC.coll_points(randperm(NN),1);
      new_p.FTOC.coll_points(:,2) = new_p.FTOC.coll_points(randperm(NN),2);
    end

    new_p = find_ectopics(new_p);
    new_p = triangulate(new_p,'CTOF');
    new_p = triangulate(new_p,'FTOC');

    new_p = find_crossings(new_p, 'CTOF');
    new_p = find_crossings(new_p, 'FTOC');

    new_p = find_largest_subgraph(new_p,'CTOF',ectopicnodes);
    new_p = find_largest_subgraph(new_p,'FTOC',ectopicnodes);

    new_p = find_dispersion(new_p, 'FTOC');
    new_p = find_dispersion(new_p, 'CTOF');

    new_p = find_dispersion(new_p, 'FTOC', true);
    new_p = find_dispersion(new_p, 'CTOF', true);

    new_p = find_overall_dispersion(new_p, 'FTOC');
    new_p = find_overall_dispersion(new_p, 'CTOF');

    new_p = find_overall_dispersion(new_p, 'FTOC', true);
    new_p = find_overall_dispersion(new_p, 'CTOF', true);


    new_p = find_link_angles(new_p,'FTOC',1);
    new_p = find_link_angles(new_p,'FTOC',0);
    new_p = find_link_angles(new_p,'CTOF',1);
    new_p = find_link_angles(new_p,'CTOF',0);
    

    new_p = get_subgraph_scatters(new_p,'FTOC');
    new_p = get_subgraph_scatters(new_p,'CTOF');

    if new_p.stats.num_ectopics >= 5
        disp('--> ectopics...')
        new_p = ectopic_order_stats(new_p);
    end

    new_p.newseed=seed-CHANGE_SEED;
    new_p.trials=trials;
    new_params(rep)= new_p; 
   
  mean_min_spacing = 0;     
  rep = rep+1;
end

