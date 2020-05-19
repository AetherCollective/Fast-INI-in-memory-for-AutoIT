@echo off
title %~n0
set StartDateTime=%date% %time%
call "%~dpn0.exe"
echo. return: %errorlevel%
echo. %StartDateTime%
echo. %date% %time%
pause