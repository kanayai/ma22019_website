#' Create Student Repositories
#'
#' Reads the roster and creates private repositories for each student
#' in the specified organization. Adds the student as a collaborator.
#'
#' @param assignment_name String, e.g. "hw_01" or "cw_01"
#' @param org_name String, default "ma22019-2026"
#' @param roster_path String, path to CSV roster
#'
#' @export
create_student_repos <- function(assignment_name,
                                 org_name = "ma22019-2026",
                                 roster_path = "../roster_public.csv") {
    if (!file.exists(roster_path)) {
        stop("Roster file not found: ", roster_path)
    }

    roster <- readr::read_csv(roster_path, show_col_types = FALSE)

    message(glue::glue("Found {nrow(roster)} students. Starting repo creation for {assignment_name}..."))

    # Iterate over each student
    purrr::walk(roster$username, function(student_user) {
        repo_name <- glue::glue("{assignment_name}-{student_user}")

        # 1. Create Repo (if not exists)
        tryCatch(
            {
                gh::gh("POST /orgs/{org}/repos",
                    org = org_name,
                    name = repo_name,
                    private = TRUE,
                    description = glue::glue("MA22019 {assignment_name} for {student_user}"),
                    auto_init = TRUE
                ) # Initialize with README
                message(glue::glue("✅ Created: {repo_name}"))
            },
            error = function(e) {
                if (grepl("name already exists", e$message)) {
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
                    permission = "push"
                )
                message(glue::glue("   👤 Added collaborator: {student_user}"))
            },
            error = function(e) {
                message(glue::glue("   ❌ Failed to add {student_user}: {e$message}"))
            }
        )
    })

    message("Done!")
}
