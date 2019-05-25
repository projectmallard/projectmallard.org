#!/bin/sh
gst-launch \
    multifilesrc location='mallard-animation-%03d.png' caps='image/png,framerate=15/1,pixel-aspect-ratio=1/1' ! \
    pngdec ! \
    videorate ! \
    ffmpegcolorspace ! \
    video/x-raw-yuv,'format=(fourcc)I420' ! \
    vp8enc ! \
    webmmux ! \
    filesink location=mallard-logo.webm
