# IDE Choice for Intro to Data Science: RStudio vs. VS Code/Positron

## Executive Summary
**Recommendation:** Use **RStudio** as the primary teaching environment for MA22019.

While VS Code and Positron represent the modern, multi-language future of Data Science (especially in 2026), RStudio remains the superior pedagogical tool for an *introductory* R-based course, particularly given the constraints of university infrastructure and student consistency.

## 1. The "Equity & Infrastructure" Constraint
You noted that **10% of students rely on university computers**, and the network lacks Positron.

*   **The "Broken Laptop" Problem:** If you teach Positron, you effectively exclude the 10% of students who cannot install software. If a student's laptop breaks during the semester, they must fall back to university PCs. If the course material relies on Positron-specific workflows (or VS Code extensions not present on the network), these students are stranded.
*   **The "Standard Operating Environment" (SOE):** RStudio is likely installed and stable on the network. VS Code on university networks is often stripped of necessary extensions or restricted from installing language servers, making the R experience subpar compared to a personal laptop.

## 2. Cognitive Load & Context Switching
Students are already taking other courses that use RStudio.

*   **Uniformity reduces friction:** If a student learns statistics in the morning using RStudio and data science in the afternoon using VS Code/Positron, they burn mental energy re-mapping shortcuts (e.g., `Ctrl+Shift+M` for pipe) and pane layouts instead of learning concepts.
*   **The "Just Works" Factor:** RStudio is purpose-built for R. It handles plotting, help pages, environment variables, and especially **Quarto rendering** with zero configuration. VS Code requires configuring `vscode-R`, `httpgd`, and path variables—problems that distract from the actual syllabus.

## 3. The "Engine vs. Dashboard" Philosophy
You rightly noted that "R is the engine, the IDE is the dashboard."

*   **For Beginners:** The dashboard *is* the car. If the dashboard is confusing (too many buttons, need to edit JSON settings files), they assume the *engine* is broken. RStudio's dashboard is opinionated and optimized strictly for R data science, making the engine approachability higher.
*   **For Professionals:** We want a customizable dashboard (VS Code) to handle multiple engines (Python, SQL, R, Julia). Beginners aren't there yet.

## 4. The "Positron" Factor (2026 Context)
Positron is an exciting development (by Posit/RStudio themselves) and is likely the future successor to RStudio.

*   **Why wait?** Since it is not yet on the university network, it is not a "safe" default. Intro courses should prioritize stability over bleeding-edge features.
*   **2026 Reality:** While VS Code is dominant in industry, RStudio is still the *lingua franca* of academic R. By teaching RStudio, you aren't teaching "obsolete" tech; you are teaching the standard academic toolset.

## 5. Recommended Strategy: The "RStudio First" Approach
Don't ban modern tools, but don't require them.

1.  **Instruction in RStudio:** All live demos, screenshots, and lab instructions should assume RStudio. This guarantees 100% of students (including those on uni PCs) can follow along.
2.  **The "Advanced Track":** Explicitly state: *"You are free to use VS Code or Positron if you prefer, but course staff cannot debug installation issues on your personal machine."* This empowers the top 10% of tech-savvy students without burdening the Tutors.
3.  **The "Bridge" Lecture:** In the final week (or a "Future Career" seminar), demonstrate a workflow in VS Code or Positron. Show *why* a professional might switch (e.g., better Copilot integration, Python interoperability). This plants the seed for their future growth without overwhelming them now.

---
**Verdict:** Stick to RStudio for consistency, equity, and ease of teaching. The transition to VS Code/Positron is a natural evolution they can make in their second year or first job.
