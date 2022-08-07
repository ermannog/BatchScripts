@echo off
setlocal enabledelayedexpansion

ECHO Generazione Playlist per subdirectory Pop Italiano
call "Create m3u from directory.cmd" ".\Pop Italiano\*.mp3" "Pop Italiano.m3u"

ECHO Generazione Playlist per subdirectory Rock
call "Create m3u from directory.cmd" ".\Rock\*.mp3" "Rock.m3u"

ECHO Generazione Playlist Pop Italiano e Rock
type "Pop Italiano.m3u" "Rock.m3u" > "Pop Italiano e Rock.m3u"

pause
