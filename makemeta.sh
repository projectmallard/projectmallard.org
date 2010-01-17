#!/bin/sh

xsltproc -o $(dirname "$0")/1.0/META.page $(dirname "$0")/makemeta.xsl $(dirname "$0")/index.cache
