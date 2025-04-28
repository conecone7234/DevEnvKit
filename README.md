# VScodeEnvKit - Python

Setup script for Python environment using a portable Python distribution and Visual Studio Code.

[日本語 README](https://github.com/conecone7234/VScodeEnvKit/blob/python/README_ja.md)

## Prerequisites
- Windows OS
- PowerShell available
- Visual Studio Code installed and `code` command is in PATH

## Usage

### 1. Installing Python
#### Without Git
1. Download and extract the project files via "Download ZIP".
2. Ensure the project root contains a `.vscode` folder with `extensions.json` and `settings.json`.
3. Run `setup.bat` in a terminal.

#### With Git
```bash
git clone <REPO_URL>
cd DevEnvKit
git checkout python
cd python
setup.bat
```

### 2. What `setup.bat` Does
1. Prompts for the Python version (press Enter to auto-detect the latest).
   - Select the desired version from the list at https://www.python.org/ftp/python/
2. Creates a `python-portable` folder containing the portable Python distribution.
3. Automatically launches Visual Studio Code and opens the project.

### 3. VS Code Extensions
When VS Code starts, a notification appears in the bottom right—click install to add the recommended extensions.

## File Structure
```
.
├ .vscode/
│   ├ extensions.json
│   └ settings.json
├ setup.bat
└ python-portable/   ← Generated folder
```

## Customization
- Modify `setup.bat` to change download URLs or extraction behavior.
- Adjust VS Code settings and recommended extensions under the `.vscode` folder.

## License
MIT License
