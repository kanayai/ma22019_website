# MA22019: Master Package Installation Script
# Run this script to install or update all required packages for the course.

# Function to safely install packages only if missing
install_if_missing <- function(packages) {
    new_packages <- packages[!(packages %in% installed.packages()[, "Package"])]
    if (length(new_packages)) {
        message("Installing: ", paste(new_packages, collapse = ", "))
        install.packages(new_packages)
    } else {
        message("✅ All packages in this group are already installed.")
    }
}

# --- 1. Core Data Science (The Tidyverse) ---
message("\n--- Checking Core Packages ---")
install_if_missing(c(
    "tidyverse", # Includes dplyr, ggplot2, tidyr, readr, etc.
    "rmarkdown",
    "knitr",
    "lubridate" # Dates
))

# --- 2. Visualization Extensions ---
message("\n--- Checking Visualization Packages ---")
install_if_missing(c(
    "patchwork", # Combining plots
    "RColorBrewer",
    "scales"
))

# --- 3. Text Analysis ---
message("\n--- Checking Text Analysis Packages ---")
install_if_missing(c(
    "tidytext",
    "wordcloud",
    "textdata"
))

# --- 4. Spatial Analysis (Mapping) ---
message("\n--- Checking Spatial Packages ---")
install_if_missing(c(
    "sf",
    "tmap", # You didn't have this, but highly recommended for easy maps
    "ggspatial",
    "prettymapr",
    "sp",
    "gstat",
    "spatstat",
    "raster"
))

message("\n=======================================================")
message("🎉 Setup Complete! You are ready for MA22019.")
message("=======================================================")
