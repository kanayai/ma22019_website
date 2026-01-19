# Should Data Science Students Learn GitHub?

## Executive Summary
For a modern Data Science curriculum (MA22019), teaching GitHub is **highly recommended**. While it introduces initial cognitive load, it addresses critical industry requirements for reproducibility, collaboration, and portfolio building. Since the course already utilizes Quarto (`.qmd`), the integration with GitHub for publishing and version control provides immediate practical benefits that outweigh the learning curve.

---

## 1. Industry Standard for Reproducibility
In 2026, the definition of a "complete" analysis includes not just the results, but the full history of how those results were achieved.

*   **The Problem:** Without version control, file naming conventions degrade into `analysis_v1.R`, `analysis_final.R`, `analysis_final_REAL.R`. This makes auditing data transformations impossible.
*   **The GitHub Solution:** Git provides an unalterable history of *who* changed *what* and *when*. It allows students to roll back to a working state if they break their code—a massive safety net for beginners.
*   **Employability:** Proficiency in Git is often a "gatekeeper" skill in technical interviews. Employers expect junior data scientists to know how to clone a repo and push code on Day 1.

## 2. The "Portfolio" Factor
For students entering the job market, a GitHub profile acts as a dynamic CV.

*   **Proof of Skill:** Listing "R and Quarto" on a resume is a claim. Linking to a GitHub repository containing a clean, documented investigation (like the topics covered in `01-DataWrangling.qmd`) is **proof**.
*   **Visibility:** It demonstrates they understand professional workflows, markdown documentation, and project organization—soft skills that coding tests often miss.

## 3. Synergy with Quarto (Your Current Stack)

Your course materials use Quarto, which was designed with Git in mind.

*   **Free Publishing:** Quarto natively supports publishing to **GitHub Pages**. Students can turn their homework or final projects into live websites/blogs with a single terminal command:
    ```bash
    quarto publish gh-pages
    ```
*   **Rendered Output vs. Source:** It teaches the valuable distinction between source code (`.qmd`) and production artifacts (`.html`/`.pdf`).

## 4. Collaboration & Group Work
Data Science is inherently collaborative.

*   **Conflict Resolution:** Without Git, students collaborating on a project must take turns editing files or risk overwriting each other's work via cloud storage syncs (Dropbox/OneDrive).
*   **Code Review:** GitHub Pull Requests (PRs) introduce the concept of code review—commenting on specific lines of code before they are merged. This is excellent practice for peer-grading or feedback.

## 5. Implementation Strategy: "Git Lite"
You do not need to teach the full command-line "plumbing" of Git to get 90% of the value.

**The "Happy Path" Workflow:**
Focus on just three concepts using the RStudio or VS Code GUI:

1.  **Pull/Clone:** Get the latest version.
2.  **Stage & Commit:** Save your work with a message.
3.  **Push:** Sync it to the cloud.

**Concepts to Skip (for now):**

*   Branching/Rebasing (unless doing advanced group work).
*   Command line interface (GUI buttons are fine for beginners).
*   Complex .gitignore rules (provide a default one for them).
