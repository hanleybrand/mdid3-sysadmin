# All OS

## Extra python packages to install:

### PDF support:

    easy_install gfx

or

    pip install gfx


# Linux 

## FFMPEG_EXECUTABLE for audio video support

mdid3 uses [ffmpeg](http://ffmpeg.org) for audio & video media. 

The setting in [settings.py](https://github.com/cit-jmu/rooibos/blob/experimental/rooibos/settings.py) is: 

    FFMPEG_EXECUTABLE = os.path.join(install_dir, 'dist', 'windows', 'ffmpeg', 'bin', 'ffmpeg.exe')

which won't work on linux installations, naturally.  

Linux admins should install ffmpeg if it isn't installed and add the correct path (get with `which ffmpeg`) to settings_local.py, for example on RHEL/Centos:

    FFMPEG_EXECUTABLE = '/usr/local/bin/ffmpeg'

Installation on RHEL 5 & 6 can follow this guide if a yum package is not available for your specific version & architecture:  http://ffmpeg.org/trac/ffmpeg/wiki/CentosCompilationGuide