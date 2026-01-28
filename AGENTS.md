# AGENTS.md - AI Agent Project Guide

> **For AI Agents**: This document provides everything you need to understand and work with this project. Read this first before making any changes.

## Project Overview

**MA22019 Course Website** - A Quarto-based educational website for the "Introduction to Data Science" course at the University of Bath. The site includes lecture notes, slides, labs, homework, quizzes, case studies, and coursework.

- **Tech Stack**: Quarto, R, RevealJS (slides), HTML/CSS
- **Author**: Dr. Karim Anaya-Izquierdo
- **Repository**: https://github.com/kanayai/ma22019_website

---

## ⚠️ Critical: Symlink Architecture

**This project uses symlinks extensively for data management.** Data files are stored on OneDrive and symlinked into the project. This is intentional and must be preserved.

### Primary OneDrive Location
```
/Users/kai21/OneDrive - University of Bath/Teaching/MA22019/from Christian/
```
Alternative path (varies by system):
```
/Users/kai21/Library/CloudStorage/OneDrive-UniversityofBath/Teaching/MA22019/from Christian/
```

### Complete Symlink Map

| Local Path | Target (OneDrive) |
|------------|-------------------|
| `assets/data` | `.../MA22019 Lecture Notes/Data` |
| `lecture_notes/Data` | `.../MA22019 Lecture Notes/Data` |
| `slides/data` | `../assets/data` (relative) |
| `case_studies/data` | `../assets/data` (relative) |
| `practice/week_1/data` | `.../Practice/Week 1/data` |
| `practice/week_2/data` | `.../Practice/Week 2/data` |
| `practice/week_3/data` | `.../Practice/Week 3/data` |
| `practice/week_4/data` | `.../Practice/Week 4/data` |
| `practice/week_5/data` | `.../Practice/Week 5/data` |
| `practice/week_6/data` | `.../Practice/Week 6/data` |
| `practice/week_7/data` | `.../Practice/Week 7/data` |
| `practice/week_8/data` | `.../Practice/Week 8/data` |
| `practice/week_9/data` | `.../Practice/Week 9/data` |
| `live_coding/week_1/Data` | `.../LIve Coding/LIve Coding 1/Data` |
| `live_coding/week_2/Data` | `.../LIve Coding/LIve Coding 2/Data` |
| `live_coding/week_3/Data` | `.../LIve Coding/LIve Coding 3/Data` |
| `live_coding/week_4/Data` | `.../LIve Coding/LIve Coding 4/Data` |
| `live_coding/week_5/Data` | `.../LIve Coding/LIve Coding 5/Data` |
| `Coursework/_Coursework 1/data` | `.../Coursework/Coursework 1/data` |
| `Coursework/_Coursework 2/data` | `.../Coursework/Coursework 2/data` |
| `Coursework/_Coursework 2/original_data` | `.../Coursework/Coursework 2/Original Data` |

### Symlink Rules for AI Agents

1. **Never delete symlinks** - They are tracked in Git intentionally
2. **Never commit actual data files** - They are `.gitignore`d
3. **If a symlink breaks**, recreate it pointing to the OneDrive location
4. **For new data folders**, create a symlink to OneDrive, not a local folder

---

## Directory Structure

```
ma22019_website/
├── _quarto.yml              # Main Quarto config - CRITICAL
├── index.qmd                # Homepage
│
├── lecture_notes/           # Course textbook (4 chapters)
│   ├── 01-DataWrangling.qmd
│   ├── 02-DataVisualization.qmd
│   ├── 03-Text-Data-Analysis.qmd
│   ├── 04-SpatialDataAnalysis.qmd
│   └── Data -> (symlink)
│
├── slides/                  # RevealJS lecture slides
│   ├── _metadata.yml        # Slide-specific Quarto settings
│   ├── 00_overview.qmd
│   ├── 01_data_cleaning_and_wrangling.qmd
│   ├── ...
│   └── data -> ../assets/data
│
├── practice/                # Labs, Homework, Quizzes by week
│   ├── _metadata.yml
│   ├── week_1/
│   │   ├── lab_1.qmd
│   │   ├── homework_1.qmd
│   │   ├── quiz_1.qmd
│   │   └── data -> (symlink)
│   └── week_2/ ... week_9/
│
├── _quizzes/                # Quiz SOLUTIONS (separate from practice/)
│   └── week_2/ ... week_9/
│
├── case_studies/            # Extended analysis examples
│   └── data -> ../assets/data
│
├── live_coding/             # Live coding demos per week
│   └── week_1/ ... week_5/
│
├── Coursework/              # Coursework assignments
│   ├── _Coursework 1/       # Underscore = not yet released
│   └── _Coursework 2/
│
├── computing_setup/         # Student setup guides
│   ├── setup.qmd            # Main setup guide (R, RStudio, Git)
│   ├── project_structure.qmd
│   ├── setup_university_drive.qmd
│   ├── weekly_workflow.qmd  # Weekly pull/clone workflow
│   ├── computing_assignments.qmd
│   ├── troubleshooting.qmd  # Common issues and fixes
│   ├── traditional_workflow.qmd  # Manual (non-Git) workflow
│   ├── why_quarto.qmd
│   └── InstallPackages.R    # R package installer
│
├── _templates/              # Assignment templates for deployment
│   ├── lab-00/
│   └── homework-01/
│
├── _tools/                  # Internal R tools
│   └── ma22019tools/        # R package for assignment deployment
│
├── _admin/                  # Internal/planning files (not rendered)
│   ├── emails/              # Email templates for students/TAs
│   ├── rosters/             # Class rosters
│   ├── new_lectures_plan.qmd
│   ├── Plan for Weeks 1-11.xlsx
│   └── book_generation/     # Legacy PDF book files
│
├── assets/                  # Static assets
│   └── data -> (symlink)    # Centralized data
│
├── style/                   # Custom theming
│   └── sta199.scss
│
├── _freeze/                 # Quarto render cache (tracked)
├── _site/                   # Built website (gitignored)
└── _solutions/              # Solution files (gitignored)
```

