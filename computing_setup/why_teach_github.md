# Why We Use Git (And Why You Should Too)

**TL;DR**: Git saves you from losing work, helps you get feedback, and is a skill employers expect. Yes, it takes a bit of learning, but it's worth it.

---

## The Problem Without Git

Have you ever had files named like this?

```
coursework_v1.R
coursework_final.R
coursework_final_REAL.R
coursework_final_REAL_v2.R
coursework_SUBMIT_THIS_ONE.R
```

We've all been there! Without version control, you lose track of what changed and when. If something breaks, you can't easily go back to a working version.

**Git fixes this.** It keeps a complete history of every change you make — who changed what, when, and why.

---

## Why It's Worth Learning

### 1. Your Work is Automatically Backed Up

Every time you **Push** to GitHub, your work is saved to the cloud. If your laptop breaks or gets stolen, your coursework is safe.

Think of it like Google Drive for code — but smarter, because it tracks every version.

### 2. You Can Undo Mistakes

Accidentally deleted something important? Broke your code and don't know why? With Git, you can roll back to a previous version. It's like an unlimited "Undo" button for your entire project.

### 3. Employers Expect It

Here's a reality check: if you apply for a data science job, they'll probably ask you to share your GitHub profile. 

- Saying "I know R and Quarto" on your CV is a **claim**
- Showing them a GitHub repo with clean, documented code is **proof**

Learning Git now gives you a real advantage when job hunting.

### 4. Tutors Can Help You More Easily

When you push your work to GitHub, your Tutor can see exactly what you've done. They can:

- Read your code before you ask for help
- Comment on specific lines
- See what you've tried already

This means better, faster feedback.

### 5. It Works Brilliantly with Quarto

Quarto (which you're using in this course) was designed to work with Git. You can even publish your Quarto documents as websites with one command:

```bash
quarto publish gh-pages
```

Imagine turning your coursework into a portfolio piece with a live URL!

### 6. The 3-Commit Rule (Why We Force You to Do It)

You'll notice in the coursework instructions that we require **at least 3 commits** showing your progress. We're not doing this to be annoying. We do it because:

1.  **Authenticity**: It's the best proof that *you* actually wrote the code over time, rather than copy-pasting it from elsewhere (or an AI) 5 minutes before the deadline.
2.  **Partial Credit**: If your final code doesn't run, but your commit from yesterday did, we can look at that version and give you marks for what worked.
3.  **Safety**: It encourages you to save often, so you never lose more than a few hours of work.

---

## What You Actually Need to Learn

Good news: you don't need to become a Git expert. For this course, you only need three things:

| Action | What It Does |
|--------|--------------|
| **Pull / Clone** | Downloads content (use Clone for new repos, Pull for updates) |
| **Stage & Commit** | Saves your work locally with a message ("Completed Q1") |
| **Push** | Uploads your saved work to GitHub |

That's it! You'll do all of this through RStudio's buttons — no scary command line required.

---

## What We're NOT Teaching

To keep things simple, we're skipping the advanced stuff:

- ❌ Branching and rebasing (advanced team workflows)
- ❌ Command line Git (buttons are fine)
- ❌ Complex `.gitignore` rules (we give you a default one)

If you're curious about these later, great! But you don't need them for this course.

---

## The Bottom Line

| Without Git | With Git |
|-------------|----------|
| Files everywhere, confusing names | One folder, clear history |
| "Did I save that?" anxiety | Everything backed up automatically |
| Hard for Tutors to help you | Tutors can see your code instantly |
| Nothing to show employers | A portfolio that proves your skills |

Yes, it takes a bit of getting used to. But by Week 2, you'll wonder how you ever lived without it.

**Ready to set up Git?** Go back to the [Computer Setup Guide](setup.qmd) and continue with Section 2.
