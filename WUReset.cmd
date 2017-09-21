net stop wuauserv 
net stop bits 
rmdir /S /Q %windir%\softwaredistribution 
net start wuauserv 
net start bits 
wuauclt.exe /resetauthorization /detectnow

pause