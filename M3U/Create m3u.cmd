REM %1 dir file name
REM %2 m3u file name

for /F "tokens=*" %%A in (%1) do (
 set line=%%A
 echo !line:~3!>>%2
)