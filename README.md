# MA22019 Course Website

A comprehensive Quarto-based website for the MA22019 (Data Analysis & Visualization) course at the University of Bath.

## 📚 Website Structure

| Section | Location | Description |
|---------|----------|-------------|
| **Home** | `index.qmd` | Course overview and announcements |
| **Lecture Notes** | `MA22019 Lecture Notes/` | Full course textbook (4 chapters) |
| **Slides** | `slides/NN_snake_case.qmd` | RevealJS presentation slides |
| **Labs** | `Practice/Week X/Lab X.qmd` | Weekly lab exercises |
| **Homework** | `Practice/Week X/Homework X.qmd` | Weekly homework assignments |
| **Quizzes** | `Practice/Week X/Quiz X.qmd` | Weekly practice quizzes |
| **Live Coding** | `LIve Coding/` | In-class coding demonstrations |
| **Computing Setup** | `computing_setup/` | Student setup guides |

## 📁 Folder Overview

ma22019_website/
├── _quarto.yml              # Main site configuration
├── index.qmd                # Homepage
├── labs.qmd                 # Labs listing page
├── homework.qmd             # Homework listing page
├── slides.qmd               # Slides listing page
├── coursework.qmd           # Coursework info page
│
├── assets/                  # Static assets
│   └── data/                # Centralized data repository
│       └── shapefiles/      # Geospatial data files
├── case_studies/            # Detailed analysis examples
├── computing_setup/         # Setup guides for students
├── lecture_notes/           # Course textbook
├── live_coding/             # Live coding session files
├── practice/                # Labs, Homework, Quizzes by week
├── slides/                  # Lecture slides (NN_snake_case.qmd)
├── style/                   # Custom CSS/SCSS theming
│
├── backup_data.sh           # Script to backup ignored data files
├── _site/                   # Generated website output
└── _freeze/                 # Quarto freeze cache

## 📝 File Naming Convention
- All files and folders use **snake_case** (e.g., `weeks_1`, `lab_1.qmd`, `my_data.csv`).


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

The server keeps running until you press `Ctrl+C` in the terminal.

### Render a Single File Manually
```bash
quarto render "Practice/Week 3/Lab 3.qmd"
```

### Freeze Cache
The project uses `_freeze/` to cache rendered output. On subsequent renders, unchanged files are skipped automatically.

Output is generated in `_site/`.

## 📦 Data Management
## 📦 Data Management
**Large data files are ignored by Git.**

- Centralized location: `assets/data/` (CSVs, TXTs) and `assets/data/shapefiles/` (SHP, DBF, etc.)
- `slides/data` and `case_studies/data` are **symlinks** pointing to `assets/data/`.
- **Backup**: Run `./backup_data.sh` to zip up open data files for safe keeping.
- **Restore**: Unzip a backup archive into `assets/data/` if setting up on a new machine.

## 🎓 Release Workflow

### Solutions
Solutions are in `_solutions/` (ignored by Quarto). To release:
1. Move the solution file from `_solutions/` to `Practice/Week X/`
2. Re-render the site
3. Commit and push

### Coursework
Coursework folders prefixed with `_` are ignored. To release:
1. Rename `_Coursework X` to `Coursework X`
2. Update `coursework.qmd` with listing
3. Re-render, commit, push

## 🖥️ Setup on a New Machine

```bash
# Clone the repository
git clone https://github.com/kanayai/ma22019_website.git
cd ma22019_website

# Ensure OneDrive is synced for data symlinks to work
# Preview the site
quarto preview
```

## 📝 Key Configuration Files

| File | Purpose |
|------|---------|
| `_quarto.yml` | Main site config, navigation, theme |
| `Practice/_metadata.yml` | Shared settings for Practice folder |
| `Slides/_quarto.yml` | RevealJS slide settings |
| `style/sta199.scss` | Custom styling (STA199 theme) |

## 👨‍🏫 Author

Dr. Karim Anaya-Izquierdo  
University of Bath
