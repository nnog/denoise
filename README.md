denoise
=======

Denoise the background audio in a video file using ffmpeg, sox and libvo_aacenc to re-encode as single-channel 128k AAC.

This took me an annoyingly long time to work out how to do; hence githubbing it.

This was intended to scratch a personal itch (a very noisy itch) so open it up and edit the values before using.

Producing MP4/H.264 video with 1-channel 128k AAC headset mic-recorded screencast (I recommend SimpleScreenRecorder on linux) yielded background audio noise that this script sorts out.

To run in batch on mp4 files:

    $ find . -name \*.mp4 -exec ./denoise.sh {} \;
