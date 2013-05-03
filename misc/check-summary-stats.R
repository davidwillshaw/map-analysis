clean <- function(dat) {
  nacols <- apply(dat, 2, function(x) {all(is.na(x))})
  return(dat[,!nacols])
}

## Read in statistics before and after change to code
dat.new <- clean(read.csv("sims-2013-03-01-sp-convhull/summary_stats.csv"))
dat.orig <- clean(read.csv("sims-2013-03-01-orig/summary_stats.csv"))

dat.diff <- dat.new - dat.orig
dat.frac.diff = dat.diff/dat.orig*100

write.csv(dat.new, "summary_stats-new.csv")
write.csv(dat.orig, "summary_stats-orig.csv")
write.csv(dat.diff, "summary_stats-diff.csv")
write.csv(dat.frac.diff, "summary_stats-frac-diff.csv")


# print(colnames(dat.diff[apply(dat.diff, 2, function(x) {length(unique(x)) != 1}),]))
message("The following statistics differ between old and new")
diff.inds <- which(apply(dat.diff, 2, function(x) {length(unique(x)) != 1}))
print(diff.inds)

write.csv(dat.new[,diff.inds], "summary_stats-new-abbrev.csv")
write.csv(dat.orig[,diff.inds], "summary_stats-orig-abbrev.csv")
write.csv(dat.diff[,diff.inds], "summary_stats-diff-abbrev.csv")
write.csv(dat.frac.diff[,diff.inds], "summary_stats-frac-diff-abbrev.csv")
