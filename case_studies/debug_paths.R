# Debugging Paths
setwd("case_studies")

# 1. Check London
cat("Checking London:\n")
p1 <- "data/shapefiles/London.shp"
cat(p1, ": ", file.exists(p1), "\n")

# 2. Check German Shapefile (Guessing path)
cat("\nChecking German:\n")
p2 <- "data/shapefiles/gadm41_DEU_1.shp"
cat(p2, ": ", file.exists(p2), "\n")

p3 <- "data/gadm41_DEU_shp/gadm41_DEU_1.shp"
cat(p3, ": ", file.exists(p3), "\n")

# 3. Check USA Shapefile
cat("\nChecking USA:\n")
p4 <- "data/shapefiles/gadm41_USA_1.shp"
cat(p4, ": ", file.exists(p4), "\n")

p5 <- "data/gadm41_USA_shp/gadm41_USA_1.shp"
cat(p5, ": ", file.exists(p5), "\n")

# 4. List data root
cat("\nListing data root:\n")
print(list.files("data"))
