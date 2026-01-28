#' Check TA Marking Progress
#'
#' Checks which student repositories have a "Feedback" issue created.
#' Useful for tracking marking progress.
#'
#' @param assignment_name String, e.g. "hw_01"
#' @param org_name String, default "ma22019-2026"
#' @param gh_host String, GitHub host (default "github.bath.ac.uk" for Enterprise)
#'
#' @return A data frame with username, has_feedback_issue, issue_count
#' @export
check_ta_progress <- function(assignment_name, org_name = "ma22019-2026",
                              gh_host = "github.bath.ac.uk") {
    # Build API URL for GitHub Enterprise
    api_url <- paste0("https://", gh_host, "/api/v3")

    message(glue::glue("Checking TA progress for {assignment_name}..."))

    repos <- gh::gh("GET /orgs/{org}/repos",
        org = org_name,
        type = "private",
        per_page = 100,
        .limit = Inf,
        .api_url = api_url
    )

    assignment_repos <- Filter(function(x) grepl(paste0("^", assignment_name, "-"), x$name), repos)

    if (length(assignment_repos) == 0) {
        warning("No repositories found for this assignment.")
        return(NULL)
    }

    message(glue::glue("Found {length(assignment_repos)} student repos. Checking issues..."))

    results <- purrr::map_df(assignment_repos, function(repo) {
        username <- sub(paste0("^", assignment_name, "-"), "", repo$name)

        # Check for issues
        issues <- tryCatch(
            gh::gh("GET /repos/{owner}/{repo}/issues",
                owner = org_name,
                repo = repo$name,
                state = "all",
                .api_url = api_url
            ),
            error = function(e) list()
        )

        # Check if title contains "Feedback"
        feedback_issues <- Filter(function(i) grepl("Feedback", i$title, ignore.case = TRUE), issues)

        has_feedback <- length(feedback_issues) > 0

        data.frame(
            username = username,
            has_feedback = has_feedback,
            issue_count = length(issues),
            stringsAsFactors = FALSE
        )
    })

    # Summary
    marked_count <- sum(results$has_feedback)
    total <- nrow(results)
    message(glue::glue("Progress: {marked_count}/{total} students have feedback Issues."))

    return(results)
}
