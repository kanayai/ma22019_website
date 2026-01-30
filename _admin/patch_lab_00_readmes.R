# MA22019: Lab 00 README Patcher
# Updates the README title to include the student username

library(gh)
library(glue)
library(readr)
library(base64enc)

# Configuration
assignment_name <- "lab-00"
org_name <- "ma22019-2026"
roster_path <- "_admin/rosters/roster_public.csv"
gh_host <- "github.bath.ac.uk"

# Load Roster
roster <- read_csv(roster_path, show_col_types = FALSE)
api_url <- paste0("https://", gh_host, "/api/v3")

message(glue("🚀 Starting README Patch for {nrow(roster)} students..."))

for (username in roster$username) {
    repo_name <- glue("{assignment_name}-{username}")

    tryCatch(
        {
            # 1. Get current README
            file_info <- gh("GET /repos/{owner}/{repo}/contents/{path}",
                owner = org_name,
                repo = repo_name,
                path = "README.md",
                .api_url = api_url
            )

            # Decode and modify content
            current_content <- rawToChar(base64decode(file_info$content))

            # Check if already patched to avoid duplicates
            if (grepl(paste0("\\(", username, "\\)"), current_content)) {
                message(glue("⏭️  Skipping {username}: Already patched."))
                next
            }

            # Replace the title line
            # Old: "# Lab 0: The Setup Check" -> New: "# Lab 0: The Setup Check (username)"
            new_content <- sub(
                "# Lab 0: The Setup Check",
                glue("# Lab 0: The Setup Check ({username})"),
                current_content
            )

            # 2. Push Update
            gh("PUT /repos/{owner}/{repo}/contents/{path}",
                owner = org_name,
                repo = repo_name,
                path = "README.md",
                message = "Update README title with username",
                content = base64encode(charToRaw(new_content)),
                sha = file_info$sha,
                .api_url = api_url
            )

            message(glue("✅ Patched: {repo_name}"))
        },
        error = function(e) {
            if (grepl("404", e$message)) {
                message(glue("⚠️  Repo not found: {repo_name} (Student hasn't accepted?)"))
            } else {
                message(glue("❌ Error {repo_name}: {e$message}"))
            }
        }
    )
}

message("\n✨ Patching Complete!")
