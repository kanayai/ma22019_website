# MA22019 Website & Course Materials

This repository contains the source code (RMarkdown, LaTeX, HTML) for the MA22019 course website.

## ⚠️ Data Management Strategy

**Large data files are NOT stored in GitHub.**
To keep the repository lightweight, this project uses a "Hybrid" workflow:

1.  **Code (Git):** RMarkdown files, scripts, and notes are tracked here.
2.  **Data (OneDrive):** Large datasets (CSVs, Shapefiles, etc.) reside in your OneDrive folder.
3.  **The Bridge (Symlinks):** Each component has a `data/` folder that is a **symbolic link** pointing to OneDrive.

### Symlinked Data Folders

| Component | Local Path | OneDrive Target |
|-----------|------------|-----------------|
| Lecture Notes | `MA22019 Lecture Notes/Data/` | `.../MA22019 Lecture Notes/Data` |
| Coursework 1 | `Coursework/Coursework 1/data/` | `.../Coursework/Coursework 1/data` |
| Coursework 2 | `Coursework/Coursework 2/data/` | `.../Coursework/Coursework 2/data` |

### Why this setup?
*   Prevents the Git repo from becoming huge (2GB+).
*   Allows data to sync via OneDrive automatically.
*   Allows R code to run unchanged on any Mac.

## 🚀 Setup on a New Mac

**Prerequisite:** Your username must be `kai21` and you must have OneDrive set up.

1.  Open Terminal.
2.  Run these commands to download the project:

```bash
# 1. Create the folder structure
mkdir -p ~/Projects/Teaching/MA22019
cd ~/Projects/Teaching/MA22019

# 2. Clone the repository
gh repo clone ma22019_website
```

**That's it!**
*   Git will download the code and the `Data` link.
*   Since your username (`kai21`) is the same on all machines, the link will automatically point to your local OneDrive data folder.

## 🔄 Daily Workflow (Syncing)

Use your standard `syncwork` script to manage this project.

```bash
syncwork
```

*   **Pushed Local Work:** Means you changed code/text, and it was saved to GitHub.
*   **Pulled Remote Updates:** Means you downloaded code changes from another Mac.
*   **Data Changes:** Are handled silently by OneDrive in the background. You don't need to git commit them.
