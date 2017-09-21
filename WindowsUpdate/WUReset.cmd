net stop wuauserv
net stop bits
 
rmdir /S /Q %windir%\SoftwareDistribution

net start wuauserv
net start bits

wuauclt.exe /resetauthorization /detectnow

pause