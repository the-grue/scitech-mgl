@echo off
REM Setup for compiling with Watcom C/C++ 11.0 in 32-bit OS/2 mode

if .%CHECKED%==.1 goto checked_build
SET LIB=%SCITECH_LIB%\lib\release\os232\wc11;.
echo Release build enabled.
goto setvars

:checked_build
SET LIB=%SCITECH_LIB%\lib\debug\os232\wc11;.
echo Checked debug build enabled.
goto setvars

:setvars
SET EDPATH=%WC11_PATH%\eddat
SET INCLUDE=include;%SCITECH%\include;%PRIVATE%\include;%WC11_PATH%\h\os2;%WC11_PATH%\h
SET WATCOM=%WC11_PATH%
SET MAKESTARTUP=%SCITECH%\makedefs\wc32.mk
call clrvars.bat
SET USE_OS232=1
SET USE_OS2GUI=1
SET WC_LIBBASE=wc11
SET EDPATH=%WC11_PATH%\EDDAT
IF .%OS%==.Windows_NT goto Win32_path
IF NOT .%WINDIR%==. goto Win32_path
PATH %SCITECH_BIN%;%WC11_PATH%\BINW;%DEFPATH%%WC_CD_PATH%
goto path_set
:Win32_path
PATH %SCITECH_BIN%;%WC11_PATH%\BINNT;%WC11_PATH%\BINW;%DEFPATH%%WC_CD_PATH%
:path_set

echo Watcom C/C++ 11.0 32-bit OS/2 GUI compilation environment set up.
