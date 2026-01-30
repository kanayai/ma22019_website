# MA22019: Lab 00 README Patcher (Tutors Edition)
# Updates the README title for tutor repos too

library(gh)
library(glue)
library(readr)
library(ma22019tools)

message("🚀 Starting Lab 00 Deployment for Tutors...")

create_student_repos(
    assignment_name = "lab-00",
    org_name = "ma22019-2026",
    roster_path = "_admin/rosters/roster_tutors.csv",
    gh_host = "github.bath.ac.uk"
)
