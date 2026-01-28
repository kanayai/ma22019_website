#' Generate Tutor's Student List with Marking Progress
#'
#' Creates a markdown table of student repos assigned to a specific tutor,
#' showing which students have already received feedback.
#'
#' @param tutor_name String, the tutor's identifier from the roster
#' @param assignment_name String, e.g. "hw-01"
#' @param org_name String, default "ma22019-2026"
#' @param roster_path String, path to CSV with 'username' and 'tutor' columns
#' @param gh_host String, GitHub host (default "github.bath.ac.uk")
#' @param output_file Optional, path to save markdown output
#'
#' @return A data frame with student info and marking status (also prints markdown)
#' @export
generate_tutor_list <- function(tutor_name,
                                assignment_name,
                                org_name = "ma22019-2026",
                                roster_path = "_admin/rosters/roster.csv",
                                gh_host = "github.bath.ac.uk",
                                output_file = NULL) {
    # Build API URL for GitHub Enterprise
    api_url <- paste0("https://", gh_host, "/api/v3")
    base_url <- paste0("https://", gh_host, "/", org_name)

    # Read roster and filter by tutor
    if (!file.exists(roster_path)) {
        stop("Roster file not found: ", roster_path)
    }

    roster <- readr::read_csv(roster_path, show_col_types = FALSE)

    if (!"tutor" %in% names(roster)) {
        stop("Roster must have a 'tutor' column")
    }

    tutor_students <- roster[roster$tutor == tutor_name, ]

    if (nrow(tutor_students) == 0) {
        warning(paste0("No students found for tutor: ", tutor_name))
        return(NULL)
    }

    message(glue::glue("Found {nrow(tutor_students)} students for {tutor_name}"))
    message("Checking marking progress...")

    # Check each student's repo for Feedback Issues
    results <- purrr::map_df(tutor_students$username, function(username) {
        repo_name <- paste0(assignment_name, "-", username)
        repo_url <- paste0(base_url, "/", repo_name)

        # Check if repo exists and has Feedback Issue
        has_feedback <- FALSE

        tryCatch(
            {
                issues <- gh::gh("GET /repos/{owner}/{repo}/issues",
                    owner = org_name,
                    repo = repo_name,
                    state = "all",
                    .api_url = api_url
                )
                feedback_issues <- Filter(
                    function(i) grepl("Feedback", i$title, ignore.case = TRUE),
                    issues
                )
                has_feedback <- length(feedback_issues) > 0
            },
            error = function(e) {
                # Repo might not exist yet
            }
        )

        data.frame(
            status = ifelse(has_feedback, "✓", "☐"),
            username = username,
            repo_url = repo_url,
            marked = has_feedback,
            stringsAsFactors = FALSE
        )
    })

    # Print markdown table
    marked_count <- sum(results$marked)
    total <- nrow(results)

    cat("\n")
    cat(glue::glue("# {tutor_name} - {assignment_name}\n\n"))
    cat(glue::glue("**Progress: {marked_count}/{total} marked**\n\n"))
    cat("| Status | Student | Repo |\n")
    cat("|--------|---------|------|\n")

    for (i in seq_len(nrow(results))) {
        row <- results[i, ]
        cat(glue::glue("| {row$status} | {row$username} | [Open]({row$repo_url}) |\n"))
    }

    cat("\n")

    # Optionally save to file
    if (!is.null(output_file)) {
        sink(output_file)
        cat(glue::glue("# {tutor_name} - {assignment_name}\n\n"))
        cat(glue::glue("**Progress: {marked_count}/{total} marked**\n\n"))
        cat("| Status | Student | Repo |\n")
        cat("|--------|---------|------|\n")
        for (i in seq_len(nrow(results))) {
            row <- results[i, ]
            cat(glue::glue("| {row$status} | {row$username} | [Open]({row$repo_url}) |\n"))
        }
        sink()
        message(glue::glue("Saved to: {output_file}"))
    }

    invisible(results)
}