---

## File Naming Conventions

- **All files/folders**: `snake_case` (e.g., `week_1`, `lab_1.qmd`)
- **Slides**: `NN_descriptive_name.qmd` (e.g., `01_data_cleaning_and_wrangling.qmd`)
- **Practice files**: `lab_N.qmd`, `homework_N.qmd`, `quiz_N.qmd`
- **Underscore prefix `_`**: Ignored by Quarto (e.g., `_Coursework 1`, `_quizzes`, `_admin`)

---

## Standard Activity Structure

All activities distributed to students (labs, homework, coursework, live coding) should follow the same internal structure. This consistency helps students navigate any activity once they learn the pattern.

```
activity_name/
├── activity_name.Rproj   # RStudio Project file
├── activity_name.qmd     # Main report/analysis file
├── data/                 # Data files for this activity
└── README.md             # (Optional) Instructions
```

**When creating templates for `github.bath.ac.uk`:**
1. Always include an `.Rproj` file matching the folder name
2. Always include a `.qmd` file as the main working document
3. Place all data in a `data/` subfolder
4. Use `snake_case` for all file and folder names

---

## Critical Files (Do Not Delete)

| File | Purpose |
|------|---------|
| `_quarto.yml` | Main site configuration, navigation, theme |
| `practice/_metadata.yml` | Shared settings for practice folder |
| `slides/_metadata.yml` | RevealJS slide settings |
| `style/sta199.scss` | Custom theming |
| `.gitignore` | Defines what's tracked |
| `SYNC_WORKFLOW.md` | Multi-machine sync instructions |
| All symlinks | Data access - see symlink map above |

---

## Build Commands

```bash
# Full render
quarto render

# Development (live reload)
quarto preview

# Single file
quarto render "practice/week_1/lab_1.qmd"
```

---

## Content Release Workflow

### Releasing Solutions
1. Move file from `_solutions/` to appropriate `practice/week_X/` folder
2. Re-render the site
3. Commit and push

### Releasing Coursework
1. Rename `_Coursework X` to `Coursework X` (remove underscore)
2. Update `coursework.qmd` with listing
3. Re-render, commit, push

---

## What's Intentionally Ignored (.gitignore)

- `_site/` - Built output
- `*.csv`, `*.shp`, `*.zip`, `*.nc` - Data files
- `*_files/` - Quarto render artifacts
- `rosm.cache/` - Map tile cache
- `_solutions/` - Unreleased solutions
- `.quarto/` - Quarto internal files

---

## For Merging With Another Project

When merging this project:

1. **Preserve all symlinks** - They are the data access mechanism
2. **Keep `_quarto.yml`** as the source of truth for site structure
3. **`_admin/`** contains internal planning files that can be ignored
4. **`_quizzes/`** contains quiz solutions (separate from student-facing `practice/`)
5. **Check OneDrive paths** if moving to a different machine

---

## Next Steps / TODO (Session Handoff - 2026-01-28)

### Completed This Session
- [x] Verified all documentation updates (Mermaid, 3-Commit Rule, Lab Tutors)
- [x] Fixed remaining "TA" → "Tutor" reference in `weekly_workflow.qmd`
- [x] Added 2FA/PAT troubleshooting section to `troubleshooting.qmd`
- [x] Updated `project_structure.qmd` to match Git workflow structure
- [x] Added "Standard Activity Structure" section to AGENTS.md
- [x] Fixed Mermaid diagram syntax in `weekly_workflow.qmd`

### Pending Decisions
- [ ] **Choose tutor feedback method**: Issues vs Pull Requests
  - See decision doc: `.gemini/antigravity/brain/.../tutor_feedback_decision.md`
  - Recommendation: Issues (simpler for 180 students)
  
- [ ] **Add student notification system for guide updates**
  - Options: CHANGELOG.md, GitHub Releases, or README badge
  - Need to decide and implement in materials repo
