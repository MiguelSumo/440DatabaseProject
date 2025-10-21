@echo off
cd /d C:\Database440Project
git add Scripts
for /f "tokens=1-3 delims=/- " %%a in ("%date%") do set D=%%a-%%b-%%c
for /f "tokens=1-2 delims=: " %%a in ("%time%") do set T=%%a%%b
git commit -m "schema+data update %D% %T%"
git push
pause