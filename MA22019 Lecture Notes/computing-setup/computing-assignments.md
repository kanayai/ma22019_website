# Assignment Workflow with RStudio & GitHub Web

In MA22019, we use **GitHub** for all assignment submissions. This serves two purposes:

1.  **Formative Assessment:** It allows us to give you feedback on your code, not just your final answers.
2.  **Industry Skills:** You are building a portfolio. By the end of this course, your GitHub profile will prove to employers that you can manage a data science project professionally.

We streamline this process using **GitHub Classroom** and **RStudio's** built-in tools. You essentially never need to open the terminal.

---

## The "Happy Path" Workflow

Follow these 4 steps for every assignment.

### Step 1: Accept the Assignment
1.  Click the **GitHub Classroom link** provided on Moodle/Course Page.
2.  GitHub will automatically create a private repository for you (e.g., `assignment-1-yourname`).
3.  **Copy the URL** of this new repository from your browser address bar.
    *   *It should look like: `https://github.com/MA22019/assignment-1-yourname`*

### Step 2: Clone into RStudio
**Do not download a ZIP file.** We will connect RStudio directly to the cloud.

1.  Open **RStudio**.
2.  Go to `File` > `New Project...`
3.  Choose **Version Control** (the 3rd option).
4.  Choose **Git** (the 1st option).
5.  Paste the **Repository URL** you copied in Step 1.
6.  Click **Create Project**.

*Result: RStudio will download your assignment files and open them automatically.*

### Step 3: The "Edit - Commit" Loop
You should save your work to the "cloud" (GitHub) frequently. Think of this as a super-charged "Save" button.

**The Workflow:**

1.  **Edit:** Work on your `.qmd` file. Write code, analysis, and answers.
2.  **Render:** Click "Render" to ensure your code runs and produces the HTML output.
3.  **Stage (The Checkbox):**
    *   Go to the **Git Pane** in RStudio (usually top-right).
    *   Check the **Staged** box next to the files you changed (e.g., `assignment.qmd`).
4.  **Commit (The Snapshot):**
    *   Click the **Commit** button in the Git Pane.
    *   Write a message in the box: *"Completed Question 1 data cleaning"*.
    *   Click **Commit**.

*Repeat this step at least 3 times per assignment (see Grading below).*

### Step 4: Submit (Push)
Your "Commits" are currently only saved on your *local computer*. To submit them to us, you must **Push**.

1.  In the Git Pane, look for the **Green Up Arrow** (Push).
2.  Click it.
3.  Wait for the message: *"HEAD -> main... set up to track remote branch..."*

**Verification:** Go back to your GitHub repository page in your browser and refresh. You should see your latest commit message and updated files.

---

## What Gets Graded?

### 1. Content (80%)
*   **The Code:** Does it run? Is it efficient?
*   **The Analysis:** Is your statistical interpretation correct?
*   **The Output:** Did you include the rendered HTML file?

### 2. Workflow Points (20%) - "The 3-Commit Rule"
We grade your professional habits. 

**Requirement:** You **must commit at least 3 times** as you work through the assignment.

*   ❌ **Bad:** One giant commit named "Uploaded files" at 11:59 PM.
*   ✅ **Good:** Small, logical steps.
    *   *Commit 1:* "Loaded data and fixed missing values"
    *   *Commit 2:* "Added ggplot analysis for Q2"
    *   *Commit 3:* "Final proofread and formatting"

**Why?**

1.  **Safety:** If your computer breaks, we can grade your partial work on GitHub.
2.  **Proof:** It proves you did the work incrementally and didn't copy-paste a finished solution at the last minute.

---

## Troubleshooting

### "I don't see the Git Pane in RStudio"

*   Did you skip Step 2? You must create a **New Project > Version Control**. You cannot just "Open File".
*   Try `Tools > Project Options > Git/SVN` and ensure "Version control system" is set to "Git".

### "Push Failed" (Login Errors)
*   GitHub no longer accepts regular passwords. 
*   If RStudio asks for a username/password:
    *   **Username:** Your GitHub username.
    *   **Password:** You must use a **Personal Access Token (PAT)**. 
    *   *See the [Setup Guide] for generating a PAT.*

### "Merge Conflict"
*   This rarely happens in individual assignments unless you edit files on two different computers.
*   If you see `<<<<<<< HEAD`, ask a TA for help immediately. Don't panic!

---

## Submission Checklist
Before the deadline, verify:

- [ ] All questions are answered in the `.qmd`.
- [ ] The document **Renders** without error (check the HTML).
- [ ] You have **Committed** your changes (Git Pane is empty).
- [ ] You have **Pushed** your commits (Green Arrow).
- [ ] **FINAL CHECK:** Open your repo on GitHub.com in a private/incognito window. Does it look correct? That is exactly what we see.
