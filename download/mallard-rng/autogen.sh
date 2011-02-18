#!/bin/sh
package='mallard-rng'
version=`awk '/m4_define\(\[pkg_version\]/ { sub(/^m4_define\(\[pkg_version\], *\[/, "", $0); sub(/\]\)$/, "", $0); print }' configure.ac`
echo "Preparing $package $version"
(cd .. && \
    xsltproc -o mallard-rng/NEWS \
    --stringparam package $package \
    --stringparam version $version \
    NEWS.xsl index.page)
cp ../../AUTHORS .
cp ../../COPYING .
(cd ../.. && ./buildrng -o download/mallard-rng)
aclocal
autoconf
automake --add-missing
./configure $@
