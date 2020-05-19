@echo off
title %~n0
mode con lines=3000
set StartDateTime=%date% %time%
call "%~dpn0.exe" "_INI_combine_output.ini" %*
echo. return: %errorlevel%
echo. %StartDateTime%
echo. %date% %time%
pause