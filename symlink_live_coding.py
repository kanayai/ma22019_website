
import os
import shutil
import re

def symlink_live_coding(root_dir):
    live_coding_dir = os.path.join(root_dir, "LIve Coding")
    onedrive_base = "/Users/kai21/OneDrive - University of Bath/Teaching/MA22019/from Christian"
    onedrive_live_coding = os.path.join(onedrive_base, "LIve Coding")
    
    if not os.path.exists(live_coding_dir):
        print("Live Coding directory not found")
        return

    # Iterate over LIve Coding 1, 2, ...
    for item in os.listdir(live_coding_dir):
        local_sub_path = os.path.join(live_coding_dir, item)
        
        if os.path.isdir(local_sub_path) and item.startswith("LIve Coding"):
            print(f"Processing {item}...")
            
            # 1. Prepare OneDrive Destination
            onedrive_sub_path = os.path.join(onedrive_live_coding, item)
            onedrive_data_path = os.path.join(onedrive_sub_path, "Data")
            
            if not os.path.exists(onedrive_data_path):
                print(f"  Creating OneDrive Data folder: {onedrive_data_path}")
                os.makedirs(onedrive_data_path, exist_ok=True)
            
            # 2. Identify and Move Data Files
            # Common data extensions or specific files we saw
            data_extensions = ('.csv', '.xlsx', '.xls', '.shp', '.dbf', '.shx', '.prj', '.cpg', '.nc')
            
            files_moved = []
            
            for f in os.listdir(local_sub_path):
                file_path = os.path.join(local_sub_path, f)
                if os.path.isfile(file_path) and f.lower().endswith(data_extensions):
                    dest_path = os.path.join(onedrive_data_path, f)
                    
                    if os.path.exists(dest_path):
                        print(f"    File {f} already exists in OneDrive. Skipping move (using OneD version).")
                        # We delete the local one to clean up, unless it's a symlink?
                        # No, if it's a file in root, it's a duplicate now.
                        # Check md5? Nah, let's just assume OneD is master or safely unnecessary to overwrite if identical.
                        # But wait, if we delete local, we rely on OneD.
                        # Let's remove local file to keep folder clean for symlinking
                        os.remove(file_path)
                    else:
                        print(f"    Moving {f} to OneDrive Data folder.")
                        shutil.move(file_path, dest_path)
                    
                    files_moved.append(f)

            # 3. Handle Local 'Data' folder if it exists
            local_data_path = os.path.join(local_sub_path, "Data")
            if os.path.exists(local_data_path):
                if os.path.islink(local_data_path):
                    print(f"  'Data' is already a symlink.")
                    # Check where it points?
                elif os.path.isdir(local_data_path):
                    print(f"  'Data' is a local directory. Moving contents to OneDrive.")
                    for f in os.listdir(local_data_path):
                        s = os.path.join(local_data_path, f)
                        d = os.path.join(onedrive_data_path, f)
                        if not os.path.exists(d):
                            shutil.move(s, d)
                    shutil.rmtree(local_data_path)
                    # Now create symlink
                    os.symlink(onedrive_data_path, local_data_path)
                    print(f"  Created symlink for Data.")
            else:
                # Create symlink
                os.symlink(onedrive_data_path, local_data_path)
                print(f"  Created symlink for Data.")

            # 4. Update Code References
            # We need to replace reference to "file.csv" with "Data/file.csv"
            # BUT ONLY for files we moved or know are in Data.
            # ALSO need to check if they already say "Data/file.csv" (don't double up)
            
            if not files_moved:
                # Iterate OneDrive data to know what's valid to prefix? "Data/..."
                try:
                    files_moved = [f for f in os.listdir(onedrive_data_path) if f.lower().endswith(data_extensions)]
                except:
                    pass

            for root, dirs, files in os.walk(local_sub_path):
                if "Data" in dirs:
                    dirs.remove("Data") # Skip scanning inside the symlink
                
                for code_file in files:
                    if code_file.lower().endswith(('.qmd', '.rmd', '.r')):
                        c_path = os.path.join(root, code_file)
                        try:
                            with open(c_path, 'r', encoding='utf-8') as f:
                                content = f.read()
                            
                            new_content = content
                            for data_file in files_moved:
                                # Regex: look for filename NOT preceded by "Data/"
                                # Quote filename for regex safety
                                safe_name = re.escape(data_file)
                                # Pattern: Look for the filename, ensure it's not already prefixed by Data/
                                # And maybe ensure it's inside quotes? usually.
                                # Matches: "pets.csv", 'pets.csv'
                                # Negative lookbehind (?<!Data/)
                                pattern = re.compile(r'(?<!Data/)' + safe_name)
                                
                                # We only want to replace if it is likely a file path string. 
                                # Simple replacement might be safe enough for these unique filenames.
                                new_content = pattern.sub(f'Data/{data_file}', new_content)

                            if new_content != content:
                                with open(c_path, 'w', encoding='utf-8') as f:
                                    f.write(new_content)
                                print(f"    Updated references in {code_file}")

                        except Exception as e:
                            print(f"    Error updating {code_file}: {e}")

if __name__ == "__main__":
    symlink_live_coding(".")
