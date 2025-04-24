#!/bin/bash

# Prompt the user to input their home directory name immediately after the script starts
echo -n "Enter your home directory name (e.g., rreno): "
read -r home_dir

# Function to detect the Steam "common" directory dynamically
detect_steam_common_dir() {
    local home_dir=$1

    # Construct possible Steam directories using the provided home directory name
    possible_dirs=(
        "/C/Users/$home_dir/Gaming/steamapps/common"
    )

    for dir in "${possible_dirs[@]}"; do
        if [[ -d "$dir" ]]; then
            echo "$dir"
            return
        fi
    done

    # If no directory is found, return an error
    echo "Error: Could not locate the Steam 'common' directory." >&2
    exit 1
}

# Detect the Steam common directory
base_dir=$(detect_steam_common_dir "$home_dir")
echo "Detected Steam directory: $base_dir"

# Prompt the user to confirm or change the detected Steam directory
echo -n "Is this the correct Steam directory? (yes/no): "
read -r confirmation
if [[ "$confirmation" != "yes" ]]; then
    echo -n "Enter the correct Steam directory path: "
    read -r base_dir
    if [[ ! -d "$base_dir" ]]; then
        echo "Error: The provided directory does not exist." >&2
        exit 1
    fi
fi

# Default ignored folders
ignored_folders=("Steamworks Shared" "Steam Controller Configs")

# Allow the user to specify additional folders to ignore
echo -n "Would you like to ignore additional folders? (yes/no): "
read -r add_ignore
if [[ "$add_ignore" == "yes" ]]; then
    echo "Enter the folder names to ignore (comma-separated): "
    read -r extra_ignored
    IFS=',' read -ra extra_ignored_folders <<< "$extra_ignored"
    ignored_folders+=("${extra_ignored_folders[@]}")
fi

# Function to find a random .exe file in the top-level directories, excluding ignored folders
find_random_exe() {
    local ignored_patterns=()
    for folder in "${ignored_folders[@]}"; do
        ignored_patterns+=(-not -name "$folder")
    done

    while true; do
        # Select a random top-level directory, excluding ignored folders
        random_dir=$(find "$base_dir" -mindepth 1 -maxdepth 1 -type d "${ignored_patterns[@]}" | shuf -n 1)

        # Search for .exe files directly in the selected directory
        exe_file=$(find "$random_dir" -maxdepth 1 -type f -name "*.exe" | shuf -n 1)

        # If an .exe file is found, return it
        if [[ -n "$exe_file" ]]; then
            echo "$exe_file"
            return
        fi

        # If no .exe file is found, repeat the process
    done
}

# Find a random .exe file
game_exe=$(find_random_exe)

chmod +x "$game_exe"

# Try to directly execute the selected game
if [[ -f "$game_exe" ]]; then
    echo "Launching: $game_exe"
    echo "Please Stand By..."
    
    # Attempt to execute the file directly
    "$game_exe" || {
        cmd.exe /c start "" "$game_exe"
    }
else
    echo "Failed to find a valid executable."
fi