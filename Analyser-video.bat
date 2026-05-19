@echo off
chcp 65001 > nul
title CAPEPS Oral 2 - Analyse video natation
setlocal EnableDelayedExpansion
cd /d "%~dp0"

REM --- 0. Ajout des binaires locaux (tools\) au PATH de la session
set "PATH=%~dp0tools;%PATH%"

echo.
echo ============================================================
echo   CAPEPS Oral 2 - Analyse video natation
echo   Lancement de Claude Code avec amorçage automatique
echo ============================================================
echo.

REM --- 1. Dossiers requis ----------------------------------------
if not exist "vidéo à analyser" (
    mkdir "vidéo à analyser"
    echo [INFO]  Dossier "vidéo à analyser" créé.
)
if not exist "résultat" (
    mkdir "résultat"
    echo [INFO]  Dossier "résultat" créé.
)

REM --- 2. Pre-vol : ffmpeg ---------------------------------------
where ffmpeg >nul 2>nul
if errorlevel 1 (
    echo [ERREUR] ffmpeg introuvable dans le PATH.
    echo Ferme ce terminal, ouvre un NOUVEAU PowerShell, puis relance.
    pause
    exit /b 1
)
for /f "tokens=3" %%v in ('ffmpeg -version 2^>nul ^| findstr /b "ffmpeg version"') do (
    set "FFMPEG_VER=%%v"
    goto :ffmpeg_done
)
:ffmpeg_done
echo [OK]    ffmpeg !FFMPEG_VER!

REM --- 3. Pre-vol : MCP server build local -----------------------
if not exist "claude-video-vision-main\mcp-server\dist\index.js" (
    echo [ERREUR] Le MCP server n'est pas build^e.
    echo Exécute : cd claude-video-vision-main\mcp-server ^& npm install ^& npm run build
    pause
    exit /b 1
)
echo [OK]    MCP server claude-video-vision (build local)

REM --- 4. Pre-vol : claude CLI -----------------------------------
where claude >nul 2>nul
if errorlevel 1 (
    echo [ERREUR] La commande "claude" n'est pas dans le PATH.
    pause
    exit /b 1
)
echo [OK]    claude CLI

REM --- 5. Pre-vol : python + python-docx -------------------------
where python >nul 2>nul
if errorlevel 1 (
    echo [ATTENTION] python introuvable - la conversion .docx sera désactivée.
    echo             Le .md sera quand même écrit dans "résultat\".
) else (
    python -c "import docx" 2>nul
    if errorlevel 1 (
        echo [ATTENTION] python-docx non installé - la conversion .docx sera désactivée.
    ) else (
        echo [OK]    python + python-docx (conversion .docx active)
    )
)

REM --- 6. Lister les videos --------------------------------------
echo.
echo Vidéos détectées dans "vidéo à analyser\" (plus récente en haut) :
echo ------------------------------------------------------------
set "VIDEO_COUNT=0"
for /f "delims=" %%f in ('dir /b /o-d "vidéo à analyser\*.mp4" "vidéo à analyser\*.mov" "vidéo à analyser\*.avi" "vidéo à analyser\*.mkv" "vidéo à analyser\*.webm" 2^>nul') do (
    set /a VIDEO_COUNT+=1
    echo   !VIDEO_COUNT!. %%f
)
if !VIDEO_COUNT! EQU 0 (
    echo   (aucune vidéo trouvée)
    echo.
    echo Dépose ta vidéo (.mp4 .mov .avi .mkv .webm) dans le dossier
    echo "vidéo à analyser\" puis relance ce .bat.
    echo.
    pause
    exit /b 0
)
echo ------------------------------------------------------------
echo.

REM --- 7. Date du jour pour nommage des sorties ------------------
for /f "tokens=2 delims==" %%i in ('"wmic os get localdatetime /value 2>nul | find ^"=^""') do set "DT=%%i"
set "TODAY=!DT:~0,4!-!DT:~4,2!-!DT:~6,2!"

echo Lancement de Claude Code...
echo Sortie en direct dans ce terminal.
echo Fichier final : résultat\Expose_^<NomVidéo^>_!TODAY!.md (+ .docx si python-docx OK)
echo.
echo ============================================================
echo.

set "PROMPT=Démarre une analyse CAPEPS Oral 2 natation. ÉTAPES OBLIGATOIRES dans cet ordre, en annonçant CHAQUE étape AVANT de la lancer pour que je voie la progression en direct : (1) Lis 'connaissances/Fiche méthodologie oral 2 natation.md', 'connaissances/TD5 situation dos Loys.md' et 'connaissances/memory.md' si tu ne les as pas encore en contexte. (2) Liste les vidéos présentes dans 'vidéo à analyser/' (la plus récente d'abord) et confirme-moi laquelle tu vas analyser. (3) Demande-moi le contexte pédagogique manquant : classe/niveau, nage, distance totale réellement nagée, séquence/n° de leçon, et mes comptages bruts si je les ai (CB total + mi-course, respirations total + mi-course, chrono total + mi-course). (4) Une fois le contexte reçu : appelle video_info, puis video_analyze (filtres scene_changes, motion) sur la vidéo, puis video_watch avec une stratégie d'extraction adaptée (FPS 3-5 sur cycles bras et respirations, FPS 0.5-1 sur portions stables, résolution 768). Annonce chaque appel d'outil avant exécution avec une phrase courte (« j'appelle video_info pour récupérer durée et résolution... »). (5) Produis l'exposé complet en 6 étapes selon la méthodologie (accroche/CA, analyse ERPI avec calculs amplitude/fréquence/vitesse en excluant la coulée, 3 hypothèses, axe de transformation + S4C, situation évolutive SA1+SA Évolution structurée comme TD5 situation dos Loys.md, conclusion CT/MT/LT). Ton sobre, technique, prose argumentée, pas d'emojis. (6) SORTIE OBLIGATOIRE : avec l'outil Write, écris l'exposé complet dans 'résultat/Expose_<NomVidéoSansExt>_!TODAY!.md' (remplace <NomVidéoSansExt> par le nom de la vidéo analysée sans son extension, en gardant accents et espaces). Puis lance via Bash : python tools/md_to_docx.py \"résultat/Expose_<NomVidéoSansExt>_!TODAY!.md\" — confirme-moi ensuite les deux chemins absolus créés. Démarre maintenant à l'étape (1)."

claude "%PROMPT%"

echo.
echo ============================================================
echo Session Claude Code terminée.
echo Fichiers produits :
dir /b /o-d "résultat\*_!TODAY!.md" "résultat\*_!TODAY!.docx" 2>nul
echo ============================================================
pause
endlocal
