#!/usr/bin/python
# -*- coding: utf-8 -*-

# Output the canonical path of a file given as argument.
# The argument can be any file (regular file, directory, symlink, fifo, etc.)
# The file given as argument may not exist; unlike other tools such as readlink
# or realpath, pathname.{pl,sh} never tries to resolve the path name given as
# argument, which can be absolute or relative.
# Usage:
# $ pathname.py ../../..//foobar/.././etc///blah/../fstab//./blah/..
# /etc/fstab

from sys import argv
from os import getcwd
from re import search,sub

def shorten(path):
    if not search('^/', path): path = '%s/%s' % (getcwd(), path)

    while search(r'/\.{0,2}(/|$)', path):
        path = sub(r'(/+\.?)+$', '', sub(r'/+', '/', sub(r'[^/]+/+\.\.(/+|$)', '/', sub(r'^(/+\.\.)+(/+|$)', '/', sub(r'(/+\.?)+/+', '/', path), count=1), count=1)), count=1)
    if path == '': path = '/'
    print(path)

if __name__ == '__main__':
    shorten(argv[1])

# vim: et sts=4 sw=4 ts=4
