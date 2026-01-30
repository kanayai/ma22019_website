# MA22019: Lab 00 MEGA Patch
# 1. Updates check_location.R (Enforce 'practice/' folder, BAN 'materials/')
# 2. Updates README.md (Add DO NOT MOVE warning)

library(gh)
library(glue)
library(readr)
library(base64enc)

# Configuration
assignment_name <- "lab-00"
org_name <- "ma22019-2026"
roster_path <- "_admin/rosters/roster_public.csv" # Students
gh_host <- "github.bath.ac.uk"

# --- NEW CONTENT DEFINITIONS ---

# 1. New check_location.R content
new_check_location <- '# MA22019 Location Check
# Run this script to verify you cloned the repo to the correct place.

cat("Checking your project location...\\n")
current_dir <- getwd()

# RULE 1: MUST NOT be inside "materials" (Prevents Repo-in-Repo)
if (grepl("/materials/", current_dir)) {
  cat("\\n❌ DANGER: You are inside the \'materials\' folder!\\n")
  cat("This will break Git. Please delete this folder and clone again into \'MA22019/practice/\'.\\n")
  stop("Invalid Location")
}

# RULE 2: ALLOW practice, homework, coursework
if (grepl("MA22019/practice", current_dir) ||
    grepl("MA22019/homework", current_dir) ||
    grepl("MA22019/coursework", current_dir)) {
  cat("\\n✅ SUCCESS: You are in the correct folder structure!\\n")
  cat("Path:", current_dir, "\\n")
} else {
  cat("\\n⚠️  WARNING: Unrecognized folder structure.\\n")
  cat("Expected path: .../MA22019/practice/lab-00...\\n")
  cat("Current path:", current_dir, "\\n")
  cat("If you are sure you are NOT inside \'materials\', you can ignore this.\\n")
}
'

# 2. New README warning (We append this to the existing README)
readme_warning <- "

## ⚠️ CRITICAL WARNING
**Do NOT move this folder** after cloning it.
If you drag-and-drop this folder into another location (like `materials`), you will break the Git connection.
If you need to move it, **delete it** and clone it again in the new location.
"


# --- EXECUTION ---

roster <- read_csv(roster_path, show_col_types = FALSE)
api_url <- paste0("https://", gh_host, "/api/v3")

message(glue("🚀 Starting MEGA Patch for {nrow(roster)} students..."))

patch_file <- function(repo_name, path, content, message_str) {
    tryCatch(
        {
            file_info <- gh("GET /repos/{owner}/{repo}/contents/{path}",
                owner = org_name,
                repo = repo_name,
                path = path,
                .api_url = api_url
            )

            gh("PUT /repos/{owner}/{repo}/contents/{path}",
                owner = org_name,
                repo = repo_name,
                path = path,
                message = message_str,
                content = base64encode(charToRaw(content)),
                sha = file_info$sha,
                .api_url = api_url
            )
            return(TRUE)
        },
        error = function(e) {
            return(FALSE)
        }
    )
}

for (username in roster$username) {
    repo_name <- glue("{assignment_name}-{username}")

    # 1. Patch check_location.R
    res1 <- patch_file(repo_name, "check_location.R", new_check_location, "Update check_location logic")

    # 2. Patch README.md (Append warning)
    # First get current content
    tryCatch(
        {
            file_info <- gh("GET /repos/{owner}/{repo}/contents/README.md",
                owner = org_name,
                repo = repo_name,
                .api_url = api_url
            )
            current_readme <- rawToChar(base64decode(file_info$content))

            if (!grepl("CRITICAL WARNING", current_readme)) {
                new_readme <- paste0(current_readme, readme_warning)
                res2 <- patch_file(repo_name, "README.md", new_readme, "Add DO NOT MOVE warning")
            } else {
                res2 <- TRUE # Already patched
            }
        },
        error = function(e) res2 <- FALSE
    )

    if (res1 && res2) {
        message(glue("✅ Patched: {repo_name}"))
    } else {
        message(glue("⚠️  Issue patching: {repo_name} (Maybe not created yet?)"))
    }
}

message("\n✨ Mega Patch Complete!")
