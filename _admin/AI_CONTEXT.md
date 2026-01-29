# AI Context: MA22019 Assignment Deployment

> **Purpose**: Quick reference for AI assistants to understand this project.

## Project Overview

| Item | Details |
|------|---------|
| **Course** | MA22019 Introduction to Data Science (2nd year, University of Bath) |
| **Students** | 180+ |
| **TAs** | 3 |
| **Platform** | `github.bath.ac.uk` only (single platform, no GitHub Classroom) |
| **Language** | R with RStudio |
| **Student skill level** | R beginners, Git beginners |

---

## Key Decisions Made

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Platform | github.bath.ac.uk only | Avoid student confusion with two GitHub platforms |
| Labs location | Inside `materials` repo | Guaranteed folder location (students pull) |
| Homework/Coursework | Separate cloned repos | Students need Git history and backup |
| Student instructions | RStudio buttons only | No terminal commands (beginners) |
| TA feedback | Via GitHub Issues | Attached to code, students can reply |

---

## File Map

| File | Purpose |
|------|---------|
| `assignment_deployment_plan.md` | **Main plan** — read this first |
| `lab_00-template/` | [NEW] Interactive Lab 0 (Setup Check) |
| `homework-01-template/` | [NEW] Homework 1 Template |
| `ma22019tools/` | R package for automation |
| `SETUP_GUIDE.md` | Student instructions for R/Git setup |
| `TROUBLESHOOTING.md` | Common fixes (Auth, Persistence) |
| `TA_MARKING_GUIDE.md` | [NEW] Instructions for TAs |
| `WEEKLY_WORKFLOW.md` | Student guide: timeline of actions |
| `why_teach_github.md` | Student guide: motivation |
| `roster_public.csv` | Student usernames (187 students) |

---

## Repository Structure

### On github.bath.ac.uk/ma22019-2026

| Repo | Type | Student Action |
|------|------|----------------|
| `materials` | Shared (read-only for students) | Clone once, pull weekly |
| `hw_XX-{username}` | Per-student homework | Clone, commit, push |
| `cw_XX-{username}` | Per-student coursework | Clone, commit, push |

### Inside `materials` repo

```
materials/
├── case_studies/      # Theory examples
├── live_coding/       # Lecture demos
├── labs/              # Practice exercises (not graded)
└── lab_solutions/     # Released after each lab
```

### Student local folder structure

```
~/Documents/MA22019/
├── materials/         ← Clone once, pull weekly
│   ├── labs/
│   └── lab_solutions/
├── homework/          ← Clone each assignment here
│   └── hw_01-username/
└── coursework/        ← Clone each assignment here
    └── cw_01-username/
```

---

## Terminology

| Term | Meaning in this project |
|------|------------------------|
| **Pull** | Get updates from `materials` repo (new labs, solutions) |
| **Clone** | Create a copy of homework/coursework repo |
| **Issues** | GitHub's discussion system — used for TA feedback |
| **github.bath.ac.uk** | University's enterprise GitHub (not github.com) |

---

## Current Status

Check `assignment_deployment_plan.md` for current status and next steps.

---

## Common Tasks

| If you need to... | Look at... |
|-------------------|------------|
| Understand the overall plan | `assignment_deployment_plan.md` |
| See why we chose single platform | `platform_comparison.md` |
| See what the old hybrid plan looked like | `assignment_deployment_plan_hybrid_backup.md` |
| Create student repos | Build `ma22019tools` R package |
| Mark homework | GitHub Issues workflow in main plan |
