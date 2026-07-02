@echo off
setlocal
cd /d "%~dp0"

echo ========================================
echo   gemini-live-translate build (Nuitka)
echo ========================================
echo.

REM ---- Check Python ----
where python >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python not found in PATH.
    pause
    exit /b 1
)

REM ---- Create venv if missing ----
if not exist ".venv\Scripts\python.exe" (
    echo Creating virtual environment...
    python -m venv .venv
)

echo Activating venv...
call ".venv\Scripts\activate.bat"

REM ---- Install deps + Nuitka ----
echo.
echo Installing dependencies + Nuitka...
python -m pip install --upgrade pip >nul
pip install -r requirements.txt
pip install nuitka
if errorlevel 1 (
    echo [ERROR] Failed to install Nuitka.
    pause
    exit /b 1
)

REM ---- Prompt for version ----
set APP_VERSION=1.0.0.0
set /p APP_VERSION="Enter version (X.Y.Z.W, default 1.0.0.0): "
if "%APP_VERSION%"=="" set APP_VERSION=1.0.0.0
echo Using version: %APP_VERSION%
echo.

REM ---- Clean previous build ----
echo.
echo Cleaning previous build output...
if exist dist rmdir /s /q dist
if exist build rmdir /s /q build

REM ---- Set cache dir for faster rebuilds ----
set NUITKA_CACHE_DIR=%LOCALAPPDATA%\Nuitka\Cache
if not exist "%NUITKA_CACHE_DIR%" mkdir "%NUITKA_CACHE_DIR%"

REM ---- Build with Nuitka ----
echo.
echo Building gemini-live-translate.exe with Nuitka...
echo This may take 5-15 minutes on first run.
echo.

python -m nuitka ^
  --onefile ^
  --windows-console-mode=disable ^
  --enable-plugins=pyside6 ^
  --include-package=pyaudiowpatch ^
  --include-package=numpy ^
  --include-package=scipy ^
  --include-package=websockets ^
  --include-package-data=pyaudiowpatch ^
  --nofollow-import-to=PySide6.QtQml ^
  --nofollow-import-to=PySide6.QtQuick ^
  --nofollow-import-to=PySide6.QtQuick3D ^
  --nofollow-import-to=PySide6.QtQuickWidgets ^
  --nofollow-import-to=PySide6.QtCharts ^
  --nofollow-import-to=PySide6.QtDataVisualization ^
  --nofollow-import-to=PySide6.QtWebEngineCore ^
  --nofollow-import-to=PySide6.QtWebEngineWidgets ^
  --nofollow-import-to=PySide6.QtWebChannel ^
  --nofollow-import-to=PySide6.QtMultimedia ^
  --nofollow-import-to=PySide6.QtPdf ^
  --nofollow-import-to=PySide6.QtPdfWidgets ^
  --nofollow-import-to=PySide6.QtPrintSupport ^
  --nofollow-import-to=PySide6.QtSvg ^
  --nofollow-import-to=PySide6.QtSvgWidgets ^
  --nofollow-import-to=PySide6.QtTest ^
  --nofollow-import-to=PySide6.QtOpenGL ^
  --nofollow-import-to=PySide6.QtOpenGLWidgets ^
  --nofollow-import-to=PySide6.QtBluetooth ^
  --nofollow-import-to=PySide6.QtSerialPort ^
  --nofollow-import-to=PySide6.QtSensors ^
  --nofollow-import-to=PySide6.QtPositioning ^
  --nofollow-import-to=PySide6.QtNfc ^
  --nofollow-import-to=PySide6.QtRemoteObjects ^
  --nofollow-import-to=PySide6.QtScxml ^
  --nofollow-import-to=PySide6.QtStateMachine ^
  --nofollow-import-to=PySide6.QtUiTools ^
  --nofollow-import-to=PySide6.QtWebSockets ^
  --nofollow-import-to=PySide6.QtHttpServer ^
  --output-dir=dist ^
  --output-filename=gemini-live-translate.exe ^
  --onefile-tempdir-spec={CACHE_DIR}/GeminiLiveTranslate ^
  --onefile-cache-mode=cached ^
  --company-name=GeminiLiveTranslate ^
  --product-name="Gemini Live Translate" ^
  --file-version=%APP_VERSION% ^
  --product-version=%APP_VERSION% ^
  --assume-yes-for-downloads ^
  --lto=yes ^
  --static-libpython=yes ^
  --python-flag=-O ^
  --python-flag=no_docstrings ^
  --python-flag=no_warnings ^
  main.py

if errorlevel 1 (
    echo.
    echo [ERROR] Build failed. See output above.
    pause
    exit /b 1
)

REM ---- Verify ----
if exist "dist\gemini-live-translate.exe" (
    echo.
    echo ========================================
    echo   SUCCESS  ^(version: %APP_VERSION%^)
    echo ========================================
    echo Output: %~dp0dist\gemini-live-translate.exe
    for %%I in ("dist\gemini-live-translate.exe") do echo Size: %%~zI bytes
) else (
    echo [ERROR] dist\gemini-live-translate.exe not found after build.
)

echo.
pause
