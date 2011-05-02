params = getparams(id)
 params = load_data(params)
 params = find_active_pixels(params)
  params = make_list_of_points(params)
   params = select_point_positions(params,'CTOF')
   params = select_point_positions(params,'FTOC')
   params = create_projection(params, 'CTOF')
   params = create_projection(params, 'FTOC')
    params = triangulation(params,'CTOF')
     params = triangulation(params,'FTOC')
     params = find_crossings(params, 'CTOF')
     params = find_crossings(params, 'FTOC')
     

   imagesc(params.elev_amp)
hold on
>>  plot(params.CTOF.coll_points(:,1),params.CTOF.coll_points(:,2),'xk')
hold on
plot(params.FTOC.coll_points(:,1),params.FTOC.coll_points(:,2),'xm')
>>  figure
plot(params.FTOC.field_points(:,1),params.FTOC.field_points(:,2),'xm')
hold on
plot(params.CTOF.field_points(:,1),params.CTOF.field_points(:,2),'xk')
>> 