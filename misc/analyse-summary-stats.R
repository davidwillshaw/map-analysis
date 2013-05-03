clean <- function(dat) {
  nacols <- apply(dat, 2, function(x) {all(is.na(x))})
  return(dat[,!nacols])
}

## Display 2 sig fig
options(digits=3)

dat <- clean(read.csv("cang/summary_stats.csv"))
write.csv(dat, "summary_stats-clean.csv")
dat$type <- dat$datalabel
dat$type <- gsub("Wild type.*", "WT", dat$type)
dat$type <- gsub("\beta.*", "B2", dat$type)
dat$type <- gsub("ephrin het TKO.*", "HetTKO", dat$type)
dat$type <- gsub("Homo triple.*", "HomTKO", dat$type)
dat$type <- factor(dat$type, levels=c("WT", "B2", "HetTKO", "HomTKO"))

## Table 1 - General properties

## Number of nodes
aggregate(FTOC_numpoints ~ type, dat, mean)
aggregate(FTOC_numpoints ~ type, dat, sd)

## Number of pixels discarded by initial filtering (%)
aggregate(percent_hi_scatter_removed ~ type, dat, mean)
aggregate(percent_hi_scatter_removed ~ type, dat, sd)

## Total area of ellipse defining colliculus (mm2)
dat$ellipse_size_mm2 <- dat$ellipse_size*dat$coll_scale^2/1E6
aggregate(ellipse_size_mm2 ~ type, dat, mean)
aggregate(ellipse_size_mm2  ~ type, dat, sd)

## Table 2 - General properties of maps

## FTOC

## Coverage of colliculus (mm2)
aggregate(stats_FTOC_coll_area/1E6 ~ type, dat, mean)
aggregate(stats_FTOC_coll_area/1E6 ~ type, dat, sd)

## Coverage of visual field (degrees2)
aggregate(stats_FTOC_field_area ~ type, dat, mean)
aggregate(stats_FTOC_field_area ~ type, dat, sd)

## Inverse magnification factor (degrees/mm)
aggregate(stats_FTOC_mag_factor*1E3 ~ type, dat, mean)
aggregate(stats_FTOC_mag_factor*1E3 ~ type, dat, sd)

## CTOF

## Coverage of colliculus (mm2)
aggregate(stats_CTOF_coll_area/1E6 ~ type, dat, mean)
aggregate(stats_CTOF_coll_area/1E6 ~ type, dat, sd)

## Coverage of visual field (degrees2)
aggregate(stats_CTOF_field_area ~ type, dat, mean)
aggregate(stats_CTOF_field_area ~ type, dat, sd)

## Inverse magnification factor (degrees/mm)
aggregate(stats_CTOF_mag_factor*1E3 ~ type, dat, mean)
aggregate(stats_CTOF_mag_factor*1E3 ~ type, dat, sd)

## Table 3 - Sizes of complementary distributions

## FTOC

## Number of nodes
aggregate(FTOC_numpoints ~ type, dat, mean)
aggregate(FTOC_numpoints ~ type, dat, sd)

## SDW1
aggregate(stats_FTOC_dispersion_yrad ~ type, dat, mean)
aggregate(stats_FTOC_dispersion_yrad ~ type, dat, sd)

## SDW2
aggregate(stats_FTOC_dispersion_xrad ~ type, dat, mean)
aggregate(stats_FTOC_dispersion_xrad ~ type, dat, sd)

## SDS1
aggregate(stats_FTOC_subgraph_dispersion_yrad ~ type, dat, mean)
aggregate(stats_FTOC_subgraph_dispersion_yrad ~ type, dat, sd)

## SDS2
aggregate(stats_FTOC_subgraph_dispersion_xrad ~ type, dat, mean)
aggregate(stats_FTOC_subgraph_dispersion_xrad ~ type, dat, sd)

## Number of nodes
aggregate(CTOF_numpoints ~ type, dat, mean)
aggregate(CTOF_numpoints ~ type, dat, sd)

## SDW1
aggregate(stats_CTOF_dispersion_yrad ~ type, dat, mean)
aggregate(stats_CTOF_dispersion_yrad ~ type, dat, sd)

## SDW2
aggregate(stats_CTOF_dispersion_xrad ~ type, dat, mean)
aggregate(stats_CTOF_dispersion_xrad ~ type, dat, sd)

## SDS1
aggregate(stats_CTOF_subgraph_dispersion_yrad ~ type, dat, mean)
aggregate(stats_CTOF_subgraph_dispersion_yrad ~ type, dat, sd)

