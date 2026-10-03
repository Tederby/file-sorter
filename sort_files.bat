@echo off
setlocal
echo Sorting...

:: FOLDER NAME DECLARATION
:: Just change the folder names you want.

set "FOLDER_IMAGES=Images"
set "FOLDER_DOCUMENTS=Documents"
set "FOLDER_VIDEO=Video"
set "FOLDER_AUDIO=Audio"
set "FOLDER_ARCHIVES=Compressed"
set "FOLDER_PROGRAMS=Programs"
set "FOLDER_SUBTITLES=Subtitles"
set "FOLDER_CODE=Programming"
set "FOLDER_GAMES=Game Files"
set "FOLDER_ANDROID=Android Apps"

:: EXTENSIONS PER CATEGORY
:: Want to add an extension? Just append it to the line, separated by spaces.

call :sortcat "%FOLDER_IMAGES%"    jpg jpeg png gif webp ico svg heic
call :sortcat "%FOLDER_DOCUMENTS%" pdf docx doc xlsx xls pptx ppt ppsx txt drawio
call :sortcat "%FOLDER_VIDEO%"     mp4 mkv avi mov m4v
call :sortcat "%FOLDER_AUDIO%"     mp3 wav mid
call :sortcat "%FOLDER_ARCHIVES%"  zip rar 7z tgz
call :sortcat "%FOLDER_PROGRAMS%"  exe msi
call :sortcat "%FOLDER_SUBTITLES%" srt sbv
call :sortcat "%FOLDER_CODE%"      cpp py html css json js ron vsix
call :sortcat "%FOLDER_GAMES%"     osz jar
call :sortcat "%FOLDER_ANDROID%"   apk

echo Done!
pause
goto :eof


:: ------------------------------------------------------------
:: :sortcat  target_folder  ext1 ext2 ext3 ...
:: Loops through every extension and hands each matching file
:: to :moveone
:: ------------------------------------------------------------
:sortcat
set "dest=%~1"
shift
:nextext
if "%~1"=="" exit /b
for %%f in (*.%~1) do call :moveone "%%f" "%dest%"
shift
goto nextext


:: ------------------------------------------------------------
:: :moveone  file  target_folder
:: If the name is already taken in the target folder, append a
:: suffix (_1, _2, ...) until a free name is found.
:: Nothing ever gets overwritten.
:: ------------------------------------------------------------
:moveone
set "src=%~1"
set "destdir=%~2"
if not exist "%destdir%\" mkdir "%destdir%"
set "target=%destdir%\%~nx1"
set /a n=0

:check
if not exist "%target%" goto domove
set /a n+=1
set "target=%destdir%\%~n1_%n%%~x1"
goto check

:domove
move "%src%" "%target%" >nul
if %n% gtr 0 echo Name conflict, saved as: %target%
exit /b
