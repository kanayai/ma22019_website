# ma22019tools

Automation tools for the MA22019 Data Science course.

## Installation

This package is designed to be installed locally by the instructor.

```r
# Install dependencies first
install.packages(c("gh", "glue", "readr", "dplyr", "purrr", "lubridate"))

# Install this package (from parent directory)
remotes::install_local("ma22019tools")
```

## Setup

You must be authenticated with GitHub to use these functions.

1. Install the GitHub CLI (`gh`) on your system.
2. Run `gh auth login` in your terminal.
3. Verify with `gh::gh_whoami()` in R.

## Usage

### 1. Create Student Repositories

Reads `roster_public.csv` and creates private repos.

```r
library(ma22019tools)

create_student_repos(
  assignment_name = "hw_01",
  org_name = "ma22019-2026",
  roster_path = "../roster_public.csv"
)
```

### 2. Check Submissions

Find out who submitted late.

```r
status <- check_submission_status(
  assignment_name = "hw_01",
  deadline = "2026-02-15 17:00"
)

# View late submissions
subset(status, is_late == TRUE)
```

### 3. Track TA Progress

See which students have received feedback.

```r
progress <- check_ta_progress("hw_01")
```
