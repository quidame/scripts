#!/usr/bin/env perl

# ECHOIP - listen on TCP port given as argument and answer client's IP to client
# requests. It listens on all IPv6 interfaces and IPv4 requests are treaten in
# IPv6 dual stack. Usage:
#   echoip.pl PORT

use warnings;
use strict;
use v5.024;
use IO::Socket::IP;

my $socket = IO::Socket::IP -> new(
    Listen => 8,
    V6Only => 0,
    ReuseAddr => 1,
    ReusePort => 1,
    LocalHost => '::',
    LocalPort => $ARGV[0],
    Proto => 'tcp'
) or die "IO::Socket::IP -> new(): $!\n";

while (1) {
    my $client = $socket -> accept();
    my $ipaddr = $client -> peerhost();
    $ipaddr =~ s/^::ffff://;
    $client -> send("$ipaddr\n");
    $client -> shutdown(2);
}

$socket -> close();

# vim: et sts=4 sw=4 ts=4
