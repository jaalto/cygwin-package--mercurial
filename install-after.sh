#!/bin/sh
#
# install-after.sh -- Custom installation
#
# The script will receive one argument: relative path to
# installation root directory. Script is called like:
#
#    $ install-after.sh .inst
#
# This script is run after [install] command.

Cmd ()
{
    echo $*
    ${test+echo} $*
}

SetPythonVersion ()
{
    root="$1"
    dir=$root/usr/bin
    file=$dir/hg

    [ -f "$file" ] || return 1

    # libdir = '../lib/python3.8/site-packages'
    python=$(awk '/libdir.*=/ { gsub(/\x27/,""); print $(NF); exit}' "$file")
    python=${python##*lib/}
    python=${python%/*}

    [ "$python" ] || return 2

    sed --in-place "/#!/s,python[0-9. ]*$,$python," $dir/*
}

Main()
{
    root=${1:-".inst"}
    root=${root%/}      # delete trailing slash

    if [ "$root"  ] && [ -d $root ]; then

	root=$(echo $root | sed 's,/$,,')  # Delete trailing slash

	mandir=$root/usr/share/man
	Cmd install -m 0755 -d $mandir/man1 $mandir/man5
	Cmd install -m 0644 doc/*.1 $mandir/man1
	Cmd install -m 0644 doc/*.5 $mandir/man5

        SetPythonVersion $root

    fi
}

Main "$@"

# End of file
