@echo off
 
  rem 使用debug模式启动
  if ""%1"" == ""debug"" goto needJavaHome
  
  rem JRE_HOME是否存在
  if not "%JRE_HOME%" == "" goto gotJreHome

  rem JAVA_HOME是否存在
  if not "%JAVA_HOME%" == "" goto gotJavaHome

  echo Neither the JAVA_HOME nor the JRE_HOME environment variable is defined
  echo At least one of these environment variable is needed to run this program
  goto exit


:needJavaHome
   rem JAVA_HOME环境变量为空
   if "%JAVA_HOME%" == "" goto noJavaHome
   if not exist "%JAVA_HOME%\bin\java.exe"  goto noJavaHome
   if not exist "%JAVA_HOME%\bin\jdb.exe"   goto noJavaHome
   if not exist "%JAVA_HOME%\bin\javac.exe" goto noJavaHome
rem 将JAVA_HOME的值赋给JRE_HOME
set "JRE_HOME=%JAVA_HOME%"
goto okJava


:noJavaHome
echo The JAVA_HOME environment variable is not defined correctly.
echo It is needed to run this program in debug mode.
echo NB: JAVA_HOME should point to a JDK not a JRE.
goto exit


:gotJavaHome
set "JRE_HOME=%JAVA_HOME%"


:gotJreHome
if not exist "%JRE_HOME%\bin\java.exe" goto noJreHome
goto okJava


:noJreHome
echo The JRE_HOME environment variable is not defined correctly
echo This environment variable is needed to run this program
goto exit


:okJava
if not "%JAVA_ENDORSED_DIRS%" == ""     goto gotEndorseddir
if not exist "%CATALINA_HOME%\endorsed" goto gotEndorseddir
set "JAVA_ENDORSED_DIRS=%CATALINA_HOME%\endorsed"


:gotEndorseddir
if not "%_RUNJAVA%" == "" goto gotRunJava
set _RUNJAVA="%JRE_HOME%\bin\java.exe"


:gotRunJava
if not "%_RUNJDB%" == "" goto gotRunJdb
set _RUNJDB="%JAVA_HOME%\bin\jdb.exe"


:gotRunJdb


goto end

:exit
exit /b 1

:end
exit /b 0