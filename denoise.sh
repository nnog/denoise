#!/bin/bash

# Denoise a video and re-encode the audio as 128k single-
# channel aac using ffmpeg, sox and libvo_aacenc (must be installed)

# George Cockshull george.cockshull@gmail.com
# usage: denoise video.mp4
# clean output goes in ./clean/video.mp4

# tip: to run in batch on all mp4 files in wd
# $ find . -name \*.mp4 -exec ./denoise.sh {} \;

ffmpeg -i $1 -vcodec copy -an tmpvid.mp4
ffmpeg -i $1 -sameq tmpaud.wav

if [ ! -f noise.prof ]
  then
    if [ ! -f noiseaud.wav ]
      then
        echo "Taking a noise sample"
        ffmpeg -i $1 -vn -ss 00:00:00 -t 1 noiseaud.wav
    fi
  echo "Generating noise profile"
  sox noiseaud.wav -n noiseprof noise.prof
fi

sox tmpaud.wav tmpaud-clean.wav noisered noise.prof 0.18
ffmpeg -i tmpaud-clean.wav -acodec libvo_aacenc -ab 128 -ac 1 tmpaud-clean.aac
ffmpeg -i tmpaud-clean.aac -acodec copy -i tmpvid.mp4 -vcodec copy ./clean/$1

rm tmpvid.mp4 tmpaud.wav tmpaud-clean.wav tmpaud-clean.aac


