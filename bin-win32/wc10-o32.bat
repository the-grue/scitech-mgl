@echo off
REM Setup for compiling with Watcom C/C++ 10.6 in 32-bit OS/2 mode

if .%CHECKED%==.1 goto checked_build
SET LIB=%SCITECH_LIB%\lib\release\os232\wc10;.
echo Release build enabled.
goto setvars

:checked_build
SET LIB=%SCITECH_LIB%\lib\debug\os232\wc10;.
echo Checked debug build enabled.
goto setvars

:setvars
SET EDPATH=%WC10_PATH%\eddat
SET INCLUDE=include;%SCITECH%\include;%PRIVATE%\include;%WC10_PATH%\h\os2;%WC10_PATH%\h
SET WATCOM=%WC10_PATH%
SET MAKESTARTUP=%SCITECH%\makedefs\wc32.mk
call clrvars.bat
SET USE_OS232=1
SET WC_LIBBASE=wc10
SET EDPATH=%WC10_PATH%\EDDAT
IF .%OS%==.Windows_NT goto Win32_path
IF NOT .%WINDIR%==. goto Win32_path
PATH %SCITECH_BIN%;%WC10_PATH%\BINW;%DEFPATH%%WC_CD_PATH%
goto path_set
:Win32_path
PATH %SCITECH_BIN%;%WC10_PATH%\BINNT;%WC10_PATH%\BINW;%DEFPATH%%WC_CD_PATH%
:path_set

echo Watcom C/C++ 10.6 32-bit OS/2 console compilation environment set up.
