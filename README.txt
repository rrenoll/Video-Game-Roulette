# Random Steam Game Launcher Script

This `bash` script is designed to help you randomly select and launch a `.exe` file from the Steam `common` directory, skipping any ignored folders. It dynamically detects your Steam directory and provides flexibility for customizations.

## Features

- Dynamically detects your Steam `common` directory.
- Prompts the user for confirmation or allows them to manually set the directory.
- Allows specifying additional folders to ignore during random selection.
- Randomly selects a `.exe` file from the top-level directories (excluding ignored folders).
- Launches the selected game `.exe` file.

## Prerequisites

- A Unix-like environment with support for `bash`.
- Steam installed on your system, with games stored in the `common` directory.
- The `shuf` utility installed on your system (`shuf` is typically part of the `coreutils` package).

## Usage

1. Save the script to a file, e.g., `random_steam_game_launcher.sh`.
2. Make the script executable:
   ```bash
   chmod +x random_steam_game_launcher.sh
   ```
3. Run the script:
   ```bash
   ./random_steam_game_launcher.sh
   ```

## How It Works

1. **Home Directory Name Prompt**:  
   The script asks for your home directory name (e.g., `rreno`) to locate the Steam `common` directory.
   
2. **Steam Directory Detection**:  
   It searches for the Steam `common` directory under:
   ```
   /C/Users/<home_directory_name>/Gaming/steamapps/common
   ```
   If the directory is not found, the script exits with an error.

3. **Confirmation of Detected Directory**:  
   The script prompts the user to confirm or override the detected Steam directory.

4. **Ignored Folders**:  
   By default, the following folders are ignored:
   - `Steamworks Shared`
   - `Steam Controller Configs`

   Users can add more folders to the ignore list during execution.

5. **Finding a Random `.exe` File**:  
   The script selects a random top-level directory (excluding ignored folders) and looks for `.exe` files. If no `.exe` file is found, it retries until a valid file is found.

6. **Launching the Game**:  
   Once a random `.exe` file is found:
   - The script makes it executable.
   - It attempts to launch the file directly. If that fails, it falls back to using `cmd.exe`.

## Example Output

```bash
Enter your home directory name (e.g., rreno): rreno
Detected Steam directory: /C/Users/rreno/Gaming/steamapps/common
Is this the correct Steam directory? (yes/no): yes
Would you like to ignore additional folders? (yes/no): no
Launching: /C/Users/rreno/Gaming/steamapps/common/GameName/game.exe
Please Stand By...
```

## Limitations

- The script assumes that your Steam games are stored in the `common` directory.
- It only works with `.exe` files and does not support other executable formats.
- The script is designed for environments with `bash` and may not work on systems without it.

## License

This script is provided as-is under the [MIT License](https://opensource.org/licenses/MIT).

## Contributions

Feel free to fork this repository and submit pull requests with improvements or additional features.