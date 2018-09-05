@ECHO OFF

REM References
REM WHOAMI Command:
REM https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/whoami
REM FIND Command:
REM https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/find
REM Well-known security identifiers in Windows operating systems:
REM https://support.microsoft.com/en-us/help/243330/well-known-security-identifiers-in-windows-operating-systems

WHOAMI /GROUPS | FIND "S-1-16-12288" > nul
IF NOT ERRORLEVEL 1 (
  ECHO The user HAS administrative privileges
) ELSE (
  ECHO The user DOES NOT HAVE administrative privileges
)

PAUSE