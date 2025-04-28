@echo off
setlocal EnableDelayedExpansion

rem ─────────────────────────────────────────────────
rem Change working directory to the folder containing this script
cd /d "%~dp0"

rem 1. Prompt for the WinLibs MinGW‑w64 version tag
set /p VERSION=Enter WinLibs MinGW-w64 version tag (e.g. 14.2.0posix-19.1.7-12.0.0-msvcrt-r3). Press Enter for latest:
echo.

rem 2. Determine the API URL based on the provided version
if defined VERSION (
    set "API_URL=https://api.github.com/repos/brechtsanders/winlibs_mingw/releases/tags/%VERSION%"
) else (
    set "API_URL=https://api.github.com/repos/brechtsanders/winlibs_mingw/releases/latest"
)

rem 3. Fetch the download URL (force TLS1.2 and output as ASCII)
echo Fetching download URL...
powershell -NoProfile -Command "[void]( [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ); (Invoke-RestMethod -Headers @{ 'User-Agent'='VSCodeEnvKit' } '%API_URL%' ).assets | Where-Object { $_.name -match 'winlibs-x86_64-posix-seh-gcc-.*\.zip$' } | Select-Object -First 1 -ExpandProperty browser_download_url | Out-File -FilePath _url.txt -Encoding ascii"

if not exist _url.txt (
    echo ERROR: Failed to retrieve download URL.
    exit /b 1
)
set /p DOWNLOAD_URL=<_url.txt
del _url.txt

if "%DOWNLOAD_URL%"=="" (
    echo ERROR: Download URL is empty.
    exit /b 1
)

echo Download URL: %DOWNLOAD_URL%
echo.

rem 4. Download the ZIP archive
echo Downloading archive...
if exist winlibs.zip del winlibs.zip
powershell -NoProfile -Command "[void]( [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ); Invoke-WebRequest -Headers @{ 'User-Agent'='VSCodeEnvKit' } -Uri '%DOWNLOAD_URL%' -OutFile 'winlibs.zip'"

if errorlevel 1 (
    echo ERROR: Download failed.
    exit /b 1
)

rem 5. Extract the downloaded archive
echo Extracting archive...
powershell -NoProfile -Command "Expand-Archive -Path 'winlibs.zip' -DestinationPath . -Force"

if errorlevel 1 (
    echo ERROR: Extraction failed.
    exit /b 1
)
del winlibs.zip

echo.
echo Open Visual Studio Code...

rem Open this script’s folder in VS Code
code "%~dp0"

endlocal
