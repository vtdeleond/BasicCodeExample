@echo off
setlocal enableDelayedExpansion enableextensions
for /f %%i in ("%0") do set DIR=%%~dpi
REM for /f %%i in ("%0") do set TMP=%%~dpi
SET DIRDELIMITER=\
REM SET TMP=C:\Windows\Temp
REM echo %1
SET TABLA=%1
SET CONDICION=%2
SET TIPOLDR=%3

SET ALIAS= AS CAMPO
SET CONDICION=!CONDICION:"=!
SET SQLSOURCEUSERPASS=user/pass@sources
SET SQLDESTUSERPASS=pas/pass@dest

SET TABLADESC=%TMP%%DIRDELIMITER%GETCAMPOS.TXT
SET TABLAGETDESC=%TMP%%DIRDELIMITER%GETCAMPOS.SQL
SET CAMPOS=%TMP%%DIRDELIMITER%CAMPOS.TXT
SET SQLCAMPOS=
SET CONTROL=%TMP%%DIRDELIMITER%CONTROL.TXT

SET LOADER_TMPL=%DIR%%DIRDELIMITER%CONTROL_TMPL.TXT
SET SQL_TMPL=%DIR%%DIRDELIMITER%SQL_TMPL.TXT
SET EXT_SQL=%TMP%%DIRDELIMITER%EXT_SQL.TXT

SET SQLFILE=%TMP%%DIRDELIMITER%FILE.SQL

REM FOR %%G IN (%*) DO (
REM 	echo %%G
REM )
REM echo "ya"


ECHO "COLUMNAS DE LA TABLA " %1

ECHO SPOOL %TABLADESC% > %TABLAGETDESC%
REM ECHO SET FEED OFF >> %TABLADESC%.SQL
ECHO SET TERMOUT off >> %TABLAGETDESC%
ECHO DESC %TABLA% >> %TABLAGETDESC%
ECHO QUIT >> %TABLAGETDESC%

ECHO "SCRIPT DE CAMPOS %TABLAGETDESC%"

sqlplus %SQLDESTUSERPASS% @%TABLAGETDESC%

FOR /F %%A IN (%TABLADESC%) DO (
  REM ECHO %%A
  SET /A CONT+=1
  IF !CONT! GTR 2 (
    REM SET C=%%A
    REM IF !CONT! GTR 3 SET C=,!C!
    REM ECHO !C! >> EXTRACTER.SQL
    REM ECHO ,%%A >> EXTRACTER.SQL
    IF !CONT! GTR 3 (
      ECHO ,%%A >> %CAMPOS%
       SET SQLCAMPOS=!SQLCAMPOS!^|^|^'^|^|^'^|^|%%A
      REM SET SQLCAMPOS=!SQLCAMPOS!,%%A
    ) ELSE (
      ECHO %%A > %CAMPOS%
      SET SQLCAMPOS=%%A
    )
    REM SET SQLCAMPOS=%%A^|^|^'^|^|^'^|^|!SQLCAMPOS!
  )
)
SET SQLCAMPOS=!SQLCAMPOS!^|^|^'^|^|^'^%ALIAS%

REM ECHO "%SQLCAMPOS%"
REM SET SQLCAMPOS=%SQLCAMPOS:"=%
REM @ECHO %SQLCAMPOS:"###=%
REM TYPE %LOADER_TMPL% > %CONTROL%
ECHO. > %CONTROL%
FOR /F "tokens=*" %%A IN (%LOADER_TMPL%) DO (
  ECHO %%A >> %CONTROL%
)
TYPE %CAMPOS% >> %CONTROL%
ECHO ) >> %CONTROL%
ECHO BEGINDATA >> %CONTROL%

ECHO. > %SQLFILE%
REM SET SQLCAMPOS=%CAMPOS%
FOR /F "tokens=* eol=" %%B IN (%SQL_TMPL%) DO (
  ECHO %%B >> %SQLFILE%
)
sqlplus %SQLSOURCEUSERPASS% @%SQLFILE%

TYPE %EXT_SQL% >> %CONTROL%

sqlldr %SQLDESTUSERPASS% control=%CONTROL% rows=10000 direct=true
