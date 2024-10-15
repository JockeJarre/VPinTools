@echo off
REM Set these two variables
set romfolder=C:\vPinball\VisualPinball\VPinMAME\Roms
set zip=C:\Program Files\7-Zip\7z.exe
REM Set these two variables

REM For each .vpx file in folder
if ["%~1"] == [""] for %%f in ("*.vpx") do call %0 "%%f"
if ["%~1"] == [""] goto :eof

set tablefile=%~1
REM Remove extension
set tablename=%tablefile:~0,-4%
echo "%tablename%"
if exist "%tablename%.vpxz" echo "%tablename%.vpxz" already exists & goto :EOF
rmdir /S/Q "%TMP%\table" 2>nul
if exist "%TMP%\table" echo "%TMP%\table" already exists & goto :EOF

mkdir "%TMP%\table\pinmame\roms" >nul
set cgamename=
REM Extract romname
"%zip%" e -o%tmp% -y "%tablefile%" GameStg\GameData >nul
REM findstr /R /c:"^Const cGameName" %tmp%\GameData
if exist %tmp%\GameData for /f "tokens=2 delims== eol='" %%i in ('findstr /R /c:"^Const cGameName" %tmp%\GameData') do set cgamename=%%i

REM Remove space
set cgamename=%cgamename: =%
REM Remove possible single quote and text after
set cgamename=%cgamename:'=&REM %
REM Remove double quote
set cgamename=%cgamename:"=%

if [%cgamename%] == [] (
    echo Table "%tablefile%" uses no rom
) else (
    echo Table "%tablefile%" uses rom "%cgamename%"
    copy %romfolder%\%cgamename%.zip "%TMP%\table\pinmame\roms\" >nul
)

copy "%tablefile%" "%TMP%\table\" >nul
"%zip%" a "%tablename%.vpxz" -tzip "%TMP%\table" >nul

del %tmp%\GameData
rmdir /S/Q "%TMP%\table"