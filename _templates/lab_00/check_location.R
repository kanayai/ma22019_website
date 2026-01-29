# MA22019 Location Check
# Run this script to verify you cloned the repo to the correct place.

cat("Checking your project location...\n")
current_dir <- getwd()

# Check 1: Does path contain 'MA22019/homework'?
if (grepl("MA22019/homework", current_dir) || grepl("MA22019/coursework", current_dir) || grepl("MA22019/materials/labs", current_dir)) {
  cat("\n✅ SUCCESS: You are in the correct folder structure!\n")
  cat("Path:", current_dir, "\n")
} else {
  cat("\n❌ WARNING: It looks like you cloned to the wrong place.\n")
  cat("Current path:", current_dir, "\n")
  cat("Expected path should contain: .../MA22019/homework/...\n\n")
  cat("Did you use the 'Browse' button when creating the project?\n")
  cat("Please close this project, delete the folder, and clone again properly.\n")
}
