# MA22019 Tutor Guide

This guide explains how to provide feedback on student homework and coursework using GitHub Issues.

---

## Quick Reference

| Step | Action |
|------|--------|
| 1 | Go to the student's repo on github.bath.ac.uk |
| 2 | Click **Issues** → **New Issue** |
| 3 | Title: `Feedback` (exact word for tracking) |
| 4 | Write your feedback in the body |
| 5 | Click **Submit new issue** |

---

## Workflow Overview

1.  **Wait**: Marking starts after the deadline (typically Friday 17:00).
2.  **Access**: Find student repositories in the `ma22019-2026` organization.
3.  **Review**: Check the `.qmd` code (render locally if needed).
4.  **Feedback**: Open a **GitHub Issue** on their repo.
    *   *Do NOT edit their code directly.*
    *   *Do NOT email them feedback.*

---

## Quick Feedback Template

For quick marking, copy and paste this into the Issue body:

```markdown
## Homework Feedback

**Status**: Satisfactory / Needs Improvement

### What worked well
- [Point 1]
- [Point 2]

### Suggestions for improvement
- [Point 1]
- [Point 2]

### General Comments
[Optional nice message]
```

## Step-by-Step: Giving Feedback

### 1. Find the Student's Repository

1. Go to [github.bath.ac.uk/ma22019-2026](https://github.bath.ac.uk/ma22019-2026)
2. Find the repo matching the assignment and student, e.g.:
   - `hw-01-ab1234` (Homework 1 for student ab1234)
   - `cw-01-cd5678` (Coursework 1 for student cd5678)

### 2. Review Their Work

1. Click on the `.qmd` file to view their code
2. To see the rendered output, you can:
   - Clone the repo locally and run `quarto render`
   - Or use the GitHub preview for a quick look

### 3. Create a Feedback Issue

1. Click the **Issues** tab (top menu)
2. Click **New Issue**
3. **Title**: Use exactly `Feedback` (this word is tracked for progress monitoring)
4. **Body**: Write your feedback. Suggested structure:

```markdown
## Summary
Good work on the data wrangling! A few areas to improve:

## What Went Well ✅
- Clean code structure
- Good use of pipes
- Correct visualizations

## Areas for Improvement 🔧
- Q2: The filter should use `>=` not `>`
- Q4: Consider using `case_when()` instead of nested `ifelse()`

## Code Suggestions
For Q2, try:
```r
data %>% filter(value >= threshold)
```

## Grade/Score (if applicable)
75/100
```

5. Click **Submit new issue**

### 4. Student Notification

- The student will receive an **email notification** automatically
- They can reply to your Issue with questions
- You can close the Issue when feedback is complete

---

## Feedback Best Practices

| Do ✅ | Don't ❌ |
|------|---------|
| Be specific ("Line 15: missing `na.rm = TRUE`") | Be vague ("Fix your code") |
| Praise what's working | Only point out negatives |
| Suggest improvements with examples | Just say "Wrong" |
| Use markdown formatting | Write walls of text |

---

## Finding Your Students

Don't search manually! Run this command to get your personal marking list with progress tracking:

```r
library(ma22019tools)
generate_tutor_list("your_name", "hw-01")
```

This outputs a table like:

```
# your_name - hw-01

**Progress: 5/12 marked**

| Status | Student | Repo |
|--------|---------|------|
| ✓      | ab1234  | [Open](link) |  ← Already marked!
| ☐      | cd5678  | [Open](link) |  ← Needs marking
```

**Key benefits:**
- Run it anytime — the list auto-updates based on your Feedback Issues
- Across multiple days, just check for ☐ entries
- Click the links to go directly to each student's repo

---

## Instructor: Tracking All Tutors

The course instructor can check overall marking progress:

```r
library(ma22019tools)
check_ta_progress("hw-01")
```

This shows which students have received feedback across all tutors.

---

## Common Scenarios

### Student asks a question in their Issue
Reply directly in the Issue thread. GitHub will email them your response.

### Student didn't submit (empty repo)
Still create a Feedback Issue noting the missing submission.

### Need to discuss privately
Use email for sensitive matters, not public Issues.

---

## Getting Help

Contact the course instructor if you:
- Can't access a student's repo
- Have questions about grading criteria
- Encounter technical issues with GitHub
