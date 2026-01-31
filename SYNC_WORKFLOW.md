# Multi-Mac Sync Workflow for MA22019

## Goal
To keep the project clean and synchronized across multiple machines using Git and OneDrive for data storage.

## 1. On This Mac (The Source of Truth)
*   **Data**: Stored in `OneDrive/.../MA22019 Lecture Notes/Data`.
*   **Project**: Uses a symlink `assets/data` -> `OneDrive Data`.
*   **Git**: Tracks the symlink, ignores the actual data content and `_site` build artifacts.

## 2. On Other Macs (Updates)
When moving to another machine, follow these steps to bring it in sync:

1.  **Pull Changes**:
    ```bash
    git pull --prune
    ```

2.  **Install Admin Tools** (Admin Only):
    If you are deploying assignments, you need the internal tools package.
    ```r
    source("_admin/setup_admin_tools.R")
    ```

3.  **Clean Untracked/Old Folders**:
    **WARNING**: This deletes all files not tracked by Git. Ensure you don't have local backups you want to keep inside the repo folder.
    ```bash
    git clean -fd
    ```
    *This will remove those old non-data folders you mentioned.*

3.  **Verify Data Link**:
    Ensure the symlink works. Run:
    ```bash
    ls -F assets/data/
    ```
    You should see the list of CSV/TXT files. If you see "No such file or directory", check that OneDrive is running and the path matches.

4.  **Render**:
    ```bash
    quarto render
    ```

## Notes
*   **Do not manually add data files to `assets/data` locally.** Always put them in the OneDrive folder.
*   **Do not commit `_site/` or `_freeze/` folders unnecessarily** (though `_freeze` is currently tracked to speed up renders).
