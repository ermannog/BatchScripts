@echo off
setlocal enabledelayedexpansion

ECHO Generazione Playlist per subdirectory Pop Italiano
del /q "Pop Italiano.m3u"
dir /b /on /s ".\Pop Italiano\*.mp3">dir.tmp
call "Create m3u.cmd" dir.tmp "Pop Italiano.m3u"

ECHO Generazione Playlist per subdirectory Rock
del /q "Rock.m3u"
dir /b /on /s ".\Rock\*.mp3">dir.tmp
call "Create m3u.cmd" dir.tmp "Rock.m3u"

ECHO Generazione Playlist Pop Italiano e Rock
type "Pop Italiano.m3u" "Rock.m3u" > "Pop Italiano e Rock.m3u"

ECHO Eliminazioe file temporanei
del /q dir.tmp
pause
