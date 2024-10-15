@echo off
REM Set these two variables
set VPinMAME=C:\vPinball\VisualPinball\VPinMAME
set zip=C:\Program Files\7-Zip\7z.exe
REM Set these two variables

REM For each .vpx file in folder
if ["%~1"] == [""] for %%f in ("*.vpx") do call %0 "%%f"
if ["%~1"] == [""] pause & goto :eof

set tablefile=%~1
REM Remove extension
set tablename=%tablefile:~0,-4%
echo "%tablename%"
if exist "%tablename%.vpxz" echo "%tablename%.vpxz" already exists & goto :EOF
rmdir /S/Q "%TMP%\table" 2>nul

mkdir "%TMP%\table\pinmame" >nul
set cgamename=
REM Extract romname
"%zip%" e -o%tmp% -y "%tablefile%" GameStg\GameData >nul
REM findstr /R /c:"^Const cGameName" %tmp%\GameData
if not exist %tmp%\GameData echo table script could not be extracted! & GOTO :EOF
for /f "tokens=2 delims== eol='" %%i in ('findstr /R /c:"^Const c[Gg]ame[Nn]ame" %tmp%\GameData') do set cgamename=%%i

REM Remove space
set cgamename=%cgamename: =%
REM Remove tab
set cgamename=%cgamename:	=%
REM Remove possible single quote and text after
set cgamename=%cgamename:'=&REM %
REM Remove possible komma and text after
set cgamename=%cgamename:,=&REM %
REM Remove double quote
set cgamename=%cgamename:"=%

if ["%cgamename%"] == [""] (
    echo Table "%tablefile%" has no cgamename variable set?
) else (
    echo Table "%tablefile%" uses rom "%cgamename%"
    robocopy %VPinMAME% %TMP%\table\pinmame %cgamename%.* /S /NDL /NJS /NJH /XF pin2dmd.* /XF *.txt
)
@REM /XD %cgamename%?* 
copy "%tablefile%" "%TMP%\table\" >nul
REM copy "%tablename%.directb2s" "%TMP%\table\" >nul
"%zip%" a "%tablename%.vpxz" -tzip "%TMP%\table" >nul

del %tmp%\GameData
rmdir /S/Q "%TMP%\table"