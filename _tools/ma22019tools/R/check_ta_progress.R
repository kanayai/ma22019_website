#' Check TA Marking Progress
#'
#' Checks which student repositories have a "Feedback" issue created.
#' Useful for tracking marking progress.
#'
#' @param assignment_name String, e.g. "hw_01"
#' @param org_name String, default "ma22019-2026"
#'
#' @return A data frame with username, has_feedback_issue, issue_count
#' @export
check_ta_progress <- function(assignment_name, org_name = "ma22019-2026") {
    message(glue::glue("Checking TA progress for {assignment_name}..."))

    repos <- gh::gh("GET /orgs/{org}/repos",
        org = org_name,
        type = "private",
        per_page = 100,
        .limit = Inf
    )

    assignment_repos <- Filter(function(x) grepl(paste0("^", assignment_name, "-"), x$name), repos)

    results <- purrr::map_df(assignment_repos, function(repo) {
        username <- sub(paste0("^", assignment_name, "-"), "", repo$name)

        # Check for issues
        issues <- gh::gh("GET /repos/{owner}/{repo}/issues",
            owner = org_name,
            repo = repo$name,
            state = "all"
        ) # Check open or closed

        # Simple check: Does ANY issue exist? TAs usually create one per assignment.
        # Refinement: Check if title contains "Feedback"
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
