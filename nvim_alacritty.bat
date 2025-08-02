@echo off
setlocal

:: Get the first argument (selected file path)
set "file_path=%~1"

:: Check if a file was provided
if "%~1"=="" (
    start "" /B alacritty -e "nvim"
	exit /b 1
)

:: Launch Neovim with the file
start "" /B alacritty -e "nvim "%file_path%""

endlocal