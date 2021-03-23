#!/bin/sh 
set -e
# path to lazbuild
export lazbuild=$(which lazbuild)

# Set up widgetset: gtk or gtk2 or qt
# Set up processor architecture: i386 or x86_64
if [ $1 ]
  then export lcl=$1
fi
if [ $lcl ] && [ $CPU_TARGET ]
  then export DC_ARCH=$(echo "--widgetset=$lcl")" "$(echo "--cpu=$CPU_TARGET")
elif [ $lcl ]
  then export DC_ARCH=$(echo "--widgetset=$lcl")
elif [ $CPU_TARGET ]
  then export DC_ARCH=$(echo "--cpu=$CPU_TARGET")
fi

$lazbuild src/ffmpegGUIta.lpi $DC_ARCH
