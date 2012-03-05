#!/bin/sh
rng_rncfile="$1";
rng_rngfile="$2";
rng_tmpfile="${rng_rngfile}.tmp";
LANG= awk -f `dirname $0`/rnc2rng.awk "$rng_rncfile" > "$rng_tmpfile" || (rm -f "$rng_tmpfile" && exit 1)
xmllint --format "$rng_tmpfile" | \
    sed -e 's/^  //' \
        -e 's/^\(<start.*>\)/\n\1/' \
        -e 's/^\(<define.*>\)/\n\1/' \
        -e 's/^\(<!--\)/\n\1/' \
        -e 's/^<\/grammar>/\n<\/grammar>/' \
        -e 's/ xmlns/\n    xmlns/g' \
        -e 's/" ns=/"\n    ns=/' \
    > "$rng_rngfile" || (rm -f "$rng_tmpfile" && exit 1) && rm -f "$rng_tmpfile"
