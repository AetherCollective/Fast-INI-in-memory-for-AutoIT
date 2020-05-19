@echo off
title %~n0
mode con lines=3000
set StartDateTime=%date% %time%
call "%~dpn0.exe" "%~1"
::call "C:\Program Files (x86)\AutoIt3\AutoIt3.exe" "%~dpn0.au3" "%~1"
echo. return: %errorlevel%
echo. %StartDateTime%
echo. %date% %time%
pause