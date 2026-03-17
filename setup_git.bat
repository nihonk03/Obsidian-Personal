@echo off
echo Inicializando Git en Obsidian...
git init
git remote add origin git@github-obsidian:nihonk03/Obsidian-Personal.git
git add .
git commit -m "Backup inicial"
echo Intentando subir archivos a GitHub...
git push -u origin main
echo Proceso finalizado.
pause
