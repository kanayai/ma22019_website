# MA22019: Student Status Checker
# Checks if students have created their Lab 00 repo and if they have pushed commits.

library(gh)
library(glue)
library(readr)
library(dplyr)
library(lubridate)

# Configuration
assignment_name <- "lab-00"
org_name <- "ma22019-2026"
gh_host <- "github.bath.ac.uk"

# Smart Path Finding
possible_paths <- c(
    "_admin/rosters/roster_public.csv", # From Project Root
    "rosters/roster_public.csv", # From _admin/ folder
    "../_admin/rosters/roster_public.csv" # Just in case
)

roster_path <- NULL
for (p in possible_paths) {
    if (file.exists(p)) {
        roster_path <- p
        break
    }
}

if (is.null(roster_path)) {
    stop(glue("❌ Roster not found! Checked: {paste(possible_paths, collapse=', ')}"))
}

message(glue("✅ Found roster at: {roster_path}"))
roster <- read_csv(roster_path, show_col_types = FALSE)
api_url <- paste0("https://", gh_host, "/api/v3")

message(glue("🔍 Checking status for {nrow(roster)} students..."))

results <- data.frame(
    username = character(),
    status = character(),
    last_commit = character(),
    stringsAsFactors = FALSE
)

for (username in roster$username) {
    repo_name <- glue("{assignment_name}-{username}")

    # Check Status
    status <- tryCatch(
        {
            # 1. Try to get repo details
            repo <- gh("GET /repos/{owner}/{repo}",
                owner = org_name,
                repo = repo_name,
                .api_url = api_url
            )

            # 2. Try to get commits
            commits <- gh("GET /repos/{owner}/{repo}/commits",
                owner = org_name,
                repo = repo_name,
                per_page = 1,
                .api_url = api_url
            )

            if (length(commits) > 0) {
                commit_info <- commits[[1]]
                author_name <- commit_info$commit$author$name
                message_text <- commit_info$commit$message
                last_date <- as_datetime(commit_info$commit$author$date)
                time_ago <- round(difftime(Sys.time(), last_date, units = "hours"), 1)

                # Heuristic: It's only "Active" if the student did it.
                # If author is GitHub Classroom or "github-classroom[bot]", it's likely just the template.
                # ALSO: Ignore automated patches from the instructor.
                is_template <- grepl("classroom", tolower(author_name)) || grepl("initial commit", tolower(message_text))
                is_patch <- grepl("update check_location logic", tolower(message_text)) || grepl("add do not move warning", tolower(message_text))

                if (is_template || is_patch) {
                    list(state = "✅ Created", info = glue("by {author_name}"))
                } else {
                    list(state = "🚀 Active", info = glue("{time_ago} hrs ago by {author_name}"))
                }
            } else {
                list(state = "✅ Created", info = "No commits yet")
            }
        },
        error = function(e) {
            if (grepl("404", e$message)) {
                list(state = "❌ Missing", info = "Repo not found")
            } else {
                list(state = "⚠️ Error", info = substr(e$message, 1, 20))
            }
        }
    )

    # Print progress
    message(glue("[{username}] {status$state} ({status$info})"))

    # Add to results
    results <- rbind(results, data.frame(
        username = username,
        status = status$state,
        last_update = status$info
    ))
}

# Summary
message("\n--- Summary ---")
print(table(results$status))
