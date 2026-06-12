@echo off
setlocal
set "ROOT=%~dp0"
for %%I in ("%ROOT%..") do set "BASE=%%~fI\"
set "OUT=%BASE%exe\"
set "VC=C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars32.bat"
if not exist "%VC%" goto missing
if not exist "%OUT%" mkdir "%OUT%"
call "%VC%" >nul
lib /nologo /machine:x86 /def:"%ROOT%bcrypt_ord.def" /out:"%ROOT%bcrypt_ord.lib"
if errorlevel 1 exit /b 1
ml /nologo /c /coff /Fo"%ROOT%ncmmini.obj" "%ROOT%ncmmini.asm"
if errorlevel 1 exit /b 1
link /nologo "%ROOT%ncmmini.obj" /OUT:"%ROOT%NCMAsmRaw.exe" /NODEFAULTLIB /ENTRY:mainCRTStartup /SUBSYSTEM:WINDOWS /OPT:REF /OPT:ICF /MERGE:.rdata=.text /MERGE:.data=.text /SECTION:.text,ERW /FIXED /DYNAMICBASE:NO /MANIFEST:NO /DEBUG:NONE kernel32.lib user32.lib comdlg32.lib "%ROOT%bcrypt_ord.lib"
if errorlevel 1 exit /b 1
powershell -NoProfile -ExecutionPolicy Bypass -File "%ROOT%hpack.ps1" "%ROOT%NCMAsmRaw.exe" "%OUT%NCMConverter.exe"
if errorlevel 1 exit /b 1
del "%ROOT%ncmmini.obj" "%ROOT%NCMAsmRaw.exe" "%ROOT%bcrypt_ord.lib" "%ROOT%bcrypt_ord.exp" "%OUT%NCMConverter.exe" 2>nul
dir "%OUT%*.exe"
exit /b 0
:missing
echo vcvars32.bat not found
exit /b 1
