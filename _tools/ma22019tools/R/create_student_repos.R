#' Create Student Repositories from Template
#'
#' Reads the roster and creates private repositories for each student
#' from a template repository. Adds the student as a collaborator.
#'
#' @param assignment_name String, e.g. "lab-00" - must match a template repo in the org
#' @param org_name String, default "ma22019-2026"
#' @param roster_path String, path to CSV roster
#' @param gh_host String, GitHub host (default "github.bath.ac.uk" for Enterprise)
#'
#' @export
create_student_repos <- function(assignment_name,
                                 org_name = "ma22019-2026",
                                 roster_path = "../roster_public.csv",
                                 gh_host = "github.bath.ac.uk") {
    if (!file.exists(roster_path)) {
        stop("Roster file not found: ", roster_path)
    }

    roster <- readr::read_csv(roster_path, show_col_types = FALSE)

    # Build API URL for GitHub Enterprise
    api_url <- paste0("https://", gh_host, "/api/v3")

    # Template repo name (same as assignment_name)
    template_repo <- assignment_name

    message(glue::glue("Found {nrow(roster)} students."))
    message(glue::glue("Using template: {org_name}/{template_repo}"))
    message(glue::glue("Using GitHub host: {gh_host}"))

    # Verify template exists
    tryCatch(
        {
            gh::gh("GET /repos/{owner}/{repo}",
                owner = org_name,
                repo = template_repo,
                .api_url = api_url
            )
            message(glue::glue("✅ Template repo verified: {template_repo}"))
        },
        error = function(e) {
            stop(glue::glue("❌ Template repo not found: {org_name}/{template_repo}. Create it first!"))
        }
    )

    message(glue::glue("\nStarting repo creation for {assignment_name}...\n"))

    # Iterate over each student
    purrr::walk(roster$username, function(student_user) {
        repo_name <- glue::glue("{assignment_name}-{student_user}")

        # 1. Create Repo from Template
        tryCatch(
            {
                gh::gh("POST /repos/{template_owner}/{template_repo}/generate",
                    template_owner = org_name,
                    template_repo = template_repo,
                    owner = org_name,
                    name = repo_name,
                    private = TRUE,
                    description = glue::glue("MA22019 {assignment_name} for {student_user}"),
                    .api_url = api_url
                )
                message(glue::glue("✅ Created: {repo_name}"))
            },
            error = function(e) {
                if (grepl("name already exists", e$message, ignore.case = TRUE)) {
                    message(glue::glue("ℹ️ Exists: {repo_name}"))
                } else {
                    message(glue::glue("❌ Failed to create {repo_name}: {e$message}"))
                }
            }
        )

        # 2. Add Student as Collaborator
        tryCatch(
            {
                gh::gh("PUT /repos/{org}/{repo}/collaborators/{username}",
                    org = org_name,
                    repo = repo_name,
                    username = student_user,
                    permission = "push",
                    .api_url = api_url
                )
                message(glue::glue("   👤 Added collaborator: {student_user}"))
            },
            error = function(e) {
                message(glue::glue("   ❌ Failed to add {student_user}: {e$message}"))
            }
        )
    })

    message("\nDone!")
}
