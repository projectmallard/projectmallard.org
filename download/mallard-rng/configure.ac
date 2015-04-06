AC_PREREQ(2.53)

m4_define([pkg_version], [1.0.1])
AC_INIT([mallard-rng], [pkg_version], [])
AC_CONFIG_SRCDIR([1.0/mallard-1.0.rng])

AM_INIT_AUTOMAKE([1.9 no-dist-gzip dist-bzip2])

MALLARD_DATA_DIR=`(
        case $prefix in
        NONE) prefix=$ac_default_prefix ;;
        *) ;;
        esac
        eval echo $(eval echo $datadir)/xml/mallard
)`
AC_SUBST(MALLARD_DATA_DIR)

AC_SUBST(rngdir, "\${datadir}/xml/mallard")

AC_CONFIG_FILES([
Makefile
catalog
])

AC_OUTPUT
