# ma22019tools - Instructor Guide

Automation tools for deploying and managing student assignments in MA22019.

---

## 🚀 Quick Start

### Step 1: One-Time Setup

**1.1. Install GitHub CLI** (if not already installed)

```bash
brew install gh
```

**1.2. Authenticate with GitHub Enterprise**

```bash
gh auth login --hostname github.bath.ac.uk
```
- Choose **HTTPS**
- Follow the browser prompts to authenticate

**1.3. Verify authentication**

```bash
gh auth status --hostname github.bath.ac.uk
```

**1.4. Install the R package**

Open RStudio and run:

```r
# Install dependencies (only needed once)
install.packages(c("gh", "glue", "readr", "dplyr", "purrr", "lubridate", "remotes"))

# Navigate to the website project folder, then:
remotes::install_local("_tools/ma22019tools")
```

---

## 📚 Complete Workflow

### PHASE 1: Before the Semester - Create Template Repos

For each assignment type (lab, homework, coursework), you need a **template repository**.

**Step A: Create the template folder in `_templates/`**

```
_templates/
├── lab-00/
│   ├── lab_00.qmd        # Main student file
│   ├── lab_00.Rproj      # RStudio project
│   ├── README.md         # Instructions
│   └── .gitignore        # Ignore HTML output
├── hw-01/
│   └── ...
```

**Step B: Push to GitHub as a template**

```bash
# Create the repo
GH_HOST=github.bath.ac.uk gh repo create ma22019-2026/lab-00 --private

# Clone, copy files, push
GH_HOST=github.bath.ac.uk gh repo clone ma22019-2026/lab-00 ~/Desktop/temp-repo
cp -r _templates/lab-00/* ~/Desktop/temp-repo/
cd ~/Desktop/temp-repo
git add . && git commit -m "Initial template" && git push

# Mark as template
GH_HOST=github.bath.ac.uk gh api repos/ma22019-2026/lab-00 -X PATCH -f is_template=true

# Clean up
rm -rf ~/Desktop/temp-repo
```

---

### PHASE 2: Before Each Assignment - Deploy to Students

**Step A: Prepare the roster**

Create a CSV file at `_admin/rosters/roster.csv`:

```csv
username
ab1234
cd5678
ef9012
...
```

> **Tip**: Export this from Moodle or your student management system.

**Step B: Run the deployment**

```r
library(ma22019tools)

create_student_repos(
  assignment_name = "lab-00",           # Must match template repo name exactly
  org_name = "ma22019-2026",
  roster_path = "_admin/rosters/roster.csv"
)
```

**What this does:**
1. Verifies the template repo exists (`ma22019-2026/lab-00`)
2. Creates a private repo for each student: `lab-00-ab1234`, `lab-00-cd5678`, etc.
3. Copies all template files into each student repo
4. Adds each student as a collaborator with push access

---

### PHASE 3: After the Deadline - Check Submissions

```r
library(ma22019tools)

status <- check_submission_status(
  assignment_name = "lab-00",
  deadline = "2026-02-15 17:00"
)

# View all
print(status)

# View only late submissions
subset(status, is_late == TRUE)

# Export to CSV
write.csv(status, "_admin/lab-00-submissions.csv", row.names = FALSE)
```

**Output columns:**
| Column | Description |
|--------|-------------|
| `username` | Student's GitHub username |
| `last_push` | Timestamp of their last push |
| `is_late` | TRUE if pushed after deadline |
| `hours_late` | How many hours late (0 if on time) |

---

### PHASE 4: Track Marking Progress

Lab Tutors give feedback via **GitHub Issues**. Track who has been marked:

```r
library(ma22019tools)

progress <- check_ta_progress("lab-00")

# View all
print(progress)

# Who still needs marking?
subset(progress, has_feedback == FALSE)
```

**Output columns:**
| Column | Description |
|--------|-------------|
| `username` | Student's GitHub username |
| `has_feedback` | TRUE if an Issue with "Feedback" in the title exists |
| `issue_count` | Total number of Issues on the repo |

---

## 📋 Function Reference

### `create_student_repos()`

Creates student repos from a template.

```r
create_student_repos(
  assignment_name,                        # e.g., "lab-00", "hw-01"
  org_name = "ma22019-2026",              # GitHub organization
  roster_path = "../roster_public.csv",   # Path to student username CSV
  gh_host = "github.bath.ac.uk"           # GitHub Enterprise host
)
```

### `check_submission_status()`

Checks when students last pushed.

```r
check_submission_status(
  assignment_name,                        # e.g., "lab-00"
  deadline,                               # e.g., "2026-02-15 17:00"
  org_name = "ma22019-2026",
  gh_host = "github.bath.ac.uk"
)
```

### `check_ta_progress()`

Checks which students have received feedback.

```r
check_ta_progress(
  assignment_name,                        # e.g., "lab-00"
  org_name = "ma22019-2026",
  gh_host = "github.bath.ac.uk"
)
```

### `generate_tutor_list()`

Generates a tutor's marking list with auto-updating progress.

```r
generate_tutor_list(
  tutor_name,                             # e.g., "alice"
  assignment_name,                        # e.g., "hw-01"
  org_name = "ma22019-2026",
  roster_path = "_admin/rosters/roster.csv",  # Must have 'tutor' column
  gh_host = "github.bath.ac.uk"
)
```

---

## ❓ Troubleshooting

### "GitHub API error (404): Not Found"
- Verify you're authenticated: `gh auth status --hostname github.bath.ac.uk`
- Check the organization name is correct
- Ensure the template repo exists

### "Roster file not found"
- Check the path is relative to your current working directory
- Use `getwd()` in R to see where you are

### Package won't install
- Make sure you're in the `ma22019_website` folder
- Run `remotes::install_local("_tools/ma22019tools", force = TRUE)` to force reinstall

### Some students don't have repos
- They may not have accepted the collaborator invitation
- Check their email matches their `github.bath.ac.uk` username
