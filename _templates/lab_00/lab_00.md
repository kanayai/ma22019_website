# Lab 00: The Setup Check
Your Name Here
2026-02-02

### Quick Guide: The YAML Header

**⚠️ WARNING:** The lines between the `---` at the top of this file are
called the **YAML header**. This is weirdly sensitive—if you check
indentation or spacing, it can break the whole document. **Do not touch
it** unless specifically instructed below (we will ask you to change
your name).

For more details, see the [Computing Setup
Guide](https://kanayai.github.io/ma22019_website/computing_setup/setup.html).

### Tips for Working in Quarto

- **Use Source Mode**: Click the “Source” button (top-left of this pane)
  to see the raw code.
- **Render Often**: Hit the **Render** button every few minutes to catch
  errors early.
- **File Naming**: Always use `snake_case` for *new* files you create
  (e.g., `my_analysis.qmd`). For this lab, **keep the file names exactly
  as they are**.

# 👋 Welcome to the Git Workflow!

If you are reading this in RStudio, **CONGRATULATIONS!** You have
successfully cloned your first repository. That is 50% of the battle
won.

**⚠️ STOP:** Has GitHub asked you to set up “Two-Factor Authentication
(2FA)”? **Do NOT activate it yet.** If you do, it will break how RStudio
talks to GitHub. We will fix this in a future week.

Today, we will finish the setup by learning how to **save** your work
back to the cloud.

------------------------------------------------------------------------

## Step 0: Verify Location (New!)

Before we start, let’s make sure you are in the right place.

1.  Look at the **Console** pane (bottom left).
2.  Type `source("check_location.R")` and press Enter.
3.  If it says **SUCCESS**, you are good to go!
4.  If it says **WARNING**, ask a TA for help immediately.

------------------------------------------------------------------------

## Step 1: Tell Us Who You Are

We need to make sure your name appears correctly on your work.

1.  Look at the top of this file (lines 1-4).
2.  Find the line that says: `author: "Your Name Here"`.
3.  Change `"Your Name Here"` to **your actual name** (e.g.,
    `"Jane Doe"`).
4.  Save this file (Cmd+S / Ctrl+S).

### (Optional) Update your GitHub Profile

Since we are setting things up, take a moment to look professional.

1.  Click on your profile icon in the upper right corner of the [GitHub
    page](https://github.bath.ac.uk) and select **Settings**.
2.  On the left side, click **Public profile**.
3.  Fill out your information and **Add a profile picture** if you wish
    (it helps TAs learn your name!).
4.  Click **Update profile**.

------------------------------------------------------------------------

## Step 2: Render to Markdown

In this course, we produce professional reports. Let’s make one now.

1.  Look for the **Render** button at the top of this pane (it has a
    blue arrow icon ➡️).
2.  Click **Render**.
    - *Note: If a popup asks you to install packages, say Yes.*
3.  A beautiful Markdown file should appear (previewed in RStudio).

**Checkpoint**: Do you see your name in the title of the Markdown
report?

> **Stuck?** Check the [Troubleshooting
> Guide](https://kanayai.github.io/ma22019_website/computing_setup/troubleshooting.html).

------------------------------------------------------------------------

## Step 3: The “Save” vs “Commit” Reality Check (CRITICAL)

You have just saved the file (Cmd+S) and Rendered it.

**STOP AND THINK**: Where are these changes?

- ✅ They are on your **laptop’s hard drive**.
- ❌ They are **NOT on GitHub** yet.

### Prove it to yourself:

1.  Open your web browser.
2.  Go to your repository page on **github.bath.ac.uk** (refresh the
    page).
3.  Look at `lab_00.qmd`.
4.  Does it show your actual name?
    - **NO**, it still says `"Your Name Here"`.
    - This is because “Saving” only happens on your computer.

To get it to GitHub, we need the **Git Cycle**: **Stage -\> Commit -\>
Push**.

------------------------------------------------------------------------

## Step 4: The Build-up (Stage & Commit)

Think of this like online shopping.

1.  **Stage (The Shopping Basket)**

    - Go to the **Git Pane** (top right in RStudio).
    - Tick the **Staged** box next to `lab_00.qmd`.
    - *Meaning: “I want to include this file in my next package.”*

2.  **Commit (The Order Confirmation)**

    - Click the **Commit** button.
    - Type a message: `"Fixed author name"`.
    - Click **Commit**.
    - *Meaning: “I have sealed the package.”*

**PAUSE**: Even now, check GitHub again. **It is still not there!** A
“Commit” is still only on your laptop (it’s a saved version in your
local Git history).

------------------------------------------------------------------------

## Step 5: The Release (Push)

This is the only step that moves data to the cloud.

1.  **Push (The Delivery)**
    - Click the **Green Up Arrow** ⬆️ (Push) in the Git pane.
    - *Note: If it asks for a username/password, use your Bath
      university credentials.*
    - Wait for the message `HEAD -> main`.

------------------------------------------------------------------------

## Step 6: Final Verification

1.  Go back to your web browser.
2.  **Refresh** the GitHub page.
3.  Look at `lab_00.qmd`.
4.  **NOW** it should show your actual name.
5.  Look for `lab_00.md`. It should be there too! (And if you click it,
    it looks great!)

✅ **Mission Accomplished**: You now understand the difference between
*Saving* (Local) and *Pushing* (Cloud).

------------------------------------------------------------------------

## One Last Thing: Prove R Works

### Part A: Simple Data Manipulation (dplyr)

Run the following code chunk by clicking the **Green Play Button** (▶️)
on the right.

``` r
library(dplyr)

# Let's verify R can do math
mtcars %>% 
  group_by(cyl) %>% 
  summarise(mean_mpg = mean(mpg))
```

    # A tibble: 3 × 2
        cyl mean_mpg
      <dbl>    <dbl>
    1     4     26.7
    2     6     19.7
    3     8     15.1

You should see a small table appear below the code. This confirms
`dplyr` is installed and working.

### Part B: Visualization (ggplot2)

Now run this chunk to see a plot.

``` r
library(ggplot2)

ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
    geom_point(size = 3) +
    geom_smooth(method = "lm", se = FALSE) +
    theme_minimal() +
    labs(
        title = "My First R Plot",
        subtitle = "If you can see this, R is working perfectly.",
        x = "Engine Size",
        y = "Highway MPG"
    )
```

![](lab_00_files/figure-commonmark/test-plot-1.png)

**Important Distinction:**

- **Running the chunk (Play button):** Shows the plot *here* in RStudio
  for you to see.
- **Rendering the file:** Puts the plot into the final visible document.

If you can see the plot above, you are ready for the semester!

------------------------------------------------------------------------

## Bonus: The Golden Rules of File Naming

As a Data Scientist, you will generate hundreds of files. If you name
them poorly, you will lose them.

**The 3 Principles**

1.  **Machine Readable:** No spaces, punctuation, or accents. Use `_` or
    `-`.
2.  **Human Readable:** Meaningful names. `analysis.R` is bad;
    `01_data_cleaning.R` is good.
3.  **Sortable:** Use ISO dates (`YYYY-MM-DD`) and numbered prefixes
    (`01_`, `02_`).

### Examples

| Bad ❌             | Good ✅                    |
|--------------------|----------------------------|
| `my abstract.docx` | `2025-02-15_abstract.docx` |
| `Joe's File.xlsx`  | `joes_file.csv`            |
| `figure 1.png`     | `fig01_scatterplot.png`    |
| `final_final_v2.R` | `04_model_evaluation.R`    |

**Apply these rules to every NEW file you create from now on!**
