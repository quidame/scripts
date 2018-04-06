#!/bin/sh

# Output the canonical path of a file given as argument.
# The argument can be any file (regular file, directory, symlink, fifo, etc.)
# The file given as argument may not exist; unlike other tools such as readlink
# or realpath, pathname.{pl,sh} never tries to resolve the path name given as
# argument, which can be absolute or relative.
# Usage:
# $ pathname.sh ../../..//foobar/.././etc///blah/../fstab//./blah/..
# /etc/fstab

set -eu

case "${1}" in
    /*) pathname="${1}";;
    *)  pathname="${PWD}/${1}";;
esac

while true; do
    case "${pathname}" in
        *//*|*/./*|*/../*|*/|*/.|*/..)
            pathname="$(echo "${pathname}" | sed -re 's,(/+\.?)+/+,/,g; s,^(/+\.\.)+(/+|$),/,; s,[^/]+/+\.\.(/+|$),/,; s,/+,/,g; s,(/+\.?)+$,,')" ;;
        "") echo "/"; break ;;
        *)  echo "${pathname}"; break ;;
    esac
done

# vim: et sts=4 sw=4 ts=4