## SDS2
aggregate(stats_CTOF_subgraph_dispersion_xrad ~ type, dat, mean)
aggregate(stats_CTOF_subgraph_dispersion_xrad ~ type, dat, sd)


## Table 4 - Precision of F-> and C-> maps

## FTOC

## Numebr of nodes attached to edges that cross
aggregate(stats_FTOC_num_nodes_crossing/FTOC_numpoints*100 ~ type, dat, mean)
aggregate(stats_FTOC_num_nodes_crossing/FTOC_numpoints*100 ~ type, dat, sd)

## Size of largest ordered submap (%)
aggregate(stats_FTOC_num_nodes_in_subgraph ~ type, dat, mean)
aggregate(stats_FTOC_num_nodes_in_subgraph ~ type, dat, sd)

## Orientation of largest ordered submap (degrees) 
aggregate(stats_FTOC_subgraph_map_orientation_mean ~ type, dat, mean)
aggregate(stats_FTOC_subgraph_map_orientation_mean ~ type, dat, sd)

## Size of largest ordered RC-disorganised submap (%)
aggregate(stats_FTOC_baseline_num_nodes_in_submap ~ type, dat, mean)
aggregate(stats_FTOC_baseline_num_nodes_in_submap ~ type, dat, sd)

## CTOF

## Numebr of nodes attached to edges that cross
aggregate(stats_CTOF_num_nodes_crossing/CTOF_numpoints*100 ~ type, dat, mean)
aggregate(stats_CTOF_num_nodes_crossing/CTOF_numpoints*100 ~ type, dat, sd)

## Size of largest ordered submap (%)
aggregate(stats_CTOF_num_nodes_in_subgraph ~ type, dat, mean)
aggregate(stats_CTOF_num_nodes_in_subgraph ~ type, dat, sd)

## Orientation of largest ordered submap (degrees) 
aggregate(stats_CTOF_subgraph_map_orientation_mean ~ type, dat, mean)
aggregate(stats_CTOF_subgraph_map_orientation_mean ~ type, dat, sd)

## Size of largest ordered RC-disorganised submap (%)
aggregate(stats_CTOF_baseline_num_nodes_in_submap ~ type, dat, mean)
aggregate(stats_CTOF_baseline_num_nodes_in_submap ~ type, dat, sd)

## Table 5 - Standard deviations of the overall compelmentary distributions
## Note NOT used subgraphs here

## FTOC

## Standard deviation along the major axis
aggregate(stats_FTOC_overall_dispersion_yrad ~ type, dat, mean)
aggregate(stats_FTOC_overall_dispersion_yrad ~ type, dat, sd)

## Standard deviation along the minor axis
aggregate(stats_FTOC_overall_dispersion_xrad ~ type, dat, mean)
aggregate(stats_FTOC_overall_dispersion_xrad ~ type, dat, sd)

## Orientation of the major axis of the overall distribution
aggregate(stats_FTOC_overall_dispersion_angle ~ type, dat, mean)
aggregate(stats_FTOC_overall_dispersion_angle ~ type, dat, sd)

## CTOF

## Standard deviation along the major axis
aggregate(stats_CTOF_overall_dispersion_yrad ~ type, dat, mean)
aggregate(stats_CTOF_overall_dispersion_yrad ~ type, dat, sd)

## Standard deviation along the minor axis
aggregate(stats_CTOF_overall_dispersion_xrad ~ type, dat, mean)
aggregate(stats_CTOF_overall_dispersion_xrad ~ type, dat, sd)

## Orientation of the major axis of the overall distribution
aggregate(stats_CTOF_overall_dispersion_angle ~ type, dat, mean)
aggregate(stats_CTOF_overall_dispersion_angle ~ type, dat, sd)

## Table 6 - Characterisation of the ectopic projections in the F->C maps.

## Number of nodes
aggregate(FTOC_numpoints ~ type, dat, mean)
aggregate(FTOC_numpoints ~ type, dat, sd)

## Number of nodes projecting to ectopic sites
aggregate(stats_num_ectopics ~ type, dat, mean)
aggregate(stats_num_ectopics ~ type, dat, sd)

## Distance between major and minor (ectopic) sites (um)
aggregate(stats_ect_dist_mean ~ type, dat, mean)
aggregate(stats_ect_dist_mean ~ type, dat, sd)

## Orientation of the line joining the major and minor (ectopic) sites
## (degrees)
aggregate(FTOC_mean_ectopic_angles ~ type, dat, mean)
aggregate(FTOC_mean_ectopic_angles ~ type, dat, sd)

