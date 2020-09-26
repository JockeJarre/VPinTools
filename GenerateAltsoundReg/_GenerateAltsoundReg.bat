@echo off
REM Put this file in the Visual Pinball\VPinMAME\altsound folder and run it.
REM It creates two registry files for all the folders in this directory.
REM Before it checks if the rom exists in the Visual Pinball\VPinMAME\roms
REM 
REM All the folders is expected to represent a rom name for VPinMAME.

echo Generate registry file (_altsoundON.reg) to turn on altsound for all rom folders in this folder.
call :genfile _altsoundON.reg 1
echo Generate registry file (_altsoundOFF.reg) to turn off altsound for all rom folders in this folder.
call :genfile _altsoundOFF.reg 0

pause
goto :eof
:genfile
	echo Windows Registry Editor Version 5.00 > %1
	for /d %%i in (*) do call :romsetting %%i %2 %1
	
goto :eof

:romsetting
	if not exist ..\roms\%1.zip (
		echo Cannot find rom %1.zip 
		goto :eof
	)
	echo "[HKEY_CURRENT_USER\Software\Freeware\Visual PinMame\%1]" >> %3
	echo "sound_mode"=dword:0000000%2 >> %3
	echo. >> %3

