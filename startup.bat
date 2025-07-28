cd /d "%~dp0"
del "C:\Users\User1\AppData\Local\nvim\start.log"
set /p DUMMY=Hit ENTER to exit...
nvim --startuptime start.log
