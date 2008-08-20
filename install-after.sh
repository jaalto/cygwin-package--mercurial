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

Cmd()
{
    echo $*
    ${test+echo} $*
}

Main()
{
    root=${1:-".inst"}

    if [ "$root"  ] && [ -d $root ]; then

	root=$(echo $root | sed 's,/$,,')  # Delete trailing slash

	mandir=$root/usr/share/man
	Cmd install -m 0755 -d $mandir/man1 $mandir/man5
	Cmd install -m 0644 doc/*.1 $mandir/man1
	Cmd install -m 0644 doc/*.5 $mandir/man5

    fi
}

Main "$@"

# End of file
