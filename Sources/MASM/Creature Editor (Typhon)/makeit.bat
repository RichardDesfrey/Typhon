@echo off
: -------------------------------
: if resources exist, build them
: -------------------------------
if not exist rsrc.rc goto over1
\MASM32\BIN\Rc.exe /v rsrc.rc
\MASM32\BIN\Cvtres.exe /machine:ix86 rsrc.res
:over1

if exist %1.obj del MCrEdit.obj
if exist %1.exe del MCrEdit.exe

: -----------------------------------------
: assemble MCrEdit.asm into an OBJ file
: -----------------------------------------
\MASM32\BIN\Ml.exe /c /coff /Fl MCrEdit.asm
if errorlevel 1 goto errasm

if not exist rsrc.obj goto nores

: --------------------------------------------------
: link the main OBJ file with the resource OBJ file
: --------------------------------------------------
\MASM32\BIN\Link.exe /SUBSYSTEM:WINDOWS  MCrEdit.obj rsrc.obj
if errorlevel 1 goto errlink

dir MCrEdit.*

goto TheEnd

:errlink
: ----------------------------------------------------
: display message if there is an error during linking
: ----------------------------------------------------
echo.
echo There has been an error while linking this project.
echo.
goto TheEnd

:errasm
: -----------------------------------------------------
: display message if there is an error during assembly
: -----------------------------------------------------
echo.
echo There has been an error while assembling this project.
echo.
goto TheEnd

:TheEnd
del MCrEdit.lst
del MCrEdit.obj
del rsrc.obj
del rsrc.res
pause
