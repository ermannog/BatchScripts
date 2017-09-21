net stop wuauserv
net stop bits
 
rmdir /S /Q %windir%\softwaredistribution

regsvr32 /s WUAPI.DLL
regsvr32 /s WUAUENG.DLL
regsvr32 /s WUAUENG1.DLL
regsvr32 /s ATL.DLL
regsvr32 /s WUCLTUI.DLL
regsvr32 /s WUPS.DLL
regsvr32 /s WUPS2.DLL
regsvr32 /s WUWEB.DLL
 
net start wuauserv
net start bits
wuauclt.exe /resetauthorization /detectnow

pause