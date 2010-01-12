#!/bin/sh
gst-launch \
    multifilesrc location='mallard-logo-%03d.png' caps='image/png,framerate=10/1,pixel-aspect-ratio=1/1' ! \
    pngdec ! \
    videorate ! \
    ffmpegcolorspace ! \
    video/x-raw-yuv,'format=(fourcc)I420' ! \
    theoraenc ! \
    oggmux ! \
    filesink location=mallard-logo.ogv
