@echo off

REM START this is needed since we need to run as Admin for mklink...
@setlocal enableextensions
@cd /d "%~dp0"
REM END this is needed since we need to run as Admin for mklink...

REM Set this variable to the folder with your pinsound altsound packages which supports altsound=1 option in VPinMAME
set ALTSOUNDFOLDER=..\_altsound

call :genlink afm_113b "%ALTSOUNDFOLDER%\Attack_From_Mars_OST_Mars_Attacks_by_PinHead3"
call :genlink diner_l4 "%ALTSOUNDFOLDER%\Diner_Sixties_by_PinHead"
call :genlink br_l4 "%ALTSOUNDFOLDER%\Black_Rose_OST_Pirates_of_the_Caribbean_by_PinHead"
call :genlink cftbl_l4 "%ALTSOUNDFOLDER%\CFTBL_wool_v1"
call :genlink dw_l2 "%ALTSOUNDFOLDER%\Doctor_Who_Modern V1.0"
call :genlink dracula "%ALTSOUNDFOLDER%\Dracula_Joffrey"
call :genlink gw_l5 "%ALTSOUNDFOLDER%\GetawayHS2-v7_MixedArtists_CustomCallouts_MrTantrum"
call :genlink gnr_300 "%ALTSOUNDFOLDER%\GNR_1.40-JULIEN42"
call :genlink hook_408 "%ALTSOUNDFOLDER%\Hook_1992"
call :genlink ij_l7 "%ALTSOUNDFOLDER%\Indiana_Jones_OST_By_PinHead"
call :genlink jupk_513 "%ALTSOUNDFOLDER%\JP_OST_Endprodukt"
call :genlink jupk_600 "%ALTSOUNDFOLDER%\JP_OST_Endprodukt"
call :genlink mb_106b "%ALTSOUNDFOLDER%\KJS_MonsterBash_mix"
call :genlink lah_112 "%ALTSOUNDFOLDER%\LAH_OST_1.50-JULIEN42"
call :genlink lw3_208 "%ALTSOUNDFOLDER%\Lethal_Weapon_3_1992"
call :genlink frankst "%ALTSOUNDFOLDER%\Mary_Shelley_s_Frankenstein_1995"
call :genlink stwr_104 "%ALTSOUNDFOLDER%\STARWARS_OST_1.0_Julien42"
call :genlink sttng_l7 "%ALTSOUNDFOLDER%\Star_Trek_REMIX_1991"
call :genlink t2_l8 "%ALTSOUNDFOLDER%\T2_OST_V1_2_FW90"
call :genlink tftc_303 "%ALTSOUNDFOLDER%\TFTC_1.3-JULIEN42"
call :genlink tom_14h "%ALTSOUNDFOLDER%\Theatre_Of_Magic_120117"
call :genlink tom_14hb "%ALTSOUNDFOLDER%\Theatre_Of_Magic_120117"
call :genlink taf_l7 "%ALTSOUNDFOLDER%\The_Addams_Family_OST_By_SLAMT1LT_v2"
call :genlink tomy_400 "%ALTSOUNDFOLDER%\TOMMY_OST_1.0_JULIEN42"
call :genlink tz_94ch "%ALTSOUNDFOLDER%\TZ_DCS_Chris_Granner"

pause
goto :eof

:genlink
if not exist ..\roms\%1.zip (
	echo Cannot find rom %1.zip 
	goto :eof
)
if not exist %2 (
	echo Cannot find destination folder %2 
	goto :eof
)

if exist %1 (
	goto :eof
)
if exist %2\config.pinsound (
	echo folder %2 seems to be a pinsound folder not compatible with pinmame altsound option= 1
	goto :eof
)
if exist %2\rules.txt (
	echo folder %1 %2 contains a rules.txt file which might interfere with VPinMAME
)

mklink /D %1 %2
