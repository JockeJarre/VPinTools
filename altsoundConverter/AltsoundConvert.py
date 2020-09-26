"""
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

"""

import csv
import pathlib
import subprocess
FFMPEG=pathlib.Path(r"ffmpeg.exe")

def convert(wavpath:str, oggpath:str):
    if not oggpath.exists():
        p = subprocess.run([str(FFMPEG), "-i", str(wavpath), str(oggpath)])
        print(p)

p = pathlib.Path('m1_afm')
for wavpath in p.glob('*.wav'):
    oggpath = p.joinpath('output',wavpath.with_suffix('.ogg').name)
    convert(wavpath, oggpath)

csvpath = p.joinpath('output','altsound.csv')
with csvpath.open('w', newline='') as csvfile:
    spamwriter = csv.writer(csvfile) #    quotechar='|', quoting=csv.QUOTE_MINIMAL)
    spamwriter.writerow("ID,CHANNEL,DUCK,GAIN,LOOP,STOP,NAME,FNAME,GROUP,SHAKER,SERIAL".split(","))
    #0x0001,0,100,50,100,0,"pre_launch","pre_launch.ogg",1,,""
    for oggpath in p.glob('output/*.ogg'):
        name,id = oggpath.stem.split('-') 
        print(oggpath, oggpath.name, oggpath.stem, name,id, f"{int(id):#06x}")
        spamwriter.writerow([f"{int(id):#06x}", 0,100,50,100,0,oggpath.stem,oggpath.name,1,"",""])
    