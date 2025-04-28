@echo off
rem =============================================================
rem  DevEnvKit  -  Python portable setup for Visual Studio Code
rem -------------------------------------------------------------
rem  * Download and unpack portable (embed) Python
rem  * Enable site-packages and install pip
rem  * Launch VS Code
rem =============================================================

chcp 65001 >nul
setlocal EnableDelayedExpansion

cd /d "%~dp0"

rem ---------- 1. Ask Python version (Enter = latest) -------------
set /p PY_VER=Enter Python version (e.g. 3.11.5) [blank = latest] :

if "%PY_VER%"=="" (
    echo Detecting latest version...

    for /f "usebackq delims=" %%V in (`
        powershell -NoProfile -Command ^
          "$d=(Invoke-WebRequest -UseBasicParsing 'https://www.python.org/ftp/python/').Links | " ^
          "Where-Object { $_.href -match '^\d+\.\d+\.\d+/$' } | ForEach-Object { $_.href.Trim('/') }; " ^
          "$s=$d | Sort-Object {[version]$_} -Descending; " ^
          "$maj=[int]($s[0] -split '\.')[0]; " ^
          "$c=$s | Where-Object { ($_ -split '\.')[0] -eq $maj }; " ^
          "$mins=$c | ForEach-Object { [int]($_ -split '\.')[1] } | Sort-Object -Unique -Descending; " ^
          "$minSel= if ($mins.Count -gt 1) { $mins[1] } else { $mins[0] }; " ^
          "$ver=$c | Where-Object { [int]($_ -split '\.')[1] -eq $minSel } | Sort-Object {[version]$_} -Descending | Select-Object -First 1; " ^
          "Write-Output $ver"
    `) do set "PY_VER=%%V"
)

echo.
echo Selected version: %PY_VER%
echo.

rem ---------- 2. Download and unpack ----------------------------
set "ZIP_URL=https://www.python.org/ftp/python/%PY_VER%/python-%PY_VER%-embed-amd64.zip"

echo [1/4] Downloading %ZIP_URL%
powershell -NoProfile -Command ^
  "Invoke-WebRequest -Uri '%ZIP_URL%' -OutFile 'python-embed.zip'"
if errorlevel 1 (
    echo Download failed. Exiting.
    goto :EOF
)

echo [2/4] Unpacking...
if exist python-portable rmdir /s /q python-portable
powershell -NoProfile -Command ^
  "Expand-Archive -Path 'python-embed.zip' -DestinationPath 'python-portable' -Force"
del python-embed.zip

rem ---------- 3. Enable site-packages and install pip -----------
echo [3/4] Installing pip...
pushd python-portable

for %%f in (python*._pth) do (
    powershell -NoProfile -Command ^
      "(Get-Content '%%f') -replace '^[# ]*import\s+site','import site' | Set-Content '%%f'"
)

powershell -NoProfile -Command ^
  "Invoke-WebRequest -Uri 'https://bootstrap.pypa.io/get-pip.py' -OutFile 'get-pip.py'"
python.exe get-pip.py --no-warn-script-location
del get-pip.py

set "PATH=%CD%\Scripts;%PATH%"
popd

rem ---------- 4. Launch VS Code -------------------------------
echo [4/4] Launching VS Code...
code .

echo.
echo Setup complete.  PIP commands are available within VSCode terminal.
endlocal
