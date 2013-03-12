function takeout = Dfind_abnormal_fields(params,thresh_scatter)

params = Dfind_three_scatter_types(params,thresh_scatter,1)

X1=params.FTOC.individual.ectopics

X2=params.FTOC.individual.big_singles

X3=params.FTOC.individual.small_singles

takeout = union(X1,X2)



