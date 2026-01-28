#' Check Submission Status
#'
#' Checks the last push timestamp for all student repositories for a given assignment.
#' Compares against the deadline to identify late submissions.
#'
#' @param assignment_name String, e.g. "hw_01"
#' @param deadline String or POSIXct, e.g. "2026-02-15 17:00"
#' @param org_name String, default "ma22019-2026"
#' @param gh_host String, GitHub host (default "github.bath.ac.uk" for Enterprise)
#'
#' @return A data frame with username, last_push, late_status, and hours_late
#' @export
check_submission_status <- function(assignment_name, deadline, org_name = "ma22019-2026",
                                    gh_host = "github.bath.ac.uk") {
    deadline_app <- lubridate::as_datetime(deadline)

    # Build API URL for GitHub Enterprise
    api_url <- paste0("https://", gh_host, "/api/v3")

    message(glue::glue("Checking submissions for {assignment_name} (Deadline: {deadline_app})..."))

    # 1. List all repos matching the pattern
    repos <- gh::gh("GET /orgs/{org}/repos",
        org = org_name,
        type = "private",
        per_page = 100,
        .limit = Inf,
        .api_url = api_url
    )

    # Filter for assignment
    assignment_repos <- Filter(function(x) grepl(paste0("^", assignment_name, "-"), x$name), repos)

    if (length(assignment_repos) == 0) {
        warning("No repositories found for this assignment.")
        return(NULL)
    }

    message(glue::glue("Found {length(assignment_repos)} student repos."))

    # 2. Extract push times
    results <- purrr::map_df(assignment_repos, function(repo) {
        username <- sub(paste0("^", assignment_name, "-"), "", repo$name)
        last_push <- lubridate::as_datetime(repo$pushed_at)

        is_late <- last_push > deadline_app
        hours_late <- if (is_late) round(difftime(last_push, deadline_app, units = "hours"), 2) else 0

        data.frame(
            username = username,
            last_push = last_push,
            is_late = is_late,
            hours_late = as.numeric(hours_late),
            stringsAsFactors = FALSE
        )
    })

    # Summary
    late_count <- sum(results$is_late)
    message(glue::glue("Summary: {late_count}/{nrow(results)} students submitted late."))

    return(results)
}
