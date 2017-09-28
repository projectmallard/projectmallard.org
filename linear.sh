#!/bin/sh

if [ ! -f __pintail__/tools/pintail.cache ]; then
    pintail build
fi

xsltproc \
    -o .linear.cache.in \
    --stringparam dir "/$1/" \
    linear-select.xsl \
    __pintail__/tools/pintail.cache

xsltdir=$(pkg-config --variable xsltdir yelp-xsl)
if [ "x$xsltdir" = "x" ]; then
    echo "Install yelp-xsl or yelp-xsl-devel" 1>&2
    exit 1
fi

xsltproc \
    -o .linear.cache \
    $xsltdir/mallard/cache/mal-cache.xsl \
    .linear.cache.in

xsltproc linear.xsl .linear.cache

rm .linear.cache.in .linear.cache
