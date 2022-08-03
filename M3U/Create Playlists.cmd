@echo off
setlocal enabledelayedexpansion

ECHO Generazione Playlist Pop Italiano
del /q "Pop Italiano.m3u"
dir /b /on /s ".\Pop Italiano\*.mp3">dir.tmp
call "Create m3u.cmd" dir.tmp "Pop Italiano.m3u"

ECHO Generazione Playlist Rock
del /q "Rock.m3u"
dir /b /on /s ".\Rock\*.mp3">dir.tmp
call "Create m3u.cmd" dir.tmp "Rock.m3u"

ECHO Generazione Playlist Hard Rock
del /q "Hard Rock.m3u"
dir /b /on /s ".\Hard Rock\*.mp3">dir.tmp
call "Create m3u.cmd" dir.tmp "Hard Rock.m3u"

ECHO Generazione Playlist Classica
del /q "Classica.m3u"
dir /b /on /s ".\Classica\*.mp3">dir.tmp
call "Create m3u.cmd" dir.tmp "Classica.m3u"

ECHO Generazione Playlist Dance
del /q "Dance.m3u"
dir /b /on /s ".\Dance\*.mp3">dir.tmp
call "Create m3u.cmd" dir.tmp "Dance.m3u"

ECHO Generazione Playlist Pop Italiano e Rock
type "Pop Italiano.m3u" "Rock.m3u" > "Pop Italiano e Rock.m3u"

ECHO Generazione Playlist Rock e Hard Rock
type "Rock.m3u" "Hard Rock.m3u" > "Rock e Hard Rock.m3u"


ECHO Eliminazioe file temporanei
del /q dir.tmp
pause