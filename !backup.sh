#!/bin/sh
dest=../archive

rm "$dest/ffmpegGUIta_src.zip"
7z a -mx9 "$dest/ffmpegGUIta_src.zip" @!backup.lst
rm "$dest/ffmpegGUIta_l64.zip"
7z a -mx9 "$dest/ffmpegGUIta_l64.zip" ffmpegGUIta *.svg *.lng *.txt *.ini *.db
rm "$dest/ffmpegGUIta_w64.zip"
7z a -mx9 "$dest/ffmpegGUIta_w64.zip" ffmpegGUIta.exe *.png *.lng *.txt *.ini *.db
