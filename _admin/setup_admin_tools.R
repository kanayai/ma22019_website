# MA22019: Admin Tools Setup Script
# Run this when switching machines to ensure deployment tools are installed.

message("🛠️ Checking Admin Tools Setup...")

# 1. Check for GitHub CLI
gh_path <- Sys.which("gh")
if (gh_path == "") {
    warning("⚠️ GitHub CLI ('gh') is NOT installed or not on the PATH.")
    message("   Please run: brew install gh")
} else {
    message("✅ GitHub CLI found: ", gh_path)
}

# 2. Install Package Dependencies
required_packages <- c("gh", "glue", "readr", "dplyr", "purrr", "lubridate", "remotes")
new_packages <- required_packages[!(required_packages %in% installed.packages()[, "Package"])]
if (length(new_packages)) {
    message("Installing dependencies: ", paste(new_packages, collapse = ", "))
    install.packages(new_packages)
} else {
    message("✅ Dependencies already installed.")
}

# 3. Install ma22019tools (Internal Package)
message("Installing/Updating local 'ma22019tools' package...")
tryCatch(
    {
        remotes::install_local("_tools/ma22019tools", force = TRUE, quiet = FALSE)
        message("✅ ma22019tools successfully installed!")
    },
    error = function(e) {
        message("❌ Error installing ma22019tools:")
        message(e$message)
        message("\nPossible fix: Ensure you are in the root 'ma22019_website' directory.")
    }
)
