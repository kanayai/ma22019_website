import os
import re

BASE_DIR = os.getcwd()
SLIDES_DIR = os.path.join(BASE_DIR, "slides")
CASE_STUDIES_DIR = os.path.join(BASE_DIR, "case_studies")

# Regex to capture filename in read functions
# capturing: read.csv("captured"), read_sf("captured"), etc.
PATTERN = re.compile(r'(?:read\.csv|read_csv|read\.table|read_sf|st_read)\s*\(\s*["\'](?!http)(?:data/)?([^"\']+)["\']')

def check_dir(directory, data_subdir_name="data"):
    missing_files = set()
    data_dir = os.path.join(directory, data_subdir_name)
    existing_data = set(os.listdir(data_dir)) if os.path.exists(data_dir) else set()
    
    # Also ignore some common false positives or absolute paths if logic fails
    ignorable = {".DS_Store", "NA"}

    for filename in os.listdir(directory):
        if filename.endswith(".qmd"):
            filepath = os.path.join(directory, filename)
            with open(filepath, 'r') as f:
                content = f.read()
            
            matches = PATTERN.findall(content)
            for m in matches:
                # m is the filename, possibly with path like "data/foo.csv" or "foo.csv"
                # The regex (?:data/)? attempts to strip leading data/, but let's be safe
                basename = os.path.basename(m)
                
                if basename in ignorable:
                    continue
                    
                # Check if exists
                if basename not in existing_data:
                    # Double check if it's a shapefile sidecar or something
                    if not os.path.exists(os.path.join(data_dir, basename)):
                         missing_files.add(basename)
    
    return missing_files

slides_missing = check_dir(SLIDES_DIR)
cs_missing = check_dir(CASE_STUDIES_DIR)

print("MISSING IN SLIDES:")
for f in sorted(slides_missing):
    print(f"- {f}")

print("\nMISSING IN CASE STUDIES:")
for f in sorted(cs_missing):
    print(f"- {f}")
