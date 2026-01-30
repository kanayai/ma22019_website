# MA22019 Course Website

A comprehensive Quarto-based website for the MA22019 (Introduction to Data Science) course at the University of Bath.

> **🤖 For AI Agents**: See [AGENTS.md](AGENTS.md) for detailed project structure, symlink architecture, and conventions.

## 📚 Website Structure

| Section | Location | Description |
|---------|----------|-------------|
| **Home** | `index.qmd` | Course overview and announcements |
| **Lecture Notes** | `lecture_notes/*.qmd` | Full course textbook (4 chapters) |
| **Slides** | `slides/NN_*.qmd` | RevealJS presentation slides |
| **Labs** | `practice/week_X/lab_X.qmd` | Weekly lab exercises |
| **Homework** | `practice/week_X/homework_X.qmd` | Weekly homework assignments |
| **Quizzes** | `practice/week_X/quiz_X.qmd` | Weekly practice quizzes |
| **Case Studies** | `case_studies/*.qmd` | Extended analysis examples |
| **Live Coding** | `live_coding/week_X/` | In-class coding demonstrations |
| **Computing Setup** | `computing_setup/` | Student setup guides |

## 📁 Folder Overview

```
ma22019_website/
├── _quarto.yml              # Main site configuration
├── index.qmd                # Homepage
├── labs.qmd                 # Labs listing page
├── homework.qmd             # Homework listing page
├── slides.qmd               # Slides listing page
├── coursework.qmd           # Coursework info page
│
├── lecture_notes/           # Course textbook (4 chapters)
├── slides/                  # Lecture slides (RevealJS)
├── practice/                # Labs, Homework, Quizzes by week
├── case_studies/            # Extended analysis examples
├── live_coding/             # Live coding session files
├── computing_setup/         # Setup guides for students
│
├── _admin/                  # Internal planning & legacy files
│   ├── book_generation/     # Legacy PDF book generation files
│   ├── new_lectures_plan.qmd
│   └── Plan for Weeks 1-11.xlsx
├── _quizzes/                # Quiz SOLUTIONS (not student-facing)
├── _solutions/              # Unreleased solutions (gitignored)
│
├── Coursework/              # Coursework assignments
│   ├── _Coursework 1/       # Underscore = not yet released
│   └── _Coursework 2/
│
├── assets/data -> OneDrive  # Centralized data (symlink)
├── style/                   # Custom CSS/SCSS theming
├── _site/                   # Generated website output
└── _freeze/                 # Quarto freeze cache
```

## 📝 File Naming Convention

- All files and folders use **snake_case** (e.g., `week_1`, `lab_1.qmd`, `my_data.csv`)
- Slides are numbered: `NN_descriptive_name.qmd` (e.g., `01_data_cleaning_and_wrangling.qmd`)
- Underscore prefix (`_`) = ignored by Quarto (e.g., `_Coursework 1`, `_admin`)

## 📦 Data Management

**Large data files are hosted on OneDrive and symlinked into the project.**

### Symlink Architecture

The project uses symlinks extensively to avoid storing large data files in Git:

| Component | Symlink Location | Points To |
|-----------|------------------|-----------|
| Central data | `assets/data/` | OneDrive `.../MA22019 Lecture Notes/Data` |
| Lecture notes | `lecture_notes/Data` | OneDrive `.../MA22019 Lecture Notes/Data` |
| Slides | `slides/data` | `../assets/data` (relative) |
| Case studies | `case_studies/data` | `../assets/data` (relative) |
| Practice weeks | `practice/week_X/data` | OneDrive `.../Practice/Week X/data` |
| Live coding | `live_coding/week_X/Data` | OneDrive `.../LIve Coding/LIve Coding X/Data` |
| Coursework | `Coursework/_Coursework X/data` | OneDrive `.../Coursework/Coursework X/data` |

### Important Rules

1. **Do not commit data files directly** - Always place them in the OneDrive folder
2. **Git tracks the symlinks**, not the data content
3. **OneDrive is the primary backup** for all data files
4. See **[SYNC_WORKFLOW.md](SYNC_WORKFLOW.md)** for multi-machine setup

## 🔧 Building the Website

### Full Render
```bash
quarto render
```
Renders the entire site. Output goes to `_site/`.

### Development Workflow (Recommended)

For day-to-day editing, use the **live preview server**:

```bash
quarto preview
```

This starts a live development server that:
- Opens your browser automatically
- **Watches for file changes** — when you save a `.qmd` file, it re-renders just that file
- **Auto-refreshes** your browser with the changes
- Much faster than full `quarto render`

### Render a Single File
```bash
quarto render "practice/week_3/lab_3.qmd"
```

### Freeze Cache
The project uses `_freeze/` to cache rendered output. On subsequent renders, unchanged files are skipped automatically.

## 🎓 Release Workflow

### Solutions
Solutions are in `_solutions/` (ignored by Quarto). To release:
1. Move the solution file from `_solutions/` to `practice/week_X/`
2. Re-render the site
3. Commit and push

### Coursework
Coursework folders prefixed with `_` are ignored. To release:
1. Rename `_Coursework X` to `Coursework X`
2. Update `coursework.qmd` with listing
3. Re-render, commit, push

### Assignment Deployment Strategy (ma22019_tools)

We use the custom `ma22019_tools` R package to manage assignment distribution.

1.  **Student Repos (The Deliverable)**:
    *   Repositories like `lab_00-username` or `hw_01-username` on GitHub.
    *   These are created from template repositories using `ma22019_tools`.

2.  **`_templates/` Folder (Website Copy)**:
    *   Located inside this project (`ma22019_website/_templates/`).
    *   **Purpose**: "Golden Master" for rendering instructions on the course website.

3.  **Why NOT in `materials`?**:
    *   The `materials` repository is **read-only** for students (Labs/Notes only).
    *   Assignments are personal repositories.

## 🖥️ Setup on a New Machine

**Crucial: Read [SYNC_WORKFLOW.md](SYNC_WORKFLOW.md) first!**

```bash
# Clone the repository
git clone https://github.bath.ac.uk/ma22019-2026/ma22019_website.git
cd ma22019_website

# 1. Pull latest changes
git pull --prune

# 2. Clean up any old untracked folders
git clean -fd

# 3. Ensure OneDrive is running and symlinks work
ls -F assets/data/

# 4. Preview the site
quarto preview
```

### If Symlinks Are Broken

Recreate the primary symlink:
```bash
ln -sf "/Users/YOUR_USERNAME/OneDrive - University of Bath/Teaching/MA22019/from Christian/MA22019 Lecture Notes/Data" assets/data
```

## 📝 Key Configuration Files

| File | Purpose |
|------|---------|
| `_quarto.yml` | Main site config, navigation, theme |
| `practice/_metadata.yml` | Shared settings for practice folder |
| `slides/_metadata.yml` | RevealJS slide settings |
| `style/sta199.scss` | Custom styling (STA199 theme) |
| `.gitignore` | Defines what's tracked/ignored |
| `AGENTS.md` | AI agent project documentation |
| `SYNC_WORKFLOW.md` | Multi-machine sync instructions |

## 📂 Internal Folders

| Folder | Purpose |
|--------|---------|
| `_admin/` | Planning files, legacy book generation scripts |
| `_quizzes/` | Quiz solutions (separate from student-facing `practice/`) |
| `_solutions/` | Unreleased solutions (gitignored) |
| `_freeze/` | Quarto render cache |

## 👨‍🏫 Author

Dr. Karim Anaya-Izquierdo  
University of Bath
