# MA22019: Lab 00 Deployment Script
# This script creates a private repository for each student in the roster.

library(ma22019tools)

message("🚀 Starting Lab 00 Deployment...")

tryCatch(
    {
        create_student_repos(
            assignment_name = "lab-00",
            org_name = "ma22019-2026",
            roster_path = "_admin/rosters/roster_public.csv",
            gh_host = "github.bath.ac.uk"
        )
        message("\n✅ Deployment process finished.")
    },
    error = function(e) {
        message("\n❌ Deployment failed with error:")
        message(e$message)
    }
)
