#!/bin/sh

xsltproc -o .linear.cache.in --stringparam dir "/$1/" linear-select.xsl index.cache.in
xsltproc -o .linear.cache \
    `pkg-config --variable xsltdir yelp-xsl`/mallard/cache/mal-cache.xsl \
		.linear.cache.in

xsltproc linear.xsl .linear.cache

rm .linear.cache.in .linear.cache
