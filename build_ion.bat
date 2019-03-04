@ECHO off
SETLOCAL

SET DIR=%~dp0
IF %DIR:~-1%==\ SET DIR=%DIR:~0,-1%
SET ION_HOME=%DIR%\ion

REM Set the build directory
SET BUILD_DIR=%DIR%\..\build

if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"

PUSHD "%BUILD_DIR%"
CALL CL /nologo /W3 /ZI /O2 "%ION_HOME%\main.c" /link /OUT:"ion_compiler.exe"
POPD
if ERRORLEVEL 1 EXIT /B %ERRORLEVEL%

PUSHD "%BUILD_DIR%"
(
  ECHO @ECHO off
  ECHO SETLOCAL
  ECHO.
  ECHO SET IONHOME=%ION_HOME%
  ECHO CALL "%BUILD_DIR%\ion_compiler.exe" %%*
  ECHO.
  ECHO ENDLOCAL
  ECHO EXIT /B %%ERRORLEVEL%%
) > "ion.bat"
POPD

ENDLOCAL
EXIT /B %ERRORLEVEL%
