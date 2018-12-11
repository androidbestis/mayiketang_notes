@echo off

setlocal


set "CURRENT_DIR=%cd%"
if not "%CATALINA_HOME%" == "" goto gotHome

set "CATALINA_HOME=%CURRENT_DIR%"
if exist "%CATALINA_HOME%\bin\catalina.bat" goto okHome

cd ..
set "CATALINA_HOME=%cd%"
cd "%CURRENT_DIR%"


:gotHome
if exist "%CATALINA_HOME%\bin\catalina.bat" goto okHome
echo The CATALINA_HOME environment variable is not defined correctly
echo This environment variable is needed to run this program
goto end


:okHome
set "EXECUTABLE=%CATALINA_HOME%\bin\catalina.bat"
if exist "%EXECUTABLE%" goto okExec
echo Cannot find "%EXECUTABLE%"
echo This file is needed to run this program
goto end


:okExec
set CMD_LINE_ARGS=


:setArgs
if ""%1""=="""" goto doneSetArgs
set CMD_LINE_ARGS=%CMD_LINE_ARGS% %1
shift
goto setArgs


:doneSetArgs
call "%EXECUTABLE%" start %CMD_LINE_ARGS%

:end
