REM %1 directory path
REM %2 m3u file name

dir /b /on /s %1>dir.tmp

del /q %2

for /F "tokens=*" %%A in (dir.tmp) do (
 set line=%%A
 echo !line:~3!>>%2
)

del /q dir.tmp