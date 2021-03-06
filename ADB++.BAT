@echo off
SET ARGUMENTS=%~1

if "%ARGUMENTS%" == "" (
    GOTO EOF
)

SET "ARGUMENTS=%ARGUMENTS:""="%"

SETLOCAL ENABLEDELAYEDEXPANSION 
:: INSTALL ON ALL ATTACHED DEVICES ::
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	if "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
		SET TRUTH="FALSE"
		SET /P INPUT="USE DEVICE: !SERIAL! (Y/N)"
		
		if "!INPUT!" == "Y" (
		    SET TRUTH="TRUE"
		)
		if "!INPUT!" == "y" (
		    SET TRUTH="TRUE"
		)
				
		if !TRUTH! == "TRUE" (
		    echo "adb -s !SERIAL! %ARGUMENTS%"
		    call adb -s !SERIAL! %ARGUMENTS%
			GOTO EOF
		)
	)
)
ENDLOCAL

:EOF