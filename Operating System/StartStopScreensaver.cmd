REM Start screensaver
start C:\Windows\System32\scrnsave.scr /s

REM Wait 10 seconds
timeout /t 10

REM Moves the cursor to position 0,0 for stop screensaver
rundll32 user32.dll,SetCursorPos

pause