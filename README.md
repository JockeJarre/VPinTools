# VPinTools
Small Visual Pinball tools which might be of use for others as well

altsoundConverter:
    Short script to convert sound files from Virtual Pinball rom files, into altsound format.
    
    m1 or VPinMAME can be used to extract the different soundfiles into wav files. 
    
    Calling this script, it converts the files to .ogg format using ffmpeg and 
    then generates a altsound.csv file.
    
    M1 uses the convinent filename format (afm_113-001.wav) which allow to extract the ID from the name.
    This is currently the expected format for the filenames.
    
    Most of the columns in the generated file are hardcoded:

    id    , CHANNEL,DUCK,GAIN,LOOP,STOP,name,fname    ,GROUP,SHAKER,SERIAL (Columns with Capital letters are hardcoded)
    The ID,       0, 100,  50, 100,   0,name,file name,    1,      ,
    
    The channel is set to 0. When testing with Visual Pinball X using VPinMAME setting SoundMode=1,
    all the sounds get played on one channel, which means it "works", but the sounds get cut quickly. 
    When you change the channel for all non music sounds, at least the music is played longer.
    I am still trying to find out how to find out which values to use here.

CreateAltsoundLink:
	Very simple script which support you in creating links to the "Visual Pinball\VPinMAME\altsound" folder.
	The script needs to be changed for your own needs and has to run with admin rights to be able to use mklink.

GenerateAltsoundReg:
	Another super simple script which creates two registry files for all the altsound folders for VPinMAME.
	Put the script in the Visual Pinball\VPinMAME\altsound folder and run it.
	
	It then creates two registry files ( _altsoundON.reg and _altsoundOFF.reg) for all the folders in this directory.
	Before it checks if the rom exists in the Visual Pinball\VPinMAME\roms. All the folders is expected to represent 
	a rom name for VPinMAME.

	These .reg files can be activated through double click in windows to activate SoundMode=1 (ON) or SoundMode=0 (OFF) for all the folders.

3D Print STL file