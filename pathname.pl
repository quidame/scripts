#!/usr/bin/perl

# Output the canonical path of a file given as argument.
# The argument can be any file (regular file, directory, symlink, fifo, etc.)
# The file given as argument may not exist; unlike other tools such as readlink
# or realpath, pathname.{pl,sh} never tries to resolve the path name given as
# argument, which can be absolute or relative.
# Usage:
# $ pathname.pl ../../..//foobar/.././etc///blah/../fstab//./blah/..
# /etc/fstab

use strict;
use warnings;
use 5.010;
use Cwd;

my $name = $0;
$name =~ s,.*/,,;
defined $ARGV[0] or die "$name: missing argument";
my $pathname = $ARGV[0];

unless ( $pathname =~ m:^/: ) { $pathname = getcwd."/$pathname"; }
while ( $pathname =~ m:/\.{0,2}(/|$): ) { s:(/+\.?)+/+:/:g, s:^(/+\.\.)+(/+|$):/:, s:[^/]+/+\.\.(/+|$):/:, s:/+:/:g, s:(/+\.?)+$:: for $pathname; }
if ( $pathname =~ /^$/ ) { $pathname = "/"; }

say "$pathname";

# vim: et sts=4 sw=4 ts=4
