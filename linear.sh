#!/bin/sh

if [ ! -f __pintail__/tools/pintail.cache ]; then
    pintail build
fi

xsltproc \
    -o .linear.cache.in \
    --stringparam dir "/$1/" \
    linear-select.xsl \
    __pintail__/tools/pintail.cache
xsltproc \
    -o .linear.cache \
    `pkg-config --variable xsltdir yelp-xsl`/mallard/cache/mal-cache.xsl \
    .linear.cache.in

xsltproc linear.xsl .linear.cache

rm .linear.cache.in .linear.cache
