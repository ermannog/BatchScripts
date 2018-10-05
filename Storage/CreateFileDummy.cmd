REM *** Set size in bytes ***
REM 10 GB = 10737418240 Bytes
REM 16 GB = 17179869184 Bytes
REM 20 GB = 21474836480 Bytes
REM 32 GB = 34359738368 Bytes
REM 64 GB = 68719476736 Bytes
SET SIZE=34359738368

REM *** Date Time Variables ***
SET MONTH=%DATE:~3,2%
SET DAY=%DATE:~0,2%
IF "%DAY:~0,1%"==" " SET DAY=0%DAY:~1,1%
SET YEAR=%DATE:~6,4%
SET HOUR=%TIME:~0,2%
IF "%HOUR:~0,1%"==" " SET HOUR=0%HOUR:~1,1%
SET MINUTE=%TIME:~3,2%
SET SECOND=%TIME:~6,2%

REM *** Creation file dummy in the current folder ***
fsutil file createnew "%~dp0File-%YEAR%-%MONTH%-%DAY%-%HOUR%-%MINUTE%-%SECOND%.dummy" %SIZE%

PAUSE 

