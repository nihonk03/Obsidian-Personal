@echo off
echo Corrigiendo nombre de rama y subiendo a GitHub...
git branch -M main
git push -u origin main
echo.
echo !Hecho! Tus archivos ya deberian estar en GitHub.
pause
