#' Check Submission Status
#'
#' Checks the last push timestamp for all student repositories for a given assignment.
#' Compares against the deadline to identify late submissions.
#'
#' @param assignment_name String, e.g. "hw_01"
#' @param deadline String or POSIXct, e.g. "2026-02-15 17:00"
#' @param org_name String, default "ma22019-2026"
#'
#' @return A data frame with username, last_push, late_status, and hours_late
#' @export
check_submission_status <- function(assignment_name, deadline, org_name = "ma22019-2026") {
    deadline_app <- lubridate::as_datetime(deadline)

    message(glue::glue("Checking submissions for {assignment_name} (Deadline: {deadline_app})..."))

    # 1. List all repos matching the pattern
    # Note: This might need pagination for >100 repos. Using .limit = Inf if supported or loop.
    # gh::gh supports .limit=Inf in some versions, or automatic pagination.
    repos <- gh::gh("GET /orgs/{org}/repos",
        org = org_name,
        type = "private",
        per_page = 100,
        .limit = Inf
    )

    # Filter for assignment
    assignment_repos <- Filter(function(x) grepl(paste0("^", assignment_name, "-"), x$name), repos)

    if (length(assignment_repos) == 0) {
        warning("No repositories found for this assignment.")
        return(NULL)
    }

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

    return(results)
}
