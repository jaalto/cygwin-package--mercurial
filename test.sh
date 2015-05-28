#!/bin/sh
# Test basic functionality

set -e

proram=$0
TMPDIR=${TMPDIR:-/tmp}
BASE=tmp.$$
TMPBASE=${TMPDIR%/}/$BASE
CURDIR=.

case "$0" in
  */*)
        CURDIR=$(cd "${0%/*}" && pwd)
        ;;
esac

AtExit ()
{
    rm -rf "$TMPBASE"
}

Run ()
{
    if [ "$1" ]; then           # Empty message, just command to run
        echo "$*"
        shift
    else
        shift
        echo "$*"
    fi

    eval "$@"
}

trap AtExit 0 1 2 3 15

# #######################################################################

file="$CURDIR/example.dat"

mkdir -p "$TMPBASE" || exit $?
cd "$TMPBASE" || exit $?

which hg

hg --version ||
{
    echo "[ERROR] You must install package before testing it."
    echo "[ERROR] It depends on Python modules in certain locations.";
    exit
}

EMAIL=john.doe@example.com

file=test.txt
touch $file

Run "%% TEST 1:" hg init
Run "%% TEST 2:" hg add $file
Run "%% TEST 3:" hg ci -m "test" $file
Run "%% TEST 4:" hg log

# End of file
